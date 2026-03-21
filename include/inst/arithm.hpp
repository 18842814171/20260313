// include/inst/add.hpp
#ifndef INST_ARITHM_HPP
#define INST_ARITHM_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#define DEBUG 1
inline void inst_add(CPU& cpu, Memory& mem, const Inst& inst) {
    
    //cpu.reg[inst.rd] = cpu.reg[inst.rs1] + cpu.reg[inst.rs2];
    LOG(cpu.get_inst_name(inst.inst_id()));
    PUSH;

    int a = cpu.reg[inst.rs1()];
    int b = cpu.reg[inst.rs2()];
    int result = a + b;

    LOG("rs1 = " + std::to_string(a));
    LOG("rs2 = " + std::to_string(b));
    LOG("result = " + std::to_string(result));

    cpu.reg[inst.rd()] = result;

    POP;
}

inline void inst_addi(CPU& cpu, Memory& mem, const Inst& inst) {
    
    LOG(cpu.get_inst_name(inst.inst_id()));
    PUSH;

    int a = cpu.reg[inst.rs1()];
    int imm = inst.i_imm();  // Get immediate value from instruction
    int result = a + imm;

    LOG("rs1 = " + std::to_string(a));
    LOG("imm = " + std::to_string(imm));
    LOG("result = " + std::to_string(result));

    cpu.reg[inst.rd()] = result;

    POP;
}

inline void inst_sub(CPU& cpu, Memory& mem, const Inst& inst) {
    LOG(cpu.get_inst_name(inst.inst_id()));  
    //LOG("SUB");
    PUSH;

    int a = cpu.reg[inst.rs1()];
    int b = cpu.reg[inst.rs2()];
    int result = a - b;  // Subtraction instead of addition

    LOG("rs1 = " + std::to_string(a));
    LOG("rs2 = " + std::to_string(b));
    LOG("result = " + std::to_string(result));

    cpu.reg[inst.rd()] = result;

    POP;
}

#endif // INST_ARITHM_HPP