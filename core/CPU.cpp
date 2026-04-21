//CPU.cpp
#include "CPU.hpp"
#include "Pipe.hpp"
#include "Instmngr.hpp"   
#include "device/Device.hpp"
#include "device/Bus.hpp"
#include "device/Timer.hpp"
#include "utils/utils.hpp"
#include "inst/encoding.hpp"
#include "inst/system.hpp"
#include "Interrupt.hpp"
#define DEBUG 1
#include <cstring>
#include <string>

CPU::CPU(Memory& mem_ref, InstManager& im_ref)
    : memory(mem_ref), inst_manager(im_ref)
{
    reg[0] = 0;
}

uint32_t CPU::read_reg_forwarded(unsigned r) const {
    if (r == 0 || r >= 32)
        return 0;
    uint32_t v = reg[r];
    if (mem_wb.valid && mem_wb.reg_write && mem_wb.rd != 0 && mem_wb.rd == r) {
        v = mem_wb.mem_read ? mem_wb.mem_data : mem_wb.alu_result;
    }
    if (ex_mem.valid && ex_mem.reg_write && ex_mem.rd != 0 && ex_mem.rd == r) {
        v = ex_mem.alu_result;
    }
    return v;
}

void CPU::fetch(Pipe_IF_ID& out) {
    SCOPE;
    if (halt) return;

    if (stall) {
        LOG("Fetch stalled");
        return;
    }

    out.valid = true;
    out.pc = pc;
    
    // Use bus if available for MMIO support, otherwise use memory directly
    if (bus) {
        out.inst = Inst(bus->read_word(pc));
    } else {
        out.inst = Inst(memory.read_word(pc));
    }

    LOG("IF pc: " + HEX(out.pc));
    LOG("  raw_inst: " + HEX(out.inst.raw));
    pc += 4;
}


void CPU::decode(Pipe_IF_ID& in, Pipe_ID_EX& out) {
    SCOPE;
        if (!in.valid) {
            out.valid = false;
            return;
        }

        stall = false;

        // LOAD-USE hazard detection
        if (id_ex.valid && id_ex.mem_read) {
            if (id_ex.rd != 0 &&
               (id_ex.rd == in.inst.rs1() ||
                id_ex.rd == in.inst.rs2())) {
                stall = true;
                LOG("LOAD-USE hazard detected: waiting for x" + DEC(id_ex.rd));
            }
        }

        if (stall) {
            LOG("STALL inserted");
            out.valid = false;
            return;
        }

        out.valid = true;
        out.pc = in.pc;

        out.inst_id = in.inst.inst_id();
        out.rs1 = in.inst.rs1();
        out.rs2 = in.inst.rs2();
        out.rd  = in.inst.rd();

        out.val_rs1 = reg[out.rs1];
        out.val_rs2 = reg[out.rs2];

        out.imm = in.inst.imm();

        out.reg_write = false;
        out.mem_read  = false;
        out.mem_write = false;
        out.is_byte   = false;
        out.is_unsigned = false;
        // Log decode info
    std::string inst_name = get_inst_name(out.inst_id);
    LOG("Decoded Instruction: " + inst_name);
    LOG("ID pc: " + HEX(out.pc));
    
    if (out.inst_id != INST_ECALL && out.inst_id != INST_EBREAK) {
        LOG("  rs1=x" + DEC(out.rs1) + " rs2=x" + DEC(out.rs2) + " rd=x" + DEC(out.rd));
        if (out.imm != 0) {
            LOG("  imm=" + HEX(out.imm));
        }
        LOG("  rs1_val=" + HEX(out.val_rs1) + " rs2_val=" + HEX(out.val_rs2));
    }
        switch (out.inst_id) {
            case INST_ADD: // ADD
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_ADDI: // ADDI
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                break;
                case INST_ANDI:
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::AND;
                break;

            case INST_SLLI:         // SLLI
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::SLL;
                break;
            case INST_SRL:   // R-type shift
                out.reg_write = true;
                out.alu_src = false;  // uses rs2, not immediate
                out.alu_op = ALUOp::SRL;
                break;

            case INST_LBU:          // byte unsigned load
            out.reg_write   = true;
            out.mem_read    = true;
            out.alu_src     = true;
            out.alu_op      = ALUOp::ADD;
            out.is_byte     = true;
            out.is_unsigned = true;     // ← this is what you asked for
            break;

        case INST_LB:           // byte signed load (add this case if you support LB)
            out.reg_write   = true;
            out.mem_read    = true;
            out.alu_src     = true;
            out.alu_op      = ALUOp::ADD;
            out.is_byte     = true;
            out.is_unsigned = false;
            break;

        case INST_LW: // LW
                out.reg_write = true;
                out.mem_read = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                out.is_byte   = false;
                break;
        case INST_SW: // SW
                out.mem_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                break;
        case INST_SB: // SB
                out.mem_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                out.is_byte = true;
                out.is_unsigned = false;
                break;
            case INST_ECALL:
            case INST_EBREAK:
            case INST_CSRRW:
            case INST_CSRRS:
            case INST_CSRRC:
            case INST_CSRRWI:
            case INST_CSRRSI:
            case INST_CSRRCI:
                break;
        }
        
}

