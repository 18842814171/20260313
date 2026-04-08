#ifndef TIMER_HPP
#define TIMER_HPP

#include "Device.hpp"
#include <cstdint>

class Timer : public Device {
private:
    static const uint32_t MTIME_ADDR = 0x02004000;
    static const uint32_t MTIMECMP_ADDR = 0x02004008;

    uint64_t mtime;       // 64-bit timer counter
    uint64_t mtimecmp;    // 64-bit compare value

public:
    Timer();
    void reset();

    // Device interface
    void write(uint32_t addr, uint8_t* data, size_t size) override;
    void read(uint32_t addr, uint8_t* data, size_t size) override;

    // Timer operations
    void tick();
    bool check_interrupt();
    void clear_interrupt();

    uint64_t get_mtime() const { return mtime; }
    uint64_t get_mtimecmp() const { return mtimecmp; }
};

#endif
