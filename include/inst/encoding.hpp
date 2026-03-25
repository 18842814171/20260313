#pragma once
//encoding.hpp

constexpr uint32_t make_inst_id(uint32_t opcode, uint32_t funct3, uint32_t funct7 = 0){
        return opcode | (funct3 << 7) | (funct7 << 10);
    }

// ADD and SUB (R-type)
constexpr uint32_t INST_ADD =
    make_inst_id(0x33, 0b000, 0b0000000);

constexpr uint32_t INST_SUB =
    make_inst_id(0x33, 0b000, 0b0100000);

// ADDI (I-type) - no funct7 needed for I-type instructions
constexpr uint32_t INST_ADDI =
    make_inst_id(0x13, 0b000);  // OP_IMM = 0x13, funct3 = 0b000 for ADD/ADDI

constexpr uint32_t INST_LW =
    make_inst_id(0x03, 0b010, 0);

// ====================== S-type ======================
constexpr uint32_t INST_SW = 
    make_inst_id(0x23, 0b010);          // STORE, funct3=010  ← you already had this

// ====================== U-type (the ones that crashed your run) ======================
constexpr uint32_t INST_LUI   = make_inst_id(0x37, 0);   // opcode 0x37, no funct3/funct7
constexpr uint32_t INST_AUIPC = make_inst_id(0x17, 0);   // opcode 0x17, no funct3/funct7

// ====================== B-type ======================
constexpr uint32_t INST_BEQ   = make_inst_id(0x63, 0b000);   // BRANCH, funct3=000

// ====================== System ======================
constexpr uint32_t INST_ECALL = make_inst_id(0x73, 0b000);   // SYSTEM, funct3=000, imm=0 for ECALL
