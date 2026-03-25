#ifndef INST_LOAD_STORE_HPP
#define INST_LOAD_STORE_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#include "Pipe.hpp"
#define DEBUG 1          // for Inst

#include <cstdint>
#include <cstdio>

// ───────────────────────────────────────────────
// lw   rd, imm(rs1)     OP_LOAD  funct3=010
// ───────────────────────────────────────────────
void inst_lw(CPU& cpu,  Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    p.alu_result = p.val_rs1 + p.imm;
    p.mem_read = true;
    p.reg_write = true;
    // Optional: nice logging
    
}

// ───────────────────────────────────────────────
// sw   rs2, imm(rs1)    OP_STORE funct3=010
// ───────────────────────────────────────────────
void inst_sw(CPU& cpu, Pipe& p) {
  
    LOG(cpu.get_inst_name(p.inst_id));
    // Address calculation
    p.alu_result = p.val_rs1 + p.imm;

    // Store value
    p.mem_data = p.val_rs2;

    // Control signal
    p.mem_write = true;

     
}
#endif