
out/timer_uart_circle_test:     file format elf32-littleriscv


Disassembly of section .text:

000100b4 <exit>:
   100b4:	ff010113          	addi	sp,sp,-16
   100b8:	00000593          	li	a1,0
   100bc:	00812423          	sw	s0,8(sp)
   100c0:	00112623          	sw	ra,12(sp)
   100c4:	00050413          	mv	s0,a0
   100c8:	709000ef          	jal	10fd0 <__call_exitprocs>
   100cc:	d681a783          	lw	a5,-664(gp) # 13aa0 <__stdio_exit_handler>
   100d0:	00078463          	beqz	a5,100d8 <exit+0x24>
   100d4:	000780e7          	jalr	a5
   100d8:	00040513          	mv	a0,s0
   100dc:	2d8020ef          	jal	123b4 <_exit>

000100e0 <register_fini>:
   100e0:	00000793          	li	a5,0
   100e4:	00078863          	beqz	a5,100f4 <register_fini+0x14>
   100e8:	00012537          	lui	a0,0x12
   100ec:	28450513          	addi	a0,a0,644 # 12284 <__libc_fini_array>
   100f0:	0300106f          	j	11120 <atexit>
   100f4:	00008067          	ret

000100f8 <_start>:
   100f8:	00004197          	auipc	gp,0x4
   100fc:	c4018193          	addi	gp,gp,-960 # 13d38 <__global_pointer$>
   10100:	00000513          	li	a0,0
   10104:	00050463          	beqz	a0,1010c <_start+0x14>
   10108:	01751073          	csrw	jvt,a0
   1010c:	00004517          	auipc	a0,0x4
   10110:	99450513          	addi	a0,a0,-1644 # 13aa0 <__stdio_exit_handler>
   10114:	00004617          	auipc	a2,0x4
   10118:	cbc60613          	addi	a2,a2,-836 # 13dd0 <__BSS_END__>
   1011c:	40a60633          	sub	a2,a2,a0
   10120:	00000593          	li	a1,0
   10124:	5d1000ef          	jal	10ef4 <memset>
   10128:	00001517          	auipc	a0,0x1
   1012c:	ff850513          	addi	a0,a0,-8 # 11120 <atexit>
   10130:	00050863          	beqz	a0,10140 <_start+0x48>
   10134:	00002517          	auipc	a0,0x2
   10138:	15050513          	addi	a0,a0,336 # 12284 <__libc_fini_array>
   1013c:	7e5000ef          	jal	11120 <atexit>
   10140:	521000ef          	jal	10e60 <__libc_init_array>
   10144:	00012503          	lw	a0,0(sp)
   10148:	00410593          	addi	a1,sp,4
   1014c:	00251613          	slli	a2,a0,0x2
   10150:	00460613          	addi	a2,a2,4
   10154:	00b60633          	add	a2,a2,a1
   10158:	3f4000ef          	jal	1054c <main>
   1015c:	f59ff06f          	j	100b4 <exit>

00010160 <__do_global_dtors_aux>:
   10160:	ff010113          	addi	sp,sp,-16
   10164:	00812423          	sw	s0,8(sp)
   10168:	d841c783          	lbu	a5,-636(gp) # 13abc <completed.1>
   1016c:	00112623          	sw	ra,12(sp)
   10170:	02079263          	bnez	a5,10194 <__do_global_dtors_aux+0x34>
   10174:	00000793          	li	a5,0
   10178:	00078a63          	beqz	a5,1018c <__do_global_dtors_aux+0x2c>
   1017c:	00012537          	lui	a0,0x12
   10180:	52450513          	addi	a0,a0,1316 # 12524 <__EH_FRAME_BEGIN__>
   10184:	00000097          	auipc	ra,0x0
   10188:	000000e7          	jalr	zero # 0 <exit-0x100b4>
   1018c:	00100793          	li	a5,1
   10190:	d8f18223          	sb	a5,-636(gp) # 13abc <completed.1>
   10194:	00c12083          	lw	ra,12(sp)
   10198:	00812403          	lw	s0,8(sp)
   1019c:	01010113          	addi	sp,sp,16
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	00000793          	li	a5,0
   101a8:	00078c63          	beqz	a5,101c0 <frame_dummy+0x1c>
   101ac:	00012537          	lui	a0,0x12
   101b0:	d8818593          	addi	a1,gp,-632 # 13ac0 <object.0>
   101b4:	52450513          	addi	a0,a0,1316 # 12524 <__EH_FRAME_BEGIN__>
   101b8:	00000317          	auipc	t1,0x0
   101bc:	00000067          	jr	zero # 0 <exit-0x100b4>
   101c0:	00008067          	ret

000101c4 <wait_ticks>:
   101c4:	fc010113          	addi	sp,sp,-64
   101c8:	02112e23          	sw	ra,60(sp)
   101cc:	02812c23          	sw	s0,56(sp)
   101d0:	04010413          	addi	s0,sp,64
   101d4:	fca42623          	sw	a0,-52(s0)
   101d8:	020047b7          	lui	a5,0x2004
   101dc:	0007a703          	lw	a4,0(a5) # 2004000 <__BSS_END__+0x1ff0230>
   101e0:	0047a783          	lw	a5,4(a5)
   101e4:	fee42423          	sw	a4,-24(s0)
   101e8:	fef42623          	sw	a5,-20(s0)
   101ec:	fe042223          	sw	zero,-28(s0)
   101f0:	fe042023          	sw	zero,-32(s0)
   101f4:	02000793          	li	a5,32
   101f8:	fcf42e23          	sw	a5,-36(s0)
   101fc:	07c0006f          	j	10278 <wait_ticks+0xb4>
   10200:	020047b7          	lui	a5,0x2004
   10204:	0007a703          	lw	a4,0(a5) # 2004000 <__BSS_END__+0x1ff0230>
   10208:	0047a783          	lw	a5,4(a5)
   1020c:	fce42823          	sw	a4,-48(s0)
   10210:	fcf42a23          	sw	a5,-44(s0)
   10214:	fd042703          	lw	a4,-48(s0)
   10218:	fe842783          	lw	a5,-24(s0)
   1021c:	00f71863          	bne	a4,a5,1022c <wait_ticks+0x68>
   10220:	fd442703          	lw	a4,-44(s0)
   10224:	fec42783          	lw	a5,-20(s0)
   10228:	02f70463          	beq	a4,a5,10250 <wait_ticks+0x8c>
   1022c:	fd042703          	lw	a4,-48(s0)
   10230:	fd442783          	lw	a5,-44(s0)
   10234:	fee42423          	sw	a4,-24(s0)
   10238:	fef42623          	sw	a5,-20(s0)
   1023c:	fe442783          	lw	a5,-28(s0)
   10240:	00178793          	addi	a5,a5,1
   10244:	fef42223          	sw	a5,-28(s0)
   10248:	fe042023          	sw	zero,-32(s0)
   1024c:	02c0006f          	j	10278 <wait_ticks+0xb4>
   10250:	fe042783          	lw	a5,-32(s0)
   10254:	00178793          	addi	a5,a5,1
   10258:	fef42023          	sw	a5,-32(s0)
   1025c:	fe042703          	lw	a4,-32(s0)
   10260:	fdc42783          	lw	a5,-36(s0)
   10264:	00f74a63          	blt	a4,a5,10278 <wait_ticks+0xb4>
   10268:	fe042023          	sw	zero,-32(s0)
   1026c:	fe442783          	lw	a5,-28(s0)
   10270:	00178793          	addi	a5,a5,1
   10274:	fef42223          	sw	a5,-28(s0)
   10278:	fe442703          	lw	a4,-28(s0)
   1027c:	fcc42783          	lw	a5,-52(s0)
   10280:	f8f740e3          	blt	a4,a5,10200 <wait_ticks+0x3c>
   10284:	00000013          	nop
   10288:	00000013          	nop
   1028c:	03c12083          	lw	ra,60(sp)
   10290:	03812403          	lw	s0,56(sp)
   10294:	04010113          	addi	sp,sp,64
   10298:	00008067          	ret

0001029c <uart_putc>:
   1029c:	fe010113          	addi	sp,sp,-32
   102a0:	00112e23          	sw	ra,28(sp)
   102a4:	00812c23          	sw	s0,24(sp)
   102a8:	02010413          	addi	s0,sp,32
   102ac:	00050793          	mv	a5,a0
   102b0:	fef407a3          	sb	a5,-17(s0)
   102b4:	100007b7          	lui	a5,0x10000
   102b8:	fef44703          	lbu	a4,-17(s0)
   102bc:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec230>
   102c0:	00000013          	nop
   102c4:	01c12083          	lw	ra,28(sp)
   102c8:	01812403          	lw	s0,24(sp)
   102cc:	02010113          	addi	sp,sp,32
   102d0:	00008067          	ret

000102d4 <uart_puts>:
   102d4:	fe010113          	addi	sp,sp,-32
   102d8:	00112e23          	sw	ra,28(sp)
   102dc:	00812c23          	sw	s0,24(sp)
   102e0:	02010413          	addi	s0,sp,32
   102e4:	fea42623          	sw	a0,-20(s0)
   102e8:	01c0006f          	j	10304 <uart_puts+0x30>
   102ec:	fec42783          	lw	a5,-20(s0)
   102f0:	00178713          	addi	a4,a5,1
   102f4:	fee42623          	sw	a4,-20(s0)
   102f8:	0007c783          	lbu	a5,0(a5)
   102fc:	00078513          	mv	a0,a5
   10300:	f9dff0ef          	jal	1029c <uart_putc>
   10304:	fec42783          	lw	a5,-20(s0)
   10308:	0007c783          	lbu	a5,0(a5)
   1030c:	fe0790e3          	bnez	a5,102ec <uart_puts+0x18>
   10310:	00000013          	nop
   10314:	00000013          	nop
   10318:	01c12083          	lw	ra,28(sp)
   1031c:	01812403          	lw	s0,24(sp)
   10320:	02010113          	addi	sp,sp,32
   10324:	00008067          	ret

00010328 <uart_put_u32>:
   10328:	fd010113          	addi	sp,sp,-48
   1032c:	02112623          	sw	ra,44(sp)
   10330:	02812423          	sw	s0,40(sp)
   10334:	03010413          	addi	s0,sp,48
   10338:	fca42e23          	sw	a0,-36(s0)
   1033c:	fe042623          	sw	zero,-20(s0)
   10340:	fdc42783          	lw	a5,-36(s0)
   10344:	06079a63          	bnez	a5,103b8 <uart_put_u32+0x90>
   10348:	03000513          	li	a0,48
   1034c:	f51ff0ef          	jal	1029c <uart_putc>
   10350:	0a80006f          	j	103f8 <uart_put_u32+0xd0>
   10354:	fdc42683          	lw	a3,-36(s0)
   10358:	ccccd7b7          	lui	a5,0xccccd
   1035c:	ccd78793          	addi	a5,a5,-819 # cccccccd <__BSS_END__+0xcccb8efd>
   10360:	02f6b7b3          	mulhu	a5,a3,a5
   10364:	0037d713          	srli	a4,a5,0x3
   10368:	00070793          	mv	a5,a4
   1036c:	00279793          	slli	a5,a5,0x2
   10370:	00e787b3          	add	a5,a5,a4
   10374:	00179793          	slli	a5,a5,0x1
   10378:	40f68733          	sub	a4,a3,a5
   1037c:	0ff77713          	zext.b	a4,a4
   10380:	fec42783          	lw	a5,-20(s0)
   10384:	00178693          	addi	a3,a5,1
   10388:	fed42623          	sw	a3,-20(s0)
   1038c:	03070713          	addi	a4,a4,48
   10390:	0ff77713          	zext.b	a4,a4
   10394:	ff078793          	addi	a5,a5,-16
   10398:	008787b3          	add	a5,a5,s0
   1039c:	fee78823          	sb	a4,-16(a5)
   103a0:	fdc42703          	lw	a4,-36(s0)
   103a4:	ccccd7b7          	lui	a5,0xccccd
   103a8:	ccd78793          	addi	a5,a5,-819 # cccccccd <__BSS_END__+0xcccb8efd>
   103ac:	02f737b3          	mulhu	a5,a4,a5
   103b0:	0037d793          	srli	a5,a5,0x3
   103b4:	fcf42e23          	sw	a5,-36(s0)
   103b8:	fdc42783          	lw	a5,-36(s0)
   103bc:	02078663          	beqz	a5,103e8 <uart_put_u32+0xc0>
   103c0:	fec42703          	lw	a4,-20(s0)
   103c4:	00a00793          	li	a5,10
   103c8:	f8e7d6e3          	bge	a5,a4,10354 <uart_put_u32+0x2c>
   103cc:	01c0006f          	j	103e8 <uart_put_u32+0xc0>
   103d0:	fec42783          	lw	a5,-20(s0)
   103d4:	ff078793          	addi	a5,a5,-16
   103d8:	008787b3          	add	a5,a5,s0
   103dc:	ff07c783          	lbu	a5,-16(a5)
   103e0:	00078513          	mv	a0,a5
   103e4:	eb9ff0ef          	jal	1029c <uart_putc>
   103e8:	fec42783          	lw	a5,-20(s0)
   103ec:	fff78713          	addi	a4,a5,-1
   103f0:	fee42623          	sw	a4,-20(s0)
   103f4:	fc079ee3          	bnez	a5,103d0 <uart_put_u32+0xa8>
   103f8:	02c12083          	lw	ra,44(sp)
   103fc:	02812403          	lw	s0,40(sp)
   10400:	03010113          	addi	sp,sp,48
   10404:	00008067          	ret

00010408 <func1_newline_then_space_to>:
   10408:	fe010113          	addi	sp,sp,-32
   1040c:	00112e23          	sw	ra,28(sp)
   10410:	00812c23          	sw	s0,24(sp)
   10414:	02010413          	addi	s0,sp,32
   10418:	fea42623          	sw	a0,-20(s0)
   1041c:	feb42423          	sw	a1,-24(s0)
   10420:	0280006f          	j	10448 <func1_newline_then_space_to+0x40>
   10424:	00a00513          	li	a0,10
   10428:	e75ff0ef          	jal	1029c <uart_putc>
   1042c:	02000513          	li	a0,32
   10430:	e6dff0ef          	jal	1029c <uart_putc>
   10434:	da01a783          	lw	a5,-608(gp) # 13ad8 <g_cur_row>
   10438:	00178713          	addi	a4,a5,1
   1043c:	dae1a023          	sw	a4,-608(gp) # 13ad8 <g_cur_row>
   10440:	00100713          	li	a4,1
   10444:	dae1a223          	sw	a4,-604(gp) # 13adc <g_cur_col>
   10448:	da01a783          	lw	a5,-608(gp) # 13ad8 <g_cur_row>
   1044c:	fec42703          	lw	a4,-20(s0)
   10450:	fce7cae3          	blt	a5,a4,10424 <func1_newline_then_space_to+0x1c>
   10454:	0180006f          	j	1046c <func1_newline_then_space_to+0x64>
   10458:	02000513          	li	a0,32
   1045c:	e41ff0ef          	jal	1029c <uart_putc>
   10460:	da41a783          	lw	a5,-604(gp) # 13adc <g_cur_col>
   10464:	00178713          	addi	a4,a5,1
   10468:	dae1a223          	sw	a4,-604(gp) # 13adc <g_cur_col>
   1046c:	da41a783          	lw	a5,-604(gp) # 13adc <g_cur_col>
   10470:	fe842703          	lw	a4,-24(s0)
   10474:	fee7c2e3          	blt	a5,a4,10458 <func1_newline_then_space_to+0x50>
   10478:	00000013          	nop
   1047c:	00000013          	nop
   10480:	01c12083          	lw	ra,28(sp)
   10484:	01812403          	lw	s0,24(sp)
   10488:	02010113          	addi	sp,sp,32
   1048c:	00008067          	ret

00010490 <func2_put_star>:
   10490:	ff010113          	addi	sp,sp,-16
   10494:	00112623          	sw	ra,12(sp)
   10498:	00812423          	sw	s0,8(sp)
   1049c:	01010413          	addi	s0,sp,16
   104a0:	02a00513          	li	a0,42
   104a4:	df9ff0ef          	jal	1029c <uart_putc>
   104a8:	da41a783          	lw	a5,-604(gp) # 13adc <g_cur_col>
   104ac:	00178713          	addi	a4,a5,1
   104b0:	dae1a223          	sw	a4,-604(gp) # 13adc <g_cur_col>
   104b4:	00000013          	nop
   104b8:	00c12083          	lw	ra,12(sp)
   104bc:	00812403          	lw	s0,8(sp)
   104c0:	01010113          	addi	sp,sp,16
   104c4:	00008067          	ret

000104c8 <iabs_i32>:
   104c8:	fe010113          	addi	sp,sp,-32
   104cc:	00112e23          	sw	ra,28(sp)
   104d0:	00812c23          	sw	s0,24(sp)
   104d4:	02010413          	addi	s0,sp,32
   104d8:	fea42623          	sw	a0,-20(s0)
   104dc:	fec42783          	lw	a5,-20(s0)
   104e0:	41f7d713          	srai	a4,a5,0x1f
   104e4:	fec42783          	lw	a5,-20(s0)
   104e8:	00f747b3          	xor	a5,a4,a5
   104ec:	40e787b3          	sub	a5,a5,a4
   104f0:	00078513          	mv	a0,a5
   104f4:	01c12083          	lw	ra,28(sp)
   104f8:	01812403          	lw	s0,24(sp)
   104fc:	02010113          	addi	sp,sp,32
   10500:	00008067          	ret

00010504 <square_mul>:
   10504:	fd010113          	addi	sp,sp,-48
   10508:	02112623          	sw	ra,44(sp)
   1050c:	02812423          	sw	s0,40(sp)
   10510:	03010413          	addi	s0,sp,48
   10514:	fca42e23          	sw	a0,-36(s0)
   10518:	fdc42503          	lw	a0,-36(s0)
   1051c:	fadff0ef          	jal	104c8 <iabs_i32>
   10520:	fea42623          	sw	a0,-20(s0)
   10524:	fec42783          	lw	a5,-20(s0)
   10528:	fec42703          	lw	a4,-20(s0)
   1052c:	02e787b3          	mul	a5,a5,a4
   10530:	fef42423          	sw	a5,-24(s0)
   10534:	fe842783          	lw	a5,-24(s0)
   10538:	00078513          	mv	a0,a5
   1053c:	02c12083          	lw	ra,44(sp)
   10540:	02812403          	lw	s0,40(sp)
   10544:	03010113          	addi	sp,sp,48
   10548:	00008067          	ret

