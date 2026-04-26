    .section .text
    .globl _start
    .align 2
_start:
    # 0x40000000 * 4 = 0x00000001_00000000, high32 should be 1
    li      a0, 0x40000000
    li      a1, 4
    mulh    a2, a0, a1

    # exit code = a2
    mv      a0, a2
    li      a7, 93
    ecall
