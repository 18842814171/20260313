#include <ctype.h>
#include <stdint.h>
#include "mmio_uart.h"

#define LINE_BUF_SIZE 96u

static void uart_print_line(const char* s, uint32_t len) {
    UART_PUTLIT("You typed: ");
    uart_write(s, len);
    UART_NL();
}

/** 是否应退出：trim 空白后单字符 q/Q；或误把字面量 "q\\n" 当成换行（共 3 字节） */
static int line_is_quit(const char* s, uint32_t n) {
    if (n == 0u) {
        return 0;
    }
    uint32_t lo = 0u;
    uint32_t hi = n;
    while (lo < hi && isspace((unsigned char)s[lo])) {
        lo++;
    }
    while (hi > lo && isspace((unsigned char)s[hi - 1u])) {
        hi--;
    }
    const uint32_t m = hi - lo;
    if (m == 0u) {
        return 0;
    }
    if (m == 1u && (s[lo] == 'q' || s[lo] == 'Q')) {
        return 1;
    }
    if (m == 3u && s[lo] == 'q' && s[lo + 1u] == '\\' && (s[lo + 2u] == 'n' || s[lo + 2u] == 'N')) {
        return 1;
    }
    return 0;
}

int main(void) {
    uart_enable_tx();
    uart_enable_rx();
    uart_disable_irq();

    UART_PUTLIT("=== UART line input test ===\n");
    UART_PUTLIT("Type one line, press ENTER to submit.\n");
    UART_PUTLIT("Type 'q' then ENTER to quit.\n");

    char line[LINE_BUF_SIZE];
    uint32_t n = 0;
    uint32_t last_was_cr = 0u;

    while (1) {
        UART_PUTLIT("> ");
        n = 0;

        while (1) {
            uint32_t ch = 0;
            while (uart_try_getc_u32(&ch) != 0) {
            }

            if (ch == (uint32_t)'\r') {
                UART_NL();
                last_was_cr = 1u;
                break;
            }
            if (ch == (uint32_t)'\n') {
                if (last_was_cr) {
                    last_was_cr = 0u;
                    continue;
                }
                UART_NL();
                break;
            }
            last_was_cr = 0u;

            if (ch == 0x08u || ch == 0x7Fu) {
                if (n > 0) {
                    n--;
                    UART_PUTLIT("\b \b");
                }
                continue;
            }

            if (n < (LINE_BUF_SIZE - 1u)) {
                line[n++] = (char)(ch & 0xFFu);
                uart_putc_u32(ch);
            }
        }

        line[n] = '\0';
        if (line_is_quit(line, n)) {
            UART_PUTLIT("Bye.\n");
            return 0;
        }

        uart_print_line(line, n);
    }
}
