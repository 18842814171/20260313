/**
 * @file 2.c
 * @brief UART 半交互测试：有输入则回显，无输入则心跳，避免阻塞
 */

#include <stdint.h>
#include "mmio_uart.h"

#define IDLE_HEARTBEAT_ROUNDS 2u
#define RX_TIMEOUT_SPINS 400u

static void uart_put_hex8(uint32_t v) {
    static const char hex[] = "0123456789ABCDEF";
    uart_putc_u32((uint8_t)hex[(v >> 4) & 0xFu]);
    uart_putc_u32((uint8_t)hex[v & 0xFu]);
}

int main(void) {
    uart_enable_tx();
    uart_enable_rx();

    UART_PUTLIT("=== UART semi-interactive test ===\n");
    UART_PUTLIT("Type any key to echo. Input 'q' to quit.\n");
    UART_PUTLIT("No input => print heartbeat and exit.\n");

    uint32_t idle_rounds = 0;
    while (idle_rounds < IDLE_HEARTBEAT_ROUNDS) {
        uint32_t ch = 0;
        if (uart_getc_u32_timeout(&ch, RX_TIMEOUT_SPINS) == 0) {
            UART_PUTLIT("[rx] '");
            uart_putc_u32(ch);
            UART_PUTLIT("' 0x");
            uart_put_hex8(ch);
            UART_NL();
            idle_rounds = 0;
            if (ch == (uint32_t)'q') {
                UART_PUTLIT("Quit by input.\n");
                return 0;
            }
        } else {
            UART_PUTLIT("[idle]\n");
            idle_rounds++;
        }
    }

    UART_PUTLIT("Exit by idle timeout.\n");
    return 0;
}