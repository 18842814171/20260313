#pragma once
#ifndef CPU_HPP
#define CPU_HPP
// include/cpu.hpp
#include <cstdint>
#include <cstdio>
#include <string>

class Memory;      
class InstManager;
#include "utils/system.hpp"   // 如果有 DRAM_BASE 等常量
#include "utils/utils.hpp"    // 你的 debug 宏 + 位移函數

class CPU {
public:
    uint32_t reg[32]{};          // x0 永遠應為 0
    uint32_t pc = 0x80000000;    // 跟 Spike 一致

    explicit CPU(Memory& mem_ref);
    ~CPU();
    // 單步執行一條指令
    bool step();

    // 執行指定數量指令（0 = 無限，直到錯誤或手動停止）
    void run(size_t max_steps = 0);

    // 除錯用
    void dump_registers() const;
    void dump_state(const std::string& prefix = "") const;

    std::string get_inst_name(uint32_t opcode) const;

private:
    Memory& memory;
    InstManager* inst_manager = nullptr;

    void init_instruction_table();

    // 暫時內建簡單取指+解碼（之後可抽成 Decoder 類）
    //bool fetch_and_decode(uint32_t& raw, Inst& decoded);
};
#endif