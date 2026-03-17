// include/inst/add.hpp
#ifndef INST_ADD_HPP
#define INST_ADD_HPP
#include "utils/utils.hpp"
#include "Types.hpp"     

inline void inst_add(CPU& cpu, Memory& mem, DecodedInst& inst) {
    cpu.reg[inst.rd] = cpu.reg[inst.rs1] + cpu.reg[inst.rs2];
}

#endif // INST_ADD_HPP