void CPU::execute(Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    SCOPE;
    if (!in.valid) {
        out.valid = false;
        return;
    }

    out.valid   = true;
    out.rd      = in.rd;
    out.pc_modified = false;

    // Forwarding: use youngest result first (MEM/WB then EX/MEM)
    uint32_t rs1_val = reg[in.rs1];
    uint32_t rs2_val = reg[in.rs2];
    if (mem_wb.valid && mem_wb.reg_write && mem_wb.rd != 0) {
        uint32_t wb_val = mem_wb.mem_read ? mem_wb.mem_data : mem_wb.alu_result;
        if (mem_wb.rd == in.rs1) { rs1_val = wb_val; LOGIF("FWD: x" + DEC(in.rs1) + " <- MEM/WB", DEBUG); }
        if (mem_wb.rd == in.rs2) { rs2_val = wb_val; LOGIF("FWD: x" + DEC(in.rs2) + " <- MEM/WB", DEBUG); }
    }
    if (ex_mem.valid && ex_mem.reg_write && ex_mem.rd != 0) {
        if (ex_mem.rd == in.rs1) { rs1_val = ex_mem.alu_result; LOGIF("FWD: x" + DEC(in.rs1) + " <- EX/MEM", DEBUG); }
        if (ex_mem.rd == in.rs2) { rs2_val = ex_mem.alu_result; LOGIF("FWD: x" + DEC(in.rs2) + " <- EX/MEM", DEBUG); }
    }
    in.val_rs1 = rs1_val;
    in.val_rs2 = rs2_val;

    // Use forwarded values for logging
    LOG("EXEC: " + get_inst_name(in.inst_id) +
        " rd=x" + DEC(in.rd) +
        " rs1=x" + DEC(in.rs1) +
        " rs2=x" + DEC(in.rs2) +
        " | x" + DEC(in.rs1) + "=" + HEX(rs1_val) +
        " x" + DEC(in.rs2) + "=" + HEX(rs2_val) +
        (in.imm != 0 ? " imm=" + HEX(in.imm) : ""));

    // =============================================================
    // Control-flow handled directly here — no cross-file state leakage.
    // Each branch/jump sets out.pc_modified and out.target_pc.
    // =============================================================
    switch (in.inst_id) {

        // ----- JAL: rd = PC+4, PC = PC + imm -----
        case INST_JAL: {
            out.reg_write  = in.reg_write;
            out.mem_read   = false;
            out.mem_write  = false;
            out.alu_result = in.pc + 4;              // link address
            out.target_pc  = in.pc + static_cast<uint32_t>(in.imm);
            out.pc_modified = true;
            LOG("JAL: target=" + HEX(out.target_pc) + " link=" + HEX(out.alu_result));
            return;
        }

        // ----- JALR: rd = PC+4, PC = (rs1 + imm) & ~1 -----
        case INST_JALR: {
            out.reg_write  = in.reg_write;
            out.mem_read   = false;
            out.mem_write  = false;
            out.alu_result = in.pc + 4;                           // link address
            out.target_pc  = (in.val_rs1 + static_cast<uint32_t>(in.imm)) & ~1U;
            out.pc_modified = true;
            LOG("JALR: target=" + HEX(out.target_pc) + " link=" + HEX(out.alu_result));
            return;
        }

        // ----- BEQ: branch if rs1 == rs2 -----
        case INST_BEQ: {
            out.target_pc   = in.pc + static_cast<uint32_t>(in.imm);
            out.pc_modified = (in.val_rs1 == in.val_rs2);
            out.reg_write   = false;
            out.mem_read    = false;
            out.mem_write   = false;
            LOG("BEQ: " + HEX(in.val_rs1) + " == " + HEX(in.val_rs2) +
                " ? " + (out.pc_modified ? "TAKEN" : "NOT TAKEN"));
            return;
        }

        // ----- BNE: branch if rs1 != rs2 -----
        case INST_BNE: {
            out.target_pc   = in.pc + static_cast<uint32_t>(in.imm);
            out.pc_modified = (in.val_rs1 != in.val_rs2);
            out.reg_write   = false;
            out.mem_read    = false;
            out.mem_write   = false;
            LOG("BNE: " + HEX(in.val_rs1) + " != " + HEX(in.val_rs2) +
                " ? " + (out.pc_modified ? "TAKEN" : "NOT TAKEN"));
            return;
        }

        // ----- BLT: branch if rs1 < rs2 (signed) -----
        case INST_BLT: {
            out.target_pc   = in.pc + static_cast<uint32_t>(in.imm);
            int32_t s1 = static_cast<int32_t>(in.val_rs1);
            int32_t s2 = static_cast<int32_t>(in.val_rs2);
            out.pc_modified = (s1 < s2);
            out.reg_write   = false;
            out.mem_read    = false;
            out.mem_write   = false;
            LOG("BLT: " + DEC(s1) + " < " + DEC(s2) +
                " ? " + (out.pc_modified ? "TAKEN" : "NOT TAKEN"));
            return;
        }

        // ----- BGE: branch if rs1 >= rs2 (signed) -----
        case INST_BGE: {
            out.target_pc   = in.pc + static_cast<uint32_t>(in.imm);
            int32_t s1 = static_cast<int32_t>(in.val_rs1);
            int32_t s2 = static_cast<int32_t>(in.val_rs2);
            out.pc_modified = (s1 >= s2);
            out.reg_write   = false;
            out.mem_read    = false;
            out.mem_write   = false;
            LOG("BGE: " + DEC(s1) + " >= " + DEC(s2) +
                " ? " + (out.pc_modified ? "TAKEN" : "NOT TAKEN"));
            return;
        }

        // ----- ECALL: syscall -----
        case INST_ECALL: {
            uint32_t sc  = read_reg_forwarded(17);
            uint32_t a0  = read_reg_forwarded(10);
            uint32_t a1  = read_reg_forwarded(11);
            uint32_t a2  = read_reg_forwarded(12);
            handle_syscall(*this, sc, a0, a1, a2);
            LOG("ECALL: a7=" + DEC(sc) + " a0=" + DEC(a0) +
                " a1=" + DEC(a1) + " a2=" + DEC(a2));
            out.alu_result = 0;
            out.reg_write  = false;
            out.mem_read   = false;
            out.mem_write  = false;
            return;
        }

        // ----- EBREAK: halt -----
        case INST_EBREAK: {
            halt     = true;
            exit_code = -1;
            LOG("EBREAK");
            out.alu_result = 0;
            out.reg_write  = false;
            out.mem_read   = false;
            out.mem_write  = false;
            return;
        }

        default:
            break;
    }

    // =============================================================
    // Non-control instructions: run via instruction manager then
    // forward control signals from decode (except for AUIPC/LUI
    // which override alu_result themselves).
    // =============================================================

    out.reg_write  = in.reg_write;
    out.mem_read   = in.mem_read;
    out.mem_write  = in.mem_write;
    out.is_byte    = in.is_byte;
    out.is_unsigned = in.is_unsigned;
    out.val_rs2    = in.val_rs2;

    // For AUIPC: out.alu_result = pc + imm (pc came from IF/ID latch)
    // For LUI:   out.alu_result = imm (already shifted by decoder)
    // For ALU ops / loads / stores: inst_manager computes out.alu_result
    inst_manager.execute_inst(*this, in, out);

    LOG("EX result: " + HEX(out.alu_result));
}

