#pragma once
#include<cstdio>
#include <vector>
#include <unordered_map>
class CPU{
public:
    int reg[32]={0};
};
class Memory{
    public:
        int dummy = 0;
};
struct DecodedInst{
    int rd;
    int rs1;
    int rs2;
};  
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
};


