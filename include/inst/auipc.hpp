// include/inst/auipc.hpp
#ifndef INST_AUIPC_HPP
#define INST_AUIPC_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#include "Pipe.hpp"
#define DEBUG 1

inline void inst_auipc(CPU& cpu, Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;
    
    // AUIPC adds the 20-bit immediate shifted left by 12 to the PC
    // imm[31:12] is the immediate value, shifted left by 12
    // The immediate is sign-extended to 32 bits
   
    uint32_t result = p.pc + (uint32_t)p.imm;
    
    LOG("pc = " + DEC(p.pc));
    LOG("imm = " + DEC(p.imm));
    LOG("result = " + DEC(result));
    
    p.alu_result = result;
    p.reg_write = true;
    POP;
    LOG("p address = " + HEX((uint64_t)&p));
}

#endif