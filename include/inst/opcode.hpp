// include/inst/opcode.hpp
#pragma once

// RV32I base opcodes
constexpr unsigned OP_ADD    = 0b0110011;  // ADD, SUB, etc.
constexpr unsigned OP_SUB    = OP_ADD;
constexpr unsigned OP_IMM    = 0b0010011;  // ADDI and other immediate instructions
constexpr unsigned OP_LUI    = 0b0110111;
constexpr unsigned OP_AUIPC  = 0b0010111;
constexpr unsigned OP_JAL    = 0b1101111;
constexpr unsigned OP_JALR   = 0b1100111;
constexpr unsigned OP_BRANCH = 0b1100011;
constexpr unsigned OP_LOAD   = 0b0000011;
constexpr unsigned OP_STORE  = 0b0100011;
constexpr unsigned OP_OP     = 0b0110011;
