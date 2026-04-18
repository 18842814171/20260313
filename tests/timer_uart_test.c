/**
 * @file timer_uart_test.c
 * @brief Timer 和 UART 设备交互式测试程序
 *
 * 设备地址:
 *   Timer: 0x02004000
 *   UART:  0x10000000
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

// =====================================================
// UART 辅助函数
// =====================================================

void uart_putc(char c) {
    while (UART_TXDATA & 0x80000000) { }  // 等待 TXFULL = 0
    UART_TXDATA = (uint32_t)c;
}

void uart_puts(const char* s) {
    while (*s) {
        uart_putc(*s++);
    }
}

void uart_puts_nl() {
    uart_putc('\r');
    uart_putc('\n');
}

void print_hex32(uint32_t val) {
    const char hex[] = "0123456789ABCDEF";
    uart_puts("0x");
    for (int i = 28; i >= 0; i -= 4) {
        uart_putc(hex[(val >> i) & 0xF]);
    }
}

// 检查是否有数据可读 (RXDATA[31] == 0 表示有数据)
int uart_has_data() {
    return !(UART_RXDATA & 0x80000000);
}

// 读取一个字符
char uart_read() {
    uint32_t rx;
    while ((rx = UART_RXDATA) & 0x80000000) { }  // 阻塞等待
    return (char)(rx & 0xFF);
}

// 读取一行（带回显）
void uart_getline(char* buf, int max_len) {
    int count = 0;
    while (count < max_len - 1) {
        char c = uart_read();
        uart_putc(c);  // 回显
        if (c == '\r' || c == '\n') {
            uart_puts_nl();
            break;
        }
        buf[count++] = c;
    }
    buf[count] = '\0';
}

// =====================================================
// 主函数
// =====================================================
int main() {
    char input_buf[64];

    // 初始化 UART
    UART_TXCTRL = 1;   // 启用发送
    UART_RXCTRL = 1;   // 启用接收

    // 欢迎信息
    uart_puts("========================================");
    uart_puts_nl();
    uart_puts("     Timer & UART Interactive Test");
    uart_puts_nl();
    uart_puts("========================================");
    uart_puts_nl();
    uart_puts_nl();

    // 主循环
    while (1) {
        uart_puts("Type something and press Enter:");
        uart_puts_nl();

        uart_getline(input_buf, sizeof(input_buf));

        // 回显输入
        uart_puts("You typed: ");
        uart_puts(input_buf);
        uart_puts_nl();

        // 显示 Timer 状态
        uart_puts("Timer MTIME: ");
        uint64_t mtime_val = TIMER_MTIME;
        print_hex32((uint32_t)(mtime_val >> 32));
        print_hex32((uint32_t)(mtime_val & 0xFFFFFFFF));
        uart_puts_nl();

        // 检查是否退出
        if (input_buf[0] == 'q' && input_buf[1] == '\0') {
            uart_puts("Goodbye!");
            uart_puts_nl();
            break;
        }
    }

    // 退出程序
    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");

    while(1);
    return 0;
}