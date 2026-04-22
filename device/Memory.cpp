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

void Memory::note_write(uint32_t addr, size_t nbytes) {
    if (nbytes == 0) {
        return;
    }
    if (!is_valid(addr)) {
        return;
    }
    uint32_t last = addr + static_cast<uint32_t>(nbytes) - 1u;
    if (!is_valid(last)) {
        last = BASE + static_cast<uint32_t>(MEM_SIZE) * 4u - 1u;
    }
    if (high_water_byte_addr_ == 0 || last > high_water_byte_addr_) {
        high_water_byte_addr_ = last;
    }
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
                note_write(addr, copy_size);
            }
        }
        return;
    }
    
    // Direct byte copy
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    memcpy(mem_bytes + offset, data, size);
    note_write(addr, size);
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
    note_write(addr, 4);
}
uint8_t Memory::read_byte(uint32_t addr) {
    if (!is_valid(addr)) {
        return 0;                     // same policy as read_word
    }

    uint64_t offset = addr - BASE;
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    return mem_bytes[offset];
}

void Memory::write_byte(uint32_t addr, uint8_t value) {
    if (!is_valid(addr)) {
        return;                       // same policy as write_word (silently ignore)
    }

    uint64_t offset = addr - BASE;
    uint8_t* mem_bytes = reinterpret_cast<uint8_t*>(mem);
    mem_bytes[offset] = value;
    note_write(addr, 1);
}
bool Memory::is_valid(uint32_t addr) const {
    return (addr >= BASE && addr < BASE + MEM_SIZE*4);
}