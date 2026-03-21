#ifndef INST_LOAD_STORE_HPP
#define INST_LOAD_STORE_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "decode.hpp"
#define DEBUG 1          // for Inst

#include <cstdint>
#include <cstdio>

// ───────────────────────────────────────────────
// lw   rd, imm(rs1)     OP_LOAD  funct3=010
// ───────────────────────────────────────────────
void inst_lw(CPU& cpu, Memory& mem, const Inst& inst) {
    if (inst.funct3() != 0b010) {
        LOG("lw only supports funct3=010\n");
        return;
    }

    uint32_t rd  = inst.rd();
    uint32_t addr = inst.calc_addr(cpu, inst);
    uint32_t value = mem.read(addr);

    if (rd != 0) {
        cpu.reg[rd] = value;
    }

    // Optional: nice logging
    printf("lw   x%-2d ← mem[0x%08x] = 0x%08x   (x%-2d + %d)\n",
           rd, addr, value, inst.rs1(), inst.imm_i());
}

// ───────────────────────────────────────────────
// sw   rs2, imm(rs1)    OP_STORE funct3=010
// ───────────────────────────────────────────────
void inst_sw(CPU& cpu, Memory& mem, const Inst& inst) {
    if (inst.funct3() != 0b010) {
        LOG("sw only supports funct3=010\n");
        return;
    }

    uint32_t rs1 = inst.rs1();
    uint32_t rs2 = inst.rs2();
    uint32_t addr = inst.calc_addr(cpu, inst);
    uint32_t value = cpu.reg[rs2];

    mem.write(addr, value);

    printf("sw   x%-2d → mem[0x%08x] = 0x%08x   (x%-2d + %d)\n",
           rs2, addr, value, rs1, inst.imm_s());
}