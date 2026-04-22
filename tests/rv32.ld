OUTPUT_FORMAT("elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

SECTIONS
{
    . = 0x10000;
    .text : {
        *(.text)
        *(.text.*)
    }
    .data : {
        *(.data)
        *(.rodata*)
    }
    .bss : {
        *(.bss)
        *(COMMON)
    }
}
