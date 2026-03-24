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
#include "inst/opcode.hpp"
#include "Decoder.hpp"

using InstFunc = void(*)(CPU&, Memory&, const Inst&);

struct InstEntry {
    InstFunc handler;
    std::string name;
};

class InstManager{

public:
    
    void register_inst(int opcode, const std::string& name, InstFunc fn);
    
    std::string get_name(int opcode) const;
    size_t size() const;

    bool has_instruction(uint32_t id) const;
    
    void execute_inst(CPU& cpu, Memory& mem, const Inst& inst);
    
private:
    std::unordered_map<int, InstEntry> table_;
};


#endif