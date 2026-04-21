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

inline void inst_slli(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    // RV32: shift amount is lower 5 bits
    uint32_t shamt = static_cast<uint32_t>(in.imm) & 0x1F;

    uint32_t val = in.val_rs1;

    out.alu_result = val << shamt;

    // no memory access
    out.mem_read = false;
    out.mem_write = false;

    // writeback
    out.reg_write = in.reg_write;

    // not a control-flow instruction
    out.pc_modified = false;

    LOG("SLLI: x" + std::to_string(in.rd) +
        " = x" + std::to_string(in.rs1) +
        " << " + std::to_string(shamt) +
        " = " + HEX(out.alu_result));
}


inline void inst_srl(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    uint32_t in1 = in.val_rs1;
    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;

    out.alu_result = alu_execute(ALUOp::SRL, in1, in2);

    // Control signals
    out.reg_write = true;
    out.mem_read = false;
    out.mem_write = false;
    LOG("SRL: in1=" + std::to_string(in1) + ", in2=" + std::to_string(in2)
          + ", result=" + std::to_string(out.alu_result));
}

inline void inst_srli(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;
    
    uint32_t in1 = in.val_rs1;
    uint32_t shift_amount = in.imm & 0x1F;  // Only lower 5 bits matter for RV32
    
    out.alu_result = alu_execute(ALUOp::SRL, in1, shift_amount);
    out.reg_write = true;
    out.mem_read = false;
    out.mem_write = false;
    
    LOG("SRLI: in1=" + std::to_string(in1) + ", shift=" + std::to_string(shift_amount)
          + ", result=" + std::to_string(out.alu_result));
}

inline void inst_andi(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;
    
    uint32_t in1 = in.val_rs1;
    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;
    
    out.alu_result = alu_execute(ALUOp::AND, in1, in2);
    
    // Control signals
    out.reg_write = true;
    out.mem_read = false;
    out.mem_write = false;
    
    LOG("ANDI: in1=" + std::to_string(in1) + ", imm=" + std::to_string(in.imm) 
          + ", result=" + std::to_string(out.alu_result));
}

inline void inst_xori(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;
    
    uint32_t in1 = in.val_rs1;
    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;
    
    out.alu_result = alu_execute(ALUOp::XOR, in1, in2);
    
    // Control signals
    out.reg_write = true;
    out.mem_read = false;
    out.mem_write = false;
    
    LOG("XORI: in1=" + std::to_string(in1) + ", imm=" + std::to_string(in.imm) 
          + ", result=" + std::to_string(out.alu_result));
}

#endif // INST_ARITHM_HPP