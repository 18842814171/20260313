// inst/jump.hpp

#ifndef INST_JUMP_HPP
#define INST_JUMP_HPP

#include "CPU.hpp"
#include "Pipe.hpp"

// JAL - Jump and Link (U-type like, but with PC update)
inline void inst_jal(CPU& cpu, Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;

    // JAL: rd = PC + 4
    //      PC = PC + sign-extended 20-bit immediate (shifted left by 1)
    //uint32_t next_pc = p.pc + 4;
    int32_t offset = p.imm << 1;           // JAL immediate is already shifted left by 1 in decoder

    uint32_t target = p.pc + offset;

    LOG("pc = " + std::to_string(p.pc));
    LOG("imm = " + std::to_string(p.imm));
    LOG("offset = " + std::to_string(offset));
    LOG("target = " + std::to_string(target));

    
    p.alu_result = target;    // New PC value

    p.pc_modified = true;     // Important: tell pipeline we changed PC
    p.reg_write = true;
    POP;
}

// JALR - Jump and Link Register
inline void inst_jalr(CPU& cpu, Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;

    // JALR: rd = PC + 4
    //       PC = (rs1 + sign-extended 12-bit immediate) & ~1  (clear LSB)
    //uint32_t next_pc = p.pc + 4;
    int32_t offset = p.imm;                    // 12-bit immediate (already sign-extended in decoder)

    uint32_t target = (p.val_rs1 + offset) & 0xFFFFFFFE;   // Force even address (clear bit 0)

    LOG("pc = " + std::to_string(p.pc));
    LOG("rs1_val = " + std::to_string(p.val_rs1));
    LOG("imm = " + std::to_string(p.imm));
    LOG("target = " + std::to_string(target));

    
    p.alu_result = target;

    p.pc_modified = true;
    p.reg_write = true;
    POP;
}

#endif