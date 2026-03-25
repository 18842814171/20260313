#include "utils/utils.hpp"
#include "CPU.hpp"  
#include "Pipe.hpp"   
#include "Decoder.hpp"
#define DEBUG 1
// LUI (U-type, opcode 0x37)
inline void inst_lui(CPU& cpu, Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;
    int imm20 = p.imm;                  // already <<12 by decoder
    LOG("imm20<<12 = " + std::to_string(imm20));
    p.rd = imm20;
    POP;
}

// If you see ADDI with large imm or other I-type, they are already covered by inst_addi