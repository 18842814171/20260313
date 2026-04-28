//CPU.cpp
#include "CPU.hpp"
#include "Pipe.hpp"
#include "Instmngr.hpp"   
#include "device/Device.hpp"
#include "device/Bus.hpp"
#include "device/Timer.hpp"
#include "device/UART.hpp"
#include "utils/utils.hpp"
#include "inst/encoding.hpp"
#include "inst/system.hpp"
#include "Loader.hpp"
#include "Interrupt.hpp"
#include <cstring>
#include <algorithm>
#include <iostream>
#include <string>

CPU::CPU(Memory& mem_ref, InstManager& im_ref)
    : memory(mem_ref), inst_manager(im_ref)
{
    reg[0] = 0;
}

static bool inst_reads_rs1(uint32_t inst_id) {
    if (inst_id == INST_LUI || inst_id == INST_AUIPC || inst_id == INST_JAL) {
        return false;
    }
    return true;
}

static bool inst_reads_rs2(uint32_t inst_id) {
    switch (inst_id) {
        case INST_ADD:
        case INST_SUB:
        case INST_SLL:
        case INST_SRL:
        case INST_SRA:
        case INST_XOR:
        case INST_OR:
        case INST_AND:
        case INST_MUL:
        case INST_MULH:
        case INST_BEQ:
        case INST_BNE:
        case INST_BLT:
        case INST_BGE:
        case INST_BLTU:
        case INST_BGEU:
        case INST_SW:
        case INST_SB:
        case INST_CSRRW:
        case INST_CSRRS:
        case INST_CSRRC:
            return true;
        default:
            return false;
    }
}

static bool inst_is_simple_alu(uint32_t inst_id) {
    switch (inst_id) {
        case INST_ADD:
        case INST_SUB:
        case INST_ADDI:
        case INST_ANDI:
        case INST_XORI:
        case INST_LUI:
        case INST_AUIPC:
        case INST_SLL:
        case INST_SLLI:
        case INST_SRL:
        case INST_SRLI:
        case INST_SRA:
        case INST_SRAI:
        case INST_XOR:
        case INST_OR:
        case INST_AND:
            return true;
        default:
            return false;
    }
}

static bool inst_writes_rd(uint32_t inst_id) {
    switch (inst_id) {
        case INST_ADD:
        case INST_SUB:
        case INST_MUL:
        case INST_MULH:
        case INST_ADDI:
        case INST_ANDI:
        case INST_XORI:
        case INST_LUI:
        case INST_AUIPC:
        case INST_SLL:
        case INST_SLLI:
        case INST_SRL:
        case INST_SRLI:
        case INST_SRA:
        case INST_SRAI:
        case INST_XOR:
        case INST_OR:
        case INST_AND:
        case INST_LW:
        case INST_LBU:
        case INST_LB:
        case INST_JAL:
        case INST_JALR:
        case INST_CSRRW:
        case INST_CSRRS:
        case INST_CSRRC:
        case INST_CSRRWI:
        case INST_CSRRSI:
        case INST_CSRRCI:
            return true;
        default:
            return false;
    }
}

void CPU::reset_instruction_statistics() {
    for (int i = 0; i < 32; ++i) {
        gpr_read_count_[i] = 0;
        gpr_write_count_[i] = 0;
    }
    mul_issued_count_ = 0;
    mul_completed_count_ = 0;
}