0001054c <main>:
   1054c:	fd010113          	addi	sp,sp,-48
   10550:	02112623          	sw	ra,44(sp)
   10554:	02812423          	sw	s0,40(sp)
   10558:	03010413          	addi	s0,sp,48
   1055c:	00600793          	li	a5,6
   10560:	fef42223          	sw	a5,-28(s0)
   10564:	fe442503          	lw	a0,-28(s0)
   10568:	f9dff0ef          	jal	10504 <square_mul>
   1056c:	fea42023          	sw	a0,-32(s0)
   10570:	100007b7          	lui	a5,0x10000
   10574:	00878793          	addi	a5,a5,8 # 10000008 <__BSS_END__+0xffec238>
   10578:	00100713          	li	a4,1
   1057c:	00e7a023          	sw	a4,0(a5)
   10580:	00a00513          	li	a0,10
   10584:	d19ff0ef          	jal	1029c <uart_putc>
   10588:	da01a023          	sw	zero,-608(gp) # 13ad8 <g_cur_row>
   1058c:	da01a223          	sw	zero,-604(gp) # 13adc <g_cur_col>
   10590:	fe442783          	lw	a5,-28(s0)
   10594:	40f007b3          	neg	a5,a5
   10598:	fef42623          	sw	a5,-20(s0)
   1059c:	0a80006f          	j	10644 <main+0xf8>
   105a0:	fec42503          	lw	a0,-20(s0)
   105a4:	f61ff0ef          	jal	10504 <square_mul>
   105a8:	fca42e23          	sw	a0,-36(s0)
   105ac:	fe442783          	lw	a5,-28(s0)
   105b0:	40f007b3          	neg	a5,a5
   105b4:	fef42423          	sw	a5,-24(s0)
   105b8:	0740006f          	j	1062c <main+0xe0>
   105bc:	fe842503          	lw	a0,-24(s0)
   105c0:	f45ff0ef          	jal	10504 <square_mul>
   105c4:	fca42c23          	sw	a0,-40(s0)
   105c8:	fd842703          	lw	a4,-40(s0)
   105cc:	fdc42783          	lw	a5,-36(s0)
   105d0:	00f707b3          	add	a5,a4,a5
   105d4:	fe042703          	lw	a4,-32(s0)
   105d8:	04f74463          	blt	a4,a5,10620 <main+0xd4>
   105dc:	fec42703          	lw	a4,-20(s0)
   105e0:	fe442783          	lw	a5,-28(s0)
   105e4:	00f707b3          	add	a5,a4,a5
   105e8:	fcf42a23          	sw	a5,-44(s0)
   105ec:	fe842703          	lw	a4,-24(s0)
   105f0:	fe442783          	lw	a5,-28(s0)
   105f4:	00f707b3          	add	a5,a4,a5
   105f8:	00178793          	addi	a5,a5,1
   105fc:	fcf42823          	sw	a5,-48(s0)
   10600:	00200513          	li	a0,2
   10604:	bc1ff0ef          	jal	101c4 <wait_ticks>
   10608:	fd042583          	lw	a1,-48(s0)
   1060c:	fd442503          	lw	a0,-44(s0)
   10610:	df9ff0ef          	jal	10408 <func1_newline_then_space_to>
   10614:	00200513          	li	a0,2
   10618:	badff0ef          	jal	101c4 <wait_ticks>
   1061c:	e75ff0ef          	jal	10490 <func2_put_star>
   10620:	fe842783          	lw	a5,-24(s0)
   10624:	00178793          	addi	a5,a5,1
   10628:	fef42423          	sw	a5,-24(s0)
   1062c:	fe842703          	lw	a4,-24(s0)
   10630:	fe442783          	lw	a5,-28(s0)
   10634:	f8e7d4e3          	bge	a5,a4,105bc <main+0x70>
   10638:	fec42783          	lw	a5,-20(s0)
   1063c:	00178793          	addi	a5,a5,1
   10640:	fef42623          	sw	a5,-20(s0)
   10644:	fec42703          	lw	a4,-20(s0)
   10648:	fe442783          	lw	a5,-28(s0)
   1064c:	f4e7dae3          	bge	a5,a4,105a0 <main+0x54>
   10650:	00a00513          	li	a0,10
   10654:	c49ff0ef          	jal	1029c <uart_putc>
   10658:	00000793          	li	a5,0
   1065c:	00078513          	mv	a0,a5
   10660:	02c12083          	lw	ra,44(sp)
   10664:	02812403          	lw	s0,40(sp)
   10668:	03010113          	addi	sp,sp,48
   1066c:	00008067          	ret

00010670 <__fp_lock>:
   10670:	00000513          	li	a0,0
   10674:	00008067          	ret

00010678 <stdio_exit_handler>:
   10678:	00013637          	lui	a2,0x13
   1067c:	000125b7          	lui	a1,0x12
   10680:	00013537          	lui	a0,0x13
   10684:	53860613          	addi	a2,a2,1336 # 13538 <__sglue>
   10688:	dc458593          	addi	a1,a1,-572 # 11dc4 <_fclose_r>
   1068c:	54850513          	addi	a0,a0,1352 # 13548 <_impure_data>
   10690:	34c0006f          	j	109dc <_fwalk_sglue>

00010694 <cleanup_stdio>:
   10694:	00452583          	lw	a1,4(a0)
   10698:	ff010113          	addi	sp,sp,-16
   1069c:	00812423          	sw	s0,8(sp)
   106a0:	00112623          	sw	ra,12(sp)
   106a4:	da818793          	addi	a5,gp,-600 # 13ae0 <__sf>
   106a8:	00050413          	mv	s0,a0
   106ac:	00f58463          	beq	a1,a5,106b4 <cleanup_stdio+0x20>
   106b0:	714010ef          	jal	11dc4 <_fclose_r>
   106b4:	00842583          	lw	a1,8(s0)
   106b8:	e1018793          	addi	a5,gp,-496 # 13b48 <__sf+0x68>
   106bc:	00f58663          	beq	a1,a5,106c8 <cleanup_stdio+0x34>
   106c0:	00040513          	mv	a0,s0
   106c4:	700010ef          	jal	11dc4 <_fclose_r>
   106c8:	00c42583          	lw	a1,12(s0)
   106cc:	e7818793          	addi	a5,gp,-392 # 13bb0 <__sf+0xd0>
   106d0:	00f58c63          	beq	a1,a5,106e8 <cleanup_stdio+0x54>
   106d4:	00040513          	mv	a0,s0
   106d8:	00812403          	lw	s0,8(sp)
   106dc:	00c12083          	lw	ra,12(sp)
   106e0:	01010113          	addi	sp,sp,16
   106e4:	6e00106f          	j	11dc4 <_fclose_r>
   106e8:	00c12083          	lw	ra,12(sp)
   106ec:	00812403          	lw	s0,8(sp)
   106f0:	01010113          	addi	sp,sp,16
   106f4:	00008067          	ret

000106f8 <__fp_unlock>:
   106f8:	00000513          	li	a0,0
   106fc:	00008067          	ret

00010700 <global_stdio_init.part.0>:
   10700:	fe010113          	addi	sp,sp,-32
   10704:	000107b7          	lui	a5,0x10
   10708:	00812c23          	sw	s0,24(sp)
   1070c:	67878793          	addi	a5,a5,1656 # 10678 <stdio_exit_handler>
   10710:	da818413          	addi	s0,gp,-600 # 13ae0 <__sf>
   10714:	00112e23          	sw	ra,28(sp)
   10718:	00912a23          	sw	s1,20(sp)
   1071c:	01212823          	sw	s2,16(sp)
   10720:	01312623          	sw	s3,12(sp)
   10724:	01412423          	sw	s4,8(sp)
   10728:	d6f1a423          	sw	a5,-664(gp) # 13aa0 <__stdio_exit_handler>
   1072c:	00800613          	li	a2,8
   10730:	00400793          	li	a5,4
   10734:	00000593          	li	a1,0
   10738:	e0418513          	addi	a0,gp,-508 # 13b3c <__sf+0x5c>
   1073c:	00f42623          	sw	a5,12(s0)
   10740:	00042023          	sw	zero,0(s0)
   10744:	00042223          	sw	zero,4(s0)
   10748:	00042423          	sw	zero,8(s0)
   1074c:	06042223          	sw	zero,100(s0)
   10750:	00042823          	sw	zero,16(s0)
   10754:	00042a23          	sw	zero,20(s0)
   10758:	00042c23          	sw	zero,24(s0)
   1075c:	798000ef          	jal	10ef4 <memset>
   10760:	00011a37          	lui	s4,0x11
   10764:	000119b7          	lui	s3,0x11
   10768:	00011937          	lui	s2,0x11
   1076c:	000114b7          	lui	s1,0x11
   10770:	000107b7          	lui	a5,0x10
   10774:	a90a0a13          	addi	s4,s4,-1392 # 10a90 <__sread>
   10778:	af498993          	addi	s3,s3,-1292 # 10af4 <__swrite>
   1077c:	b7c90913          	addi	s2,s2,-1156 # 10b7c <__sseek>
   10780:	be048493          	addi	s1,s1,-1056 # 10be0 <__sclose>
   10784:	00978793          	addi	a5,a5,9 # 10009 <exit-0xab>
   10788:	00800613          	li	a2,8
   1078c:	00000593          	li	a1,0
   10790:	e6c18513          	addi	a0,gp,-404 # 13ba4 <__sf+0xc4>
   10794:	06f42a23          	sw	a5,116(s0)
   10798:	03442023          	sw	s4,32(s0)
   1079c:	03342223          	sw	s3,36(s0)
   107a0:	03242423          	sw	s2,40(s0)
   107a4:	02942623          	sw	s1,44(s0)
   107a8:	00842e23          	sw	s0,28(s0)
   107ac:	06042423          	sw	zero,104(s0)
   107b0:	06042623          	sw	zero,108(s0)
   107b4:	06042823          	sw	zero,112(s0)
   107b8:	0c042623          	sw	zero,204(s0)
   107bc:	06042c23          	sw	zero,120(s0)
   107c0:	06042e23          	sw	zero,124(s0)
   107c4:	08042023          	sw	zero,128(s0)
   107c8:	72c000ef          	jal	10ef4 <memset>
   107cc:	000207b7          	lui	a5,0x20
   107d0:	01278793          	addi	a5,a5,18 # 20012 <__BSS_END__+0xc242>
   107d4:	e1018713          	addi	a4,gp,-496 # 13b48 <__sf+0x68>
   107d8:	ed418513          	addi	a0,gp,-300 # 13c0c <__sf+0x12c>
   107dc:	00800613          	li	a2,8
   107e0:	00000593          	li	a1,0
   107e4:	09442423          	sw	s4,136(s0)
   107e8:	09342623          	sw	s3,140(s0)
   107ec:	09242823          	sw	s2,144(s0)
   107f0:	08942a23          	sw	s1,148(s0)
   107f4:	0cf42e23          	sw	a5,220(s0)
   107f8:	0c042823          	sw	zero,208(s0)
   107fc:	0c042a23          	sw	zero,212(s0)
   10800:	0c042c23          	sw	zero,216(s0)
   10804:	12042a23          	sw	zero,308(s0)
   10808:	0e042023          	sw	zero,224(s0)
   1080c:	0e042223          	sw	zero,228(s0)
   10810:	0e042423          	sw	zero,232(s0)
   10814:	08e42223          	sw	a4,132(s0)
   10818:	6dc000ef          	jal	10ef4 <memset>
   1081c:	e7818793          	addi	a5,gp,-392 # 13bb0 <__sf+0xd0>
   10820:	0f442823          	sw	s4,240(s0)
   10824:	0f342a23          	sw	s3,244(s0)
   10828:	0f242c23          	sw	s2,248(s0)
   1082c:	0e942e23          	sw	s1,252(s0)
   10830:	01c12083          	lw	ra,28(sp)
   10834:	0ef42623          	sw	a5,236(s0)
   10838:	01812403          	lw	s0,24(sp)
   1083c:	01412483          	lw	s1,20(sp)
   10840:	01012903          	lw	s2,16(sp)
   10844:	00c12983          	lw	s3,12(sp)
   10848:	00812a03          	lw	s4,8(sp)
   1084c:	02010113          	addi	sp,sp,32
   10850:	00008067          	ret

00010854 <__sfp>:
   10854:	d681a783          	lw	a5,-664(gp) # 13aa0 <__stdio_exit_handler>
   10858:	fe010113          	addi	sp,sp,-32
   1085c:	00912a23          	sw	s1,20(sp)
   10860:	00112e23          	sw	ra,28(sp)
   10864:	00812c23          	sw	s0,24(sp)
   10868:	00050493          	mv	s1,a0
   1086c:	0e078e63          	beqz	a5,10968 <__sfp+0x114>
   10870:	00013837          	lui	a6,0x13
   10874:	53880813          	addi	a6,a6,1336 # 13538 <__sglue>
   10878:	fff00693          	li	a3,-1
   1087c:	00482783          	lw	a5,4(a6)
   10880:	fff78793          	addi	a5,a5,-1
   10884:	0807c063          	bltz	a5,10904 <__sfp+0xb0>
   10888:	00882403          	lw	s0,8(a6)
   1088c:	00c0006f          	j	10898 <__sfp+0x44>
   10890:	06840413          	addi	s0,s0,104
   10894:	06d78863          	beq	a5,a3,10904 <__sfp+0xb0>
   10898:	00c41703          	lh	a4,12(s0)
   1089c:	fff78793          	addi	a5,a5,-1
   108a0:	fe0718e3          	bnez	a4,10890 <__sfp+0x3c>
   108a4:	ffff07b7          	lui	a5,0xffff0
   108a8:	00178793          	addi	a5,a5,1 # ffff0001 <__BSS_END__+0xfffdc231>
   108ac:	00f42623          	sw	a5,12(s0)
   108b0:	06042223          	sw	zero,100(s0)
   108b4:	00042023          	sw	zero,0(s0)
   108b8:	00042423          	sw	zero,8(s0)
   108bc:	00042223          	sw	zero,4(s0)
   108c0:	00042823          	sw	zero,16(s0)
   108c4:	00042a23          	sw	zero,20(s0)
   108c8:	00042c23          	sw	zero,24(s0)
   108cc:	00800613          	li	a2,8
   108d0:	00000593          	li	a1,0
   108d4:	05c40513          	addi	a0,s0,92
   108d8:	61c000ef          	jal	10ef4 <memset>
   108dc:	02042823          	sw	zero,48(s0)
   108e0:	02042a23          	sw	zero,52(s0)
   108e4:	04042223          	sw	zero,68(s0)
   108e8:	04042423          	sw	zero,72(s0)
   108ec:	01c12083          	lw	ra,28(sp)
   108f0:	00040513          	mv	a0,s0
   108f4:	01812403          	lw	s0,24(sp)
   108f8:	01412483          	lw	s1,20(sp)
   108fc:	02010113          	addi	sp,sp,32
   10900:	00008067          	ret
   10904:	00082403          	lw	s0,0(a6)
   10908:	00040663          	beqz	s0,10914 <__sfp+0xc0>
   1090c:	00040813          	mv	a6,s0
   10910:	f6dff06f          	j	1087c <__sfp+0x28>
   10914:	1ac00593          	li	a1,428
   10918:	00048513          	mv	a0,s1
   1091c:	01012623          	sw	a6,12(sp)
   10920:	421000ef          	jal	11540 <_malloc_r>
   10924:	00c12803          	lw	a6,12(sp)
   10928:	00050413          	mv	s0,a0
   1092c:	04050263          	beqz	a0,10970 <__sfp+0x11c>
   10930:	00400793          	li	a5,4
   10934:	00f52223          	sw	a5,4(a0)
   10938:	00c50513          	addi	a0,a0,12
   1093c:	00042023          	sw	zero,0(s0)
   10940:	00a42423          	sw	a0,8(s0)
   10944:	1a000613          	li	a2,416
   10948:	00000593          	li	a1,0
   1094c:	01012623          	sw	a6,12(sp)
   10950:	5a4000ef          	jal	10ef4 <memset>
   10954:	00c12803          	lw	a6,12(sp)
   10958:	fff00693          	li	a3,-1
   1095c:	00882023          	sw	s0,0(a6)
   10960:	00040813          	mv	a6,s0
   10964:	f19ff06f          	j	1087c <__sfp+0x28>
   10968:	d99ff0ef          	jal	10700 <global_stdio_init.part.0>
   1096c:	f05ff06f          	j	10870 <__sfp+0x1c>
   10970:	00082023          	sw	zero,0(a6)
   10974:	00c00793          	li	a5,12
   10978:	00f4a023          	sw	a5,0(s1)
   1097c:	f71ff06f          	j	108ec <__sfp+0x98>

00010980 <__sinit>:
   10980:	03452783          	lw	a5,52(a0)
   10984:	00078463          	beqz	a5,1098c <__sinit+0xc>
   10988:	00008067          	ret
   1098c:	000107b7          	lui	a5,0x10
   10990:	d681a703          	lw	a4,-664(gp) # 13aa0 <__stdio_exit_handler>
   10994:	69478793          	addi	a5,a5,1684 # 10694 <cleanup_stdio>
   10998:	02f52a23          	sw	a5,52(a0)
   1099c:	fe0716e3          	bnez	a4,10988 <__sinit+0x8>
   109a0:	d61ff06f          	j	10700 <global_stdio_init.part.0>

000109a4 <__sfp_lock_acquire>:
   109a4:	00008067          	ret

000109a8 <__sfp_lock_release>:
   109a8:	00008067          	ret

000109ac <__fp_lock_all>:
   109ac:	00013637          	lui	a2,0x13
   109b0:	000105b7          	lui	a1,0x10
   109b4:	53860613          	addi	a2,a2,1336 # 13538 <__sglue>
   109b8:	67058593          	addi	a1,a1,1648 # 10670 <__fp_lock>
   109bc:	00000513          	li	a0,0
   109c0:	01c0006f          	j	109dc <_fwalk_sglue>

