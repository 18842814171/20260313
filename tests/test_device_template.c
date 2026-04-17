/**
 * @file program_test_device.c
 * @brief 外设设备测试程序模板
 *
 * 本文件用于编写自定义外设设备的测试程序。
 *
 * =====================================================
 * 设计自定义设备的步骤
 * =====================================================
 *
 * 1. 在 include/device/ 目录下创建设备头文件
 *    - 继承 Device 基类
 *    - 定义寄存器偏移量
 *    - 实现 read() 和 write() 方法
 *
 * 2. 在 simulator_api.cpp 中注册设备
 *    - 创建设备实例
 *    - 使用 bus->attach_device() 挂载到总线
 *
 * 3. 在此文件中编写测试代码访问设备
 *    - 使用 MMIO 地址访问寄存器
 *
 * =====================================================
 * MMIO 地址规范
 * =====================================================
 *
 * 内存区域:
 *   0x00001000 - 0x00010000: 程序代码和数据
 *
 * MMIO 区域:
 *   0x10000000 起: 外设设备
 *
 * 示例设备地址:
 *   Timer: 0x02004000
 *   自定义设备: 0x20000000 (示例)
 *
 * =====================================================
 * 寄存器访问模式
 * =====================================================
 *
 * struct DeviceRegisters {
 *     volatile uint32_t REG_CTRL;   // 控制寄存器
 *     volatile uint32_t REG_STATUS; // 状态寄存器
 *     volatile uint32_t REG_DATA;   // 数据寄存器
 * };
 *
 * 访问示例:
 * #define DEVICE_BASE  0x20000000
 * #define REG_CTRL     (DEVICE_BASE + 0x00)
 * #define REG_STATUS   (DEVICE_BASE + 0x04)
 * #define REG_DATA     (DEVICE_BASE + 0x08)
 *
 * 读取: uint32_t val = *(volatile uint32_t*)REG_STATUS;
 * 写入: *(volatile uint32_t*)REG_CTRL = value;
 *
 * =====================================================
 * 调试建议
 * =====================================================
 *
 * 1. 先使用内存映射确认设备已正确挂载
 * 2. 读写寄存器时注意字节序（小端序）
 * 3. 使用 ebreak 指令在关键点设置断点
 * 4. 检查 CPU 寄存器确认操作结果
 *
 * 调试输出示例:
 *     asm volatile("li a0, 0x1234");
 *     asm volatile("ebreak");
 */

/*
 * =====================================================
 * 模板代码（取消注释即可使用）
 * =====================================================
 */

/*
#include <stdint.h>

// 设备基地址（根据实际设备修改）
#define DEVICE_BASE  0x20000000

// 寄存器偏移量（根据实际设备修改）
#define REG_CTRL     0x00
#define REG_STATUS   0x04
#define REG_CONFIG   0x08
#define REG_DATA     0x0C

// 辅助宏
#define REG_ADDR(offset) ((volatile uint32_t*)(DEVICE_BASE + (offset)))

int main() {
    // 初始化设备
    *REG_ADDR(REG_CTRL) = 0x01;      // 启用设备

    // 读取状态
    uint32_t status = *REG_ADDR(REG_STATUS);

    // 写入数据
    *REG_ADDR(REG_DATA) = 0x12345678;

    // 轮询等待完成
    while ((*REG_ADDR(REG_STATUS) & 0x01) == 0) {
        asm volatile("nop");
    }

    // 读取结果
    uint32_t result = *REG_ADDR(REG_DATA);

    // 退出程序
    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");

    while(1);
    return 0;
}
*/

/**
 * =====================================================
 * 设备驱动封装示例
 * =====================================================
 *
 * 以下是封装设备驱动函数的示例:
 */

/*
#include <stdint.h>

#define DEVICE_BASE  0x20000000

// 设备驱动结构
typedef struct {
    volatile uint32_t CTRL;
    volatile uint32_t STATUS;
    volatile uint32_t CONFIG;
    volatile uint32_t DATA;
} DeviceRegs_t;

#define DEVICE ((DeviceRegs_t*)DEVICE_BASE)

// 初始化设备
void device_init() {
    DEVICE->CTRL = 0x01;      // 启用设备
    DEVICE->CONFIG = 0x00;    // 默认配置
}

// 写入数据
void device_write(uint32_t data) {
    while (DEVICE->STATUS & 0x02) { }  // 等待就绪
    DEVICE->DATA = data;
}

// 读取数据
uint32_t device_read() {
    return DEVICE->DATA;
}

// 检查设备状态
int device_ready() {
    return (DEVICE->STATUS & 0x01) != 0;
}

int main() {
    device_init();

    device_write(100);
    while (!device_ready()) { }

    uint32_t result = device_read();

    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");

    while(1);
    return 0;
}
*/