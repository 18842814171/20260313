#ifndef BUS_HPP
#define BUS_HPP

#include "Device.hpp"
#include "Memory.hpp"
#include <cstdint>
#include <cstddef>
#include <map>

class Bus {
private:
    Memory* memory;
    std::map<uint32_t, Device*> devices;  // addr -> device mapping

public:
    Bus();
    void attach_memory(Memory* mem);
    void attach_device(uint32_t base_addr, Device* dev);

    void write(uint32_t addr, uint8_t* data, size_t size);
    void read(uint32_t addr, uint8_t* data, size_t size);

    uint32_t read_word(uint32_t addr);
    void write_word(uint32_t addr, uint32_t value);

    Device* find_device(uint32_t addr);
};

#endif
