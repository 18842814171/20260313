/**
 * @file timer_uart_test.c
 * @brief 仅输出（不读输入）：周期性打印 MTIME，覆盖 Timer + UART
 */

#include <stdint.h>
#include "mmio_uart.h"

#define TIMER_BASE 0x02004000u
#define TIMER_MTIME_LO (*(volatile uint32_t*)(TIMER_BASE + 0x00u))

#define PRINT_ROUNDS 4
#define WAIT_TICKS_PER_ROUND 80u

static void uart_put_hex32(uint32_t v) {
    static const char hex[] = "0123456789ABCDEF";
    UART_PUTLIT("0x");
    for (int i = 28; i >= 0; i -= 4) {
        uart_putc_u32((uint8_t)hex[(v >> i) & 0xFu]);
    }
}

static void wait_ticks(uint32_t ticks) {
    /* 软等待：避免依赖 MTIME 单调前进导致死循环。 */
    for (uint32_t i = 0; i < ticks; ++i) {
        (void)TIMER_MTIME_LO;
    }
}

int main(void) {
    uart_enable_tx();
    UART_PUTLIT("=== Timer + UART output-only test ===");
    UART_NL();
    UART_PUTLIT("No input required; print MTIME periodically.");
    UART_NL();

    for (uint32_t i = 0; i < PRINT_ROUNDS; ++i) {
        uint32_t t = TIMER_MTIME_LO;
        UART_PUTLIT("[tick] MTIME=");
        uart_put_hex32(t);
        UART_NL();
        wait_ticks(WAIT_TICKS_PER_ROUND);
    }

    UART_PUTLIT("Done.");
    UART_NL();
    return 0;
}
