// UART output-only test, using shared MMIO UART helpers
#include "mmio_uart.h"

void main() {
    uart_enable_tx();
    UART_PUTLIT("abc");
    UART_NL();
}