000109c4 <__fp_unlock_all>:
   109c4:	00013637          	lui	a2,0x13
   109c8:	000105b7          	lui	a1,0x10
   109cc:	53860613          	addi	a2,a2,1336 # 13538 <__sglue>
   109d0:	6f858593          	addi	a1,a1,1784 # 106f8 <__fp_unlock>
   109d4:	00000513          	li	a0,0
   109d8:	0040006f          	j	109dc <_fwalk_sglue>

000109dc <_fwalk_sglue>:
   109dc:	fd010113          	addi	sp,sp,-48
   109e0:	03212023          	sw	s2,32(sp)
   109e4:	01312e23          	sw	s3,28(sp)
   109e8:	01412c23          	sw	s4,24(sp)
   109ec:	01512a23          	sw	s5,20(sp)
   109f0:	01612823          	sw	s6,16(sp)
   109f4:	01712623          	sw	s7,12(sp)
   109f8:	02112623          	sw	ra,44(sp)
   109fc:	02812423          	sw	s0,40(sp)
   10a00:	02912223          	sw	s1,36(sp)
   10a04:	00060a93          	mv	s5,a2
   10a08:	00050b13          	mv	s6,a0
   10a0c:	00058b93          	mv	s7,a1
   10a10:	00000a13          	li	s4,0
   10a14:	00100993          	li	s3,1
   10a18:	fff00913          	li	s2,-1
   10a1c:	004aa483          	lw	s1,4(s5)
   10a20:	fff48493          	addi	s1,s1,-1
   10a24:	0204ca63          	bltz	s1,10a58 <_fwalk_sglue+0x7c>
   10a28:	008aa403          	lw	s0,8(s5)
   10a2c:	00c45783          	lhu	a5,12(s0)
   10a30:	00f9fe63          	bgeu	s3,a5,10a4c <_fwalk_sglue+0x70>
   10a34:	00e41783          	lh	a5,14(s0)
   10a38:	00040593          	mv	a1,s0
   10a3c:	000b0513          	mv	a0,s6
   10a40:	01278663          	beq	a5,s2,10a4c <_fwalk_sglue+0x70>
   10a44:	000b80e7          	jalr	s7
   10a48:	00aa6a33          	or	s4,s4,a0
   10a4c:	fff48493          	addi	s1,s1,-1
   10a50:	06840413          	addi	s0,s0,104
   10a54:	fd249ce3          	bne	s1,s2,10a2c <_fwalk_sglue+0x50>
   10a58:	000aaa83          	lw	s5,0(s5)
   10a5c:	fc0a90e3          	bnez	s5,10a1c <_fwalk_sglue+0x40>
   10a60:	02c12083          	lw	ra,44(sp)
   10a64:	02812403          	lw	s0,40(sp)
   10a68:	02412483          	lw	s1,36(sp)
   10a6c:	02012903          	lw	s2,32(sp)
   10a70:	01c12983          	lw	s3,28(sp)
   10a74:	01412a83          	lw	s5,20(sp)
   10a78:	01012b03          	lw	s6,16(sp)
   10a7c:	00c12b83          	lw	s7,12(sp)
   10a80:	000a0513          	mv	a0,s4
   10a84:	01812a03          	lw	s4,24(sp)
   10a88:	03010113          	addi	sp,sp,48
   10a8c:	00008067          	ret

00010a90 <__sread>:
   10a90:	ff010113          	addi	sp,sp,-16
   10a94:	00812423          	sw	s0,8(sp)
   10a98:	00058413          	mv	s0,a1
   10a9c:	00e59583          	lh	a1,14(a1)
   10aa0:	00112623          	sw	ra,12(sp)
   10aa4:	2ec000ef          	jal	10d90 <_read_r>
   10aa8:	02054063          	bltz	a0,10ac8 <__sread+0x38>
   10aac:	05042783          	lw	a5,80(s0)
   10ab0:	00c12083          	lw	ra,12(sp)
   10ab4:	00a787b3          	add	a5,a5,a0
   10ab8:	04f42823          	sw	a5,80(s0)
   10abc:	00812403          	lw	s0,8(sp)
   10ac0:	01010113          	addi	sp,sp,16
   10ac4:	00008067          	ret
   10ac8:	00c45783          	lhu	a5,12(s0)
   10acc:	fffff737          	lui	a4,0xfffff
   10ad0:	fff70713          	addi	a4,a4,-1 # ffffefff <__BSS_END__+0xfffeb22f>
   10ad4:	00e7f7b3          	and	a5,a5,a4
   10ad8:	00c12083          	lw	ra,12(sp)
   10adc:	00f41623          	sh	a5,12(s0)
   10ae0:	00812403          	lw	s0,8(sp)
   10ae4:	01010113          	addi	sp,sp,16
   10ae8:	00008067          	ret

00010aec <__seofread>:
   10aec:	00000513          	li	a0,0
   10af0:	00008067          	ret

00010af4 <__swrite>:
   10af4:	00c59783          	lh	a5,12(a1)
   10af8:	fe010113          	addi	sp,sp,-32
   10afc:	00068313          	mv	t1,a3
   10b00:	00112e23          	sw	ra,28(sp)
   10b04:	1007f693          	andi	a3,a5,256
   10b08:	00058713          	mv	a4,a1
   10b0c:	00060893          	mv	a7,a2
   10b10:	00050813          	mv	a6,a0
   10b14:	02069863          	bnez	a3,10b44 <__swrite+0x50>
   10b18:	fffff6b7          	lui	a3,0xfffff
   10b1c:	fff68693          	addi	a3,a3,-1 # ffffefff <__BSS_END__+0xfffeb22f>
   10b20:	01c12083          	lw	ra,28(sp)
   10b24:	00d7f7b3          	and	a5,a5,a3
   10b28:	00e71583          	lh	a1,14(a4)
   10b2c:	00f71623          	sh	a5,12(a4)
   10b30:	00030693          	mv	a3,t1
   10b34:	00088613          	mv	a2,a7
   10b38:	00080513          	mv	a0,a6
   10b3c:	02010113          	addi	sp,sp,32
   10b40:	2b80006f          	j	10df8 <_write_r>
   10b44:	00e59583          	lh	a1,14(a1)
   10b48:	00c12423          	sw	a2,8(sp)
   10b4c:	00200693          	li	a3,2
   10b50:	00000613          	li	a2,0
   10b54:	00612623          	sw	t1,12(sp)
   10b58:	00e12023          	sw	a4,0(sp)
   10b5c:	00a12223          	sw	a0,4(sp)
   10b60:	1c8000ef          	jal	10d28 <_lseek_r>
   10b64:	00012703          	lw	a4,0(sp)
   10b68:	00c12303          	lw	t1,12(sp)
   10b6c:	00812883          	lw	a7,8(sp)
   10b70:	00c71783          	lh	a5,12(a4)
   10b74:	00412803          	lw	a6,4(sp)
   10b78:	fa1ff06f          	j	10b18 <__swrite+0x24>

00010b7c <__sseek>:
   10b7c:	ff010113          	addi	sp,sp,-16
   10b80:	00812423          	sw	s0,8(sp)
   10b84:	00058413          	mv	s0,a1
   10b88:	00e59583          	lh	a1,14(a1)
   10b8c:	00112623          	sw	ra,12(sp)
   10b90:	198000ef          	jal	10d28 <_lseek_r>
   10b94:	fff00713          	li	a4,-1
   10b98:	00c41783          	lh	a5,12(s0)
   10b9c:	02e50263          	beq	a0,a4,10bc0 <__sseek+0x44>
   10ba0:	00001737          	lui	a4,0x1
   10ba4:	00e7e7b3          	or	a5,a5,a4
   10ba8:	00c12083          	lw	ra,12(sp)
   10bac:	04a42823          	sw	a0,80(s0)
   10bb0:	00f41623          	sh	a5,12(s0)
   10bb4:	00812403          	lw	s0,8(sp)
   10bb8:	01010113          	addi	sp,sp,16
   10bbc:	00008067          	ret
   10bc0:	80050713          	addi	a4,a0,-2048
   10bc4:	80070713          	addi	a4,a4,-2048 # 800 <exit-0xf8b4>
   10bc8:	00e7f7b3          	and	a5,a5,a4
   10bcc:	00c12083          	lw	ra,12(sp)
   10bd0:	00f41623          	sh	a5,12(s0)
   10bd4:	00812403          	lw	s0,8(sp)
   10bd8:	01010113          	addi	sp,sp,16
   10bdc:	00008067          	ret

00010be0 <__sclose>:
   10be0:	00e59583          	lh	a1,14(a1)
   10be4:	0040006f          	j	10be8 <_close_r>

00010be8 <_close_r>:
   10be8:	ff010113          	addi	sp,sp,-16
   10bec:	00812423          	sw	s0,8(sp)
   10bf0:	00912223          	sw	s1,4(sp)
   10bf4:	00050493          	mv	s1,a0
   10bf8:	00058513          	mv	a0,a1
   10bfc:	00112623          	sw	ra,12(sp)
   10c00:	d601a623          	sw	zero,-660(gp) # 13aa4 <errno>
   10c04:	770010ef          	jal	12374 <_close>
   10c08:	fff00793          	li	a5,-1
   10c0c:	00f50c63          	beq	a0,a5,10c24 <_close_r+0x3c>
   10c10:	00c12083          	lw	ra,12(sp)
   10c14:	00812403          	lw	s0,8(sp)
   10c18:	00412483          	lw	s1,4(sp)
   10c1c:	01010113          	addi	sp,sp,16
   10c20:	00008067          	ret
   10c24:	d6c1a783          	lw	a5,-660(gp) # 13aa4 <errno>
   10c28:	fe0784e3          	beqz	a5,10c10 <_close_r+0x28>
   10c2c:	00c12083          	lw	ra,12(sp)
   10c30:	00812403          	lw	s0,8(sp)
   10c34:	00f4a023          	sw	a5,0(s1)
   10c38:	00412483          	lw	s1,4(sp)
   10c3c:	01010113          	addi	sp,sp,16
   10c40:	00008067          	ret

00010c44 <_reclaim_reent>:
   10c44:	d5c1a783          	lw	a5,-676(gp) # 13a94 <_impure_ptr>
   10c48:	0ca78e63          	beq	a5,a0,10d24 <_reclaim_reent+0xe0>
   10c4c:	04452583          	lw	a1,68(a0)
   10c50:	fe010113          	addi	sp,sp,-32
   10c54:	00912a23          	sw	s1,20(sp)
   10c58:	00112e23          	sw	ra,28(sp)
   10c5c:	00812c23          	sw	s0,24(sp)
   10c60:	00050493          	mv	s1,a0
   10c64:	04058863          	beqz	a1,10cb4 <_reclaim_reent+0x70>
   10c68:	01212823          	sw	s2,16(sp)
   10c6c:	01312623          	sw	s3,12(sp)
   10c70:	00000913          	li	s2,0
   10c74:	08000993          	li	s3,128
   10c78:	012587b3          	add	a5,a1,s2
   10c7c:	0007a403          	lw	s0,0(a5)
   10c80:	00040e63          	beqz	s0,10c9c <_reclaim_reent+0x58>
   10c84:	00040593          	mv	a1,s0
   10c88:	00042403          	lw	s0,0(s0)
   10c8c:	00048513          	mv	a0,s1
   10c90:	5c8000ef          	jal	11258 <_free_r>
   10c94:	fe0418e3          	bnez	s0,10c84 <_reclaim_reent+0x40>
   10c98:	0444a583          	lw	a1,68(s1)
   10c9c:	00490913          	addi	s2,s2,4
   10ca0:	fd391ce3          	bne	s2,s3,10c78 <_reclaim_reent+0x34>
   10ca4:	00048513          	mv	a0,s1
   10ca8:	5b0000ef          	jal	11258 <_free_r>
   10cac:	01012903          	lw	s2,16(sp)
   10cb0:	00c12983          	lw	s3,12(sp)
   10cb4:	0384a583          	lw	a1,56(s1)
   10cb8:	00058663          	beqz	a1,10cc4 <_reclaim_reent+0x80>
   10cbc:	00048513          	mv	a0,s1
   10cc0:	598000ef          	jal	11258 <_free_r>
   10cc4:	0404a403          	lw	s0,64(s1)
   10cc8:	00040c63          	beqz	s0,10ce0 <_reclaim_reent+0x9c>
   10ccc:	00040593          	mv	a1,s0
   10cd0:	00042403          	lw	s0,0(s0)
   10cd4:	00048513          	mv	a0,s1
   10cd8:	580000ef          	jal	11258 <_free_r>
   10cdc:	fe0418e3          	bnez	s0,10ccc <_reclaim_reent+0x88>
   10ce0:	04c4a583          	lw	a1,76(s1)
   10ce4:	00058663          	beqz	a1,10cf0 <_reclaim_reent+0xac>
   10ce8:	00048513          	mv	a0,s1
   10cec:	56c000ef          	jal	11258 <_free_r>
   10cf0:	0344a783          	lw	a5,52(s1)
   10cf4:	00078e63          	beqz	a5,10d10 <_reclaim_reent+0xcc>
   10cf8:	01812403          	lw	s0,24(sp)
   10cfc:	01c12083          	lw	ra,28(sp)
   10d00:	00048513          	mv	a0,s1
   10d04:	01412483          	lw	s1,20(sp)
   10d08:	02010113          	addi	sp,sp,32
   10d0c:	00078067          	jr	a5
   10d10:	01c12083          	lw	ra,28(sp)
   10d14:	01812403          	lw	s0,24(sp)
   10d18:	01412483          	lw	s1,20(sp)
   10d1c:	02010113          	addi	sp,sp,32
   10d20:	00008067          	ret
   10d24:	00008067          	ret

00010d28 <_lseek_r>:
   10d28:	ff010113          	addi	sp,sp,-16
   10d2c:	00058793          	mv	a5,a1
   10d30:	00812423          	sw	s0,8(sp)
   10d34:	00912223          	sw	s1,4(sp)
   10d38:	00060593          	mv	a1,a2
   10d3c:	00050493          	mv	s1,a0
   10d40:	00068613          	mv	a2,a3
   10d44:	00078513          	mv	a0,a5
   10d48:	00112623          	sw	ra,12(sp)
   10d4c:	d601a623          	sw	zero,-660(gp) # 13aa4 <errno>
   10d50:	694010ef          	jal	123e4 <_lseek>
   10d54:	fff00793          	li	a5,-1
   10d58:	00f50c63          	beq	a0,a5,10d70 <_lseek_r+0x48>
   10d5c:	00c12083          	lw	ra,12(sp)
   10d60:	00812403          	lw	s0,8(sp)
   10d64:	00412483          	lw	s1,4(sp)
   10d68:	01010113          	addi	sp,sp,16
   10d6c:	00008067          	ret
   10d70:	d6c1a783          	lw	a5,-660(gp) # 13aa4 <errno>
   10d74:	fe0784e3          	beqz	a5,10d5c <_lseek_r+0x34>
   10d78:	00c12083          	lw	ra,12(sp)
   10d7c:	00812403          	lw	s0,8(sp)
   10d80:	00f4a023          	sw	a5,0(s1)
   10d84:	00412483          	lw	s1,4(sp)
   10d88:	01010113          	addi	sp,sp,16
   10d8c:	00008067          	ret

00010d90 <_read_r>:
   10d90:	ff010113          	addi	sp,sp,-16
   10d94:	00058793          	mv	a5,a1
   10d98:	00812423          	sw	s0,8(sp)
   10d9c:	00912223          	sw	s1,4(sp)
   10da0:	00060593          	mv	a1,a2
   10da4:	00050493          	mv	s1,a0
   10da8:	00068613          	mv	a2,a3
   10dac:	00078513          	mv	a0,a5
   10db0:	00112623          	sw	ra,12(sp)
   10db4:	d601a623          	sw	zero,-660(gp) # 13aa4 <errno>
   10db8:	66c010ef          	jal	12424 <_read>
   10dbc:	fff00793          	li	a5,-1
   10dc0:	00f50c63          	beq	a0,a5,10dd8 <_read_r+0x48>
   10dc4:	00c12083          	lw	ra,12(sp)
   10dc8:	00812403          	lw	s0,8(sp)
   10dcc:	00412483          	lw	s1,4(sp)
   10dd0:	01010113          	addi	sp,sp,16
   10dd4:	00008067          	ret
   10dd8:	d6c1a783          	lw	a5,-660(gp) # 13aa4 <errno>
   10ddc:	fe0784e3          	beqz	a5,10dc4 <_read_r+0x34>
   10de0:	00c12083          	lw	ra,12(sp)
   10de4:	00812403          	lw	s0,8(sp)
   10de8:	00f4a023          	sw	a5,0(s1)
   10dec:	00412483          	lw	s1,4(sp)
   10df0:	01010113          	addi	sp,sp,16
   10df4:	00008067          	ret

00010df8 <_write_r>:
   10df8:	ff010113          	addi	sp,sp,-16
   10dfc:	00058793          	mv	a5,a1
   10e00:	00812423          	sw	s0,8(sp)
   10e04:	00912223          	sw	s1,4(sp)
   10e08:	00060593          	mv	a1,a2
   10e0c:	00050493          	mv	s1,a0
   10e10:	00068613          	mv	a2,a3
   10e14:	00078513          	mv	a0,a5
   10e18:	00112623          	sw	ra,12(sp)
   10e1c:	d601a623          	sw	zero,-660(gp) # 13aa4 <errno>
   10e20:	6bc010ef          	jal	124dc <_write>
   10e24:	fff00793          	li	a5,-1
   10e28:	00f50c63          	beq	a0,a5,10e40 <_write_r+0x48>
   10e2c:	00c12083          	lw	ra,12(sp)
   10e30:	00812403          	lw	s0,8(sp)
   10e34:	00412483          	lw	s1,4(sp)
   10e38:	01010113          	addi	sp,sp,16
   10e3c:	00008067          	ret
   10e40:	d6c1a783          	lw	a5,-660(gp) # 13aa4 <errno>
   10e44:	fe0784e3          	beqz	a5,10e2c <_write_r+0x34>
   10e48:	00c12083          	lw	ra,12(sp)
   10e4c:	00812403          	lw	s0,8(sp)
   10e50:	00f4a023          	sw	a5,0(s1)
   10e54:	00412483          	lw	s1,4(sp)
   10e58:	01010113          	addi	sp,sp,16
   10e5c:	00008067          	ret

