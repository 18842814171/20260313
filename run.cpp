//run.cpp
#include"utils/utils.hpp"
#include "CPU.hpp"
#include "Instmngr.hpp"
#include "Memory.hpp"
int main(){
    
    // 需要創建 Memory 對象並傳遞給 CPU
    Memory mem;  // 假設 Memory 有默認構造函數
    CPU cpu(mem);  // 傳遞 memory 引用
    Inst inst(0x003100B3);
    //Inst inst{1,2,3};
    mem.write(0x80000000, 0x003100B3);
    cpu.reg[2] = 10;
    cpu.reg[3] = 20;

    cpu.step();
 
    LOGIF("PASS ADD",cpu.reg[1] == 30);

    return 0;
}