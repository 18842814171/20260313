#ifndef DEVICE_HPP
#define DEVICE_HPP
#include<cstdint>
#include<vector>
#include<cstddef>

class Device {
public:
    virtual void write(uint32_t addr, uint8_t* data, size_t size) = 0;
    virtual void read(uint32_t addr, uint8_t* data, size_t size) = 0;
};

class Memory:public Device{
	private:
		static const uint32_t MEM_SIZE = 1024*256*4;
		static const uint32_t BASE = 0x10000;
		uint32_t mem[MEM_SIZE];
	public:
		Memory();
		void write(uint32_t addr, uint8_t* data, size_t size);
		void read(uint32_t addr, uint8_t* data, size_t size);
		uint32_t read_word(uint32_t addr);
		void write_word(uint32_t addr, uint32_t value);
		bool is_valid(uint32_t addr) const;  // Add this declaration
};


#endif