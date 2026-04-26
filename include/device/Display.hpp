#ifndef DISPLAY_HPP
#define DISPLAY_HPP

#include "device/Device.hpp"
#include <cstdint>
#include <string>
class Memory;

class DisplayDevice : public Device {
public:
    // MMIO register offsets (relative to device base)
    static constexpr uint32_t REG_CTRL = 0x00;
    static constexpr uint32_t REG_STATUS = 0x04;
    static constexpr uint32_t REG_FB_ADDR = 0x08;
    static constexpr uint32_t REG_WIDTH = 0x0C;
    static constexpr uint32_t REG_HEIGHT = 0x10;
    static constexpr uint32_t REG_FORMAT = 0x14;
    static constexpr uint32_t REG_FRAME_COUNT = 0x18;
    static constexpr uint32_t REG_OUT_NAME_ADDR = 0x1C;
    static constexpr uint32_t REG_OUT_NAME_LEN = 0x20;

    // CTRL bits
    static constexpr uint32_t CTRL_ENABLE = 1u << 0;
    static constexpr uint32_t CTRL_REFRESH = 1u << 1; // write 1 to trigger dump

    // STATUS bits
    static constexpr uint32_t STATUS_READY = 1u << 0;
    static constexpr uint32_t STATUS_ERROR = 1u << 1;

    // Pixel formats
    static constexpr uint32_t FORMAT_GRAY8 = 0u;
    static constexpr uint32_t FORMAT_RGB332 = 1u;

    explicit DisplayDevice(Memory& mem);

    void write(uint32_t addr, uint8_t* data, size_t size) override;
    void read(uint32_t addr, uint8_t* data, size_t size) override;

private:
    Memory& memory_;
    uint32_t ctrl_ = 0;
    uint32_t status_ = STATUS_READY;
    uint32_t fb_addr_ = 0x30000;
    uint32_t width_ = 64;
    uint32_t height_ = 64;
    uint32_t format_ = FORMAT_RGB332;
    uint32_t frame_count_ = 0;
    uint32_t out_name_addr_ = 0;
    uint32_t out_name_len_ = 0;

    void dump_frame_to_ppm();
    static void rgb332_to_rgb888(uint8_t p, uint8_t& r, uint8_t& g, uint8_t& b);
    std::string resolve_output_filename() const;
};

#endif
