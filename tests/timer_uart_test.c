/**
 * @file timer_uart_test.c
 * @brief 同时覆盖 Timer（0x02004000）与 UART（0x10000000）：行编辑 + 回显 + 打印 MTIME
 *
 * 单独测某一外设时，在 tests/ 下另建只访问该设备的 C 程序即可。
 */

#include <stdint.h>

#define TIMER_BASE     0x02004000
#define TIMER_MTIME    (*(volatile uint64_t*)(TIMER_BASE + 0x00))
#define TIMER_MTIMECMP (*(volatile uint64_t*)(TIMER_BASE + 0x08))

#define UART_BASE   0x10000000
#define UART_TXDATA (*(volatile uint32_t*)(UART_BASE + 0x00))
#define UART_RXDATA (*(volatile uint32_t*)(UART_BASE + 0x04))
#define UART_TXCTRL (*(volatile uint32_t*)(UART_BASE + 0x08))
#define UART_RXCTRL (*(volatile uint32_t*)(UART_BASE + 0x0C))
#define UART_IE     (*(volatile uint32_t*)(UART_BASE + 0x10))

static void uart_putc(char c) {
    while (UART_TXDATA & 0x80000000) {
    }
    UART_TXDATA = (uint32_t)(unsigned char)c;
}

static void uart_puts(const char* s) {
    while (*s) {
        uart_putc(*s++);
    }
}

static void uart_nl(void) {
    uart_putc('\r');
    uart_putc('\n');
}

static void print_hex32(uint32_t val) {
    static const char hex[] = "0123456789ABCDEF";
    uart_puts("0x");
    for (int i = 28; i >= 0; i -= 4) {
        uart_putc(hex[(val >> i) & 0xF]);
    }
}

static char uart_read(void) {
    uint32_t rx;
    while ((rx = UART_RXDATA) & 0x80000000) {
    }
    return (char)(rx & 0xFF);
}

static void uart_getline(char* buf, int max_len) {
    int n = 0;
    while (n < max_len - 1) {
        char c = uart_read();
        uart_putc(c);
        if (c == '\r' || c == '\n') {
            uart_nl();
            break;
        }
        buf[n++] = c;
    }
    buf[n] = '\0';
}

void _start(void) {
    UART_TXCTRL = 1;
    UART_RXCTRL = 1 | 2;
    UART_IE = 2;

    uart_puts("=== Timer + UART（双设备）===");
    uart_nl();
    uart_puts("每行输入后回车，将打印 MTIME；输入 q 回车退出。");
    uart_nl();

    char line[80];
    for (;;) {
        uart_puts("> ");
        uart_getline(line, (int)sizeof(line));

        if (line[0] == 'q' && line[1] == '\0') {
            uart_puts("再见。");
            uart_nl();
            break;
        }

        uart_puts("收到: ");
        uart_puts(line);
        uart_nl();

        uart_puts("Timer MTIME: ");
        uint64_t mtime_val = TIMER_MTIME;
        print_hex32((uint32_t)(mtime_val >> 32));
        print_hex32((uint32_t)(mtime_val & 0xFFFFFFFFU));
        uart_nl();
    }

    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");

    for (;;) {
    }
}
