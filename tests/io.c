#include <stdint.h>
#include "mmio_uart.h"

int main(void) {
    uart_enable_tx();
    uart_enable_rx();
    uart_disable_irq();

    UART_PUTLIT("=== UART mixed I/O test ===\n");
    UART_PUTLIT("Prompt + timeout + echo.\n");

    uint32_t last_was_cr = 0u;
    while (1) {
        UART_PUTLIT("Input one char (q to quit): ");

        uint32_t ch = 0;
        while (uart_try_getc_u32(&ch) != 0) {
        }

        if (ch == (uint32_t)'\r') {
            UART_PUTLIT(" -> got: <ENTER>\n");
            last_was_cr = 1u;
            continue;
        }
        if (ch == (uint32_t)'\n') {
            if (last_was_cr) {
                /* 吃掉 CR 后紧跟的 LF，避免一次回车触发两次输入事件。 */
                last_was_cr = 0u;
                continue;
            }
            UART_PUTLIT(" -> got: <ENTER>\n");
            continue;
        }
        last_was_cr = 0u;

        UART_PUTLIT(" -> got: ");
        uart_putc_u32(ch);
        UART_NL();
        if (ch == (uint32_t)'q') {
            UART_PUTLIT("Bye.\n");
            return 0;
        }
    }
}