00010e60 <__libc_init_array>:
   10e60:	ff010113          	addi	sp,sp,-16
   10e64:	00812423          	sw	s0,8(sp)
   10e68:	01212023          	sw	s2,0(sp)
   10e6c:	00013437          	lui	s0,0x13
   10e70:	00013937          	lui	s2,0x13
   10e74:	00112623          	sw	ra,12(sp)
   10e78:	00912223          	sw	s1,4(sp)
   10e7c:	52890913          	addi	s2,s2,1320 # 13528 <__init_array_start>
   10e80:	52840413          	addi	s0,s0,1320 # 13528 <__init_array_start>
   10e84:	02890263          	beq	s2,s0,10ea8 <__libc_init_array+0x48>
   10e88:	40890933          	sub	s2,s2,s0
   10e8c:	40295913          	srai	s2,s2,0x2
   10e90:	00000493          	li	s1,0
   10e94:	00042783          	lw	a5,0(s0)
   10e98:	00148493          	addi	s1,s1,1
   10e9c:	00440413          	addi	s0,s0,4
   10ea0:	000780e7          	jalr	a5
   10ea4:	ff24e8e3          	bltu	s1,s2,10e94 <__libc_init_array+0x34>
   10ea8:	00013937          	lui	s2,0x13
   10eac:	00013437          	lui	s0,0x13
   10eb0:	53090913          	addi	s2,s2,1328 # 13530 <__do_global_dtors_aux_fini_array_entry>
   10eb4:	52840413          	addi	s0,s0,1320 # 13528 <__init_array_start>
   10eb8:	02890263          	beq	s2,s0,10edc <__libc_init_array+0x7c>
   10ebc:	40890933          	sub	s2,s2,s0
   10ec0:	40295913          	srai	s2,s2,0x2
   10ec4:	00000493          	li	s1,0
   10ec8:	00042783          	lw	a5,0(s0)
   10ecc:	00148493          	addi	s1,s1,1
   10ed0:	00440413          	addi	s0,s0,4
   10ed4:	000780e7          	jalr	a5
   10ed8:	ff24e8e3          	bltu	s1,s2,10ec8 <__libc_init_array+0x68>
   10edc:	00c12083          	lw	ra,12(sp)
   10ee0:	00812403          	lw	s0,8(sp)
   10ee4:	00412483          	lw	s1,4(sp)
   10ee8:	00012903          	lw	s2,0(sp)
   10eec:	01010113          	addi	sp,sp,16
   10ef0:	00008067          	ret

00010ef4 <memset>:
   10ef4:	00f00313          	li	t1,15
   10ef8:	00050713          	mv	a4,a0
   10efc:	02c37e63          	bgeu	t1,a2,10f38 <memset+0x44>
   10f00:	00f77793          	andi	a5,a4,15
   10f04:	0a079063          	bnez	a5,10fa4 <memset+0xb0>
   10f08:	08059263          	bnez	a1,10f8c <memset+0x98>
   10f0c:	ff067693          	andi	a3,a2,-16
   10f10:	00f67613          	andi	a2,a2,15
   10f14:	00e686b3          	add	a3,a3,a4
   10f18:	00b72023          	sw	a1,0(a4)
   10f1c:	00b72223          	sw	a1,4(a4)
   10f20:	00b72423          	sw	a1,8(a4)
   10f24:	00b72623          	sw	a1,12(a4)
   10f28:	01070713          	addi	a4,a4,16
   10f2c:	fed766e3          	bltu	a4,a3,10f18 <memset+0x24>
   10f30:	00061463          	bnez	a2,10f38 <memset+0x44>
   10f34:	00008067          	ret
   10f38:	40c306b3          	sub	a3,t1,a2
   10f3c:	00269693          	slli	a3,a3,0x2
   10f40:	00000297          	auipc	t0,0x0
   10f44:	005686b3          	add	a3,a3,t0
   10f48:	00c68067          	jr	12(a3)
   10f4c:	00b70723          	sb	a1,14(a4)
   10f50:	00b706a3          	sb	a1,13(a4)
   10f54:	00b70623          	sb	a1,12(a4)
   10f58:	00b705a3          	sb	a1,11(a4)
   10f5c:	00b70523          	sb	a1,10(a4)
   10f60:	00b704a3          	sb	a1,9(a4)
   10f64:	00b70423          	sb	a1,8(a4)
   10f68:	00b703a3          	sb	a1,7(a4)
   10f6c:	00b70323          	sb	a1,6(a4)
   10f70:	00b702a3          	sb	a1,5(a4)
   10f74:	00b70223          	sb	a1,4(a4)
   10f78:	00b701a3          	sb	a1,3(a4)
   10f7c:	00b70123          	sb	a1,2(a4)
   10f80:	00b700a3          	sb	a1,1(a4)
   10f84:	00b70023          	sb	a1,0(a4)
   10f88:	00008067          	ret
   10f8c:	0ff5f593          	zext.b	a1,a1
   10f90:	00859693          	slli	a3,a1,0x8
   10f94:	00d5e5b3          	or	a1,a1,a3
   10f98:	01059693          	slli	a3,a1,0x10
   10f9c:	00d5e5b3          	or	a1,a1,a3
   10fa0:	f6dff06f          	j	10f0c <memset+0x18>
   10fa4:	00279693          	slli	a3,a5,0x2
   10fa8:	00000297          	auipc	t0,0x0
   10fac:	005686b3          	add	a3,a3,t0
   10fb0:	00008293          	mv	t0,ra
   10fb4:	fa0680e7          	jalr	-96(a3)
   10fb8:	00028093          	mv	ra,t0
   10fbc:	ff078793          	addi	a5,a5,-16
   10fc0:	40f70733          	sub	a4,a4,a5
   10fc4:	00f60633          	add	a2,a2,a5
   10fc8:	f6c378e3          	bgeu	t1,a2,10f38 <memset+0x44>
   10fcc:	f3dff06f          	j	10f08 <memset+0x14>

00010fd0 <__call_exitprocs>:
   10fd0:	fd010113          	addi	sp,sp,-48
   10fd4:	01412c23          	sw	s4,24(sp)
   10fd8:	03212023          	sw	s2,32(sp)
   10fdc:	d701a903          	lw	s2,-656(gp) # 13aa8 <__atexit>
   10fe0:	02112623          	sw	ra,44(sp)
   10fe4:	0a090863          	beqz	s2,11094 <__call_exitprocs+0xc4>
   10fe8:	01312e23          	sw	s3,28(sp)
   10fec:	01512a23          	sw	s5,20(sp)
   10ff0:	01612823          	sw	s6,16(sp)
   10ff4:	01712623          	sw	s7,12(sp)
   10ff8:	02812423          	sw	s0,40(sp)
   10ffc:	02912223          	sw	s1,36(sp)
   11000:	01812423          	sw	s8,8(sp)
   11004:	00050b13          	mv	s6,a0
   11008:	00058b93          	mv	s7,a1
   1100c:	fff00993          	li	s3,-1
   11010:	00100a93          	li	s5,1
   11014:	00492483          	lw	s1,4(s2)
   11018:	fff48413          	addi	s0,s1,-1
   1101c:	04044e63          	bltz	s0,11078 <__call_exitprocs+0xa8>
   11020:	00249493          	slli	s1,s1,0x2
   11024:	009904b3          	add	s1,s2,s1
   11028:	080b9063          	bnez	s7,110a8 <__call_exitprocs+0xd8>
   1102c:	00492783          	lw	a5,4(s2)
   11030:	0044a683          	lw	a3,4(s1)
   11034:	fff78793          	addi	a5,a5,-1
   11038:	0c878463          	beq	a5,s0,11100 <__call_exitprocs+0x130>
   1103c:	0004a223          	sw	zero,4(s1)
   11040:	02068663          	beqz	a3,1106c <__call_exitprocs+0x9c>
   11044:	18892783          	lw	a5,392(s2)
   11048:	008a9733          	sll	a4,s5,s0
   1104c:	00492c03          	lw	s8,4(s2)
   11050:	00f777b3          	and	a5,a4,a5
   11054:	06079e63          	bnez	a5,110d0 <__call_exitprocs+0x100>
   11058:	000680e7          	jalr	a3
   1105c:	00492703          	lw	a4,4(s2)
   11060:	d701a783          	lw	a5,-656(gp) # 13aa8 <__atexit>
   11064:	09871863          	bne	a4,s8,110f4 <__call_exitprocs+0x124>
   11068:	09279663          	bne	a5,s2,110f4 <__call_exitprocs+0x124>
   1106c:	fff40413          	addi	s0,s0,-1
   11070:	ffc48493          	addi	s1,s1,-4
   11074:	fb341ae3          	bne	s0,s3,11028 <__call_exitprocs+0x58>
   11078:	02812403          	lw	s0,40(sp)
   1107c:	02412483          	lw	s1,36(sp)
   11080:	01c12983          	lw	s3,28(sp)
   11084:	01412a83          	lw	s5,20(sp)
   11088:	01012b03          	lw	s6,16(sp)
   1108c:	00c12b83          	lw	s7,12(sp)
   11090:	00812c03          	lw	s8,8(sp)
   11094:	02c12083          	lw	ra,44(sp)
   11098:	02012903          	lw	s2,32(sp)
   1109c:	01812a03          	lw	s4,24(sp)
   110a0:	03010113          	addi	sp,sp,48
   110a4:	00008067          	ret
   110a8:	1044a783          	lw	a5,260(s1)
   110ac:	fff40713          	addi	a4,s0,-1
   110b0:	f6fb8ee3          	beq	s7,a5,1102c <__call_exitprocs+0x5c>
   110b4:	ffe40413          	addi	s0,s0,-2
   110b8:	fd3700e3          	beq	a4,s3,11078 <__call_exitprocs+0xa8>
   110bc:	1004a783          	lw	a5,256(s1)
   110c0:	05778463          	beq	a5,s7,11108 <__call_exitprocs+0x138>
   110c4:	ff848493          	addi	s1,s1,-8
   110c8:	ff3410e3          	bne	s0,s3,110a8 <__call_exitprocs+0xd8>
   110cc:	fadff06f          	j	11078 <__call_exitprocs+0xa8>
   110d0:	18c92783          	lw	a5,396(s2)
   110d4:	0844a583          	lw	a1,132(s1)
   110d8:	00f77733          	and	a4,a4,a5
   110dc:	02071c63          	bnez	a4,11114 <__call_exitprocs+0x144>
   110e0:	000b0513          	mv	a0,s6
   110e4:	000680e7          	jalr	a3
   110e8:	00492703          	lw	a4,4(s2)
   110ec:	d701a783          	lw	a5,-656(gp) # 13aa8 <__atexit>
   110f0:	f7870ce3          	beq	a4,s8,11068 <__call_exitprocs+0x98>
   110f4:	f80782e3          	beqz	a5,11078 <__call_exitprocs+0xa8>
   110f8:	00078913          	mv	s2,a5
   110fc:	f19ff06f          	j	11014 <__call_exitprocs+0x44>
   11100:	00892223          	sw	s0,4(s2)
   11104:	f3dff06f          	j	11040 <__call_exitprocs+0x70>
   11108:	00070413          	mv	s0,a4
   1110c:	ffc48493          	addi	s1,s1,-4
   11110:	f1dff06f          	j	1102c <__call_exitprocs+0x5c>
   11114:	00058513          	mv	a0,a1
   11118:	000680e7          	jalr	a3
   1111c:	f41ff06f          	j	1105c <__call_exitprocs+0x8c>

00011120 <atexit>:
   11120:	00050593          	mv	a1,a0
   11124:	00000693          	li	a3,0
   11128:	00000613          	li	a2,0
   1112c:	00000513          	li	a0,0
   11130:	1b00106f          	j	122e0 <__register_exitproc>

00011134 <_malloc_trim_r>:
   11134:	fe010113          	addi	sp,sp,-32
   11138:	01212823          	sw	s2,16(sp)
   1113c:	00013937          	lui	s2,0x13
   11140:	00812c23          	sw	s0,24(sp)
   11144:	00912a23          	sw	s1,20(sp)
   11148:	01312623          	sw	s3,12(sp)
   1114c:	00058413          	mv	s0,a1
   11150:	00112e23          	sw	ra,28(sp)
   11154:	00050993          	mv	s3,a0
   11158:	68890913          	addi	s2,s2,1672 # 13688 <__malloc_av_>
   1115c:	461000ef          	jal	11dbc <__malloc_lock>
   11160:	00892783          	lw	a5,8(s2)
   11164:	00001737          	lui	a4,0x1
   11168:	0047a483          	lw	s1,4(a5)
   1116c:	ffc4f493          	andi	s1,s1,-4
   11170:	7ff48793          	addi	a5,s1,2047
   11174:	7f078793          	addi	a5,a5,2032
   11178:	40878433          	sub	s0,a5,s0
   1117c:	00c45413          	srli	s0,s0,0xc
   11180:	fff40413          	addi	s0,s0,-1
   11184:	00c41413          	slli	s0,s0,0xc
   11188:	00e44e63          	blt	s0,a4,111a4 <_malloc_trim_r+0x70>
   1118c:	00000593          	li	a1,0
   11190:	00098513          	mv	a0,s3
   11194:	094010ef          	jal	12228 <_sbrk_r>
   11198:	00892783          	lw	a5,8(s2)
   1119c:	009787b3          	add	a5,a5,s1
   111a0:	02f50663          	beq	a0,a5,111cc <_malloc_trim_r+0x98>
   111a4:	00098513          	mv	a0,s3
   111a8:	419000ef          	jal	11dc0 <__malloc_unlock>
   111ac:	01c12083          	lw	ra,28(sp)
   111b0:	01812403          	lw	s0,24(sp)
   111b4:	01412483          	lw	s1,20(sp)
   111b8:	01012903          	lw	s2,16(sp)
   111bc:	00c12983          	lw	s3,12(sp)
   111c0:	00000513          	li	a0,0
   111c4:	02010113          	addi	sp,sp,32
   111c8:	00008067          	ret
   111cc:	408005b3          	neg	a1,s0
   111d0:	00098513          	mv	a0,s3
   111d4:	054010ef          	jal	12228 <_sbrk_r>
   111d8:	fff00793          	li	a5,-1
   111dc:	04f50463          	beq	a0,a5,11224 <_malloc_trim_r+0xf0>
   111e0:	00892683          	lw	a3,8(s2)
   111e4:	ee01a783          	lw	a5,-288(gp) # 13c18 <__malloc_current_mallinfo>
   111e8:	408484b3          	sub	s1,s1,s0
   111ec:	0014e493          	ori	s1,s1,1
   111f0:	00098513          	mv	a0,s3
   111f4:	408787b3          	sub	a5,a5,s0
   111f8:	0096a223          	sw	s1,4(a3)
   111fc:	eef1a023          	sw	a5,-288(gp) # 13c18 <__malloc_current_mallinfo>
   11200:	3c1000ef          	jal	11dc0 <__malloc_unlock>
   11204:	01c12083          	lw	ra,28(sp)
   11208:	01812403          	lw	s0,24(sp)
   1120c:	01412483          	lw	s1,20(sp)
   11210:	01012903          	lw	s2,16(sp)
   11214:	00c12983          	lw	s3,12(sp)
   11218:	00100513          	li	a0,1
   1121c:	02010113          	addi	sp,sp,32
   11220:	00008067          	ret
   11224:	00000593          	li	a1,0
   11228:	00098513          	mv	a0,s3
   1122c:	7fd000ef          	jal	12228 <_sbrk_r>
   11230:	00892703          	lw	a4,8(s2)
   11234:	00f00693          	li	a3,15
   11238:	40e507b3          	sub	a5,a0,a4
   1123c:	f6f6d4e3          	bge	a3,a5,111a4 <_malloc_trim_r+0x70>
   11240:	d601a603          	lw	a2,-672(gp) # 13a98 <__malloc_sbrk_base>
   11244:	0017e793          	ori	a5,a5,1
   11248:	40c50533          	sub	a0,a0,a2
   1124c:	00f72223          	sw	a5,4(a4) # 1004 <exit-0xf0b0>
   11250:	eea1a023          	sw	a0,-288(gp) # 13c18 <__malloc_current_mallinfo>
   11254:	f51ff06f          	j	111a4 <_malloc_trim_r+0x70>

