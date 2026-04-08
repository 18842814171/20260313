/**
 * @file Device.hpp
 * @brief 设备基类模板 - 用于设计自定义外设设备
 *
 * 本文件定义了 RISC-V 模拟器中所有设备必须遵循的接口规范。
 * 若要实现新的外设设备（如 UART、GPIO、PWM 等），
 * 必须继承 Device 基类并实现以下接口。
 */

#ifndef DEVICE_HPP
#define DEVICE_HPP

#include <cstdint>
#include <cstddef>

/**
 * @brief 设备基类
 *
 * 所有外设设备必须继承此类并实现纯虚函数。
 * 设备通过 MMIO (Memory-Mapped I/O) 与 CPU 通信。
 *
 * 地址映射规范：
 * - 内存区域：0x10000 - 正常程序内存
 * - MMIO 区域：0x10000000 起 - 外设设备区
 *
 * 示例 - 定义寄存器偏移量：
 * @code
 * static constexpr uint32_t REG_CTRL  = 0x00;
 * static constexpr uint32_t REG_STATUS = 0x04;
 * static constexpr uint32_t REG_DATA   = 0x08;
 * @endcode
 */
class Device {
public:
    /**
     * @brief 写入设备寄存器
     * @param addr 访问地址（相对于设备基地址的偏移量）
     * @param data 写入数据缓冲区
     * @param size 写入字节数（1、2 或 4）
     *
     * @note 地址 addr 是相对于设备挂载地址的偏移量，不是绝对地址
     *
     * 示例实现：
     * @code
     * void write(uint32_t addr, uint8_t* data, size_t size) override {
     *     if (size == 4) {
     *         uint32_t value = *reinterpret_cast<uint32_t*>(data);
     *         switch (addr) {
     *             case REG_CTRL:  control = value; break;
     *             case REG_STATUS: status = value; break;
     *         }
     *     }
     * }
     * @endcode
     */
    virtual void write(uint32_t addr, uint8_t* data, size_t size) = 0;

    /**
     * @brief 读取设备寄存器
     * @param addr 访问地址（相对于设备基地址的偏移量）
     * @param data 读取数据缓冲区（由调用者分配）
     * @param size 读取字节数（1、2 或 4）
     *
     * 示例实现：
     * @code
     * void read(uint32_t addr, uint8_t* data, size_t size) override {
     *     if (size == 4) {
     *         uint32_t value = 0;
     *         switch (addr) {
     *             case REG_STATUS: value = status; break;
     *             case REG_DATA:   value = read_fifo(); break;
     *             default: value = 0;
     *         }
     *         *reinterpret_cast<uint32_t*>(data) = value;
     *     }
     * }
     * @endcode
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

// ============================================================================
// 设备模板示例（用于参考和继承）
// ============================================================================

/**
 * @example CustomDevice.hpp
 *
 * 以下是一个自定义设备的实现模板：
 *
 * @code
 * #ifndef CUSTOM_DEVICE_HPP
 * #define CUSTOM_DEVICE_HPP
 *
 * #include "device/Device.hpp"
 *
 * class CustomDevice : public Device {
 * private:
 *     // 寄存器定义（相对于设备基地址的偏移量）
 *     static constexpr uint32_t REG_CONTROL  = 0x00;
 *     static constexpr uint32_t REG_STATUS   = 0x04;
 *     static constexpr uint32_t REG_CONFIG  = 0x08;
 *     static constexpr uint32_t REG_DATA     = 0x0C;
 *
 *     // 寄存器变量
 *     uint32_t control;
 *     uint32_t status;
 *     uint32_t config;
 *     uint32_t data_reg;
 *
 * public:
 *     CustomDevice() : control(0), status(0), config(0), data_reg(0) {}
 *
 *     void write(uint32_t addr, uint8_t* data, size_t size) override {
 *         if (size != 4) return;
 *         uint32_t value = bytes_to_word(data);
 *
 *         switch (addr) {
 *             case REG_CONTROL: control = value; break;
 *             case REG_CONFIG:  config = value; break;
 *             case REG_DATA:    data_reg = value; break;
 *         }
 *     }
 *
 *     void read(uint32_t addr, uint8_t* data, size_t size) override {
 *         if (size != 4) return;
 *         uint32_t value = 0;
 *
 *         switch (addr) {
 *             case REG_STATUS: value = status; break;
 *             case REG_DATA:   value = data_reg; break;
 *             case REG_CONTROL: value = control; break;
 *         }
 *         word_to_bytes(value, data);
 *     }
 * };
 *
 * #endif
 * @endcode
 */

/**
 * @page device_implementation 设备实现指南
 *
 * 1. 创建头文件：在 include/device/ 目录下创建设备的头文件
 * 2. 继承 Device 基类
 * 3. 定义寄存器偏移量（使用 static constexpr）
 * 4. 实现 write() 和 read() 方法
 * 5. 在 simulator_api.cpp 中注册设备并挂载到总线
 *
 * 挂载设备示例：
 * @code
 * // 创建设备实例（建议使用 static 避免生命周期问题）
 * static CustomDevice my_device;
 *
 * // 创建总线并挂载
 * Bus* bus = new Bus();
 * bus->attach_memory(mem);
 * bus->attach_device(0x20000000, &my_device);  // 地址可自定义
 *
 * // 将总线连接到 CPU
 * cpu->attach_bus(bus);
 * @endcode
 */

#endif // DEVICE_HPP
