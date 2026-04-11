#ifndef INSTMNGR_HPP
#define INSTMNGR_HPP
//include/Instmngr.hpp
#pragma once
#include<cstdio>
#include <vector>
#include <unordered_map>
#include <string>
class CPU;
class Memory;
class Inst;
#include "Pipe.hpp"
#include "inst/opcode.hpp"
#include "Decoder.hpp"

using InstFunc = void(*)(CPU&, Pipe_ID_EX&, Pipe_EX_MEM&);

struct InstEntry {
    InstFunc handler;
    std::string name;
};

class InstManager{

public:
    
    void register_inst(uint32_t inst_id, const std::string& name, InstFunc fn);
    
    std::string get_name(uint32_t inst_id) const;
    size_t size() const;

    bool has_instruction(uint32_t id) const;
    
    void execute_inst(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out);
    const InstEntry* lookup(uint32_t inst_id) const;
private:
    std::unordered_map<uint32_t, InstEntry> table_;
};


#endif