00011258 <_free_r>:
   11258:	12058463          	beqz	a1,11380 <_free_r+0x128>
   1125c:	fe010113          	addi	sp,sp,-32
   11260:	00812c23          	sw	s0,24(sp)
   11264:	00b12623          	sw	a1,12(sp)
   11268:	00050413          	mv	s0,a0
   1126c:	00112e23          	sw	ra,28(sp)
   11270:	34d000ef          	jal	11dbc <__malloc_lock>
   11274:	00c12583          	lw	a1,12(sp)
   11278:	00013837          	lui	a6,0x13
   1127c:	68880813          	addi	a6,a6,1672 # 13688 <__malloc_av_>
   11280:	ffc5a503          	lw	a0,-4(a1)
   11284:	ff858713          	addi	a4,a1,-8
   11288:	00882883          	lw	a7,8(a6)
   1128c:	ffe57793          	andi	a5,a0,-2
   11290:	00f70633          	add	a2,a4,a5
   11294:	00462683          	lw	a3,4(a2)
   11298:	00157313          	andi	t1,a0,1
   1129c:	ffc6f693          	andi	a3,a3,-4
   112a0:	18c88863          	beq	a7,a2,11430 <_free_r+0x1d8>
   112a4:	00d62223          	sw	a3,4(a2)
   112a8:	00d608b3          	add	a7,a2,a3
   112ac:	0048a883          	lw	a7,4(a7)
   112b0:	0018f893          	andi	a7,a7,1
   112b4:	08031a63          	bnez	t1,11348 <_free_r+0xf0>
   112b8:	ff85a303          	lw	t1,-8(a1)
   112bc:	000135b7          	lui	a1,0x13
   112c0:	69058593          	addi	a1,a1,1680 # 13690 <__malloc_av_+0x8>
   112c4:	40670733          	sub	a4,a4,t1
   112c8:	00872503          	lw	a0,8(a4)
   112cc:	006787b3          	add	a5,a5,t1
   112d0:	12b50a63          	beq	a0,a1,11404 <_free_r+0x1ac>
   112d4:	00c72303          	lw	t1,12(a4)
   112d8:	00652623          	sw	t1,12(a0)
   112dc:	00a32423          	sw	a0,8(t1) # 101c0 <frame_dummy+0x1c>
   112e0:	18088c63          	beqz	a7,11478 <_free_r+0x220>
   112e4:	0017e693          	ori	a3,a5,1
   112e8:	00d72223          	sw	a3,4(a4)
   112ec:	00f62023          	sw	a5,0(a2)
   112f0:	1ff00693          	li	a3,511
   112f4:	0af6e263          	bltu	a3,a5,11398 <_free_r+0x140>
   112f8:	ff87f693          	andi	a3,a5,-8
   112fc:	00868693          	addi	a3,a3,8
   11300:	00482583          	lw	a1,4(a6)
   11304:	00d806b3          	add	a3,a6,a3
   11308:	0006a603          	lw	a2,0(a3)
   1130c:	0057d513          	srli	a0,a5,0x5
   11310:	00100793          	li	a5,1
   11314:	00a797b3          	sll	a5,a5,a0
   11318:	00b7e7b3          	or	a5,a5,a1
   1131c:	ff868593          	addi	a1,a3,-8
   11320:	00c72423          	sw	a2,8(a4)
   11324:	00b72623          	sw	a1,12(a4)
   11328:	00f82223          	sw	a5,4(a6)
   1132c:	00e6a023          	sw	a4,0(a3)
   11330:	00e62623          	sw	a4,12(a2)
   11334:	00040513          	mv	a0,s0
   11338:	01812403          	lw	s0,24(sp)
   1133c:	01c12083          	lw	ra,28(sp)
   11340:	02010113          	addi	sp,sp,32
   11344:	27d0006f          	j	11dc0 <__malloc_unlock>
   11348:	02089e63          	bnez	a7,11384 <_free_r+0x12c>
   1134c:	000135b7          	lui	a1,0x13
   11350:	00d787b3          	add	a5,a5,a3
   11354:	69058593          	addi	a1,a1,1680 # 13690 <__malloc_av_+0x8>
   11358:	00862683          	lw	a3,8(a2)
   1135c:	0017e893          	ori	a7,a5,1
   11360:	00f70533          	add	a0,a4,a5
   11364:	16b68063          	beq	a3,a1,114c4 <_free_r+0x26c>
   11368:	00c62603          	lw	a2,12(a2)
   1136c:	00c6a623          	sw	a2,12(a3)
   11370:	00d62423          	sw	a3,8(a2)
   11374:	01172223          	sw	a7,4(a4)
   11378:	00f52023          	sw	a5,0(a0)
   1137c:	f75ff06f          	j	112f0 <_free_r+0x98>
   11380:	00008067          	ret
   11384:	00156513          	ori	a0,a0,1
   11388:	fea5ae23          	sw	a0,-4(a1)
   1138c:	00f62023          	sw	a5,0(a2)
   11390:	1ff00693          	li	a3,511
   11394:	f6f6f2e3          	bgeu	a3,a5,112f8 <_free_r+0xa0>
   11398:	0097d693          	srli	a3,a5,0x9
   1139c:	00400613          	li	a2,4
   113a0:	0ed66063          	bltu	a2,a3,11480 <_free_r+0x228>
   113a4:	0067d693          	srli	a3,a5,0x6
   113a8:	03968593          	addi	a1,a3,57
   113ac:	00359593          	slli	a1,a1,0x3
   113b0:	03868613          	addi	a2,a3,56
   113b4:	00b805b3          	add	a1,a6,a1
   113b8:	0005a683          	lw	a3,0(a1)
   113bc:	ff858593          	addi	a1,a1,-8
   113c0:	00d59863          	bne	a1,a3,113d0 <_free_r+0x178>
   113c4:	11c0006f          	j	114e0 <_free_r+0x288>
   113c8:	0086a683          	lw	a3,8(a3)
   113cc:	00d58863          	beq	a1,a3,113dc <_free_r+0x184>
   113d0:	0046a603          	lw	a2,4(a3)
   113d4:	ffc67613          	andi	a2,a2,-4
   113d8:	fec7e8e3          	bltu	a5,a2,113c8 <_free_r+0x170>
   113dc:	00c6a583          	lw	a1,12(a3)
   113e0:	00b72623          	sw	a1,12(a4)
   113e4:	00d72423          	sw	a3,8(a4)
   113e8:	00040513          	mv	a0,s0
   113ec:	01812403          	lw	s0,24(sp)
   113f0:	01c12083          	lw	ra,28(sp)
   113f4:	00e5a423          	sw	a4,8(a1)
   113f8:	00e6a623          	sw	a4,12(a3)
   113fc:	02010113          	addi	sp,sp,32
   11400:	1c10006f          	j	11dc0 <__malloc_unlock>
   11404:	0a089063          	bnez	a7,114a4 <_free_r+0x24c>
   11408:	00c62583          	lw	a1,12(a2)
   1140c:	00862603          	lw	a2,8(a2)
   11410:	00f686b3          	add	a3,a3,a5
   11414:	0016e793          	ori	a5,a3,1
   11418:	00b62623          	sw	a1,12(a2)
   1141c:	00c5a423          	sw	a2,8(a1)
   11420:	00f72223          	sw	a5,4(a4)
   11424:	00d70733          	add	a4,a4,a3
   11428:	00d72023          	sw	a3,0(a4)
   1142c:	f09ff06f          	j	11334 <_free_r+0xdc>
   11430:	00d786b3          	add	a3,a5,a3
   11434:	02031063          	bnez	t1,11454 <_free_r+0x1fc>
   11438:	ff85a783          	lw	a5,-8(a1)
   1143c:	40f70733          	sub	a4,a4,a5
   11440:	00872603          	lw	a2,8(a4)
   11444:	00f686b3          	add	a3,a3,a5
   11448:	00c72783          	lw	a5,12(a4)
   1144c:	00f62623          	sw	a5,12(a2)
   11450:	00c7a423          	sw	a2,8(a5)
   11454:	0016e613          	ori	a2,a3,1
   11458:	d641a783          	lw	a5,-668(gp) # 13a9c <__malloc_trim_threshold>
   1145c:	00c72223          	sw	a2,4(a4)
   11460:	00e82423          	sw	a4,8(a6)
   11464:	ecf6e8e3          	bltu	a3,a5,11334 <_free_r+0xdc>
   11468:	d7c1a583          	lw	a1,-644(gp) # 13ab4 <__malloc_top_pad>
   1146c:	00040513          	mv	a0,s0
   11470:	cc5ff0ef          	jal	11134 <_malloc_trim_r>
   11474:	ec1ff06f          	j	11334 <_free_r+0xdc>
   11478:	00d787b3          	add	a5,a5,a3
   1147c:	eddff06f          	j	11358 <_free_r+0x100>
   11480:	01400613          	li	a2,20
   11484:	02d67863          	bgeu	a2,a3,114b4 <_free_r+0x25c>
   11488:	05400613          	li	a2,84
   1148c:	06d66863          	bltu	a2,a3,114fc <_free_r+0x2a4>
   11490:	00c7d693          	srli	a3,a5,0xc
   11494:	06f68593          	addi	a1,a3,111
   11498:	00359593          	slli	a1,a1,0x3
   1149c:	06e68613          	addi	a2,a3,110
   114a0:	f15ff06f          	j	113b4 <_free_r+0x15c>
   114a4:	0017e693          	ori	a3,a5,1
   114a8:	00d72223          	sw	a3,4(a4)
   114ac:	00f62023          	sw	a5,0(a2)
   114b0:	e85ff06f          	j	11334 <_free_r+0xdc>
   114b4:	05c68593          	addi	a1,a3,92
   114b8:	00359593          	slli	a1,a1,0x3
   114bc:	05b68613          	addi	a2,a3,91
   114c0:	ef5ff06f          	j	113b4 <_free_r+0x15c>
   114c4:	00e82a23          	sw	a4,20(a6)
   114c8:	00e82823          	sw	a4,16(a6)
   114cc:	00b72623          	sw	a1,12(a4)
   114d0:	00b72423          	sw	a1,8(a4)
   114d4:	01172223          	sw	a7,4(a4)
   114d8:	00f52023          	sw	a5,0(a0)
   114dc:	e59ff06f          	j	11334 <_free_r+0xdc>
   114e0:	00482503          	lw	a0,4(a6)
   114e4:	40265613          	srai	a2,a2,0x2
   114e8:	00100793          	li	a5,1
   114ec:	00c797b3          	sll	a5,a5,a2
   114f0:	00a7e7b3          	or	a5,a5,a0
   114f4:	00f82223          	sw	a5,4(a6)
   114f8:	ee9ff06f          	j	113e0 <_free_r+0x188>
   114fc:	15400613          	li	a2,340
   11500:	00d66c63          	bltu	a2,a3,11518 <_free_r+0x2c0>
   11504:	00f7d693          	srli	a3,a5,0xf
   11508:	07868593          	addi	a1,a3,120
   1150c:	00359593          	slli	a1,a1,0x3
   11510:	07768613          	addi	a2,a3,119
   11514:	ea1ff06f          	j	113b4 <_free_r+0x15c>
   11518:	55400613          	li	a2,1364
   1151c:	00d66c63          	bltu	a2,a3,11534 <_free_r+0x2dc>
   11520:	0127d693          	srli	a3,a5,0x12
   11524:	07d68593          	addi	a1,a3,125
   11528:	00359593          	slli	a1,a1,0x3
   1152c:	07c68613          	addi	a2,a3,124
   11530:	e85ff06f          	j	113b4 <_free_r+0x15c>
   11534:	3f800593          	li	a1,1016
   11538:	07e00613          	li	a2,126
   1153c:	e79ff06f          	j	113b4 <_free_r+0x15c>

