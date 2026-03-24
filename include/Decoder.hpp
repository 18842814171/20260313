#ifndef DECODE_HPP
#define DECODE_HPP
#pragma once
#include <cstdint>
#include "encoding.hpp"
#include "CPU.hpp"
#include "opcode.hpp"
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

    
    uint32_t inst_id() const;

    int32_t i_imm() const;

    int32_t s_imm() const;

    int32_t b_imm() const;

    int32_t u_imm() const;

    int32_t j_imm() const;
    uint32_t calc_addr(const CPU& cpu, Inst inst)const;    

private:
    uint32_t bits(unsigned lo, unsigned len) const;
    int32_t sext(uint32_t val, unsigned width) const;
};

#endif