void CPU::memory_access(Pipe_EX_MEM& in, Pipe_MEM_WB& out) {
    SCOPE;
        if (!in.valid) {
            out.valid = false;
            return;
        }

        out.valid = true;
        out.rd = in.rd;
        out.alu_result = in.alu_result;
        out.is_byte    = in.is_byte;
        out.reg_write = in.reg_write;
        out.mem_read  = in.mem_read;
        uint32_t addr = in.alu_result;
        if (in.mem_read) {
        if (in.is_byte) {                  // byte load: LB or LBU
            uint8_t byte_val;
            if (bus) {
                byte_val = bus->read_byte(addr);
            } else {
                byte_val = memory.read_byte(addr);
            }

            // Simple rule: if funct3 == 0b100 (LBU) → unsigned, else (LB) → signed
            // We will set is_unsigned in decode stage using funct3
            // For now, to keep it minimal, we assume you will pass the info.
            // Temporary simple version:
            //bool is_unsigned = /* TODO: set from decode based on funct3 */;

            if (in.is_unsigned) {
                out.mem_data = byte_val;                    // zero extend
            } else {
                out.mem_data = static_cast<int32_t>(static_cast<int8_t>(byte_val)); // sign extend
            }
            LOG("LB/LBU addr: " + HEX(addr));
        }
        else {  // word load (LW)
            if (bus) {
                out.mem_data = bus->read_word(addr);
            } else {
                out.mem_data = memory.read_word(addr);
            }
            LOG("LW addr: " + HEX(addr));
        }
    }
    else if (in.mem_write) {
        if (in.is_byte) {                  // byte store: SB
            uint8_t data = static_cast<uint8_t>(in.val_rs2 & 0xFFu);
            if (bus) {
                bus->write_byte(addr, data);
            } else {
                memory.write_byte(addr, data);
            }
            LOG("SB addr: " + HEX(addr));
        }
        else {  // word store (SW)
            if (bus) {
                bus->write_word(addr, in.val_rs2);
            } else {
                memory.write_word(addr, in.val_rs2);
            }
            LOG("SW addr: " + HEX(addr));
        }
    }
}

