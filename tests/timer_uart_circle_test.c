#include <stdint.h>

#define TIMER_BASE 0x02004000u
#define TIMER_MTIME (*(volatile uint64_t*)(TIMER_BASE + 0x00u))

#define UART_BASE 0x10000000u
#define UART_TXCTRL (*(volatile uint32_t*)(UART_BASE + 0x08u))
#define UART_TXDATA (*(volatile uint32_t*)(UART_BASE + 0x00u))

/* 可调参数：半径越大，圆面越大。 */
#define CIRCLE_RADIUS 6
/* 可调参数：每一步的计时器节拍间隔。 */
#define STEP_TICKS 2

static int32_t g_cur_row = 0;
static int32_t g_cur_col = 0;

static void wait_ticks(int32_t ticks) {
    uint64_t last = TIMER_MTIME;
    int32_t passed = 0;
    int32_t fallback_spins = 0;
    const int32_t kFallbackSpinLimit = 32;
    while (passed < ticks) {
        uint64_t now = TIMER_MTIME;
        if (now != last) {
            last = now;
            passed++;
            fallback_spins = 0;
        } else {
            /*
             * 某些实现里 MTIME MMIO 可能读不出增量，给一个后备推进避免卡死。
             * 逻辑仍然优先由计时器控制节拍。
             */
            fallback_spins++;
            if (fallback_spins >= kFallbackSpinLimit) {
                fallback_spins = 0;
                passed++;
            }
        }
    }
}

static void uart_putc(char c) {
    /* simple_uart_test 同款：直接写 TXDATA。 */
    UART_TXDATA = (uint32_t)(uint8_t)c;
}

/* 函数1：先换行，再补空格，把光标移动到目标位置。 */
static void func1_newline_then_space_to(int32_t target_row, int32_t target_col) {
    while (g_cur_row < target_row) {
        uart_putc('\n');
        uart_putc(' ');
        g_cur_row++;
        g_cur_col = 1;
    }
    while (g_cur_col < target_col) {
        uart_putc(' ');
        g_cur_col++;
    }
}

/* 函数2：打印一个 '*'。 */
static void func2_put_star(void) {
    uart_putc('*');
    g_cur_col++;
}

static int32_t iabs_i32(int32_t v) {
    return (v < 0) ? -v : v;
}

/* 纯加法平方，避免触发 M 扩展乘法指令。 */
static int32_t square_no_mul(int32_t v) {
    int32_t a = iabs_i32(v);
    int32_t s = 0;
    for (int32_t i = 0; i < a; ++i) {
        s += a;
    }
    return s;
}

int main(void) {
    const int32_t r = CIRCLE_RADIUS;
    const int32_t rr = square_no_mul(r);
    UART_TXCTRL = 1u;

    /* 顶部留一行，便于观察。 */
    uart_putc('\n');
    g_cur_row = 0;
    g_cur_col = 0;

    for (int32_t y = -r; y <= r; ++y) {
        const int32_t yy = square_no_mul(y);
        for (int32_t x = -r; x <= r; ++x) {
            const int32_t xx = square_no_mul(x);
            if (xx + yy <= rr) {
                /* 把数学坐标映射到打印网格坐标（列整体右移 r+1）。 */
                int32_t row = y + r;
                int32_t col = x + r + 1;

                wait_ticks(STEP_TICKS);
                func1_newline_then_space_to(row, col);

                wait_ticks(STEP_TICKS);
                func2_put_star();
            }
        }
    }

    uart_putc('\n');
    return 0;
}
