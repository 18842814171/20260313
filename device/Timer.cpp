#include "device/Timer.hpp"
#include <cstring>
#include <iostream>

#define LOG(msg) std::cout << "[Timer] " << msg << std::endl

Timer::Timer() : mtime(0), mtimecmp(0xFFFFFFFFFFFFFFFFULL) {
}

void Timer::reset() {
    mtime = 0;
    mtimecmp = 0xFFFFFFFFFFFFFFFFULL;
}

void Timer::tick() {
    mtime++;
}

bool Timer::check_interrupt() {
    return mtime >= mtimecmp;
}

void Timer::clear_interrupt() {
    mtimecmp = mtime + 1;
}

void Timer::write(uint32_t addr, uint8_t* data, size_t size) {
    if (size == 8) {
        uint64_t value = 0;
        for (size_t i = 0; i < 8; i++) {
            value |= (static_cast<uint64_t>(data[i]) << (i * 8));
        }

        if (addr == MTIMECMP_ADDR) {
            mtimecmp = value;
            LOG("mtimecmp = 0x" << std::hex << value);
        }
    } else if (size == 4) {
        uint32_t value = 0;
        for (size_t i = 0; i < 4; i++) {
            value |= (static_cast<uint32_t>(data[i]) << (i * 8));
        }

        if (addr == MTIMECMP_ADDR) {
            mtimecmp = (mtimecmp & 0xFFFFFFFF00000000ULL) | value;
            LOG("mtimecmp lo = 0x" << std::hex << value);
        }
    }
}

void Timer::read(uint32_t addr, uint8_t* data, size_t size) {
    memset(data, 0, size);

    if (addr == MTIME_ADDR || addr == MTIME_ADDR + 4) {
        if (size == 8) {
            uint64_t val = mtime;
            for (size_t i = 0; i < 8; i++) {
                data[i] = (val >> (i * 8)) & 0xFF;
            }
        } else if (size == 4) {
            uint32_t val = (addr == MTIME_ADDR) ?
                (mtime & 0xFFFFFFFF) : ((mtime >> 32) & 0xFFFFFFFF);
            for (size_t i = 0; i < 4; i++) {
                data[i] = (val >> (i * 8)) & 0xFF;
            }
        }
    } else if (addr == MTIMECMP_ADDR || addr == MTIMECMP_ADDR + 4) {
        if (size == 8) {
            uint64_t val = mtimecmp;
            for (size_t i = 0; i < 8; i++) {
                data[i] = (val >> (i * 8)) & 0xFF;
            }
        } else if (size == 4) {
            uint32_t val = (addr == MTIMECMP_ADDR) ?
                (mtimecmp & 0xFFFFFFFF) : ((mtimecmp >> 32) & 0xFFFFFFFF);
            for (size_t i = 0; i < 4; i++) {
                data[i] = (val >> (i * 8)) & 0xFF;
            }
        }
    }
}
