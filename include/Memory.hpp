#ifndef MEMORY_HPP
#define MEMORY_HPP
#include<cstdint>
#include<vector>

class Memory{
	private:
		static const uint32_t MEM_SIZE = 1024;
		static const uint32_t BASE = 0x80000000;
		uint32_t mem[MEM_SIZE];
	public:
		Memory();
		uint32_t read(uint32_t addr);
		void write(uint32_t addr, uint32_t data);

};


#endif