void CPU::dump_instruction_statistics(std::ostream& os) const {
    uint64_t rd_total = 0;
    uint64_t wr_total = 0;
    for (int i = 0; i < 32; ++i) {
        rd_total += gpr_read_count_[i];
        wr_total += gpr_write_count_[i];
    }
    os << "  寄存器读次数合计: " << rd_total << "  写次数合计: " << wr_total << "\n";
    os << "  各寄存器读/写 (x0 也会统计读端口占用):\n";
    for (int i = 0; i < 32; ++i) {
        if (gpr_read_count_[i] == 0 && gpr_write_count_[i] == 0) {
            continue;
        }
        os << "    x" << i << " 读=" << gpr_read_count_[i] << " 写=" << gpr_write_count_[i] << "\n";
    }
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

        if (mul_unit_.has_pending_write()) {
            const uint32_t pending_rd = mul_unit_.pending_rd();
            const uint32_t next_id = in.inst.inst_id();
            const bool reads_pending =
                (pending_rd != 0) &&
                ((inst_reads_rs1(next_id) && in.inst.rs1() == pending_rd) ||
                 (inst_reads_rs2(next_id) && in.inst.rs2() == pending_rd));
            const bool writes_pending =
                (pending_rd != 0) && inst_writes_rd(next_id) && (in.inst.rd() == pending_rd);
            const bool mul_port_busy = (next_id == INST_MUL) && !mul_unit_.can_issue();
            if (reads_pending || writes_pending || mul_port_busy) {
                stall = true;
                LOG("MUL scoreboard stall: pending x" + DEC(pending_rd) +
                    " next=" + get_inst_name(next_id));
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
        if (inst_reads_rs1(out.inst_id) && out.rs1 < 32) {
            gpr_read_count_[out.rs1]++;
        }
        if (inst_reads_rs2(out.inst_id) && out.rs2 < 32) {
            gpr_read_count_[out.rs2]++;
        }

        switch (out.inst_id) {
            case INST_ADD: // ADD
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_SUB: // SUB
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::SUB;
                break;
            case INST_MUL: // MUL (RV32M low 32-bit result)
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_MULH: // MULH (RV32M signed high 32-bit result)
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_ADDI: // ADDI
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_AUIPC: // AUIPC
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::ADD;
                break;
            case INST_LUI: // LUI
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
            case INST_SLL:          // SLL
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::SLL;
                break;
            case INST_SRLI:         // SRLI
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::SRL;
                break;
            case INST_SRAI:         // SRAI
                out.reg_write = true;
                out.alu_src = true;
                out.alu_op = ALUOp::SRA;
                break;
            case INST_SRL:   // R-type shift
                out.reg_write = true;
                out.alu_src = false;  // uses rs2, not immediate
                out.alu_op = ALUOp::SRL;
                break;
            case INST_SRA:   // R-type arithmetic shift
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::SRA;
                break;
            case INST_XOR:   // R-type xor
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::XOR;
                break;
            case INST_OR:    // R-type or
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::OR;
                break;
            case INST_AND:   // R-type and
                out.reg_write = true;
                out.alu_src = false;
                out.alu_op = ALUOp::AND;
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
            case INST_JAL:
            case INST_JALR:
                out.reg_write = true;
                break;
            case INST_BEQ:
            case INST_BNE:
            case INST_BLT:
            case INST_BGE:
            case INST_BLTU:
            case INST_BGEU:
                out.reg_write = false;
                out.mem_read = false;
                out.mem_write = false;
                break;
        }
        
}

void CPU::execute(Pipe_ID_EX& in, const Pipe_EX_MEM& prev_ex_mem, Pipe_EX_MEM& out) {
    SCOPE;
    out.valid = false;

    // Forwarding: use youngest result first (MEM/WB then EX/MEM).
    // IMPORTANT: use prev_ex_mem (the prior cycle's EX/MEM latch).
    if (mul_unit_.result_ready()) {
        uint32_t m_rd = 0, m_pc = 0, m_prod = 0;
        mul_unit_.consume_result(m_rd, m_pc, m_prod);
        mul_completed_count_++;
        out.valid = true;
        out.pc = m_pc;
        out.rd = m_rd;
        out.alu_result = m_prod;
        out.val_rs2 = 0;
        out.reg_write = true;
        out.mem_read = false;
        out.mem_write = false;
        out.is_byte = false;
        out.is_unsigned = false;
        out.pc_modified = false;
        LOG("MUL (multiplier): complete, rd=x" + DEC(m_rd) + " prod=" + HEX(m_prod));
        return;
    }

    if (!in.valid) {
        return;
    }

    uint32_t rs1_val = reg[in.rs1];
    uint32_t rs2_val = reg[in.rs2];
    if (mem_wb.valid && mem_wb.reg_write && mem_wb.rd != 0) {
        uint32_t wb_val = mem_wb.mem_read ? mem_wb.mem_data : mem_wb.alu_result;
        if (mem_wb.rd == in.rs1) { rs1_val = wb_val; LOGIF("FWD: x" + DEC(in.rs1) + " <- MEM/WB", DEBUG); }
        if (mem_wb.rd == in.rs2) { rs2_val = wb_val; LOGIF("FWD: x" + DEC(in.rs2) + " <- MEM/WB", DEBUG); }
    }
    if (prev_ex_mem.valid && prev_ex_mem.reg_write && prev_ex_mem.rd != 0) {
        if (prev_ex_mem.rd == in.rs1) { rs1_val = prev_ex_mem.alu_result; LOGIF("FWD: x" + DEC(in.rs1) + " <- EX/MEM", DEBUG); }
        if (prev_ex_mem.rd == in.rs2) { rs2_val = prev_ex_mem.alu_result; LOGIF("FWD: x" + DEC(in.rs2) + " <- EX/MEM", DEBUG); }
    }
    in.val_rs1 = rs1_val;
    in.val_rs2 = rs2_val;

    if (in.inst_id == INST_MUL) {
        mul_unit_.issue(rs1_val, rs2_val, in.rd, in.pc);
        mul_issued_count_++;
        LOG("MUL (multiplier): issue, latency=" + DEC(MultiplierUnit::kLatency) +
            " rs1=" + HEX(rs1_val) + " rs2=" + HEX(rs2_val));
        return;
    }

    if (in.inst_id == INST_MULH) {
        const int64_t prod =
            static_cast<int64_t>(static_cast<int32_t>(rs1_val)) *
            static_cast<int64_t>(static_cast<int32_t>(rs2_val));
        out.valid = true;
        out.pc = in.pc;
        out.rd = in.rd;
        out.alu_result = static_cast<uint32_t>((static_cast<uint64_t>(prod) >> 32) & 0xFFFFFFFFu);
        out.val_rs2 = in.val_rs2;
        out.reg_write = true;
        out.mem_read = false;
        out.mem_write = false;
        out.is_byte = false;
        out.is_unsigned = false;
        out.pc_modified = false;
        return;
    }

    out.valid   = true;
    out.pc      = in.pc;
    out.rd      = in.rd;
    out.pc_modified = false;

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

        // ----- BLTU: branch if rs1 < rs2 (unsigned) -----
        case INST_BLTU: {
            out.target_pc   = in.pc + static_cast<uint32_t>(in.imm);
            out.pc_modified = (in.val_rs1 < in.val_rs2);
            out.reg_write   = false;
            out.mem_read    = false;
            out.mem_write   = false;
            LOG("BLTU: " + HEX(in.val_rs1) + " < " + HEX(in.val_rs2) +
                " ? " + (out.pc_modified ? "TAKEN" : "NOT TAKEN"));
            return;
        }

        // ----- BGEU: branch if rs1 >= rs2 (unsigned) -----
        case INST_BGEU: {
            out.target_pc   = in.pc + static_cast<uint32_t>(in.imm);
            out.pc_modified = (in.val_rs1 >= in.val_rs2);
            out.reg_write   = false;
            out.mem_read    = false;
            out.mem_write   = false;
            LOG("BGEU: " + HEX(in.val_rs1) + " >= " + HEX(in.val_rs2) +
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
    if (!inst_manager.has_instruction(in.inst_id)) {
        halt = true;
        exit_code = -2;
        out.reg_write = false;
        out.mem_read = false;
        out.mem_write = false;
        uint32_t raw = 0;
        if (bus) {
            raw = bus->read_word(in.pc);
        } else {
            raw = memory.read_word(in.pc);
        }
        std::cerr << "[模拟器] 非法/未实现指令，已停止。inst_id=0x"
                  << std::hex << in.inst_id << std::dec
                  << " pc=0x" << std::hex << in.pc
                  << " raw=0x" << raw << std::dec << "\n";
        return;
    }

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

        // Clear last access (set again below if we actually touch memory/MMIO)
        last_mem_valid = false;

        out.valid = true;
        out.rd = in.rd;
        out.alu_result = in.alu_result;
        out.is_byte    = in.is_byte;
        out.reg_write = in.reg_write;
        out.mem_read  = in.mem_read;
        uint32_t addr = in.alu_result;
        if (in.mem_read) {
        last_mem_valid = true;
        last_mem_is_read = true;
        last_mem_addr = addr;
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
            last_mem_read_data = out.mem_data;
            LOG("LB/LBU addr: " + HEX(addr));
        }
        else {  // word load (LW)
            if (bus) {
                out.mem_data = bus->read_word(addr);
            } else {
                out.mem_data = memory.read_word(addr);
            }
            last_mem_read_data = out.mem_data;
            LOG("LW addr: " + HEX(addr));
        }
    }
    else if (in.mem_write) {
        last_mem_valid = true;
        last_mem_is_read = false;
        last_mem_addr = addr;
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
            gpr_write_count_[in.rd]++;
            std::string source = in.mem_read ? "MEM" : "ALU";
            LOG("WB: r" + DEC(in.rd) + " = "  + HEX(data) + " (from " + source + ")"); 
        }
                
}

void CPU::tick_mmio_and_irq_sources() {
    if (bus && int_ctrl) {
        Timer* timer = dynamic_cast<Timer*>(bus->find_device(0x02004000));
        if (timer) {
            timer->tick();
            if (timer->check_interrupt()) {
                int_ctrl->request_interrupt(InterruptType::TIMER, 0);
            }
        }

        UART* uart_dev = dynamic_cast<UART*>(bus->find_device(0x10000000));
        if (uart_dev && uart_dev->check_interrupt()) {
            int_ctrl->request_interrupt(InterruptType::EXTERNAL, 0);
        }
    }

    if (int_ctrl) {
        int_ctrl->tick();
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
    mul_unit_.tick();
    const bool mul_result_occupies_ex_this_cycle = mul_unit_.result_ready();
    Pipe_EX_MEM prev_ex_mem = ex_mem;
    execute(id_ex, prev_ex_mem, ex_mem);
    // ECALL/EBREAK set halt in execute; do not decode/fetch this cycle or we may
    // fault on a bogus PC or pull more instructions after syscall.
    if (halt)
        return true;
    // 控制流重定向：仅冲刷比 EX 更年轻的流水级（IF/ID、ID/EX）。
    // 本周期 EX/MEM 已是产生跳转的那条指令的结果（如 JAL 的 link），必须保留，不得清空 ex_mem。
    if (ex_mem.pc_modified) {
        mul_unit_.cancel();
        // 越界哨兵：若跳转目标不在任何已加载 ELF 段范围内，通常表示返回地址/跳转目标被破坏。
        const auto& elf = loaded_elf_last_info();
        if (!loaded_elf_contains(elf, ex_mem.target_pc)) {
            uint32_t raw = 0;
            if (bus) {
                raw = bus->read_word(ex_mem.pc);
            } else {
                raw = memory.read_word(ex_mem.pc);
            }
            halt = true;
            exit_code = -3;
            std::cerr << "[模拟器] 跳转目标越界，已停止。pc=0x" << std::hex << ex_mem.pc
                      << " raw=0x" << raw
                      << " -> target_pc=0x" << ex_mem.target_pc;
            // 如果是 JALR，额外打印 rs1/imm/rs1_val，方便定位是函数指针为 0 还是计算错。
            if ((raw & 0x7f) == 0x67) {
                const uint32_t rs1 = (raw >> 15) & 0x1f;
                int32_t imm = static_cast<int32_t>(raw) >> 20; // sign-extend imm[31:20]
                uint32_t rs1_word = 0;
                if (bus) {
                    rs1_word = bus->read_word(reg[8]); // s0 is frequently used as table pointer in crt/newlib
                } else {
                    rs1_word = memory.read_word(reg[8]);
                }
                uint32_t init0 = bus ? bus->read_word(0x130c4) : memory.read_word(0x130c4);
                uint32_t init1 = bus ? bus->read_word(0x130c8) : memory.read_word(0x130c8);
                std::cerr << " (JALR rs1=x" << std::dec << rs1
                          << " rs1_val=0x" << std::hex << reg[rs1]
                          << " imm=" << std::dec << imm
                          << " s0=0x" << std::hex << reg[8]
                          << " mem[s0]=0x" << rs1_word
                          << " init_array[0]=0x" << init0
                          << " init_array[1]=0x" << init1 << ")";
            }
            std::cerr << std::dec << "\n";
            return true;
        }
        pc = ex_mem.target_pc;
        if_id.valid = false;
        id_ex.valid = false;
        ex_mem.pc_modified = false;
        LOG("FLUSH: branch/jump taken, PC -> " + HEX(pc));
    }
    if (mul_result_occupies_ex_this_cycle) {
        tick_mmio_and_irq_sources();
        return true;
    }
    decode(if_id, id_ex);
    fetch(if_id);
    
    tick_mmio_and_irq_sources();
    //dump_registers();
    //dump_pipeline_state();
    return true;
} 


void CPU::run(size_t max_steps) {
    step_count = 0;

    const size_t effective_limit = max_steps
        ? std::min(max_steps, kHardAbsoluteRunStepLimit)
        : kDefaultRunStepLimit;

    SimLogConfig::step_scope_enabled = true;
    SimLogConfig::current_step = 0;
    while (!halt) {
        if (step_count >= effective_limit) {
            if (!halt) {
                std::cerr << "[模拟器] 已达步数上限 " << effective_limit
                          << "，未通过 ECALL 正常退出。请检查死循环，或显式传入更大的 max_steps（受 "
                             "CPU::kHardAbsoluteRunStepLimit 硬顶）；max_steps==0 时默认上限为 "
                             "CPU::kDefaultRunStepLimit。\n";
            }
            break;
        }
        SimLogConfig::current_step = step_count;
        GAP;
        LOG("Step: " + DEC(step_count));
        GAP;
        if (!step()) {
            break;
        }
        step_count++;
    }
    SimLogConfig::step_scope_enabled = false;

    if (halt) {
        LOG("Halted (ECALL/EBREAK).");
    }

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
        if (opcode == INST_MUL) {
            return "MUL";
        }
        if (opcode == INST_MULH) {
            return "MULH";
        }
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