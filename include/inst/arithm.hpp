// include/inst/add.hpp
#ifndef INST_ARITHM_HPP
#define INST_ARITHM_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#define DEBUG 1
inline void inst_add(CPU& cpu,  Pipe& p) {
    LOG("*************");
    int a = p.val_rs1;
    int b = p.val_rs2;
    int result = a + b;

    LOG("rs1 = " + std::to_string(a));
    LOG("rs2 = " + std::to_string(b));
    LOG("result = " + std::to_string(result));

    p.alu_result = result;
    p.reg_write = true;
     
}

inline void inst_addi(CPU& cpu, Pipe& p) {
    LOG("*************");
    
    int a = p.val_rs1;
    int imm = p.imm;  // Get immediate value from instruction
    int result = a + imm;

    LOG("rs1 = " + std::to_string(a));
    LOG("imm = " + std::to_string(imm));
    LOG("result = " + std::to_string(result));

    p.alu_result = result;
    p.reg_write = true;
     
}

inline void inst_sub(CPU& cpu, Pipe& p) {
    LOG("*************");
    int a = p.val_rs1;
    int b = p.val_rs2;
    int result = a - b;  // Subtraction instead of addition

    LOG("rs1 = " + std::to_string(a));
    LOG("rs2 = " + std::to_string(b));
    LOG("result = " + std::to_string(result));

    p.alu_result = result;
    p.reg_write = true;
     
}

#endif // INST_ARITHM_HPP