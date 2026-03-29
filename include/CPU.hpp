#pragma once
#ifndef CPU_HPP
#define CPU_HPP
// include/cpu.hpp
#include <cstdint>
#include <cstdio>
#include <string>

class Memory;      
class InstManager;
struct Pipe;
class Inst;
#include "utils/utils.hpp"   

class CPU {
public:
    uint32_t reg[32]{};
    uint32_t pc = 0x10000;
    bool pc_modified = false;
    //for ecall
    bool halt = false;        
    int exit_code = 0; 

    CPU(Memory& mem_ref, InstManager& im_ref); 
    ~CPU();

    //Pipeline stages
    void fetch(Pipe& p);
    void decode(Pipe& p);
    void execute(Pipe& p);
    void memory_access(Pipe& p);
    void writeback(Pipe& p);

    bool step();//single instruction 
    void run(size_t max_steps = 0);//multiple instructions

    void set_pc(uint32_t new_pc) { pc = new_pc; }
    void dump_registers() const; 
    void dump_state(const std::string& prefix = "") const; 
    std::string get_inst_name(uint32_t opcode) const;
    uint32_t calc_addr(const CPU& cpu, Inst inst) const;
  
private:
    Memory& memory;
    InstManager& inst_manager;   
};
#endif