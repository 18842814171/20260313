#include"Instmngr.hpp"
#include"utils/utils.hpp"


struct CPU{
    int reg[32]={0};
};

struct Memory {
    int dummy = 0;
};

struct DecodedInst {
    int rd;
    int rs1;
    int rs2;
};

void inst_add(CPU& cpu, Memory& , DecodedInst &inst){
    cpu.reg[inst.rd] = cpu.reg[inst.rs1] + cpu.reg[inst.rs2];
}

int main(){
    InstManager manager;

    manager.register_inst(0x33, inst_add);

    CPU cpu;
    Memory mem;
    DecodedInst inst{1,2,3};

    cpu.reg[2] = 10;
    cpu.reg[3] = 20;

    manager.execute(0x33, cpu, mem, inst);
    ASSERT(cpu.reg[1] == 30);
    LOG("PASS ADD");

    return 0;
}