#pragma once
//encoding.hpp
// Privilege levels 
#define PRV_U 0
#define PRV_M 3


// Most important CSRs for RV32I (minimal set)
#define CSR_MSTATUS     0x300
#define CSR_MTVEC       0x305
#define CSR_MEPC        0x341
#define CSR_MCAUSE      0x342
#define CSR_MTVAL       0x343

// Exception causes you will actually meet in RV32I
#define CAUSE_MISALIGNED_FETCH      0
#define CAUSE_ILLEGAL_INSTRUCTION   2
#define CAUSE_BREAKPOINT            3
#define CAUSE_MISALIGNED_LOAD       4
#define CAUSE_LOAD_ACCESS           5
#define CAUSE_MISALIGNED_STORE      6
#define CAUSE_STORE_ACCESS          7
#define CAUSE_ECALL_U               8
#define CAUSE_ECALL_M              11

// Reset vector (typical value used in many RV32I bare-metal environments)
#define DEFAULT_RSTVEC     0x00000000   // or 0x80000000 if you follow Spike-like DRAM base

// Memory map basics (choose one — simple choice first)
#define DRAM_BASE          0x80000000


constexpr uint32_t INST_ADD =
    make_inst_id(0x33, 0b000, 0b0000000);

constexpr uint32_t INST_SUB =
    make_inst_id(0x33, 0b000, 0b0100000);

constexpr uint32_t INST_LW =
    make_inst_id(0x03, 0b010, 0);