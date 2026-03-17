//run.cpp
#include"utils/utils.hpp"
#include "Types.hpp"
#include "inst/add.hpp"

int main(){
    InstManager manager;

    manager.register_inst(0x33, inst_add);

    // 需要創建 Memory 對象並傳遞給 CPU
    Memory mem;  // 假設 Memory 有默認構造函數
    CPU cpu(mem);  // 傳遞 memory 引用
    
    DecodedInst inst{1,2,3};

    cpu.reg[2] = 10;
    cpu.reg[3] = 20;

    manager.execute(0x33, cpu, mem, inst);
 
    LOGIF("PASS ADD",cpu.reg[1] == 30);

    return 0;
}