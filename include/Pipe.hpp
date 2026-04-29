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
    bool is_byte = false;      // ← ADD THIS
    bool is_unsigned = false;  // ← ADD THIS (only meaningful for loads)
    // interrupt/exception related
    bool is_trap;
    uint32_t trap_cause;
};

struct Pipe_EX_MEM{
    bool valid = false;

    uint32_t pc;
    uint32_t rd;
    bool is_unsigned = false;
    uint32_t alu_result;
    uint32_t val_rs2;   // needed for SW
    uint32_t target_pc;
    // control
    bool pc_modified;
    bool reg_write;
    bool mem_read;
    bool mem_write;
    bool is_byte = false;
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
    bool is_byte = false;
    bool is_unsigned = false;
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

// 统一的日志字段清单：后续要新增/删除日志字段，只改这里即可。
#define PIPE_IF_ID_LOG_FIELDS(X) \
    X(valid)                     \
    X(pc)                        \
    X(interrupt_taken)           \
    X(interrupt_pc)

#define PIPE_ID_EX_LOG_FIELDS(X) \
    X(valid)                     \
    X(pc)                        \
    X(inst_id)                   \
    X(rs1)                       \
    X(rs2)                       \
    X(rd)                        \
    X(imm)                       \
    X(val_rs1)                   \
    X(val_rs2)                   \
    X(alu_src)                   \
    X(reg_write)                 \
    X(mem_read)                  \
    X(mem_write)                 \
    X(is_byte)                   \
    X(is_unsigned)               \
    X(is_trap)                   \
    X(trap_cause)

#define PIPE_EX_MEM_LOG_FIELDS(X) \
    X(valid)                      \
    X(pc)                         \
    X(rd)                         \
    X(is_unsigned)                \
    X(alu_result)                 \
    X(val_rs2)                    \
    X(target_pc)                  \
    X(pc_modified)                \
    X(reg_write)                  \
    X(mem_read)                   \
    X(mem_write)                  \
    X(is_byte)                    \
    X(is_trap)                    \
    X(trap_cause)

#define PIPE_MEM_WB_LOG_FIELDS(X) \
    X(valid)                      \
    X(rd)                         \
    X(alu_result)                 \
    X(mem_data)                   \
    X(reg_write)                  \
    X(mem_read)                   \
    X(is_byte)                    \
    X(is_unsigned)                \
    X(is_trap)                    \
    X(trap_cause)


#endif