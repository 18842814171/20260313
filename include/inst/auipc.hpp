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
    uint32_t imm = p.imm;  // Get the 20-bit immediate (bits 31-12)
    uint32_t result = p.pc + (imm << 12);
    
    LOG("pc = " + std::to_string(p.pc));
    LOG("imm = " + std::to_string(imm));
    LOG("result = " + std::to_string(result));
    
    p.rd = result;
    
    POP;
}

#endif