00011540 <_malloc_r>:
   11540:	fc010113          	addi	sp,sp,-64
   11544:	02812c23          	sw	s0,56(sp)
   11548:	02112e23          	sw	ra,60(sp)
   1154c:	00b58793          	addi	a5,a1,11
   11550:	01600713          	li	a4,22
   11554:	00050413          	mv	s0,a0
   11558:	08f76e63          	bltu	a4,a5,115f4 <_malloc_r+0xb4>
   1155c:	01000693          	li	a3,16
   11560:	06b6ec63          	bltu	a3,a1,115d8 <_malloc_r+0x98>
   11564:	059000ef          	jal	11dbc <__malloc_lock>
   11568:	01000693          	li	a3,16
   1156c:	01800713          	li	a4,24
   11570:	00200893          	li	a7,2
   11574:	00013837          	lui	a6,0x13
   11578:	68880813          	addi	a6,a6,1672 # 13688 <__malloc_av_>
   1157c:	00e80733          	add	a4,a6,a4
   11580:	00472783          	lw	a5,4(a4)
   11584:	ff870613          	addi	a2,a4,-8
   11588:	44c78c63          	beq	a5,a2,119e0 <_malloc_r+0x4a0>
   1158c:	0047a703          	lw	a4,4(a5)
   11590:	00c7a603          	lw	a2,12(a5)
   11594:	0087a583          	lw	a1,8(a5)
   11598:	ffc77713          	andi	a4,a4,-4
   1159c:	00e78733          	add	a4,a5,a4
   115a0:	00472683          	lw	a3,4(a4)
   115a4:	00c5a623          	sw	a2,12(a1)
   115a8:	00f12623          	sw	a5,12(sp)
   115ac:	00b62423          	sw	a1,8(a2)
   115b0:	0016e693          	ori	a3,a3,1
   115b4:	00040513          	mv	a0,s0
   115b8:	00d72223          	sw	a3,4(a4)
   115bc:	005000ef          	jal	11dc0 <__malloc_unlock>
   115c0:	00c12783          	lw	a5,12(sp)
   115c4:	03c12083          	lw	ra,60(sp)
   115c8:	03812403          	lw	s0,56(sp)
   115cc:	00878513          	addi	a0,a5,8
   115d0:	04010113          	addi	sp,sp,64
   115d4:	00008067          	ret
   115d8:	00c00793          	li	a5,12
   115dc:	00f42023          	sw	a5,0(s0)
   115e0:	00000513          	li	a0,0
   115e4:	03c12083          	lw	ra,60(sp)
   115e8:	03812403          	lw	s0,56(sp)
   115ec:	04010113          	addi	sp,sp,64
   115f0:	00008067          	ret
   115f4:	ff87f693          	andi	a3,a5,-8
   115f8:	fe07c0e3          	bltz	a5,115d8 <_malloc_r+0x98>
   115fc:	fcb6eee3          	bltu	a3,a1,115d8 <_malloc_r+0x98>
   11600:	00d12623          	sw	a3,12(sp)
   11604:	7b8000ef          	jal	11dbc <__malloc_lock>
   11608:	00c12683          	lw	a3,12(sp)
   1160c:	1f700793          	li	a5,503
   11610:	4cd7f663          	bgeu	a5,a3,11adc <_malloc_r+0x59c>
   11614:	0096d793          	srli	a5,a3,0x9
   11618:	16078e63          	beqz	a5,11794 <_malloc_r+0x254>
   1161c:	00400713          	li	a4,4
   11620:	42f76863          	bltu	a4,a5,11a50 <_malloc_r+0x510>
   11624:	0066d793          	srli	a5,a3,0x6
   11628:	03978893          	addi	a7,a5,57
   1162c:	03878e13          	addi	t3,a5,56
   11630:	00389513          	slli	a0,a7,0x3
   11634:	00013837          	lui	a6,0x13
   11638:	68880813          	addi	a6,a6,1672 # 13688 <__malloc_av_>
   1163c:	00a80533          	add	a0,a6,a0
   11640:	00452783          	lw	a5,4(a0)
   11644:	ff850513          	addi	a0,a0,-8
   11648:	02f50863          	beq	a0,a5,11678 <_malloc_r+0x138>
   1164c:	00f00313          	li	t1,15
   11650:	0140006f          	j	11664 <_malloc_r+0x124>
   11654:	00c7a583          	lw	a1,12(a5)
   11658:	34065463          	bgez	a2,119a0 <_malloc_r+0x460>
   1165c:	00b50e63          	beq	a0,a1,11678 <_malloc_r+0x138>
   11660:	00058793          	mv	a5,a1
   11664:	0047a703          	lw	a4,4(a5)
   11668:	ffc77713          	andi	a4,a4,-4
   1166c:	40d70633          	sub	a2,a4,a3
   11670:	fec352e3          	bge	t1,a2,11654 <_malloc_r+0x114>
   11674:	000e0893          	mv	a7,t3
   11678:	01082783          	lw	a5,16(a6)
   1167c:	00013e37          	lui	t3,0x13
   11680:	690e0e13          	addi	t3,t3,1680 # 13690 <__malloc_av_+0x8>
   11684:	2dc78c63          	beq	a5,t3,1195c <_malloc_r+0x41c>
   11688:	0047a703          	lw	a4,4(a5)
   1168c:	00f00593          	li	a1,15
   11690:	ffc77713          	andi	a4,a4,-4
   11694:	40d70633          	sub	a2,a4,a3
   11698:	46c5cc63          	blt	a1,a2,11b10 <_malloc_r+0x5d0>
   1169c:	01c82a23          	sw	t3,20(a6)
   116a0:	01c82823          	sw	t3,16(a6)
   116a4:	44065263          	bgez	a2,11ae8 <_malloc_r+0x5a8>
   116a8:	1ff00613          	li	a2,511
   116ac:	00482303          	lw	t1,4(a6)
   116b0:	34e66063          	bltu	a2,a4,119f0 <_malloc_r+0x4b0>
   116b4:	ff877613          	andi	a2,a4,-8
   116b8:	00860613          	addi	a2,a2,8
   116bc:	00c80633          	add	a2,a6,a2
   116c0:	00062583          	lw	a1,0(a2)
   116c4:	00575513          	srli	a0,a4,0x5
   116c8:	00100713          	li	a4,1
   116cc:	00a71733          	sll	a4,a4,a0
   116d0:	00e36333          	or	t1,t1,a4
   116d4:	ff860713          	addi	a4,a2,-8
   116d8:	00b7a423          	sw	a1,8(a5)
   116dc:	00e7a623          	sw	a4,12(a5)
   116e0:	00682223          	sw	t1,4(a6)
   116e4:	00f62023          	sw	a5,0(a2)
   116e8:	00f5a623          	sw	a5,12(a1)
   116ec:	4028d793          	srai	a5,a7,0x2
   116f0:	00100513          	li	a0,1
   116f4:	00f51533          	sll	a0,a0,a5
   116f8:	0aa36663          	bltu	t1,a0,117a4 <_malloc_r+0x264>
   116fc:	006577b3          	and	a5,a0,t1
   11700:	02079463          	bnez	a5,11728 <_malloc_r+0x1e8>
   11704:	00151513          	slli	a0,a0,0x1
   11708:	ffc8f893          	andi	a7,a7,-4
   1170c:	006577b3          	and	a5,a0,t1
   11710:	00488893          	addi	a7,a7,4
   11714:	00079a63          	bnez	a5,11728 <_malloc_r+0x1e8>
   11718:	00151513          	slli	a0,a0,0x1
   1171c:	006577b3          	and	a5,a0,t1
   11720:	00488893          	addi	a7,a7,4
   11724:	fe078ae3          	beqz	a5,11718 <_malloc_r+0x1d8>
   11728:	00f00e93          	li	t4,15
   1172c:	00389f13          	slli	t5,a7,0x3
   11730:	01e80f33          	add	t5,a6,t5
   11734:	000f0313          	mv	t1,t5
   11738:	00c32703          	lw	a4,12(t1)
   1173c:	00088f93          	mv	t6,a7
   11740:	32e30a63          	beq	t1,a4,11a74 <_malloc_r+0x534>
   11744:	00472603          	lw	a2,4(a4)
   11748:	00070793          	mv	a5,a4
   1174c:	00c72703          	lw	a4,12(a4)
   11750:	ffc67613          	andi	a2,a2,-4
   11754:	40d605b3          	sub	a1,a2,a3
   11758:	32beca63          	blt	t4,a1,11a8c <_malloc_r+0x54c>
   1175c:	fe05c2e3          	bltz	a1,11740 <_malloc_r+0x200>
   11760:	00c78633          	add	a2,a5,a2
   11764:	00462683          	lw	a3,4(a2)
   11768:	0087a583          	lw	a1,8(a5)
   1176c:	00040513          	mv	a0,s0
   11770:	0016e693          	ori	a3,a3,1
   11774:	00d62223          	sw	a3,4(a2)
   11778:	00e5a623          	sw	a4,12(a1)
   1177c:	00b72423          	sw	a1,8(a4)
   11780:	00f12623          	sw	a5,12(sp)
   11784:	63c000ef          	jal	11dc0 <__malloc_unlock>
   11788:	00c12783          	lw	a5,12(sp)
   1178c:	00878513          	addi	a0,a5,8
   11790:	e55ff06f          	j	115e4 <_malloc_r+0xa4>
   11794:	20000513          	li	a0,512
   11798:	04000893          	li	a7,64
   1179c:	03f00e13          	li	t3,63
   117a0:	e95ff06f          	j	11634 <_malloc_r+0xf4>
   117a4:	00882783          	lw	a5,8(a6)
   117a8:	0047a703          	lw	a4,4(a5)
   117ac:	ffc77313          	andi	t1,a4,-4
   117b0:	40d30633          	sub	a2,t1,a3
   117b4:	00d36663          	bltu	t1,a3,117c0 <_malloc_r+0x280>
   117b8:	01062713          	slti	a4,a2,16
   117bc:	1a070463          	beqz	a4,11964 <_malloc_r+0x424>
   117c0:	d7c1a583          	lw	a1,-644(gp) # 13ab4 <__malloc_top_pad>
   117c4:	d601a603          	lw	a2,-672(gp) # 13a98 <__malloc_sbrk_base>
   117c8:	fff00713          	li	a4,-1
   117cc:	00b685b3          	add	a1,a3,a1
   117d0:	42e60463          	beq	a2,a4,11bf8 <_malloc_r+0x6b8>
   117d4:	00001737          	lui	a4,0x1
   117d8:	00f70713          	addi	a4,a4,15 # 100f <exit-0xf0a5>
   117dc:	00e585b3          	add	a1,a1,a4
   117e0:	fffff737          	lui	a4,0xfffff
   117e4:	00e5f5b3          	and	a1,a1,a4
   117e8:	00040513          	mv	a0,s0
   117ec:	01012e23          	sw	a6,28(sp)
   117f0:	00f12c23          	sw	a5,24(sp)
   117f4:	00d12a23          	sw	a3,20(sp)
   117f8:	00612823          	sw	t1,16(sp)
   117fc:	00b12623          	sw	a1,12(sp)
   11800:	229000ef          	jal	12228 <_sbrk_r>
   11804:	fff00713          	li	a4,-1
   11808:	00c12583          	lw	a1,12(sp)
   1180c:	01012303          	lw	t1,16(sp)
   11810:	01412683          	lw	a3,20(sp)
   11814:	01812783          	lw	a5,24(sp)
   11818:	01c12803          	lw	a6,28(sp)
   1181c:	00050e13          	mv	t3,a0
   11820:	34e50663          	beq	a0,a4,11b6c <_malloc_r+0x62c>
   11824:	00678733          	add	a4,a5,t1
   11828:	34e56063          	bltu	a0,a4,11b68 <_malloc_r+0x628>
   1182c:	ee018e93          	addi	t4,gp,-288 # 13c18 <__malloc_current_mallinfo>
   11830:	000ea603          	lw	a2,0(t4)
   11834:	00c58633          	add	a2,a1,a2
   11838:	00cea023          	sw	a2,0(t4)
   1183c:	48a70a63          	beq	a4,a0,11cd0 <_malloc_r+0x790>
   11840:	d601af03          	lw	t5,-672(gp) # 13a98 <__malloc_sbrk_base>
   11844:	fff00513          	li	a0,-1
   11848:	4aaf0263          	beq	t5,a0,11cec <_malloc_r+0x7ac>
   1184c:	40ee0733          	sub	a4,t3,a4
   11850:	00c70733          	add	a4,a4,a2
   11854:	00eea023          	sw	a4,0(t4)
   11858:	007e7f13          	andi	t5,t3,7
   1185c:	3a0f0e63          	beqz	t5,11c18 <_malloc_r+0x6d8>
   11860:	ff8e7e13          	andi	t3,t3,-8
   11864:	000018b7          	lui	a7,0x1
   11868:	008e0e13          	addi	t3,t3,8
   1186c:	00888893          	addi	a7,a7,8 # 1008 <exit-0xf0ac>
   11870:	00be0633          	add	a2,t3,a1
   11874:	41e885b3          	sub	a1,a7,t5
   11878:	40c585b3          	sub	a1,a1,a2
   1187c:	01459593          	slli	a1,a1,0x14
   11880:	0145d593          	srli	a1,a1,0x14
   11884:	00040513          	mv	a0,s0
   11888:	03012623          	sw	a6,44(sp)
   1188c:	03d12423          	sw	t4,40(sp)
   11890:	02f12223          	sw	a5,36(sp)
   11894:	02d12023          	sw	a3,32(sp)
   11898:	00612e23          	sw	t1,28(sp)
   1189c:	01c12c23          	sw	t3,24(sp)
   118a0:	01e12a23          	sw	t5,20(sp)
   118a4:	00c12823          	sw	a2,16(sp)
   118a8:	00b12623          	sw	a1,12(sp)
   118ac:	17d000ef          	jal	12228 <_sbrk_r>
   118b0:	00050713          	mv	a4,a0
   118b4:	fff00513          	li	a0,-1
   118b8:	00c12583          	lw	a1,12(sp)
   118bc:	01012603          	lw	a2,16(sp)
   118c0:	01412f03          	lw	t5,20(sp)
   118c4:	01812e03          	lw	t3,24(sp)
   118c8:	01c12303          	lw	t1,28(sp)
   118cc:	02012683          	lw	a3,32(sp)
   118d0:	02412783          	lw	a5,36(sp)
   118d4:	02812e83          	lw	t4,40(sp)
   118d8:	02c12803          	lw	a6,44(sp)
   118dc:	44a70e63          	beq	a4,a0,11d38 <_malloc_r+0x7f8>
   118e0:	000ea603          	lw	a2,0(t4)
   118e4:	41c70733          	sub	a4,a4,t3
   118e8:	00b70733          	add	a4,a4,a1
   118ec:	00176713          	ori	a4,a4,1
   118f0:	01c82423          	sw	t3,8(a6)
   118f4:	00c58633          	add	a2,a1,a2
   118f8:	00ee2223          	sw	a4,4(t3)
   118fc:	00cea023          	sw	a2,0(t4)
   11900:	03078e63          	beq	a5,a6,1193c <_malloc_r+0x3fc>
   11904:	00f00513          	li	a0,15
   11908:	3e657663          	bgeu	a0,t1,11cf4 <_malloc_r+0x7b4>
   1190c:	0047a583          	lw	a1,4(a5)
   11910:	ff430713          	addi	a4,t1,-12
   11914:	ff877713          	andi	a4,a4,-8
   11918:	0015f593          	andi	a1,a1,1
   1191c:	00e5e5b3          	or	a1,a1,a4
   11920:	00b7a223          	sw	a1,4(a5)
   11924:	00500893          	li	a7,5
   11928:	00e785b3          	add	a1,a5,a4
   1192c:	0115a223          	sw	a7,4(a1)
   11930:	0115a423          	sw	a7,8(a1)
   11934:	40e56a63          	bltu	a0,a4,11d48 <_malloc_r+0x808>
   11938:	004e2703          	lw	a4,4(t3)
   1193c:	d781a583          	lw	a1,-648(gp) # 13ab0 <__malloc_max_sbrked_mem>
   11940:	00c5f463          	bgeu	a1,a2,11948 <_malloc_r+0x408>
   11944:	d6c1ac23          	sw	a2,-648(gp) # 13ab0 <__malloc_max_sbrked_mem>
   11948:	d741a583          	lw	a1,-652(gp) # 13aac <__malloc_max_total_mem>
   1194c:	00c5f463          	bgeu	a1,a2,11954 <_malloc_r+0x414>
   11950:	d6c1aa23          	sw	a2,-652(gp) # 13aac <__malloc_max_total_mem>
   11954:	000e0793          	mv	a5,t3
   11958:	21c0006f          	j	11b74 <_malloc_r+0x634>
   1195c:	00482303          	lw	t1,4(a6)
   11960:	d8dff06f          	j	116ec <_malloc_r+0x1ac>
   11964:	0016e713          	ori	a4,a3,1
   11968:	00e7a223          	sw	a4,4(a5)
   1196c:	00d786b3          	add	a3,a5,a3
   11970:	00166613          	ori	a2,a2,1
   11974:	00d82423          	sw	a3,8(a6)
   11978:	00040513          	mv	a0,s0
   1197c:	00c6a223          	sw	a2,4(a3)
   11980:	00f12623          	sw	a5,12(sp)
   11984:	43c000ef          	jal	11dc0 <__malloc_unlock>
   11988:	00c12783          	lw	a5,12(sp)
   1198c:	03c12083          	lw	ra,60(sp)
   11990:	03812403          	lw	s0,56(sp)
   11994:	00878513          	addi	a0,a5,8
   11998:	04010113          	addi	sp,sp,64
   1199c:	00008067          	ret
   119a0:	0087a603          	lw	a2,8(a5)
   119a4:	00e78733          	add	a4,a5,a4
   119a8:	00472683          	lw	a3,4(a4) # fffff004 <__BSS_END__+0xfffeb234>
   119ac:	00b62623          	sw	a1,12(a2)
   119b0:	00f12623          	sw	a5,12(sp)
   119b4:	0016e693          	ori	a3,a3,1
   119b8:	00c5a423          	sw	a2,8(a1)
   119bc:	00040513          	mv	a0,s0
   119c0:	00d72223          	sw	a3,4(a4)
   119c4:	3fc000ef          	jal	11dc0 <__malloc_unlock>
   119c8:	00c12783          	lw	a5,12(sp)
   119cc:	03c12083          	lw	ra,60(sp)
   119d0:	03812403          	lw	s0,56(sp)
   119d4:	00878513          	addi	a0,a5,8
   119d8:	04010113          	addi	sp,sp,64
   119dc:	00008067          	ret
   119e0:	00c72783          	lw	a5,12(a4)
   119e4:	00288893          	addi	a7,a7,2
   119e8:	c8f708e3          	beq	a4,a5,11678 <_malloc_r+0x138>
   119ec:	ba1ff06f          	j	1158c <_malloc_r+0x4c>
   119f0:	00975613          	srli	a2,a4,0x9
   119f4:	00400593          	li	a1,4
   119f8:	14c5fe63          	bgeu	a1,a2,11b54 <_malloc_r+0x614>
   119fc:	01400593          	li	a1,20
   11a00:	28c5e263          	bltu	a1,a2,11c84 <_malloc_r+0x744>
   11a04:	05c60513          	addi	a0,a2,92
   11a08:	00351513          	slli	a0,a0,0x3
   11a0c:	05b60593          	addi	a1,a2,91
   11a10:	00a80533          	add	a0,a6,a0
   11a14:	00052603          	lw	a2,0(a0)
   11a18:	ff850513          	addi	a0,a0,-8
   11a1c:	00c51863          	bne	a0,a2,11a2c <_malloc_r+0x4ec>
   11a20:	1e00006f          	j	11c00 <_malloc_r+0x6c0>
   11a24:	00862603          	lw	a2,8(a2)
   11a28:	00c50863          	beq	a0,a2,11a38 <_malloc_r+0x4f8>
   11a2c:	00462583          	lw	a1,4(a2)
   11a30:	ffc5f593          	andi	a1,a1,-4
   11a34:	feb768e3          	bltu	a4,a1,11a24 <_malloc_r+0x4e4>
   11a38:	00c62503          	lw	a0,12(a2)
   11a3c:	00a7a623          	sw	a0,12(a5)
   11a40:	00c7a423          	sw	a2,8(a5)
   11a44:	00f52423          	sw	a5,8(a0)
   11a48:	00f62623          	sw	a5,12(a2)
   11a4c:	ca1ff06f          	j	116ec <_malloc_r+0x1ac>
   11a50:	01400713          	li	a4,20
   11a54:	14f77063          	bgeu	a4,a5,11b94 <_malloc_r+0x654>
   11a58:	05400713          	li	a4,84
   11a5c:	24f76263          	bltu	a4,a5,11ca0 <_malloc_r+0x760>
   11a60:	00c6d793          	srli	a5,a3,0xc
   11a64:	06f78893          	addi	a7,a5,111
   11a68:	06e78e13          	addi	t3,a5,110
   11a6c:	00389513          	slli	a0,a7,0x3
   11a70:	bc5ff06f          	j	11634 <_malloc_r+0xf4>
   11a74:	001f8f93          	addi	t6,t6,1
   11a78:	003ff793          	andi	a5,t6,3
   11a7c:	00830313          	addi	t1,t1,8
   11a80:	12078863          	beqz	a5,11bb0 <_malloc_r+0x670>
   11a84:	00c32703          	lw	a4,12(t1)
   11a88:	cb9ff06f          	j	11740 <_malloc_r+0x200>
   11a8c:	0087a503          	lw	a0,8(a5)
   11a90:	0016e893          	ori	a7,a3,1
   11a94:	0117a223          	sw	a7,4(a5)
   11a98:	00e52623          	sw	a4,12(a0)
   11a9c:	00a72423          	sw	a0,8(a4)
   11aa0:	00d786b3          	add	a3,a5,a3
   11aa4:	00d82a23          	sw	a3,20(a6)
   11aa8:	00d82823          	sw	a3,16(a6)
   11aac:	0015e713          	ori	a4,a1,1
   11ab0:	00c78633          	add	a2,a5,a2
   11ab4:	01c6a623          	sw	t3,12(a3)
   11ab8:	01c6a423          	sw	t3,8(a3)
   11abc:	00e6a223          	sw	a4,4(a3)
   11ac0:	00040513          	mv	a0,s0
   11ac4:	00b62023          	sw	a1,0(a2)
   11ac8:	00f12623          	sw	a5,12(sp)
   11acc:	2f4000ef          	jal	11dc0 <__malloc_unlock>
   11ad0:	00c12783          	lw	a5,12(sp)
   11ad4:	00878513          	addi	a0,a5,8
   11ad8:	b0dff06f          	j	115e4 <_malloc_r+0xa4>
   11adc:	0036d893          	srli	a7,a3,0x3
   11ae0:	00868713          	addi	a4,a3,8
   11ae4:	a91ff06f          	j	11574 <_malloc_r+0x34>
   11ae8:	00e78733          	add	a4,a5,a4
   11aec:	00472683          	lw	a3,4(a4)
   11af0:	00f12623          	sw	a5,12(sp)
   11af4:	00040513          	mv	a0,s0
   11af8:	0016e693          	ori	a3,a3,1
   11afc:	00d72223          	sw	a3,4(a4)
   11b00:	2c0000ef          	jal	11dc0 <__malloc_unlock>
   11b04:	00c12783          	lw	a5,12(sp)
   11b08:	00878513          	addi	a0,a5,8
   11b0c:	ad9ff06f          	j	115e4 <_malloc_r+0xa4>
   11b10:	0016e593          	ori	a1,a3,1
   11b14:	00b7a223          	sw	a1,4(a5)
   11b18:	00d786b3          	add	a3,a5,a3
   11b1c:	00d82a23          	sw	a3,20(a6)
   11b20:	00d82823          	sw	a3,16(a6)
   11b24:	00166593          	ori	a1,a2,1
   11b28:	00e78733          	add	a4,a5,a4
   11b2c:	01c6a623          	sw	t3,12(a3)
   11b30:	01c6a423          	sw	t3,8(a3)
   11b34:	00b6a223          	sw	a1,4(a3)
   11b38:	00040513          	mv	a0,s0
   11b3c:	00c72023          	sw	a2,0(a4)
   11b40:	00f12623          	sw	a5,12(sp)
   11b44:	27c000ef          	jal	11dc0 <__malloc_unlock>
   11b48:	00c12783          	lw	a5,12(sp)
   11b4c:	00878513          	addi	a0,a5,8
   11b50:	a95ff06f          	j	115e4 <_malloc_r+0xa4>
   11b54:	00675613          	srli	a2,a4,0x6
   11b58:	03960513          	addi	a0,a2,57
   11b5c:	00351513          	slli	a0,a0,0x3
   11b60:	03860593          	addi	a1,a2,56
   11b64:	eadff06f          	j	11a10 <_malloc_r+0x4d0>
   11b68:	15078a63          	beq	a5,a6,11cbc <_malloc_r+0x77c>
   11b6c:	00882783          	lw	a5,8(a6)
   11b70:	0047a703          	lw	a4,4(a5)
   11b74:	ffc77713          	andi	a4,a4,-4
   11b78:	40d70633          	sub	a2,a4,a3
   11b7c:	00d76663          	bltu	a4,a3,11b88 <_malloc_r+0x648>
   11b80:	01062713          	slti	a4,a2,16
   11b84:	de0700e3          	beqz	a4,11964 <_malloc_r+0x424>
   11b88:	00040513          	mv	a0,s0
   11b8c:	234000ef          	jal	11dc0 <__malloc_unlock>
   11b90:	a51ff06f          	j	115e0 <_malloc_r+0xa0>
   11b94:	05c78893          	addi	a7,a5,92
   11b98:	05b78e13          	addi	t3,a5,91
   11b9c:	00389513          	slli	a0,a7,0x3
   11ba0:	a95ff06f          	j	11634 <_malloc_r+0xf4>
   11ba4:	008f2783          	lw	a5,8(t5)
   11ba8:	fff88893          	addi	a7,a7,-1
   11bac:	21e79463          	bne	a5,t5,11db4 <_malloc_r+0x874>
   11bb0:	0038f793          	andi	a5,a7,3
   11bb4:	ff8f0f13          	addi	t5,t5,-8
   11bb8:	fe0796e3          	bnez	a5,11ba4 <_malloc_r+0x664>
   11bbc:	00482703          	lw	a4,4(a6)
   11bc0:	fff54793          	not	a5,a0
   11bc4:	00e7f7b3          	and	a5,a5,a4
   11bc8:	00f82223          	sw	a5,4(a6)
   11bcc:	00151513          	slli	a0,a0,0x1
   11bd0:	fff50713          	addi	a4,a0,-1
   11bd4:	bcf778e3          	bgeu	a4,a5,117a4 <_malloc_r+0x264>
   11bd8:	00f57733          	and	a4,a0,a5
   11bdc:	00071a63          	bnez	a4,11bf0 <_malloc_r+0x6b0>
   11be0:	00151513          	slli	a0,a0,0x1
   11be4:	00f57733          	and	a4,a0,a5
   11be8:	004f8f93          	addi	t6,t6,4
   11bec:	fe070ae3          	beqz	a4,11be0 <_malloc_r+0x6a0>
   11bf0:	000f8893          	mv	a7,t6
   11bf4:	b39ff06f          	j	1172c <_malloc_r+0x1ec>
   11bf8:	01058593          	addi	a1,a1,16
   11bfc:	bedff06f          	j	117e8 <_malloc_r+0x2a8>
   11c00:	4025d593          	srai	a1,a1,0x2
   11c04:	00100713          	li	a4,1
   11c08:	00b71733          	sll	a4,a4,a1
   11c0c:	00e36333          	or	t1,t1,a4
   11c10:	00682223          	sw	t1,4(a6)
   11c14:	e29ff06f          	j	11a3c <_malloc_r+0x4fc>
   11c18:	00be0633          	add	a2,t3,a1
   11c1c:	40c005b3          	neg	a1,a2
   11c20:	01459593          	slli	a1,a1,0x14
   11c24:	0145d593          	srli	a1,a1,0x14
   11c28:	00040513          	mv	a0,s0
   11c2c:	03012423          	sw	a6,40(sp)
   11c30:	03d12223          	sw	t4,36(sp)
   11c34:	02f12023          	sw	a5,32(sp)
   11c38:	00d12e23          	sw	a3,28(sp)
   11c3c:	00612c23          	sw	t1,24(sp)
   11c40:	01c12a23          	sw	t3,20(sp)
   11c44:	00b12623          	sw	a1,12(sp)
   11c48:	00c12823          	sw	a2,16(sp)
   11c4c:	5dc000ef          	jal	12228 <_sbrk_r>
   11c50:	00050713          	mv	a4,a0
   11c54:	fff00513          	li	a0,-1
   11c58:	00c12583          	lw	a1,12(sp)
   11c5c:	01412e03          	lw	t3,20(sp)
   11c60:	01812303          	lw	t1,24(sp)
   11c64:	01c12683          	lw	a3,28(sp)
   11c68:	02012783          	lw	a5,32(sp)
   11c6c:	02412e83          	lw	t4,36(sp)
   11c70:	02812803          	lw	a6,40(sp)
   11c74:	c6a716e3          	bne	a4,a0,118e0 <_malloc_r+0x3a0>
   11c78:	01012703          	lw	a4,16(sp)
   11c7c:	00000593          	li	a1,0
   11c80:	c61ff06f          	j	118e0 <_malloc_r+0x3a0>
   11c84:	05400593          	li	a1,84
   11c88:	06c5ec63          	bltu	a1,a2,11d00 <_malloc_r+0x7c0>
   11c8c:	00c75613          	srli	a2,a4,0xc
   11c90:	06f60513          	addi	a0,a2,111
   11c94:	00351513          	slli	a0,a0,0x3
   11c98:	06e60593          	addi	a1,a2,110
   11c9c:	d75ff06f          	j	11a10 <_malloc_r+0x4d0>
   11ca0:	15400713          	li	a4,340
   11ca4:	06f76c63          	bltu	a4,a5,11d1c <_malloc_r+0x7dc>
   11ca8:	00f6d793          	srli	a5,a3,0xf
   11cac:	07878893          	addi	a7,a5,120
   11cb0:	07778e13          	addi	t3,a5,119
   11cb4:	00389513          	slli	a0,a7,0x3
   11cb8:	97dff06f          	j	11634 <_malloc_r+0xf4>
   11cbc:	ee018e93          	addi	t4,gp,-288 # 13c18 <__malloc_current_mallinfo>
   11cc0:	000ea603          	lw	a2,0(t4)
   11cc4:	00c58633          	add	a2,a1,a2
   11cc8:	00cea023          	sw	a2,0(t4)
   11ccc:	b75ff06f          	j	11840 <_malloc_r+0x300>
   11cd0:	01451513          	slli	a0,a0,0x14
   11cd4:	b60516e3          	bnez	a0,11840 <_malloc_r+0x300>
   11cd8:	00882e03          	lw	t3,8(a6)
   11cdc:	00b305b3          	add	a1,t1,a1
   11ce0:	0015e713          	ori	a4,a1,1
   11ce4:	00ee2223          	sw	a4,4(t3)
   11ce8:	c55ff06f          	j	1193c <_malloc_r+0x3fc>
   11cec:	d7c1a023          	sw	t3,-672(gp) # 13a98 <__malloc_sbrk_base>
   11cf0:	b69ff06f          	j	11858 <_malloc_r+0x318>
   11cf4:	00100793          	li	a5,1
   11cf8:	00fe2223          	sw	a5,4(t3)
   11cfc:	e8dff06f          	j	11b88 <_malloc_r+0x648>
   11d00:	15400593          	li	a1,340
   11d04:	06c5ec63          	bltu	a1,a2,11d7c <_malloc_r+0x83c>
   11d08:	00f75613          	srli	a2,a4,0xf
   11d0c:	07860513          	addi	a0,a2,120
   11d10:	00351513          	slli	a0,a0,0x3
   11d14:	07760593          	addi	a1,a2,119
   11d18:	cf9ff06f          	j	11a10 <_malloc_r+0x4d0>
   11d1c:	55400713          	li	a4,1364
   11d20:	06f76c63          	bltu	a4,a5,11d98 <_malloc_r+0x858>
   11d24:	0126d793          	srli	a5,a3,0x12
   11d28:	07d78893          	addi	a7,a5,125
   11d2c:	07c78e13          	addi	t3,a5,124
   11d30:	00389513          	slli	a0,a7,0x3
   11d34:	901ff06f          	j	11634 <_malloc_r+0xf4>
   11d38:	ff8f0f13          	addi	t5,t5,-8
   11d3c:	01e60733          	add	a4,a2,t5
   11d40:	00000593          	li	a1,0
   11d44:	b9dff06f          	j	118e0 <_malloc_r+0x3a0>
   11d48:	00878593          	addi	a1,a5,8
   11d4c:	00040513          	mv	a0,s0
   11d50:	01012a23          	sw	a6,20(sp)
   11d54:	01d12823          	sw	t4,16(sp)
   11d58:	00d12623          	sw	a3,12(sp)
   11d5c:	cfcff0ef          	jal	11258 <_free_r>
   11d60:	01412803          	lw	a6,20(sp)
   11d64:	01012e83          	lw	t4,16(sp)
   11d68:	00c12683          	lw	a3,12(sp)
   11d6c:	00882e03          	lw	t3,8(a6)
   11d70:	000ea603          	lw	a2,0(t4)
   11d74:	004e2703          	lw	a4,4(t3)
   11d78:	bc5ff06f          	j	1193c <_malloc_r+0x3fc>
   11d7c:	55400593          	li	a1,1364
   11d80:	02c5e463          	bltu	a1,a2,11da8 <_malloc_r+0x868>
   11d84:	01275613          	srli	a2,a4,0x12
   11d88:	07d60513          	addi	a0,a2,125
   11d8c:	00351513          	slli	a0,a0,0x3
   11d90:	07c60593          	addi	a1,a2,124
   11d94:	c7dff06f          	j	11a10 <_malloc_r+0x4d0>
   11d98:	3f800513          	li	a0,1016
   11d9c:	07f00893          	li	a7,127
   11da0:	07e00e13          	li	t3,126
   11da4:	891ff06f          	j	11634 <_malloc_r+0xf4>
   11da8:	3f800513          	li	a0,1016
   11dac:	07e00593          	li	a1,126
   11db0:	c61ff06f          	j	11a10 <_malloc_r+0x4d0>
   11db4:	00482783          	lw	a5,4(a6)
   11db8:	e15ff06f          	j	11bcc <_malloc_r+0x68c>

