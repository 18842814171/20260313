//run.cpp
#include"utils/utils.hpp"
#include "CPU.hpp"
#include "Instmngr.hpp"
#include "Memory.hpp"
int main(){
    
    // 需要創建 Memory 對象並傳遞給 CPU
    Memory mem;  // 假設 Memory 有默認構造函數
    CPU cpu(mem);  // 傳遞 memory 引用
    uint32_t test_sub_code=0x403100b3;
    Inst inst(test_sub_code);
    //Inst inst{1,2,3};sub x1, x2, x3
    mem.write(0x80000000,test_sub_code);
    cpu.reg[2] = 10;
    cpu.reg[3] = 20;

    cpu.step();
    //printf("ID = 0x%08x\n", inst.inst_id());
    LOGIF("PASS SUB",cpu.reg[1] == -10);//x1=x2-x3

    return 0;
}