#include<iostream>
#include "memory.hpp"
#include "utils/utils.hpp"
using namespace std;

int main(){
	Memorybasic mem;
	LOG("Basic Memory Test");
	mem.write(10,1234);
	mem.write(20,5678);

	uint32_t a = mem.read(10);
	uint32_t b = mem.read(20);
	
	LOGIF("Addr10:1234", a==1234);
	LOGIF("Addr20:5678" ,b==5678);
	return 0;
}
