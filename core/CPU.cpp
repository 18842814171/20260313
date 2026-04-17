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
            case INST_LW: // LW
                out.reg_write = true;
                out.mem_read = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_SW: // SW
                out.mem_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
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
        LOG("Decoded Instruction:" + get_inst_name(out.inst_id));
        LOG("ID pc: " + HEX(out.pc));
    }



void CPU::execute(Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    SCOPE;
    if (!in.valid) {
        out.valid = false;
        return;
    }
    std::string inst_name = get_inst_name(in.inst_id);
        // Log instruction execution with details
        if (DEBUG) {
            std::stringstream ss;
            ss << "EXEC: " << inst_name;
            if (in.inst_id != INST_ECALL && in.inst_id != INST_EBREAK) {
                ss << " rd=x" << in.rd << " rs1=x" << in.rs1 << " rs2=x" << in.rs2;
                if (in.imm != 0) {
                    ss << " imm=" << HEX(in.imm);
                }
                // Show register values
                uint32_t rs1_val = reg[in.rs1];
                uint32_t rs2_val = reg[in.rs2];
                ss << " | vals: x" << in.rs1 << "=" << HEX(rs1_val) 
                   << " x" << in.rs2 << "=" << HEX(rs2_val);
            }
            LOG(ss.str());
        }
    if (in.inst_id == INST_ECALL) {
        uint32_t syscall = read_reg_forwarded(17);
        uint32_t arg0    = read_reg_forwarded(10);
        uint32_t arg1    = read_reg_forwarded(11);
        uint32_t arg2    = read_reg_forwarded(12);
        
        // Use enhanced syscall handler
        handle_syscall(*this);
        // Log syscall details
        LOG("SYSCALL: a7=" + DEC(syscall) + " a0=" + DEC(arg0) + 
            " a1=" + DEC(arg1) + " a2=" + DEC(arg2));
        
        out.valid = true;
        out.rd = in.rd;
        out.alu_result = 0;
        out.val_rs2 = 0;
        out.reg_write = false;
        out.mem_read = false;
        out.mem_write = false;
        LOG("EX result: " + HEX(out.alu_result));
        return;
    }
    if (in.inst_id == INST_EBREAK) {
        halt = true;
        exit_code = -1;
        LOG("EBREAK");
        out.valid = true;
        out.rd = in.rd;
        out.alu_result = 0;
        out.val_rs2 = 0;
        out.reg_write = false;
        out.mem_read = false;
        out.mem_write = false;
        LOG("EX result: " + HEX(out.alu_result));
        return;
    }

    // CSR instructions - handled by inst_* functions in system.hpp via execute_inst
    if (in.inst_id == INST_CSRRW || in.inst_id == INST_CSRRS ||
        in.inst_id == INST_CSRRC || in.inst_id == INST_CSRRWI ||
        in.inst_id == INST_CSRRSI || in.inst_id == INST_CSRRCI) {
        out.valid = true;
        out.reg_write = true;  // CSR instructions write to rd
        out.mem_read = false;
        out.mem_write = false;
        out.alu_result = 0;
        out.val_rs2 = 0;
        return;
    }

    // Use architectural regs after writeback() ran this cycle; id_ex.val_rs*
    // is stale for values that completed WB between decode and execute.
    uint32_t rs1_val = reg[in.rs1];
    uint32_t rs2_val = reg[in.rs2];

    // Forwarding: MEM/WB first, then EX/MEM overwrites (younger result wins)
    if (mem_wb.valid && mem_wb.reg_write && mem_wb.rd != 0) {
        uint32_t wb_val = mem_wb.mem_read ? mem_wb.mem_data : mem_wb.alu_result;
        if (mem_wb.rd == in.rs1) 
        {rs1_val = wb_val;
        LOGIF("Forwarding: x" + std::to_string(in.rs1) + " from MEM/WB", DEBUG);}
        if (mem_wb.rd == in.rs2) {rs2_val = wb_val;
        LOGIF("Forwarding: x" + std::to_string(in.rs2) + " from MEM/WB", DEBUG);}
    }
    if (ex_mem.valid && ex_mem.reg_write && ex_mem.rd != 0) {
        if (ex_mem.rd == in.rs1) 
        {rs1_val = ex_mem.alu_result;
        LOGIF("Forwarding: x" + std::to_string(in.rs1) + " from EX/MEM", DEBUG);}
        if (ex_mem.rd == in.rs2) 
        {rs2_val = ex_mem.alu_result;
        LOGIF("Forwarding: x" + std::to_string(in.rs2) + " from EX/MEM", DEBUG);}
    }

    uint32_t op1 = rs1_val;
    uint32_t op2 = in.alu_src ? in.imm : rs2_val;

    out.alu_result = alu_execute(in.alu_op, op1, op2);

    out.valid = true;
    out.rd = in.rd;
    out.val_rs2 = rs2_val;

    out.reg_write = in.reg_write;
    out.mem_read  = in.mem_read;
    out.mem_write = in.mem_write;

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

        out.reg_write = in.reg_write;
        out.mem_read  = in.mem_read;

        if (in.mem_read) {
            if (bus) {
                out.mem_data = bus->read_word(in.alu_result);
            } else {
                out.mem_data = memory.read_word(in.alu_result);
            }
            LOG("LW addr: " + HEX(in.alu_result));
        }
        else if (in.mem_write) {
            if (bus) {
                bus->write_word(in.alu_result, in.val_rs2);
            } else {
                memory.write_word(in.alu_result, in.val_rs2);
            }
            LOG("SW addr: " + HEX(in.alu_result));
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
    dump_registers();
    dump_pipeline_state();
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