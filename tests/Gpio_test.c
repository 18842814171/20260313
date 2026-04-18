/**
 * @file Gpio_test.c
 * @brief Gpio Device Test Program
 *
 * Device address: 0x200000001
 */

#include <stdint.h>

/* Device Registers */
#define GPIO_BASE   0x200000001
#define REG_CTRL                     0x00
#define REG_STATUS                   0x04
#define REG_DATA                     0x08

/* Helper macros */
#define REG(offset) ((volatile uint32_t*)(GPIO_BASE + (offset)))

int main() {
    /* Initialize device */
    *REG(REG_CTRL) = 0x01;

    /* Read status */
    uint32_t status = *REG(REG_STATUS);

    /* Main loop - customize for your device */
    for (int i = 0; i < 10; i++) {
        *REG(REG_DATA) = i;
        while ((*REG(REG_STATUS) & 0x01) == 0) {
            asm volatile("nop");
        }
    }

    /* Exit (RISC-V ecall) */
    asm volatile("li a7, 93");
    asm volatile("li a0, 0");
    asm volatile("ecall");

    while(1);
    return 0;
}
