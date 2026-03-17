#include "Types.hpp"
#include<iostream>
using namespace std;
Memory::Memory(){
	for (int i=0; i<MEM_SIZE; i++){
		mem[i]=0;
	}
}

uint32_t Memory::read(uint32_t addr){
	if (addr/4>=MEM_SIZE){
		cout<<" Address out of range\n";
		return 0;
	}
	return mem[addr];
}
	
void Memory::write(uint32_t addr, uint32_t data){
	 if (addr/4 >= MEM_SIZE){
		 cout<<"Address out of range\n";
		 return;
	 }
	 mem[addr]=data;
}
