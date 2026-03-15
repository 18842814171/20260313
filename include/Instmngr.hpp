#pragma once
#include<cstdio>
#include <vector>
#include <unordered_map>
class CPU;
class Memory;
struct DecodedInst;  
using InstFunc = void(*)(CPU&, Memory&, DecodedInst&);
class InstManager{
public:
void register_inst(int opcode, InstFunc fn){
    table_[opcode] = fn;
}
void execute(int opcode, CPU& cpu, Memory& mem, DecodedInst& inst){
    auto it = table_.find(opcode);
        if (it != table_.end()) {
            it->second(cpu, mem, inst);  
        }
}
private:
    std::unordered_map<int, InstFunc> table_;
}


