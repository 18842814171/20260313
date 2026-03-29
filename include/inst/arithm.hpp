// include/inst/add.hpp
#ifndef INST_ARITHM_HPP
#define INST_ARITHM_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     

#include "ALU.hpp"
#define DEBUG 1
inline void inst_add(CPU& cpu,  Pipe& p) {
    LOG("*************");
    p.alu_src = false;
    p.alu_op  = ALUOp::ADD;
    
    uint32_t in1 = p.val_rs1;
    uint32_t in2 = choice(p.alu_src, p.val_rs2, p.imm);

    p.alu_result = alu_execute(p.alu_op, in1, in2); 
    p.reg_write = true;

    LOG("ALUOp:" + ALUOp);
    LOG("Input1 value = " + std::to_string(in1));
    LOG("Input2 source = " + std::string(p.alu_src ? "Immediate" : "Register (rs2)"));
    LOG("Selected Input2 value = " + std::to_string(in2));
    LOG("result = " + std::to_string(p.alu_result));

   
     
}

inline void inst_addi(CPU& cpu, Pipe& p) {
    LOG("*************");
    
    p.alu_src = true;
    p.alu_op  = ALUOp::ADD;
    
    uint32_t in1 = p.val_rs1;
    uint32_t in2 = choice(p.alu_src, p.val_rs2, p.imm);

    p.alu_result = alu_execute(p.alu_op, in1, in2); 
    p.reg_write = true;

    LOG("ALUOp:" + ALUOp);
    LOG("Input1 value = " + std::to_string(in1));
    LOG("Input2 source = " + std::string(p.alu_src ? "Immediate" : "Register (rs2)"));
    LOG("Selected Input2 value = " + std::to_string(in2));
    LOG("result = " + std::to_string(p.alu_result));
     
}

inline void inst_sub(CPU& cpu, Pipe& p) {
    LOG("*************");
    p.alu_src = false;
    p.alu_op  = ALUOp::SUB;
    
    uint32_t in1 = p.val_rs1;
    uint32_t in2 = choice(p.alu_src, p.val_rs2, p.imm);

    p.alu_result = alu_execute(p.alu_op, in1, in2); 
    p.reg_write = true;

    LOG("ALUOp:" + ALUOp);
    LOG("Input1 value = " + std::to_string(in1));
    LOG("Input2 source = " + std::string(p.alu_src ? "Immediate" : "Register (rs2)"));
    LOG("Selected Input2 value = " + std::to_string(in2));
    LOG("result = " + std::to_string(p.alu_result));
     
}

#endif // INST_ARITHM_HPP