void CPU::writeback(Pipe_MEM_WB& in) {
    SCOPE;    
    if (!in.valid) return;

    if (in.reg_write && in.rd != 0) {
            uint32_t data = in.mem_read ? in.mem_data : in.alu_result;
            reg[in.rd] = data;
            std::string source = in.mem_read ? "MEM" : "ALU";
            LOG("WB: r" + DEC(in.rd) + " = "  + HEX(data) + " (from " + source + ")"); 
        }
                
}

bool CPU::step()
{    
   
    
    SCOPE; 
    
    // Check for pending interrupts before fetching
    if (interrupt_enabled && int_ctrl && int_ctrl->has_pending_interrupt()) {
        LOG("Taking pending interrupt");
        auto irq = int_ctrl->get_pending_interrupt();
        enter_trap(true, static_cast<uint32_t>(irq.type));
        // Clear pipeline for interrupt
        if_id.valid = false;
        id_ex.valid = false;
        ex_mem.valid = false;
    }
    
    if (halt) return false;
    writeback(mem_wb);
    memory_access(ex_mem, mem_wb);
    execute(id_ex, ex_mem);
    // ECALL/EBREAK set halt in execute; do not decode/fetch this cycle or we may
    // fault on a bogus PC or pull more instructions after syscall.
    if (halt)
        return true;
    if (ex_mem.pc_modified) {
        pc = ex_mem.target_pc;
        if_id.valid = false;
        id_ex.valid = false;
        ex_mem.pc_modified = false;
        LOG("FLUSH: branch/jump taken, PC -> " + HEX(pc));
    }
    decode(if_id, id_ex);
    fetch(if_id);
    
    // Tick devices via bus
    if (bus) {
        Timer* timer = dynamic_cast<Timer*>(bus->find_device(0x02004000));
        if (timer) {
            timer->tick();
            if (timer->check_interrupt()) {
                int_ctrl->request_interrupt(InterruptType::TIMER, 0);
            }
        }
    }
    
    // Tick interrupt controller
    if (int_ctrl) {
        int_ctrl->tick();
    }
    //dump_registers();
    //dump_pipeline_state();
    return true;
} 


