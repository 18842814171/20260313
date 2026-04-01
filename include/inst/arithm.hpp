// include/inst/add.hpp
#ifndef INST_ARITHM_HPP
#define INST_ARITHM_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     

#include "ALU.hpp"
#define DEBUG 1
inline void inst_add(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {

    out.valid = in.valid;
    out.rd = in.rd;

    uint32_t in1 = in.val_rs1;
    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;

    out.alu_result = alu_execute(in.alu_op, in1, in2);

    out.val_rs2 = in.val_rs2;

    // pass control signals forward
    out.reg_write = in.reg_write;
    out.mem_read  = in.mem_read;
    out.mem_write = in.mem_write;
}

inline void inst_addi(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;
    //in.alu_src = true;
    uint32_t in1 = in.val_rs1;
    // For ADDI, alu_src should have been set to true in the Decode stage
    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;
    //out.alu_src = true;
    out.alu_result = alu_execute(in.alu_op, in1, in2);

    // Pass forward metadata and control signals
    out.val_rs2 = in.val_rs2;
    out.reg_write = in.reg_write;
    out.mem_read  = in.mem_read;
    out.mem_write = in.mem_write;
    LOG("Input1 value = " + std::to_string(in1));
    LOG("Input2 source = " + std::string(in.alu_src ? "Immediate" : "Register (rs2)"));
    LOG("Selected Input2 value = " + std::to_string(in2));
    // Optional Logging
    LOG("ADDI Result: " + std::to_string(out.alu_result));
}


inline void inst_sub(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    uint32_t in1 = in.val_rs1;
    // For SUB, alu_src should have been set to false in the Decode stage
    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;

    out.alu_result = alu_execute(in.alu_op, in1, in2);

    out.val_rs2 = in.val_rs2;
    out.reg_write = in.reg_write;
    out.mem_read  = in.mem_read;
    out.mem_write = in.mem_write;

    LOG("Input1 value = " + std::to_string(in1));
    LOG("Input2 source = " + std::string(in.alu_src ? "Immediate" : "Register (rs2)"));
    LOG("Selected Input2 value = " + std::to_string(in2));
    LOG("result = " + std::to_string(out.alu_result));
     
}

#endif // INST_ARITHM_HPP