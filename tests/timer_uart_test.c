/**
 * @file timer_uart_test.c
 * @brief Timer 和 UART 设备测试程序
 *
 * 本程序测试 Timer 和 UART 外设设备的 MMIO 访问。
 *
 * 设备地址:
 *   Timer: 0x02004000 (MTIME=0x00, MTIMECMP=0x08)
 *   UART:  0x10000000 (TXDATA=0x00, RXDATA=0x04, TXCTRL=0x08, RXCTRL=0x0C)
 */

#include <stdint.h>

// =====================================================
// Timer 寄存器定义
// =====================================================
#define TIMER_BASE   0x02004000
#define TIMER_MTIME      (*(volatile uint64_t*)(TIMER_BASE + 0x00))
#define TIMER_MTIMECMP   (*(volatile uint64_t*)(TIMER_BASE + 0x08))

// =====================================================
// UART 寄存器定义
// =====================================================
#define UART_BASE   0x10000000
#define UART_TXDATA    (*(volatile uint32_t*)(UART_BASE + 0x00))
#define UART_RXDATA    (*(volatile uint32_t*)(UART_BASE + 0x04))
#define UART_TXCTRL    (*(volatile uint32_t*)(UART_BASE + 0x08))
#define UART_RXCTRL    (*(volatile uint32_t*)(UART_BASE + 0x0C))
#define UART_IE        (*(volatile uint32_t*)(UART_BASE + 0x10))
#define UART_IP        (*(volatile uint32_t*)(UART_BASE + 0x14))
#define UART_DIV       (*(volatile uint32_t*)(UART_BASE + 0x18))

// =====================================================
// 辅助函数
// =====================================================

// 打印字符到 UART
void uart_putc(char c) {
    UART_TXDATA = (uint32_t)c;
}

// 打印字符串到 UART
void uart_puts(const char* s) {
    while (*s) {
        uart_putc(*s);
        s++;
    }
}

// 打印十六进制数字
void print_hex(uint32_t val) {
    const char hex_chars[] = "0123456789ABCDEF";
    char buf[11];
    buf[0] = '0';
    buf[1] = 'x';
    buf[10] = '\0';
    
    for (int i = 9; i >= 2; i--) {
        buf[i] = hex_chars[val & 0xF];
        val >>= 4;
    }
    
    uart_puts(buf);
}

// 打印换行
void println() {
    uart_putc('\n');
}

// =====================================================
// 主函数
// =====================================================
int main() {
    // 初始化 UART
    UART_TXCTRL = 1;   // 启用发送
    UART_RXCTRL = 1;   // 启用接收
    UART_DIV = 16;      // 波特率分频
    
    // 测试输出
    uart_puts("=== Timer & UART Test ===");
    println();
    
    // 测试 Timer
    uart_puts("Timer MTIME: ");
    uint64_t mtime_val = TIMER_MTIME;
    // 打印高32位
    print_hex((uint32_t)(mtime_val >> 32));
    // 打印低32位
    print_hex((uint32_t)(mtime_val & 0xFFFFFFFF));
    println();
    
    // 测试 UART 发送
    uart_puts("Writing to UART...");
    println();
    
    uart_putc('H');
    uart_putc('e');
    uart_putc('l');
    uart_putc('l');
    uart_putc('o');
    uart_putc(' ');
    uart_putc('W');
    uart_putc('o');
    uart_putc('r');
    uart_putc('l');
    uart_putc('d');
    uart_putc('!');
    println();
    
    // 读取 UART RXDATA (应该为空，返回 0x80000000)
    uart_puts("UART RXDATA (should be empty): ");
    uint32_t rx = UART_RXDATA;
    print_hex(rx);
    println();
    
    // 写一些数据到 RXDATA 以模拟接收
    uart_puts("Writing test data to RXDATA...");
    println();
    
    // 测试寄存器读写
    uart_puts("UART TXCTRL: ");
    print_hex(UART_TXCTRL);
    println();
    
    uart_puts("UART RXCTRL: ");
    print_hex(UART_RXCTRL);
    println();
    
    uart_puts("UART DIV: ");
    print_hex(UART_DIV);
    println();
    
    // 测试完成
    uart_puts("=== Test Complete ===");
    println();
    
    // 退出程序
    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");
    
    while(1);
    return 0;
}
