#include "Memory.hpp"
#include<iostream>
#include <cstring>
#include <stdexcept>

using namespace std;

Memory::Memory() {
    memset(mem, 0, sizeof(mem));
}

void Memory::write(uint32_t addr, uint8_t* data, size_t size) {
    uint64_t offset = addr - BASE;
    
    if (offset + size > MEM_SIZE) {
        throw out_of_range("Memory write out of bounds");
    }
    
    // Direct byte copy
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    memcpy(mem_bytes + offset, data, size);
}

void Memory::read(uint32_t addr, uint8_t* data, size_t size) {
    uint64_t offset = addr - BASE;
    
    if (offset + size > MEM_SIZE) {
        throw out_of_range("Memory read out of bounds");
    }
    
    // Direct byte copy
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    memcpy(data, mem_bytes + offset, size);
}

uint32_t Memory::read_word(uint32_t addr) {
        uint32_t value = 0;
        read(addr, reinterpret_cast<uint8_t*>(&value), sizeof(value));
        return value;
    }

void Memory::write_word(uint32_t addr, uint32_t value) {
        Memory::write(addr, reinterpret_cast<uint8_t*>(&value), 4);
    }