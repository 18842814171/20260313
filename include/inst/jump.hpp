// inst/jump.hpp

#ifndef INST_JUMP_HPP
#define INST_JUMP_HPP

#include "CPU.hpp"
#include "Pipe.hpp"
#include "ALU.hpp"
// JAL - Jump and Link (U-type like, but with PC update)
inline void inst_jal(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    // 1. Calculate Target: PC + Offset
    out.alu_result = alu_execute(ALUOp::ADD, in.pc, 4); // Link address to rd
    out.pc = in.pc + in.imm; 
    
    out.pc_modified = true;
    out.reg_write = in.reg_write;

    LOG("JAL: Target=" + HEX(out.pc) + ", Link=" + HEX(out.alu_result));
}

inline void inst_jalr(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    // 1. Target: (rs1 + imm) & ~1
    uint32_t target = (in.val_rs1 + in.imm) & ~1U;
    out.pc = target;

    // 2. Link Address: PC + 4
    out.alu_result = alu_execute(ALUOp::ADD, in.pc, 4);
    
    out.pc_modified = true;
    out.reg_write = in.reg_write;

    LOG("JALR: Target=" + HEX(target) + ", Link=" + HEX(out.alu_result));
}

#endif