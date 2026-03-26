#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#include "Pipe.hpp"
#define DEBUG 1
// === B-type: BEQ (opcode 0x63, funct3=0) ===
inline void inst_beq(CPU& cpu,  Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;
    int a = p.rs1;
    int b = p.rs2;
    int imm = p.imm;                    // Decoder must sign-extend and <<1 for B-type
    LOG("rs1 = " + std::to_string(a));
    LOG("rs2 = " + std::to_string(b));
    LOG("imm (offset) = " + std::to_string(imm));
    if (a == b) {
        p.pc += imm;                   // because PC will be +=4 after this step
        p.pc_modified = true;
        LOG("branch taken -> new PC = " + std::to_string(p.pc));
    } else {
        LOG("branch not taken");
    }
    p.reg_write = true;
    POP;
}