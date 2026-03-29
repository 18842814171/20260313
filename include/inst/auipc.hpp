// include/inst/auipc.hpp
#ifndef INST_AUIPC_HPP
#define INST_AUIPC_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#include "Pipe.hpp"
#define DEBUG 1
#include "ALU.hpp"
inline void inst_auipc(CPU& cpu, Pipe& p) {
    
    // AUIPC adds the 20-bit immediate shifted left by 12 to the PC
    // imm[31:12] is the immediate value, shifted left by 12
    // The immediate is sign-extended to 32 bits
    p.alu_src = true;
    p.alu_op  = ALUOp::ADD;
    
    uint32_t in1 = p.pc;
    uint32_t in2 = choice(p.alu_src, p.val_rs2, p.imm);
    p.alu_result = alu_execute(p.alu_op, in1, in2);
    p.reg_write = true;

    //LOG("AUIPC - ALUOp: " + to_string(p.alu_op));
    LOG("Input1 (PC)   = " + std::to_string(in1));
    LOG("Input2 (imm)  = " + std::to_string(in2));
    LOG("Result (rd)   = " + std::to_string(p.alu_result));
}
#endif