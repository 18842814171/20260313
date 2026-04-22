#ifndef TESTS_MMIO_UART_H
#define TESTS_MMIO_UART_H

#include <stdint.h>

/* 供 RISC-V 测试程序直接访问的 UART MMIO 定义。 */
#define TEST_UART_BASE 0x10000000u
#define TEST_UART_TXDATA (*(volatile uint32_t*)(TEST_UART_BASE + 0x00u))
#define TEST_UART_RXDATA (*(volatile uint32_t*)(TEST_UART_BASE + 0x04u))
#define TEST_UART_TXCTRL (*(volatile uint32_t*)(TEST_UART_BASE + 0x08u))
#define TEST_UART_RXCTRL (*(volatile uint32_t*)(TEST_UART_BASE + 0x0Cu))
#define TEST_UART_IE (*(volatile uint32_t*)(TEST_UART_BASE + 0x10u))

/* simple 模式：与 simple_uart_test.c 一样，直接写 TXDATA。 */
#define UART_PUTC(ch) (TEST_UART_TXDATA = (uint32_t)(uint8_t)(ch))
#define UART_NL() UART_PUTC('\n')

static inline void uart_enable_tx(void) {
    TEST_UART_TXCTRL = 1u;
}

static inline void uart_enable_rx(void) {
    TEST_UART_RXCTRL = 1u;
}

static inline void uart_disable_irq(void) {
    TEST_UART_IE = 0u;
}

/* 注意：用 uint32_t 参数可避免某些环境下 char 参数传递导致的异常字节路径。 */
static inline void uart_putc_u32(uint32_t c) {
    TEST_UART_TXDATA = (uint32_t)(c & 0xFFu);
}

/* 通用字节流输出：可复用到任意缓冲区，不依赖手写 ASCII 常量。 */
static inline void uart_write(const char* buf, uint32_t len) {
    for (uint32_t i = 0; i < len; ++i) {
        uart_putc_u32((uint8_t)buf[i]);
    }
}

static inline void uart_puts(const char* s) {
    while (*s) {
        uart_putc_u32((uint8_t)*s++);
    }
}

/* 有界字符串输出：最多发送 max_len 字节，避免异常情况下越界喷日志。 */
static inline void uart_puts_n(const char* s, uint32_t max_len) {
    uint32_t i = 0;
    while (i < max_len && s[i] != '\0') {
        uart_putc_u32((uint8_t)s[i]);
        i++;
    }
}

/* 字符串字面量安全输出：编译期长度（不包含 '\0'）。 */
#define UART_PUTLIT(lit) uart_write((lit), (uint32_t)(sizeof(lit) - 1u))

static inline void uart_println(const char* s) {
    uart_puts(s);
    UART_NL();
}

static inline void uart_put_repeat(char c, uint32_t count) {
    for (uint32_t i = 0; i < count; ++i) {
        uart_putc_u32((uint8_t)c);
    }
}

/* RX bit31=1 表示 FIFO 空。 */
static inline int uart_try_getc_u32(uint32_t* out_c) {
    uint32_t v = TEST_UART_RXDATA;
    /*
     * 兼容两种“空 FIFO”语义：
     * 1) bit31=1（标准 empty 标志）
     * 2) 读回 0x00000000（某些实现/路径会这样返回）
     */
    if ((v & 0x80000000u) || v == 0x00000000u) {
        return -1;
    }
    *out_c = v & 0xFFu;
    return 0;
}

/* 带软超时读取，避免阻塞卡死。 */
static inline int uart_getc_u32_timeout(uint32_t* out_c, uint32_t max_spins) {
    for (uint32_t i = 0; i < max_spins; ++i) {
        if (uart_try_getc_u32(out_c) == 0) {
            return 0;
        }
    }
    return -1;
}

/* 不依赖字符串常量存储的便捷输出，适合当前仿真链路。 */
#define UART_PUT3(c1, c2, c3) \
    do {                      \
        uart_putc_u32((uint8_t)(c1)); \
        uart_putc_u32((uint8_t)(c2)); \
        uart_putc_u32((uint8_t)(c3)); \
    } while (0)

#endif
