// Circle print test following abc.c style: pure UART MMIO macros.
#include <stdint.h>
#include "mmio_uart.h"

#define CIRCLE_RADIUS 6

static int32_t iabs_i32(int32_t v) {
    return (v < 0) ? -v : v;
}

static int32_t square_mul(int32_t v) {
    int32_t a = iabs_i32(v);
    int32_t r;
    asm volatile("mul %0, %1, %2" : "=r"(r) : "r"(a), "r"(a));
    return r;
}

int main(void) {
    const int32_t r = CIRCLE_RADIUS;
    const int32_t rr = square_mul(r);

    uart_enable_tx();
    UART_PUTLIT("=== circle print test ===");
    UART_NL();

    for (int32_t y = -r; y <= r; ++y) {
        const int32_t yy = square_mul(y);
        for (int32_t x = -r; x <= r; ++x) {
            const int32_t xx = square_mul(x);
            if (xx + yy <= rr) {
                UART_PUTC('*');
            } else {
                UART_PUTC(' ');
            }
        }
        UART_NL();
    }

    return 0;
}
