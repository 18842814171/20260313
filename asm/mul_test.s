# RV32IM test:
# - MUL runs in the dedicated multiplier
# - independent ADDI/ADD should be able to pass while MUL is in flight
# - dependent ADD waits for MUL result
    .section .text
    .globl _start
    .align 2
_start:
    li      a0, 6
    li      a1, 7
    mul     a0, a0, a1
    addi    a2, zero, 5
    addi    a3, a2, 9
    add     a4, a0, a3
    mv      a0, a4
    li      a7, 93
    ecall
