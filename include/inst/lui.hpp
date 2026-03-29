#include "utils/utils.hpp"
#include "CPU.hpp"  
#include "Pipe.hpp"   
#include "ALU.hpp"
#define DEBUG 1
// LUI (U-type, opcode 0x37)
inline void inst_lui(CPU& cpu, Pipe& p) {
    
    int imm20 = p.imm;                  // already <<12 by decoder
    LOG("imm20<<12 = " + std::to_string(imm20));
    p.alu_result = imm20;
     
    p.reg_write = true;
}

