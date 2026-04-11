// include/inst/auipc.hpp
#ifndef INST_AUIPC_HPP
#define INST_AUIPC_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#include "Pipe.hpp"
#define DEBUG 1
#include "ALU.hpp"
inline void inst_auipc(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    // AUIPC adds the immediate to the PC
    uint32_t in1 = in.pc;
    uint32_t in2 = in.imm;

    out.alu_result = alu_execute(in.alu_op, in1, in2);

    // Pass control signals forward
    out.val_rs2 = in.val_rs2;
    out.reg_write = in.reg_write;
    out.mem_read  = in.mem_read;
    out.mem_write = in.mem_write;

    LOG("AUIPC: PC(" + HEX(in1) + ") + IMM(" + HEX(in2) + ") = " + HEX(out.alu_result));
}
#endif