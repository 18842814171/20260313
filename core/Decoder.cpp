//Decoder.cpp
#include "Decoder.hpp"

#include <cstdint>
#include "encoding.hpp"


int32_t Inst::i_imm() const {
        return sext(bits(20,12), 12);
    }

int32_t Inst::s_imm() const {
        return sext(bits(7,5) | (bits(25,7) << 5), 12);
    }

int32_t Inst::b_imm() const {
        return sext(
            (bits(8,4) << 1) |
            (bits(25,6) << 5) |
            (bits(7,1)  << 11) |
            (bits(31,1) << 12),
            13
        );
    }

int32_t Inst::u_imm() const {
        return int32_t(raw & 0xFFFFF000);
    }

int32_t Inst::j_imm() const {
        return sext(
            (bits(21,10) << 1) |
            (bits(20,1)  << 11) |
            (bits(12,8)  << 12) |
            (bits(31,1)  << 20),
            21
        );
    }

int32_t Inst::imm() const { //choose imm type
    switch (opcode()) {
        case OP_IMM:
        case OP_LOAD:
        case OP_JALR:
            return i_imm();

        case OP_STORE:
            return s_imm();

        case OP_BRANCH:
            return b_imm();

        case OP_LUI:
        case OP_AUIPC:
            return u_imm();

        case OP_JAL:
            return j_imm();
    }
    return 0;
}

uint32_t Inst::bits(unsigned lo, unsigned len) const {
        return (raw >> lo) & ((len == 32) ? 0xFFFFFFFFu : ((1u << len) - 1));
    }

int32_t Inst::sext(uint32_t val, unsigned width) const {
        uint32_t sign = 1u << (width - 1);
        return (val ^ sign) - sign;
    }

uint32_t Inst::inst_id() const{ // Use internal 'raw'
    uint32_t op = opcode();
    uint32_t f3 = funct3();
    uint32_t f7 = funct7();
    // NOTE: third argument is overloaded:
    // - R-type: full funct7
    // - shift-immediate: bit30 only
    // - SYSTEM: csr (imm12)
    switch (op) {
        case OP_OP:
            return make_inst_id(op, f3, f7);

        case OP_IMM:
            // SLLI, SRLI, and SRAI require part of funct7 (bit 30)
            if (f3 == 0x1 || f3 == 0x5) {
                uint32_t f7_bit30 = (f7 >> 5) & 0x1; // extract bit 30
                return make_inst_id(op, f3, f7_bit30);
            }
            return make_inst_id(op, f3, 0);

        case OP_LOAD:
        case OP_STORE:
        case OP_BRANCH:
        case OP_JALR:
            return make_inst_id(op, f3, 0);

        case OP_LUI:
        case OP_AUIPC:
        case OP_JAL:
            return make_inst_id(op, 0, 0);
        
        case OP_SYSTEM: // SYSTEM
            if (f3 == 0) { // Privileged instructions
                uint32_t imm12 = raw >> 20;
                if (imm12 == 0) return INST_ECALL;
                if (imm12 == 1) return INST_EBREAK;
            }
            uint32_t csr = raw >> 20; // imm12
            return make_inst_id(op, f3, csr); // CSR instructions
    }
    return 0;
}

bool Inst::writes_rd() const {
    uint32_t op = opcode();
    switch (op) {
        case OP_LUI:
        case OP_AUIPC:
        case OP_JAL:
        case OP_JALR:
        case OP_LOAD:
        case OP_IMM:
        case OP_OP:
            return true;
        case OP_SYSTEM: // SYSTEM (CSR instructions write to rd, ECALL/EBREAK do not)
            return funct3() != 0; 
        default:
            return false;
    }
}