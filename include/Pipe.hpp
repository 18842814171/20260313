#ifndef PIPE_HPP
#define PIPE_HPP
#include "Decoder.hpp"
struct Pipe {
    Inst inst;

    uint32_t pc;

    uint32_t inst_id;

    // decoded fields
    uint32_t rs1, rs2, rd;
    int32_t imm;

    // register values
    uint32_t val_rs1, val_rs2;

    // execution result
    uint32_t alu_result;

    // memory result
    uint32_t mem_data;

    // control signals (important later)
    bool reg_write = false;
    bool mem_read  = false;
    bool mem_write = false;
    bool pc_modified = false;
};

#endif