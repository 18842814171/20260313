#include "Memory.hpp"
#include<iostream>
using namespace std;
Memory::Memory(){
	for (int i=0; i<MEM_SIZE; i++){
		mem[i]=0;
	}
}

uint32_t Memory::read(uint32_t addr) {
    if (addr < BASE) {
        printf("Invalid address!\n");
        exit(1);
    }

    uint32_t index = (addr - BASE) >> 2;

    if (index >= MEM_SIZE) {
        printf("Out of bounds!\n");
        exit(1);
    }

    return mem[index];
}
	
void Memory::write(uint32_t addr, uint32_t data){
	uint32_t index = (addr - BASE) >> 2;

    if (index >= MEM_SIZE) {
        printf("Memory write out of bounds!\n");
        exit(1);
    }

    mem[index] = data;
}
