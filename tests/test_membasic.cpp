#include<iostream>
#include "../memory/memory.hpp"
using namespace std;

int main(){
	Memorybasic mem;
	cout<<"Basic memory\n";
	mem.write(10,1234);
	mem.write(20,5678);

	uint32_t a = mem.read(10);
	uint32_t b = mem.read(20);
	
	cout<<"address 10:"<<a<<endl;
	cout<<"address 20:"<<b<<endl;
	
	return 0;
}
