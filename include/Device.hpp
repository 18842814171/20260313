/**
 * @file Device.hpp
 * @brief 设备基类和 Memory 类定义
 *
 * @note 详细的设备模板和文档请参考 include/device/Device.hpp
 */

#ifndef DEVICE_HPP
#define DEVICE_HPP

#include <cstdint>
#include <cstddef>

/**
 * @brief 设备基类
 *
 * 所有外设设备必须继承此类并实现 write() 和 read() 方法。
 * 详细文档和模板请参考 include/device/Device.hpp
 */
class Device {
public:
    /**
     * @brief 写入设备寄存器
     * @param addr 访问地址（相对于设备基地址的偏移量）
     * @param data 写入数据缓冲区
     * @param size 写入字节数（1、2 或 4）
     */
    virtual void write(uint32_t addr, uint8_t* data, size_t size) = 0;

    /**
     * @brief 读取设备寄存器
     * @param addr 访问地址（相对于设备基地址的偏移量）
     * @param data 读取数据缓冲区（由调用者分配）
     * @param size 读取字节数（1、2 或 4）
     */
    virtual void read(uint32_t addr, uint8_t* data, size_t size) = 0;

    /**
     * @brief 虚析构函数
     */
    virtual ~Device() {}

protected:
    /**
     * @brief 辅助方法：将字节数组转换为 uint32_t（小端序）
     */
    static uint32_t bytes_to_word(const uint8_t* data) {
        return data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
    }

    /**
     * @brief 辅助方法：将 uint32_t 转换为字节数组（小端序）
     */
    static void word_to_bytes(uint32_t value, uint8_t* data) {
        data[0] = value & 0xFF;
        data[1] = (value >> 8) & 0xFF;
        data[2] = (value >> 16) & 0xFF;
        data[3] = (value >> 24) & 0xFF;
    }
};

/**
 * @brief 内存类
 *
 * 模拟系统内存，支持字节、半字、字的读写操作。
 * 内存区域：0x10000 - 0x5FFFF (256KB)
 */
class Memory : public Device {
private:
    static constexpr uint32_t MEM_SIZE = 1024 * 256 * 4;  // 256KB
    static constexpr uint32_t BASE = 0x10000;
    uint32_t mem[MEM_SIZE];

public:
    Memory();
    
    void write(uint32_t addr, uint8_t* data, size_t size) override;
    void read(uint32_t addr, uint8_t* data, size_t size) override;
    
    uint32_t read_word(uint32_t addr);
    void write_word(uint32_t addr, uint32_t value);
    bool is_valid(uint32_t addr) const;
};

#endif // DEVICE_HPP