00011dbc <__malloc_lock>:
   11dbc:	00008067          	ret

00011dc0 <__malloc_unlock>:
   11dc0:	00008067          	ret

00011dc4 <_fclose_r>:
   11dc4:	ff010113          	addi	sp,sp,-16
   11dc8:	00112623          	sw	ra,12(sp)
   11dcc:	01212023          	sw	s2,0(sp)
   11dd0:	02058863          	beqz	a1,11e00 <_fclose_r+0x3c>
   11dd4:	00812423          	sw	s0,8(sp)
   11dd8:	00912223          	sw	s1,4(sp)
   11ddc:	00058413          	mv	s0,a1
   11de0:	00050493          	mv	s1,a0
   11de4:	00050663          	beqz	a0,11df0 <_fclose_r+0x2c>
   11de8:	03452783          	lw	a5,52(a0)
   11dec:	0c078c63          	beqz	a5,11ec4 <_fclose_r+0x100>
   11df0:	00c41783          	lh	a5,12(s0)
   11df4:	02079263          	bnez	a5,11e18 <_fclose_r+0x54>
   11df8:	00812403          	lw	s0,8(sp)
   11dfc:	00412483          	lw	s1,4(sp)
   11e00:	00c12083          	lw	ra,12(sp)
   11e04:	00000913          	li	s2,0
   11e08:	00090513          	mv	a0,s2
   11e0c:	00012903          	lw	s2,0(sp)
   11e10:	01010113          	addi	sp,sp,16
   11e14:	00008067          	ret
   11e18:	00040593          	mv	a1,s0
   11e1c:	00048513          	mv	a0,s1
   11e20:	0b8000ef          	jal	11ed8 <__sflush_r>
   11e24:	02c42783          	lw	a5,44(s0)
   11e28:	00050913          	mv	s2,a0
   11e2c:	00078a63          	beqz	a5,11e40 <_fclose_r+0x7c>
   11e30:	01c42583          	lw	a1,28(s0)
   11e34:	00048513          	mv	a0,s1
   11e38:	000780e7          	jalr	a5
   11e3c:	06054463          	bltz	a0,11ea4 <_fclose_r+0xe0>
   11e40:	00c45783          	lhu	a5,12(s0)
   11e44:	0807f793          	andi	a5,a5,128
   11e48:	06079663          	bnez	a5,11eb4 <_fclose_r+0xf0>
   11e4c:	03042583          	lw	a1,48(s0)
   11e50:	00058c63          	beqz	a1,11e68 <_fclose_r+0xa4>
   11e54:	04040793          	addi	a5,s0,64
   11e58:	00f58663          	beq	a1,a5,11e64 <_fclose_r+0xa0>
   11e5c:	00048513          	mv	a0,s1
   11e60:	bf8ff0ef          	jal	11258 <_free_r>
   11e64:	02042823          	sw	zero,48(s0)
   11e68:	04442583          	lw	a1,68(s0)
   11e6c:	00058863          	beqz	a1,11e7c <_fclose_r+0xb8>
   11e70:	00048513          	mv	a0,s1
   11e74:	be4ff0ef          	jal	11258 <_free_r>
   11e78:	04042223          	sw	zero,68(s0)
   11e7c:	b29fe0ef          	jal	109a4 <__sfp_lock_acquire>
   11e80:	00041623          	sh	zero,12(s0)
   11e84:	b25fe0ef          	jal	109a8 <__sfp_lock_release>
   11e88:	00c12083          	lw	ra,12(sp)
   11e8c:	00812403          	lw	s0,8(sp)
   11e90:	00412483          	lw	s1,4(sp)
   11e94:	00090513          	mv	a0,s2
   11e98:	00012903          	lw	s2,0(sp)
   11e9c:	01010113          	addi	sp,sp,16
   11ea0:	00008067          	ret
   11ea4:	00c45783          	lhu	a5,12(s0)
   11ea8:	fff00913          	li	s2,-1
   11eac:	0807f793          	andi	a5,a5,128
   11eb0:	f8078ee3          	beqz	a5,11e4c <_fclose_r+0x88>
   11eb4:	01042583          	lw	a1,16(s0)
   11eb8:	00048513          	mv	a0,s1
   11ebc:	b9cff0ef          	jal	11258 <_free_r>
   11ec0:	f8dff06f          	j	11e4c <_fclose_r+0x88>
   11ec4:	abdfe0ef          	jal	10980 <__sinit>
   11ec8:	f29ff06f          	j	11df0 <_fclose_r+0x2c>

00011ecc <fclose>:
   11ecc:	00050593          	mv	a1,a0
   11ed0:	d5c1a503          	lw	a0,-676(gp) # 13a94 <_impure_ptr>
   11ed4:	ef1ff06f          	j	11dc4 <_fclose_r>

00011ed8 <__sflush_r>:
   11ed8:	00c59703          	lh	a4,12(a1)
   11edc:	fe010113          	addi	sp,sp,-32
   11ee0:	00812c23          	sw	s0,24(sp)
   11ee4:	01312623          	sw	s3,12(sp)
   11ee8:	00112e23          	sw	ra,28(sp)
   11eec:	00877793          	andi	a5,a4,8
   11ef0:	00058413          	mv	s0,a1
   11ef4:	00050993          	mv	s3,a0
   11ef8:	12079263          	bnez	a5,1201c <__sflush_r+0x144>
   11efc:	000017b7          	lui	a5,0x1
   11f00:	80078793          	addi	a5,a5,-2048 # 800 <exit-0xf8b4>
   11f04:	0045a683          	lw	a3,4(a1)
   11f08:	00f767b3          	or	a5,a4,a5
   11f0c:	00f59623          	sh	a5,12(a1)
   11f10:	18d05c63          	blez	a3,120a8 <__sflush_r+0x1d0>
   11f14:	02842803          	lw	a6,40(s0)
   11f18:	0e080663          	beqz	a6,12004 <__sflush_r+0x12c>
   11f1c:	00912a23          	sw	s1,20(sp)
   11f20:	01371693          	slli	a3,a4,0x13
   11f24:	0009a483          	lw	s1,0(s3)
   11f28:	0009a023          	sw	zero,0(s3)
   11f2c:	1806ca63          	bltz	a3,120c0 <__sflush_r+0x1e8>
   11f30:	01c42583          	lw	a1,28(s0)
   11f34:	00000613          	li	a2,0
   11f38:	00100693          	li	a3,1
   11f3c:	00098513          	mv	a0,s3
   11f40:	000800e7          	jalr	a6
   11f44:	fff00793          	li	a5,-1
   11f48:	00050613          	mv	a2,a0
   11f4c:	1af50c63          	beq	a0,a5,12104 <__sflush_r+0x22c>
   11f50:	00c41783          	lh	a5,12(s0)
   11f54:	02842803          	lw	a6,40(s0)
   11f58:	0047f793          	andi	a5,a5,4
   11f5c:	00078e63          	beqz	a5,11f78 <__sflush_r+0xa0>
   11f60:	00442703          	lw	a4,4(s0)
   11f64:	03042783          	lw	a5,48(s0)
   11f68:	40e60633          	sub	a2,a2,a4
   11f6c:	00078663          	beqz	a5,11f78 <__sflush_r+0xa0>
   11f70:	03c42783          	lw	a5,60(s0)
   11f74:	40f60633          	sub	a2,a2,a5
   11f78:	01c42583          	lw	a1,28(s0)
   11f7c:	00000693          	li	a3,0
   11f80:	00098513          	mv	a0,s3
   11f84:	000800e7          	jalr	a6
   11f88:	fff00713          	li	a4,-1
   11f8c:	00c41783          	lh	a5,12(s0)
   11f90:	12e51c63          	bne	a0,a4,120c8 <__sflush_r+0x1f0>
   11f94:	0009a683          	lw	a3,0(s3)
   11f98:	01d00713          	li	a4,29
   11f9c:	18d76263          	bltu	a4,a3,12120 <__sflush_r+0x248>
   11fa0:	20400737          	lui	a4,0x20400
   11fa4:	00170713          	addi	a4,a4,1 # 20400001 <__BSS_END__+0x203ec231>
   11fa8:	00d75733          	srl	a4,a4,a3
   11fac:	00177713          	andi	a4,a4,1
   11fb0:	16070863          	beqz	a4,12120 <__sflush_r+0x248>
   11fb4:	01042683          	lw	a3,16(s0)
   11fb8:	fffff737          	lui	a4,0xfffff
   11fbc:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffeba2f>
   11fc0:	00e7f733          	and	a4,a5,a4
   11fc4:	00e41623          	sh	a4,12(s0)
   11fc8:	00042223          	sw	zero,4(s0)
   11fcc:	00d42023          	sw	a3,0(s0)
   11fd0:	01379713          	slli	a4,a5,0x13
   11fd4:	00075663          	bgez	a4,11fe0 <__sflush_r+0x108>
   11fd8:	0009a783          	lw	a5,0(s3)
   11fdc:	10078863          	beqz	a5,120ec <__sflush_r+0x214>
   11fe0:	03042583          	lw	a1,48(s0)
   11fe4:	0099a023          	sw	s1,0(s3)
   11fe8:	10058a63          	beqz	a1,120fc <__sflush_r+0x224>
   11fec:	04040793          	addi	a5,s0,64
   11ff0:	00f58663          	beq	a1,a5,11ffc <__sflush_r+0x124>
   11ff4:	00098513          	mv	a0,s3
   11ff8:	a60ff0ef          	jal	11258 <_free_r>
   11ffc:	01412483          	lw	s1,20(sp)
   12000:	02042823          	sw	zero,48(s0)
   12004:	01c12083          	lw	ra,28(sp)
   12008:	01812403          	lw	s0,24(sp)
   1200c:	00c12983          	lw	s3,12(sp)
   12010:	00000513          	li	a0,0
   12014:	02010113          	addi	sp,sp,32
   12018:	00008067          	ret
   1201c:	01212823          	sw	s2,16(sp)
   12020:	0105a903          	lw	s2,16(a1)
   12024:	08090a63          	beqz	s2,120b8 <__sflush_r+0x1e0>
   12028:	00912a23          	sw	s1,20(sp)
   1202c:	0005a483          	lw	s1,0(a1)
   12030:	00377713          	andi	a4,a4,3
   12034:	0125a023          	sw	s2,0(a1)
   12038:	412484b3          	sub	s1,s1,s2
   1203c:	00000793          	li	a5,0
   12040:	00071463          	bnez	a4,12048 <__sflush_r+0x170>
   12044:	0145a783          	lw	a5,20(a1)
   12048:	00f42423          	sw	a5,8(s0)
   1204c:	00904863          	bgtz	s1,1205c <__sflush_r+0x184>
   12050:	0640006f          	j	120b4 <__sflush_r+0x1dc>
   12054:	00a90933          	add	s2,s2,a0
   12058:	04905e63          	blez	s1,120b4 <__sflush_r+0x1dc>
   1205c:	02442783          	lw	a5,36(s0)
   12060:	01c42583          	lw	a1,28(s0)
   12064:	00048693          	mv	a3,s1
   12068:	00090613          	mv	a2,s2
   1206c:	00098513          	mv	a0,s3
   12070:	000780e7          	jalr	a5
   12074:	40a484b3          	sub	s1,s1,a0
   12078:	fca04ee3          	bgtz	a0,12054 <__sflush_r+0x17c>
   1207c:	00c45783          	lhu	a5,12(s0)
   12080:	01012903          	lw	s2,16(sp)
   12084:	0407e793          	ori	a5,a5,64
   12088:	01c12083          	lw	ra,28(sp)
   1208c:	00f41623          	sh	a5,12(s0)
   12090:	01812403          	lw	s0,24(sp)
   12094:	01412483          	lw	s1,20(sp)
   12098:	00c12983          	lw	s3,12(sp)
   1209c:	fff00513          	li	a0,-1
   120a0:	02010113          	addi	sp,sp,32
   120a4:	00008067          	ret
   120a8:	03c5a683          	lw	a3,60(a1)
   120ac:	e6d044e3          	bgtz	a3,11f14 <__sflush_r+0x3c>
   120b0:	f55ff06f          	j	12004 <__sflush_r+0x12c>
   120b4:	01412483          	lw	s1,20(sp)
   120b8:	01012903          	lw	s2,16(sp)
   120bc:	f49ff06f          	j	12004 <__sflush_r+0x12c>
   120c0:	05042603          	lw	a2,80(s0)
   120c4:	e95ff06f          	j	11f58 <__sflush_r+0x80>
   120c8:	01042683          	lw	a3,16(s0)
   120cc:	fffff737          	lui	a4,0xfffff
   120d0:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffeba2f>
   120d4:	00e7f733          	and	a4,a5,a4
   120d8:	00e41623          	sh	a4,12(s0)
   120dc:	00042223          	sw	zero,4(s0)
   120e0:	00d42023          	sw	a3,0(s0)
   120e4:	01379713          	slli	a4,a5,0x13
   120e8:	ee075ce3          	bgez	a4,11fe0 <__sflush_r+0x108>
   120ec:	03042583          	lw	a1,48(s0)
   120f0:	04a42823          	sw	a0,80(s0)
   120f4:	0099a023          	sw	s1,0(s3)
   120f8:	ee059ae3          	bnez	a1,11fec <__sflush_r+0x114>
   120fc:	01412483          	lw	s1,20(sp)
   12100:	f05ff06f          	j	12004 <__sflush_r+0x12c>
   12104:	0009a783          	lw	a5,0(s3)
   12108:	e40784e3          	beqz	a5,11f50 <__sflush_r+0x78>
   1210c:	fe378713          	addi	a4,a5,-29
   12110:	00070c63          	beqz	a4,12128 <__sflush_r+0x250>
   12114:	fea78793          	addi	a5,a5,-22
   12118:	00078863          	beqz	a5,12128 <__sflush_r+0x250>
   1211c:	00c45783          	lhu	a5,12(s0)
   12120:	0407e793          	ori	a5,a5,64
   12124:	f65ff06f          	j	12088 <__sflush_r+0x1b0>
   12128:	0099a023          	sw	s1,0(s3)
   1212c:	01412483          	lw	s1,20(sp)
   12130:	ed5ff06f          	j	12004 <__sflush_r+0x12c>

