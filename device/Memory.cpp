#include "device/Device.hpp"
#include "device/Memory.hpp"
#include<iostream>
#include <cstring>
#include <stdexcept>
#include <climits>

using namespace std;

Memory::Memory() {
    memset(mem, 0, sizeof(mem));
}

void Memory::write(uint32_t addr, uint8_t* data, size_t size) {
    uint64_t offset = addr - BASE;
    
    if (offset + size > MEM_SIZE*4) {
        // Memory write out of bounds - silently ignore or extend
        // For simulation, we allow writes beyond defined memory
        if (addr >= BASE) {
            uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
            size_t copy_size = (offset < MEM_SIZE*4) ? 
                min(size, static_cast<size_t>(MEM_SIZE*4 - offset)) : 0;
            if (copy_size > 0) {
                memcpy(mem_bytes + offset, data, copy_size);
            }
        }
        return;
    }
    
    // Direct byte copy
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    memcpy(mem_bytes + offset, data, size);
}

void Memory::read(uint32_t addr, uint8_t* data, size_t size) {
    uint64_t offset = addr - BASE;
    
    if (offset + size > MEM_SIZE*4) {
        // Memory read out of bounds - return 0
        memset(data, 0, size);
        return;
    }
    
    // Direct byte copy
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    memcpy(data, mem_bytes + offset, size);
}

uint32_t Memory::read_word(uint32_t addr) {
    if (!is_valid(addr)) {
        // Return 0 for invalid reads (better for simulation)
        return 0;
    }

    uint32_t index = (addr - BASE) / 4;
    return mem[index];
}

void Memory::write_word(uint32_t addr, uint32_t value) {
    if (!is_valid(addr)) {
        // Silently ignore invalid writes
        return;
    }

    uint32_t index = (addr - BASE) / 4;
    mem[index] = value;
}

bool Memory::is_valid(uint32_t addr) const {
    return (addr >= BASE && addr < BASE + MEM_SIZE*4);
}