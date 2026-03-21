//run.cpp
#include"utils/utils.hpp"
#include "CPU.hpp"
#include "Instmngr.hpp"
#include "Memory.hpp"
int main(){
    
    // 需要創建 Memory 對象並傳遞給 CPU
    Memory mem;  // 假設 Memory 有默認構造函數
    CPU cpu(mem);  // 傳遞 memory 引用
    uint32_t code[] = {
    0x00F10093,     // addi x1, x2, 15     (x1 = x2 + 15)
    0x00308133,     // add  x2, x1, x3     (x2 = x1 + x3)
    0x403100B3,     // sub  x1, x2, x3     (x1 = x2 - x3)   ← should get original x2 back
    0x00100073      // ebreak              (stop)
    };

    constexpr uint32_t start_addr = 0x80000000;

    for (size_t i = 0; i < sizeof(code)/sizeof(code[0]); i++) {
        mem.write(start_addr + i*4, code[i]);
    }

    cpu.pc = start_addr;

    cpu.reg[2] = 100;   // x2 = 100
    cpu.reg[3] = 30;    // x3 = 30
    cpu.dump_registers();
    cpu.dump_state("Initial");
    // Now step 3× and check intermediate states
    cpu.step();   
    LOGIF("after addi",  cpu.reg[1] == 115);
    cpu.dump_registers();
    cpu.step();   
    LOGIF("after add",   cpu.reg[2] == 145);
    cpu.step(); 
    cpu.dump_registers();  
    LOGIF("after sub",   cpu.reg[1] == 115);
    cpu.dump_registers();
   
    return 0;
}