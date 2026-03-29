// inst/jump.hpp

#ifndef INST_JUMP_HPP
#define INST_JUMP_HPP

#include "CPU.hpp"
#include "Pipe.hpp"
#include "ALU.hpp"
// JAL - Jump and Link (U-type like, but with PC update)
inline void inst_jal(CPU& cpu, Pipe& p) {
    // JAL: rd = PC + 4
    //      PC = PC + sign-extended 20-bit immediate (shifted left by 1)
    //uint32_t next_pc = p.pc + 4;
    int32_t offset = p.imm; 
    uint32_t target = p.pc + offset;
    p.next_pc = target;
    // 2. Use ALU-like logic to compute the Link Address (rd = PC + 4)
    p.alu_op = ALUOp::ADD;
    p.alu_src = true; 
    
    // We treat '4' as the second operand to get the return address
    p.alu_result = alu_execute(p.alu_op, p.pc, 4); 
    
    // 3. Pipeline Control
    p.reg_write = true;      // Write PC+4 to rd
    p.pc_modified = true;    // Signal a jump
    
    LOG("Jump Target = " + std::to_string(target));
    LOG("Link Value (rd) = " + std::to_string(p.alu_result));
     
}

// JALR - Jump and Link Register
inline void inst_jalr(CPU& cpu, Pipe& p) {

    // JALR: rd = PC + 4
    //       PC = (rs1 + sign-extended 12-bit immediate) & ~1  (clear LSB)
    //uint32_t next_pc = p.pc + 4;
    // Setup ALU to calculate the Target Address (rs1 + imm)
    p.alu_src = true; 
    p.alu_op  = ALUOp::ADD;

    uint32_t in1 = p.val_rs1;
    uint32_t in2 = p.imm;

    // The ALU calculates the TARGET
    uint32_t target = alu_execute(p.alu_op, in1, in2) & ~1U;
    p.next_pc = target;
    // BUT: In JALR, the value saved to the register is PC + 4
    // To fit your template, we store PC + 4 in alu_result
    p.alu_result = alu_execute(p.alu_op, p.pc, 4);
    p.reg_write = true;
    p.pc_modified = true;

    LOG("Target (from ALU-style op) = " + std::to_string(target));
    LOG("Link Value (to rd) = " + std::to_string(p.alu_result));
}

#endif