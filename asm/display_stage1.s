
out/display_stage1:     file format elf32-littleriscv


Disassembly of section .text:

00010000 <_start>:
   10000:	000302b7          	lui	t0,0x30
   10004:	0e000313          	li	t1,224
   10008:	00628023          	sb	t1,0(t0) # 30000 <__global_pointer$+0x1e7c8>
   1000c:	100013b7          	lui	t2,0x10001
   10010:	0053a423          	sw	t0,8(t2) # 10001008 <__global_pointer$+0xffef7d0>
   10014:	00100e13          	li	t3,1
   10018:	01c3a623          	sw	t3,12(t2)
   1001c:	01c3a823          	sw	t3,16(t2)
   10020:	01c3aa23          	sw	t3,20(t2)
   10024:	00300e93          	li	t4,3
   10028:	01d3a023          	sw	t4,0(t2)
   1002c:	00000513          	li	a0,0
   10030:	05d00893          	li	a7,93
   10034:	00000073          	ecall
