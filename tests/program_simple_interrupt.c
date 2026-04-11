/**
 * @file program_simple_interrupt.c
 * @brief 中断测试程序模板
 *
 * 本文件为中断测试程序模板。用户可参考此模板编写自己的测试程序。
 *
 * =====================================================
 * 使用说明
 * =====================================================
 *
 * 1. 定义 MMIO 地址
 *    - Timer 设备地址: 0x02004000 (MTIME), 0x02004008 (MTIMECMP)
 *    - 根据实际设备修改偏移量
 *
 * 2. 实现中断处理
 *    - 使用 wfi 指令等待中断
 *    - 在中断处理函数中设置 mtimecmp 触发下次中断
 *
 * 3. 编译方式
 *    riscv64-unknown-elf-gcc -march=rv32i -nostartfiles \
 *        -T tests/rv32.ld -o output.elf your_program.c
 *
 * =====================================================
 * MMIO 寄存器偏移量参考（Timer 为例）
 * =====================================================
 *
 * struct TimerRegisters {
 *     volatile uint32_t MTIME;       // 偏移 0x00: 当前时间
 *     volatile uint32_t MTIMECMP;    // 偏移 0x08: 比较时间
 * };
 *
 * 地址映射示例:
 * #define MTIME_ADDR    0x02004000
 * #define MTIMECMP_ADDR 0x02004008
 *
 * =====================================================
 * 中断编程建议
 * =====================================================
 *
 * 1. 设置中断向量 (mtvec)
 * 2. 使能全局中断 (mstatus.MIE)
 * 3. 使能特定中断源 (mie)
 * 4. 循环中执行 wfi 等待中断
 * 5. 中断处理完成后设置 mtimecmp 触发下次中断
 *
 * 示例代码结构:
 *
 * void setup_interrupts() {
 *     // 设置中断向量
 *     asm volatile("csrw mtvec, %0" : : "r"(trap_handler_addr));
 *
 *     // 使能中断
 *     asm volatile("csrs mstatus, 0x8");  // mstatus.MIE = 1
 *     asm volatile("csrs mie, 0x80");     // mie.MTIE = 1 (Timer 中断)
 * }
 *
 * int main() {
 *     setup_interrupts();
 *
 *     // 设置首次中断时间
 *     volatile uint32_t* mtimecmp = (uint32_t*)MTIMECMP_ADDR;
 *     *mtimecmp = 100;
 *
 *     // 主循环
 *     while (1) {
 *         asm volatile("wfi");
 *         // 中断发生后在此继续执行
 *     }
 *
 *     return 0;
 * }
 */

/*
 * =====================================================
 * 模板代码（取消注释即可使用）
 * =====================================================
 */

/*
#include <stdint.h>

// Timer 寄存器地址
#define MTIME_ADDR    ((volatile uint32_t*)0x02004000)
#define MTIMECMP_ADDR ((volatile uint32_t*)0x02004008)

volatile int interrupt_count = 0;

void _start() {
    // 设置中断向量和使能中断
    uint32_t trap_addr = 0x100;  // 中断处理函数地址
    asm volatile("csrw mtvec, %0" : : "r"(trap_addr));
    asm volatile("csrs mstatus, 8");  // MIE = 1
    asm volatile("csrs mie, 0x80");    // MTIE = 1

    // 设置首次定时器比较值
    *MTIMECMP_ADDR = 100;

    // 主循环
    while (interrupt_count < 5) {
        asm volatile("wfi");
        // 重新设置下次中断时间
        *MTIMECMP_ADDR = *MTIME_ADDR + 100;
    }

    // 退出程序 (syscall 93)
    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");

    while(1);  // 不应到达此处
}

int main() {
    _start();
    return 0;
}
*/
