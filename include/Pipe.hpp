#ifndef PIPE_HPP
#define PIPE_HPP
#include "Decoder.hpp"
#include "ALU.hpp"
struct Pipe {
    Inst inst;

    uint32_t pc;

    uint32_t inst_id;

    // decoded fields
    uint32_t rs1, rs2, rd;
    int32_t imm;

    // register values
    uint32_t val_rs1, val_rs2;
    // control signals
    bool alu_src;     // 0=rs2, 1=imm
    ALUOp alu_op;
    // execution result
    uint32_t alu_result;

    // control signals (important later)
    bool reg_write = false;
    bool mem_read  = false;
    bool mem_write = false;
    bool pc_modified = false;
    bool branch = false;
    
    uint32_t next_pc;
};

#endif