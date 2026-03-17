#ifndef INSTMNGR_HPP
#define INSTMNGR_HPP
//include/Instmngr.hpp
#pragma once
#include<cstdio>
#include <vector>
#include <unordered_map>
#include "Types.hpp"
#include "inst/opcode.hpp"


struct DecodedInst{
    int rd;
    int rs1;
    int rs2;
    uint32_t opcode;      // 原始 opcode
    uint32_t funct3;      // funct3 字段
    uint32_t funct7;      // funct7 字段
    uint32_t inst_id;     // 指令ID（用於查詢執行函數）
};  
using InstFunc = void(*)(CPU&, Memory&, DecodedInst&);
class InstManager{
public:
void register_inst(int opcode, InstFunc fn){
    table_[opcode] = fn;
}
bool execute(int opcode, CPU& cpu, Memory& mem, DecodedInst& inst){
    auto it = table_.find(opcode);
        if (it != table_.end()) {
            it->second(cpu, mem, inst); 
            return true;           // ← success 
        }
    return false;  // ← not found / illegal
}
size_t size() const {
        return table_.size();
    }
private:
    std::unordered_map<int, InstFunc> table_;
};


#endif