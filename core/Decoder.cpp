#include "Decoder.hpp"

#include <cstdint>
#include "encoding.hpp"

uint32_t Inst::inst_id() const {
       return make_inst_id(opcode(), funct3(), funct7());
    }

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
uint32_t Inst::calc_addr(const CPU& cpu, Inst inst) const{
    uint32_t rs1 = inst.rs1();
    int32_t  imm;

    if (inst.opcode() == OP_LOAD) {
        imm = inst.i_imm();           // I-type immediate
    } else {
        imm = inst.s_imm();           // S-type immediate
    }

    return cpu.reg[rs1] + static_cast<uint32_t>(imm);
    }
    


uint32_t Inst::bits(unsigned lo, unsigned len) const {
        return (raw >> lo) & ((len == 32) ? 0xFFFFFFFFu : ((1u << len) - 1));
    }

int32_t Inst::sext(uint32_t val, unsigned width) const {
        uint32_t sign = 1u << (width - 1);
        return (val ^ sign) - sign;
    }
