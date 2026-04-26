#pragma once
//encoding.hpp
#include"opcode.hpp"
constexpr uint32_t make_inst_id(uint32_t opcode, uint32_t funct3, uint32_t funct7 = 0){
        return opcode | (funct3 << 7) | (funct7 << 10);
    }

// ADD and SUB (R-type)
constexpr uint32_t INST_ADD =make_inst_id(0x33, 0b000, 0b0000000);
constexpr uint32_t INST_SUB =make_inst_id(0x33, 0b000, 0b0100000);
constexpr uint32_t INST_MUL =make_inst_id(0x33, 0b000, 0b0000001);
constexpr uint32_t INST_MULH =make_inst_id(0x33, 0b001, 0b0000001);
constexpr uint32_t INST_SLL =make_inst_id(0x33, 0b001, 0b0000000);
constexpr uint32_t INST_XOR =make_inst_id(0x33, 0b100, 0b0000000);
constexpr uint32_t INST_SRA =make_inst_id(0x33, 0b101, 0b0100000);
constexpr uint32_t INST_OR  =make_inst_id(0x33, 0b110, 0b0000000);
constexpr uint32_t INST_AND =make_inst_id(0x33, 0b111, 0b0000000);

// ADDI (I-type) - no funct7 needed for I-type instructions
constexpr uint32_t INST_ADDI =make_inst_id(0x13, 0b000);  // OP_IMM = 0x13, funct3 = 0b000 for ADD/ADDI
constexpr uint32_t INST_SLLI = make_inst_id(0x13, 0b001, 0);
constexpr uint32_t INST_SRL =make_inst_id(0x33,0b101, 0);
constexpr uint32_t INST_SRLI = make_inst_id(0x13, 0b101, 0);  // bit30=0
constexpr uint32_t INST_SRAI = make_inst_id(0x13, 0b101, 1);  // bit30=1
constexpr uint32_t INST_ANDI = make_inst_id(OP_IMM, 0b111, 0);  // funct3=0b111 for ANDI
constexpr uint32_t INST_XORI = make_inst_id(0x13, 0b100, 0);  // OP_IMM, funct3=0b100

constexpr uint32_t INST_LW = make_inst_id(0x03, 0b010, 0);
constexpr uint32_t INST_LBU =make_inst_id(0x03, 0b100, 0);
constexpr uint32_t INST_LB  = make_inst_id(0x03, 0b000, 0);   // funct3 = 000
// ====================== S-type ======================
constexpr uint32_t INST_SW = make_inst_id(0x23, 0b010);          // STORE, funct3=010  ← you already had this
constexpr uint32_t INST_SB = make_inst_id(0x23, 0b000);   // STORE, funct3=000
// ====================== U-type (the ones that crashed your run) ======================
constexpr uint32_t INST_LUI   = make_inst_id(0x37, 0);   // opcode 0x37, no funct3/funct7
constexpr uint32_t INST_AUIPC = make_inst_id(0x17, 0);   // opcode 0x17, no funct3/funct7

// ====================== B-type ======================
constexpr uint32_t INST_BEQ   = make_inst_id(0x63, 0b000);   // BRANCH, funct3=000
constexpr uint32_t INST_BNE = make_inst_id(OP_BRANCH, 0b001, 0);
constexpr uint32_t INST_BGE = make_inst_id(OP_BRANCH, 0b101, 0);  // funct3=0b101
constexpr uint32_t INST_BLTU = make_inst_id(OP_BRANCH, 0b110, 0);
constexpr uint32_t INST_BGEU = make_inst_id(OP_BRANCH, 0b111, 0);

constexpr uint32_t INST_BLT   = make_inst_id(0x63, 0b100, 0);
//======================= J-type ======================
constexpr uint32_t INST_JAL  = make_inst_id(0X6f, 0, 0);
constexpr uint32_t INST_JALR  = make_inst_id(0X67, 0, 0);

// ====================== System ======================
// imm12 encoded in "funct7 slot" (decoder key only)
constexpr uint32_t INST_ECALL  = make_inst_id(0x73, 0b000, 0);   // imm12 = 0
constexpr uint32_t INST_EBREAK = make_inst_id(0x73, 0b000, 1);   // imm12 = 1
constexpr uint32_t INST_WFI    = make_inst_id(0x73, 0b000, 5);   // imm12 = 5

// ====================== CSR Instructions ======================
// For CSRRW/CSRRS/CSRRCI: funct3 tells us the instruction type
// imm12 is stored in the funct7 bits
constexpr uint32_t INST_CSRRW = make_inst_id(0x73, 0b001, 0);  // CSR Read-Write
constexpr uint32_t INST_CSRRS = make_inst_id(0x73, 0b010, 0);  // CSR Read-Set
constexpr uint32_t INST_CSRRC = make_inst_id(0x73, 0b011, 0);  // CSR Read-Clear
constexpr uint32_t INST_CSRRWI = make_inst_id(0x73, 0b101, 0); // CSR Read-Write Imm
constexpr uint32_t INST_CSRRSI = make_inst_id(0x73, 0b110, 0); // CSR Read-Set Imm
constexpr uint32_t INST_CSRRCI = make_inst_id(0x73, 0b111, 0); // CSR Read-Clear Imm