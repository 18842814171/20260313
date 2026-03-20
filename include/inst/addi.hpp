#ifndef INST_ADDI_HPP
#define INST_ADDI_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "decode.hpp"
#define DEBUG 1
inline void inst_addi(CPU& cpu, Memory& mem, const Inst& inst) {
    
    LOG("ADDI");
    PUSH;

    int a = cpu.reg[inst.rs1()];
    int imm = inst.imm();  // Get immediate value from instruction
    int result = a + imm;

    LOG("rs1 = " + std::to_string(a));
    LOG("imm = " + std::to_string(imm));
    LOG("result = " + std::to_string(result));

    cpu.reg[inst.rd()] = result;

    POP;
}

#endif // INST_ADDI_HPP