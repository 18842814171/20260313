#pragma once
#ifndef CPU_HPP
#define CPU_HPP
// include/cpu.hpp
#include <cstdint>
#include <cstdio>
#include <string>
#include "Pipe.hpp"
class Memory;      
class InstManager;

class Inst;
#include "utils/utils.hpp"   

class CPU {
public:
   
    Pipe_IF_ID if_id;
    Pipe_ID_EX id_ex;
    Pipe_EX_MEM ex_mem;
    Pipe_MEM_WB mem_wb;
    uint32_t reg[32]{};
    uint32_t pc = 0x10000;
    bool pc_modified = false;
    //for ecall
    bool halt = false;        
    int exit_code = 0; 
    bool stall=false;
    CPU(Memory& mem_ref, InstManager& im_ref); 
    ~CPU();

    //Pipeline stages
    void fetch(Pipe_IF_ID& out);
    void decode(Pipe_IF_ID& in, Pipe_ID_EX& out);
    void execute(Pipe_ID_EX& in, Pipe_EX_MEM& out);
    void memory_access(Pipe_EX_MEM& in, Pipe_MEM_WB& out);
    void writeback(Pipe_MEM_WB& in);

    bool step();//single cycle
    void run(size_t max_steps = 0);//multiple cycles

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