void CPU::run(size_t max_steps) {
    
    step_count = 0;
    
    while (!halt) {
        if (max_steps && step_count >= max_steps)
            break;
        GAP;
        LOG("Step: " + DEC(step_count));
        GAP;
        if (!step())
            break;
        //dump_registers();
        step_count++;
        
    }

    if (halt)
        LOG("Halted (ECALL/EBREAK).");
    else if (max_steps)
        LOG("Stopped: step limit (" + std::to_string(max_steps) + ") reached before halt.");

    // exit_code is set by ECALL exit syscall; else main's return is typically in a0 (x10).
    LOG("Ran " + std::to_string(step_count) + " step(s). "
        "a0 (x10) = " + std::to_string(reg[10]) + ". "
        "exit_code = " + std::to_string(exit_code));
}


void CPU::dump_registers() const {
    for (int i = 0; i < 32; i += 4) {
        printf("x%02d: 0x%08x   x%02d: 0x%08x   x%02d: 0x%08x   x%02d: 0x%08x\n",
               i, reg[i], i+1, reg[i+1], i+2, reg[i+2], i+3, reg[i+3]);
    }
    printf("dump registers state pc: 0x%08x\n", pc);
}


std::string CPU::get_inst_name(uint32_t opcode) const {
        return inst_manager.get_name(opcode);
    }


    void CPU::dump_pipeline_state() const {
        if (!DEBUG) return;
        
        GAP;
        LOG("=== Pipeline State ===");
        LOG("IF/ID: " + std::string(if_id.valid ? "valid" : "invalid"));
        if (if_id.valid) {
            LOG("  PC=" + HEX(if_id.pc) + " inst=" + HEX(if_id.inst.raw));
        }
        
        LOG("ID/EX: " + std::string(id_ex.valid ? "valid" : "invalid"));
        if (id_ex.valid) {
            LOG("  inst=" + get_inst_name(id_ex.inst_id) + " rd=x" + DEC(id_ex.rd));
        }
        
        LOG("EX/MEM: " + std::string(ex_mem.valid ? "valid" : "invalid"));
        if (ex_mem.valid) {
            LOG("  rd=x" + DEC(ex_mem.rd) + " result=" + HEX(ex_mem.alu_result));
        }
        
        LOG("MEM/WB: " + std::string(mem_wb.valid ? "valid" : "invalid"));
        if (mem_wb.valid) {
            LOG("  rd=x" + DEC(mem_wb.rd) + " data=" + HEX(mem_wb.mem_data));
        }
        GAP;
    }
CPU::~CPU() {
    
}