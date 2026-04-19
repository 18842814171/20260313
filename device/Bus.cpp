#include "device/Bus.hpp"
#include <cstring>
#include <iostream>

Bus::Bus() : memory(nullptr) {
}

void Bus::attach_memory(Memory* mem) {
    memory = mem;
}

void Bus::attach_device(uint32_t base_addr, Device* dev) {
    devices[base_addr] = dev;
}

Device* Bus::find_device(uint32_t addr) {
    for (auto& pair : devices) {
        uint32_t base = pair.first;
        Device* dev = pair.second;
        // Check if addr is within this device's range (assuming 4KB page)
        if (addr >= base && addr < base + 0x1000) {
            return dev;
        }
    }
    return nullptr;
}

void Bus::write(uint32_t addr, uint8_t* data, size_t size) {
    for (auto& pair : devices) {
        uint32_t base = pair.first;
        Device* dev = pair.second;
        if (addr >= base && addr < base + 0x1000) {
            uint32_t offset = addr - base;
            dev->write(offset, data, size);
            return;
        }
    }
    if (memory) {
        memory->write(addr, data, size);
    }
}

void Bus::read(uint32_t addr, uint8_t* data, size_t size) {
    for (auto& pair : devices) {
        uint32_t base = pair.first;
        Device* dev = pair.second;
        if (addr >= base && addr < base + 0x1000) {
            uint32_t offset = addr - base;
            dev->read(offset, data, size);
            return;
        }
    }
    if (memory) {
        memory->read(addr, data, size);
    } else {
        memset(data, 0, size);
    }
}

uint32_t Bus::read_word(uint32_t addr) {
    uint8_t data[4];
    read(addr, data, 4);
    uint32_t value = 0;
    for (size_t i = 0; i < 4; i++) {
        value |= (static_cast<uint32_t>(data[i]) << (i * 8));
    }
    return value;
}

void Bus::write_word(uint32_t addr, uint32_t value) {
    uint8_t data[4];
    for (size_t i = 0; i < 4; i++) {
        data[i] = (value >> (i * 8)) & 0xFF;
    }
    write(addr, data, 4);
}

uint8_t Bus::read_byte(uint32_t addr) {
    uint8_t data[1] = {0};
    read(addr, data, 1);        // reuse your existing read() which handles devices + memory
    return data[0];
}

void Bus::write_byte(uint32_t addr, uint8_t value) {
    uint8_t data[1] = {value};
    write(addr, data, 1);       // reuse your existing write() which handles devices + memory
}