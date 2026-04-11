#include "utils/utils.hpp"
#include "CPU.hpp"  
#include "Pipe.hpp"   
#include "ALU.hpp"
#define DEBUG 1
// LUI (U-type, opcode 0x37)
inline void inst_lui(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    // LUI simply moves the immediate (already shifted) into rd
    // Effectively: 0 + imm
    out.alu_result = in.imm;
    out.reg_write = in.reg_write;

    LOG("LUI: Result=" + HEX(out.alu_result));
}
