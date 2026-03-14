#include"memory.hpp"
#include<iostream>
using namespace std;
Memorybasic::Memorybasic(){
	for (int i=0; i<MEM_SIZE; i++){
		mem[i]=0;
	}
}

uint32_t Memorybasic::read(uint32_t addr){
	if (addr/4>=MEM_SIZE){
		cout<<" Address out of range\n";
		return 0;
	}
	return mem[addr];
}
	
void Memorybasic::write(uint32_t addr, uint32_t data){
	 if (addr/4 >= MEM_SIZE){
		 cout<<"Address out of range\n";
		 return;
	 }
	 mem[addr]=data;
}
