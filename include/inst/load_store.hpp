#ifndef INST_LOAD_STORE_HPP
#define INST_LOAD_STORE_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "ALU.hpp"
#include "Pipe.hpp"
#define DEBUG 1          // for Inst

#include <cstdint>
#include <cstdio>

inline void inst_lw(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd;

    // Address calculation
    out.alu_result = in.val_rs1 + in.imm;

    // Pass control signals
    out.mem_read = in.mem_read;
    out.reg_write = in.reg_write;
    out.mem_write = false; 
    LOG("LW: Address=" + HEX(out.alu_result));
}

inline void inst_sw(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    int32_t imm = static_cast<int32_t>(in.imm);
    // Address calculation
    out.alu_result = in.val_rs1 + imm;

    // Value to store (rs2)
    out.val_rs2 = in.val_rs2; 

    // Control signals
    out.mem_write = in.mem_write;
    out.reg_write = false; // Stores don't write to registers
    out.mem_read = false;
    LOG("SW: Address=" + HEX(out.alu_result) + ", Data=" + HEX(out.val_rs2));
}
#endif