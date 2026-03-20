#ifndef DECODE_HPP
#define DECODE_HPP
#pragma once
#include <cstdint>
#include "encoding.hpp"
class Inst {
public:
    uint32_t raw;

    Inst(uint32_t bits = 0) : raw(bits) {}

    uint32_t opcode() const { return bits(0, 7); }
    uint32_t rd()     const { return bits(7, 5); }
    uint32_t funct3() const { return bits(12, 3); }
    uint32_t rs1()    const { return bits(15, 5); }
    uint32_t rs2()    const { return bits(20, 5); }
    uint32_t funct7() const { return bits(25, 7); }

    
    uint32_t inst_id() const {
       return make_inst_id(opcode(), funct3(), funct7());
    }

    int32_t i_imm() const {
        return sext(bits(20,12), 12);
    }

    int32_t s_imm() const {
        return sext(bits(7,5) | (bits(25,7) << 5), 12);
    }

    int32_t b_imm() const {
        return sext(
            (bits(8,4) << 1) |
            (bits(25,6) << 5) |
            (bits(7,1)  << 11) |
            (bits(31,1) << 12),
            13
        );
    }

    int32_t u_imm() const {
        return int32_t(raw & 0xFFFFF000);
    }

    int32_t j_imm() const {
        return sext(
            (bits(21,10) << 1) |
            (bits(20,1)  << 11) |
            (bits(12,8)  << 12) |
            (bits(31,1)  << 20),
            21
        );
    }
    

private:
    uint32_t bits(unsigned lo, unsigned len) const {
        return (raw >> lo) & ((len == 32) ? 0xFFFFFFFFu : ((1u << len) - 1));
    }

    int32_t sext(uint32_t val, unsigned width) const {
        uint32_t sign = 1u << (width - 1);
        return (val ^ sign) - sign;
    }
};

#endif