00012134 <_fflush_r>:
   12134:	00050793          	mv	a5,a0
   12138:	00050663          	beqz	a0,12144 <_fflush_r+0x10>
   1213c:	03452703          	lw	a4,52(a0)
   12140:	00070e63          	beqz	a4,1215c <_fflush_r+0x28>
   12144:	00c59703          	lh	a4,12(a1)
   12148:	00071663          	bnez	a4,12154 <_fflush_r+0x20>
   1214c:	00000513          	li	a0,0
   12150:	00008067          	ret
   12154:	00078513          	mv	a0,a5
   12158:	d81ff06f          	j	11ed8 <__sflush_r>
   1215c:	fe010113          	addi	sp,sp,-32
   12160:	00b12623          	sw	a1,12(sp)
   12164:	00112e23          	sw	ra,28(sp)
   12168:	00a12423          	sw	a0,8(sp)
   1216c:	815fe0ef          	jal	10980 <__sinit>
   12170:	00c12583          	lw	a1,12(sp)
   12174:	00812783          	lw	a5,8(sp)
   12178:	00c59703          	lh	a4,12(a1)
   1217c:	00070a63          	beqz	a4,12190 <_fflush_r+0x5c>
   12180:	01c12083          	lw	ra,28(sp)
   12184:	00078513          	mv	a0,a5
   12188:	02010113          	addi	sp,sp,32
   1218c:	d4dff06f          	j	11ed8 <__sflush_r>
   12190:	01c12083          	lw	ra,28(sp)
   12194:	00000513          	li	a0,0
   12198:	02010113          	addi	sp,sp,32
   1219c:	00008067          	ret

000121a0 <fflush>:
   121a0:	06050063          	beqz	a0,12200 <fflush+0x60>
   121a4:	00050593          	mv	a1,a0
   121a8:	d5c1a503          	lw	a0,-676(gp) # 13a94 <_impure_ptr>
   121ac:	00050663          	beqz	a0,121b8 <fflush+0x18>
   121b0:	03452783          	lw	a5,52(a0)
   121b4:	00078c63          	beqz	a5,121cc <fflush+0x2c>
   121b8:	00c59783          	lh	a5,12(a1)
   121bc:	00079663          	bnez	a5,121c8 <fflush+0x28>
   121c0:	00000513          	li	a0,0
   121c4:	00008067          	ret
   121c8:	d11ff06f          	j	11ed8 <__sflush_r>
   121cc:	fe010113          	addi	sp,sp,-32
   121d0:	00b12623          	sw	a1,12(sp)
   121d4:	00a12423          	sw	a0,8(sp)
   121d8:	00112e23          	sw	ra,28(sp)
   121dc:	fa4fe0ef          	jal	10980 <__sinit>
   121e0:	00c12583          	lw	a1,12(sp)
   121e4:	00812503          	lw	a0,8(sp)
   121e8:	00c59783          	lh	a5,12(a1)
   121ec:	02079863          	bnez	a5,1221c <fflush+0x7c>
   121f0:	01c12083          	lw	ra,28(sp)
   121f4:	00000513          	li	a0,0
   121f8:	02010113          	addi	sp,sp,32
   121fc:	00008067          	ret
   12200:	00013637          	lui	a2,0x13
   12204:	000125b7          	lui	a1,0x12
   12208:	00013537          	lui	a0,0x13
   1220c:	53860613          	addi	a2,a2,1336 # 13538 <__sglue>
   12210:	13458593          	addi	a1,a1,308 # 12134 <_fflush_r>
   12214:	54850513          	addi	a0,a0,1352 # 13548 <_impure_data>
   12218:	fc4fe06f          	j	109dc <_fwalk_sglue>
   1221c:	01c12083          	lw	ra,28(sp)
   12220:	02010113          	addi	sp,sp,32
   12224:	cb5ff06f          	j	11ed8 <__sflush_r>

00012228 <_sbrk_r>:
   12228:	ff010113          	addi	sp,sp,-16
   1222c:	00812423          	sw	s0,8(sp)
   12230:	00912223          	sw	s1,4(sp)
   12234:	00050493          	mv	s1,a0
   12238:	00058513          	mv	a0,a1
   1223c:	00112623          	sw	ra,12(sp)
   12240:	d601a623          	sw	zero,-660(gp) # 13aa4 <errno>
   12244:	220000ef          	jal	12464 <_sbrk>
   12248:	fff00793          	li	a5,-1
   1224c:	00f50c63          	beq	a0,a5,12264 <_sbrk_r+0x3c>
   12250:	00c12083          	lw	ra,12(sp)
   12254:	00812403          	lw	s0,8(sp)
   12258:	00412483          	lw	s1,4(sp)
   1225c:	01010113          	addi	sp,sp,16
   12260:	00008067          	ret
   12264:	d6c1a783          	lw	a5,-660(gp) # 13aa4 <errno>
   12268:	fe0784e3          	beqz	a5,12250 <_sbrk_r+0x28>
   1226c:	00c12083          	lw	ra,12(sp)
   12270:	00812403          	lw	s0,8(sp)
   12274:	00f4a023          	sw	a5,0(s1)
   12278:	00412483          	lw	s1,4(sp)
   1227c:	01010113          	addi	sp,sp,16
   12280:	00008067          	ret

00012284 <__libc_fini_array>:
   12284:	ff010113          	addi	sp,sp,-16
   12288:	00812423          	sw	s0,8(sp)
   1228c:	000137b7          	lui	a5,0x13
   12290:	00013437          	lui	s0,0x13
   12294:	53478793          	addi	a5,a5,1332 # 13534 <__fini_array_end>
   12298:	53040413          	addi	s0,s0,1328 # 13530 <__do_global_dtors_aux_fini_array_entry>
   1229c:	408787b3          	sub	a5,a5,s0
   122a0:	00912223          	sw	s1,4(sp)
   122a4:	00112623          	sw	ra,12(sp)
   122a8:	4027d493          	srai	s1,a5,0x2
   122ac:	02048063          	beqz	s1,122cc <__libc_fini_array+0x48>
   122b0:	ffc40413          	addi	s0,s0,-4
   122b4:	00f40433          	add	s0,s0,a5
   122b8:	00042783          	lw	a5,0(s0)
   122bc:	fff48493          	addi	s1,s1,-1
   122c0:	ffc40413          	addi	s0,s0,-4
   122c4:	000780e7          	jalr	a5
   122c8:	fe0498e3          	bnez	s1,122b8 <__libc_fini_array+0x34>
   122cc:	00c12083          	lw	ra,12(sp)
   122d0:	00812403          	lw	s0,8(sp)
   122d4:	00412483          	lw	s1,4(sp)
   122d8:	01010113          	addi	sp,sp,16
   122dc:	00008067          	ret

000122e0 <__register_exitproc>:
   122e0:	d701a783          	lw	a5,-656(gp) # 13aa8 <__atexit>
   122e4:	04078c63          	beqz	a5,1233c <__register_exitproc+0x5c>
   122e8:	0047a703          	lw	a4,4(a5)
   122ec:	01f00813          	li	a6,31
   122f0:	06e84e63          	blt	a6,a4,1236c <__register_exitproc+0x8c>
   122f4:	00271813          	slli	a6,a4,0x2
   122f8:	02050663          	beqz	a0,12324 <__register_exitproc+0x44>
   122fc:	01078333          	add	t1,a5,a6
   12300:	08c32423          	sw	a2,136(t1)
   12304:	1887a883          	lw	a7,392(a5)
   12308:	00100613          	li	a2,1
   1230c:	00e61633          	sll	a2,a2,a4
   12310:	00c8e8b3          	or	a7,a7,a2
   12314:	1917a423          	sw	a7,392(a5)
   12318:	10d32423          	sw	a3,264(t1)
   1231c:	00200693          	li	a3,2
   12320:	02d50463          	beq	a0,a3,12348 <__register_exitproc+0x68>
   12324:	00170713          	addi	a4,a4,1
   12328:	00e7a223          	sw	a4,4(a5)
   1232c:	010787b3          	add	a5,a5,a6
   12330:	00b7a423          	sw	a1,8(a5)
   12334:	00000513          	li	a0,0
   12338:	00008067          	ret
   1233c:	f0818793          	addi	a5,gp,-248 # 13c40 <__atexit0>
   12340:	d6f1a823          	sw	a5,-656(gp) # 13aa8 <__atexit>
   12344:	fa5ff06f          	j	122e8 <__register_exitproc+0x8>
   12348:	18c7a683          	lw	a3,396(a5)
   1234c:	00170713          	addi	a4,a4,1
   12350:	00e7a223          	sw	a4,4(a5)
   12354:	00c6e6b3          	or	a3,a3,a2
   12358:	18d7a623          	sw	a3,396(a5)
   1235c:	010787b3          	add	a5,a5,a6
   12360:	00b7a423          	sw	a1,8(a5)
   12364:	00000513          	li	a0,0
   12368:	00008067          	ret
   1236c:	fff00513          	li	a0,-1
   12370:	00008067          	ret

00012374 <_close>:
   12374:	03900893          	li	a7,57
   12378:	00000073          	ecall
   1237c:	00054463          	bltz	a0,12384 <_close+0x10>
   12380:	00008067          	ret
   12384:	fe010113          	addi	sp,sp,-32
   12388:	00112e23          	sw	ra,28(sp)
   1238c:	00a12623          	sw	a0,12(sp)
   12390:	18c000ef          	jal	1251c <__errno>
   12394:	00c12783          	lw	a5,12(sp)
   12398:	01c12083          	lw	ra,28(sp)
   1239c:	40f007b3          	neg	a5,a5
   123a0:	00f52023          	sw	a5,0(a0)
   123a4:	fff00793          	li	a5,-1
   123a8:	00078513          	mv	a0,a5
   123ac:	02010113          	addi	sp,sp,32
   123b0:	00008067          	ret

000123b4 <_exit>:
   123b4:	05d00893          	li	a7,93
   123b8:	00000073          	ecall
   123bc:	00054463          	bltz	a0,123c4 <_exit+0x10>
   123c0:	0000006f          	j	123c0 <_exit+0xc>
   123c4:	fe010113          	addi	sp,sp,-32
   123c8:	00112e23          	sw	ra,28(sp)
   123cc:	00a12623          	sw	a0,12(sp)
   123d0:	14c000ef          	jal	1251c <__errno>
   123d4:	00c12783          	lw	a5,12(sp)
   123d8:	40f007b3          	neg	a5,a5
   123dc:	00f52023          	sw	a5,0(a0)
   123e0:	0000006f          	j	123e0 <_exit+0x2c>

000123e4 <_lseek>:
   123e4:	03e00893          	li	a7,62
   123e8:	00000073          	ecall
   123ec:	00054463          	bltz	a0,123f4 <_lseek+0x10>
   123f0:	00008067          	ret
   123f4:	fe010113          	addi	sp,sp,-32
   123f8:	00112e23          	sw	ra,28(sp)
   123fc:	00a12623          	sw	a0,12(sp)
   12400:	11c000ef          	jal	1251c <__errno>
   12404:	00c12783          	lw	a5,12(sp)
   12408:	01c12083          	lw	ra,28(sp)
   1240c:	40f007b3          	neg	a5,a5
   12410:	00f52023          	sw	a5,0(a0)
   12414:	fff00793          	li	a5,-1
   12418:	00078513          	mv	a0,a5
   1241c:	02010113          	addi	sp,sp,32
   12420:	00008067          	ret

00012424 <_read>:
   12424:	03f00893          	li	a7,63
   12428:	00000073          	ecall
   1242c:	00054463          	bltz	a0,12434 <_read+0x10>
   12430:	00008067          	ret
   12434:	fe010113          	addi	sp,sp,-32
   12438:	00112e23          	sw	ra,28(sp)
   1243c:	00a12623          	sw	a0,12(sp)
   12440:	0dc000ef          	jal	1251c <__errno>
   12444:	00c12783          	lw	a5,12(sp)
   12448:	01c12083          	lw	ra,28(sp)
   1244c:	40f007b3          	neg	a5,a5
   12450:	00f52023          	sw	a5,0(a0)
   12454:	fff00793          	li	a5,-1
   12458:	00078513          	mv	a0,a5
   1245c:	02010113          	addi	sp,sp,32
   12460:	00008067          	ret

00012464 <_sbrk>:
   12464:	d801a783          	lw	a5,-640(gp) # 13ab8 <heap_end.0>
   12468:	ff010113          	addi	sp,sp,-16
   1246c:	00112623          	sw	ra,12(sp)
   12470:	00050713          	mv	a4,a0
   12474:	02079063          	bnez	a5,12494 <_sbrk+0x30>
   12478:	0d600893          	li	a7,214
   1247c:	00000513          	li	a0,0
   12480:	00000073          	ecall
   12484:	fff00793          	li	a5,-1
   12488:	02f50c63          	beq	a0,a5,124c0 <_sbrk+0x5c>
   1248c:	00050793          	mv	a5,a0
   12490:	d8a1a023          	sw	a0,-640(gp) # 13ab8 <heap_end.0>
   12494:	00f70533          	add	a0,a4,a5
   12498:	0d600893          	li	a7,214
   1249c:	00000073          	ecall
   124a0:	d801a783          	lw	a5,-640(gp) # 13ab8 <heap_end.0>
   124a4:	00f70733          	add	a4,a4,a5
   124a8:	00e51c63          	bne	a0,a4,124c0 <_sbrk+0x5c>
   124ac:	00c12083          	lw	ra,12(sp)
   124b0:	d8a1a023          	sw	a0,-640(gp) # 13ab8 <heap_end.0>
   124b4:	00078513          	mv	a0,a5
   124b8:	01010113          	addi	sp,sp,16
   124bc:	00008067          	ret
   124c0:	05c000ef          	jal	1251c <__errno>
   124c4:	00c12083          	lw	ra,12(sp)
   124c8:	00c00793          	li	a5,12
   124cc:	00f52023          	sw	a5,0(a0)
   124d0:	fff00513          	li	a0,-1
   124d4:	01010113          	addi	sp,sp,16
   124d8:	00008067          	ret

000124dc <_write>:
   124dc:	04000893          	li	a7,64
   124e0:	00000073          	ecall
   124e4:	00054463          	bltz	a0,124ec <_write+0x10>
   124e8:	00008067          	ret
   124ec:	fe010113          	addi	sp,sp,-32
   124f0:	00112e23          	sw	ra,28(sp)
   124f4:	00a12623          	sw	a0,12(sp)
   124f8:	024000ef          	jal	1251c <__errno>
   124fc:	00c12783          	lw	a5,12(sp)
   12500:	01c12083          	lw	ra,28(sp)
   12504:	40f007b3          	neg	a5,a5
   12508:	00f52023          	sw	a5,0(a0)
   1250c:	fff00793          	li	a5,-1
   12510:	00078513          	mv	a0,a5
   12514:	02010113          	addi	sp,sp,32
   12518:	00008067          	ret

0001251c <__errno>:
   1251c:	d5c1a503          	lw	a0,-676(gp) # 13a94 <_impure_ptr>
   12520:	00008067          	ret
