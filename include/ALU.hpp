#pragma once
#ifndef ALU_HPP
#define ALU_HPP
#include <cstdint>
#include "encoding.hpp"

// Better choice function that handles different but compatible types
template<typename T, typename U>
T choice(bool sel, T a, U b) {
    return sel ? static_cast<T>(b) : a;
}

enum class ALUOp {
    ADD,
    SUB,
    AND,
    OR,
    XOR,
    SLT,
    SLL,
    SRL,
    SRA,
    NONE
};
uint32_t alu_execute(ALUOp op, uint32_t a, uint32_t b) ;
#endif