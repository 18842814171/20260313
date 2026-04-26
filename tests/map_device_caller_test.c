#include <stdint.h>

// Display MMIO: 0x10001000
#define DISP_BASE 0x10001000u
#define DISP_REG_ADDR(offset) ((volatile uint32_t*)(DISP_BASE + (offset)))

#define DISP_REG_CTRL 0x00u
#define DISP_REG_STATUS 0x04u
#define DISP_REG_FB_ADDR 0x08u
#define DISP_REG_WIDTH 0x0Cu
#define DISP_REG_HEIGHT 0x10u
#define DISP_REG_FORMAT 0x14u
#define DISP_REG_OUT_NAME_ADDR 0x1Cu
#define DISP_REG_OUT_NAME_LEN 0x20u

#define DISP_CTRL_ENABLE (1u << 0)
#define DISP_CTRL_REFRESH (1u << 1)
#define DISP_STATUS_READY (1u << 0)

// Must match include/utils/color_schema.hpp schema values.
#define DISP_FORMAT_GRAY8 0u
#define DISP_FORMAT_RGB332 1u

#define FB_ADDR 0x30000u
#define OUT_NAME_ADDR 0x3F000u
#define MAP_W 512u
#define MAP_H 512u

int main(void) {
    // Name requested by guest for host output image.
    // Device will auto-prefix with "out/" if no slash is present.
    static const char kOutName[] = "maploader_sample_render.ppm";
    volatile uint8_t* out_name_mem = (volatile uint8_t*)OUT_NAME_ADDR;
    for (uint32_t i = 0; i < (uint32_t)sizeof(kOutName); ++i) {
        out_name_mem[i] = (uint8_t)kOutName[i];
    }

    // The map JSON is preloaded by simulator (--map ...). Guest only calls device.
    *DISP_REG_ADDR(DISP_REG_FB_ADDR) = FB_ADDR;
    *DISP_REG_ADDR(DISP_REG_WIDTH) = MAP_W;
    *DISP_REG_ADDR(DISP_REG_HEIGHT) = MAP_H;
    *DISP_REG_ADDR(DISP_REG_FORMAT) = DISP_FORMAT_RGB332;
    *DISP_REG_ADDR(DISP_REG_OUT_NAME_ADDR) = OUT_NAME_ADDR;
    *DISP_REG_ADDR(DISP_REG_OUT_NAME_LEN) = (uint32_t)sizeof(kOutName);
    *DISP_REG_ADDR(DISP_REG_CTRL) = DISP_CTRL_ENABLE | DISP_CTRL_REFRESH;

    // Poll status once to keep caller behavior aligned with template style.
    while (((*DISP_REG_ADDR(DISP_REG_STATUS)) & DISP_STATUS_READY) == 0u) {
        asm volatile("nop");
    }

    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");
    return 0;
}
