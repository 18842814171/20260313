// include/inst/mul.hpp
#ifndef INST_MUL_HPP
#define INST_MUL_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"
#include "ALU.hpp"

inline void inst_mul(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    uint32_t in1 = in.val_rs1;
    uint32_t in2 = in.val_rs2;

    out.alu_result = alu_execute(ALU_MUL, in1, in2);

    // Control signals
    out.reg_write = true;
    out.mem_read = false;
    out.mem_write = false;
    LOG("MUL: in1=" + std::to_string(in1) + ", in2=" + std::to_string(in2)
          + ", result=" + std::to_string(out.alu_result));
}

