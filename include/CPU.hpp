#pragma once
#ifndef CPU_HPP
#define CPU_HPP
// include/cpu.hpp
#include <cstdint>
#include <cstdio>
#include <string>

class Memory;      
class InstManager;

#include "utils/utils.hpp"   

class CPU {
public:
    uint32_t reg[32]{};
    uint32_t pc = 0x10000;

    CPU(Memory& mem_ref, InstManager& im_ref); 
    ~CPU();
    bool step();//single instruction 
    void run(size_t max_steps = 0);//multiple instructions

    void set_pc(uint32_t new_pc) { pc = new_pc; }
    void dump_registers() const; 
    void dump_state(const std::string& prefix = "") const; 
    std::string get_inst_name(uint32_t opcode) const;
private:
    Memory& memory;
    InstManager& inst_manager;   
};
#endif