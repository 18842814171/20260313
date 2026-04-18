/**
 * @file Gpio.hpp
 * @brief Gpio Device Driver
 *
 * Device address: 0x200000001
 */
#ifndef GPIO_HPP
#define GPIO_HPP

#include "device/Device.hpp"

/**
 * @brief Gpio Device
 *
 * Registers:
 *   REG_CTRL   (0x00): Control register
 *   REG_STATUS (0x04): Status register
 *   REG_DATA   (0x08): Data register
 */
class Gpio : public Device {
private:
    static constexpr uint32_t REG_CTRL   = 0x00;
    static constexpr uint32_t REG_STATUS = 0x04;
    static constexpr uint32_t REG_DATA   = 0x08;

    uint32_t control = 0;
    uint32_t status = 0;
    uint32_t data_reg = 0;

public:
    Gpio() {}

    void write(uint32_t addr, uint8_t* data, size_t size) override {
        if (size != 4) return;
        uint32_t value = bytes_to_word(data);

        switch (addr) {
            case REG_CTRL:   control = value; break;
            case REG_STATUS: status = value; break;
            case REG_DATA:   data_reg = value; break;
        }
    }

    void read(uint32_t addr, uint8_t* data, size_t size) override {
        if (size != 4) return;
        uint32_t value = 0;

        switch (addr) {
            case REG_CTRL:   value = control; break;
            case REG_STATUS: value = status; break;
            case REG_DATA:   value = data_reg; break;
        }
        word_to_bytes(value, data);
    }
};

#endif // GPIO_HPP
