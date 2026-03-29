#include "utils/utils.hpp"
#include "CPU.hpp"  
#include "Pipe.hpp"   
#include "ALU.hpp"
#define DEBUG 1
// LUI (U-type, opcode 0x37)
inline void inst_lui(CPU& cpu, Pipe& p) {
    
    // LUI: Load Upper Immediate → rd = {imm[19:0], 12'b0}
    // p.imm already contains the sign-extended 32-bit value with lower 12 bits zero
    p.alu_src = true;
    p.alu_op  = ALUOp::ADD;
    
    uint32_t in1 = cpu.reg[0];      // First operand is zero
    uint32_t in2 = choice(p.alu_src, p.val_rs2, p.imm);
    p.alu_result = alu_execute(p.alu_op, in1, in2);
    p.reg_write = true;

    //LOG("LUI - ALUOp: " + to_string(p.alu_op));
    LOG("Input1 (zero) = " + std::to_string(in1));
    LOG("Input2 (imm<<12) = " + std::to_string(in2));
    LOG("Result (rd) = " + std::to_string(p.alu_result));
}

