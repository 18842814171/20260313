// include/inst/add.hpp
#ifndef INST_ADD_HPP
#define INST_ADD_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "decode.hpp"
//#include "inst_name.hpp"
inline void inst_add(CPU& cpu, Memory& mem, const Inst& inst) {
    
    //cpu.reg[inst.rd] = cpu.reg[inst.rs1] + cpu.reg[inst.rs2];
    LOG("ADD");
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

#endif // INST_ADD_HPP