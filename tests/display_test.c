#include <stdint.h>

// Display device MMIO: 0x10001000
#define DISP_BASE 0x10001000u
#define DISP_CTRL (*(volatile uint32_t*)(DISP_BASE + 0x00u))
#define DISP_FB_ADDR (*(volatile uint32_t*)(DISP_BASE + 0x08u))
#define DISP_WIDTH (*(volatile uint32_t*)(DISP_BASE + 0x0Cu))
#define DISP_HEIGHT (*(volatile uint32_t*)(DISP_BASE + 0x10u))
#define DISP_FORMAT (*(volatile uint32_t*)(DISP_BASE + 0x14u))

#define DISP_CTRL_ENABLE (1u << 0)
#define DISP_CTRL_REFRESH (1u << 1)
#define DISP_FORMAT_RGB332 1u

#define FB_ADDR 0x30000u
#define W 128u
#define H 96u

int main(void) {
    volatile uint8_t* fb = (volatile uint8_t*)FB_ADDR;
    for (uint32_t y = 0; y < H; ++y) {
        for (uint32_t x = 0; x < W; ++x) {
            // RGB332 test pattern without libgcc division helpers
            uint8_t r = (uint8_t)((x >> 4) & 0x07u); // 0..7 across width 128
            uint8_t g = (uint8_t)((y >> 4) & 0x07u); // 0..5 across height 96
            uint8_t b = (uint8_t)(((x ^ y) & 0x3u));
            fb[y * W + x] = (uint8_t)((r << 5) | (g << 2) | b);
        }
    }

    DISP_FB_ADDR = FB_ADDR;
    DISP_WIDTH = W;
    DISP_HEIGHT = H;
    DISP_FORMAT = DISP_FORMAT_RGB332;
    DISP_CTRL = DISP_CTRL_ENABLE | DISP_CTRL_REFRESH;
    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");
    return 0;
}
