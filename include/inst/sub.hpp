#ifndef INST_SUB_HPP
#define INST_SUB_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "decode.hpp"
#define DEBUG 1
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

#endif // INST_SUB_HPP