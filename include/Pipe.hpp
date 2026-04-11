#ifndef PIPE_HPP
#define PIPE_HPP
#include "Decoder.hpp"
#include "ALU.hpp"
//Pipe if_id{}, id_ex{}, ex_mem{}, mem_wb{};

enum class PipeStage {
    IF,
    ID,
    EX,
    MEM,
    WB
};

struct Pipe_ID_EX{
    bool valid = false;

    uint32_t pc;
    uint32_t inst_id;
    // decoded fields
    uint32_t rs1, rs2, rd;
    int32_t imm;

    uint32_t val_rs1, val_rs2;

    // control
    bool alu_src;
    ALUOp alu_op;

    bool reg_write;
    bool mem_read;
    bool mem_write;
    
    // interrupt/exception related
    bool is_trap;
    uint32_t trap_cause;
};

struct Pipe_EX_MEM{
    bool valid = false;

    uint32_t pc;
    uint32_t rd;

    uint32_t alu_result;
    uint32_t val_rs2;   // needed for SW
    uint32_t target_pc;
    // control
    bool pc_modified;
    bool reg_write;
    bool mem_read;
    bool mem_write;
    
    // interrupt/exception related
    bool is_trap;
    uint32_t trap_cause;
};

struct Pipe_MEM_WB{
    bool valid = false;

    uint32_t rd;

    uint32_t alu_result;
    uint32_t mem_data;

    // control
    bool reg_write;
    bool mem_read;
    
    // interrupt/exception related
    bool is_trap;
    uint32_t trap_cause;
};

struct Pipe_IF_ID {
    bool valid = false;
    Inst inst;

    uint32_t pc;
    
    // for interrupt handling
    bool interrupt_taken;
    uint32_t interrupt_pc;
};


#endif