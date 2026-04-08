	.section .text
	.global _start
	.align 2

_start:
	li	sp, 0x20000
	sw	s0, -4(sp)
	mv	s0, sp
	addi	sp, sp, -48

	li	a5, 10

	li	a7, 93
	li	a0, 0
	ecall
