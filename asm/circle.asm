
out/circle:     file format elf32-littleriscv


Disassembly of section .text:

000100b4 <exit>:
   100b4:	ff010113          	addi	sp,sp,-16
   100b8:	00000593          	li	a1,0
   100bc:	00812423          	sw	s0,8(sp)
   100c0:	00112623          	sw	ra,12(sp)
   100c4:	00050413          	mv	s0,a0
   100c8:	4b5000ef          	jal	10d7c <__call_exitprocs>
   100cc:	d681a783          	lw	a5,-664(gp) # 13868 <__stdio_exit_handler>
   100d0:	00078463          	beqz	a5,100d8 <exit+0x24>
   100d4:	000780e7          	jalr	a5
   100d8:	00040513          	mv	a0,s0
   100dc:	084020ef          	jal	12160 <_exit>

000100e0 <register_fini>:
   100e0:	00000793          	li	a5,0
   100e4:	00078863          	beqz	a5,100f4 <register_fini+0x14>
   100e8:	00012537          	lui	a0,0x12
   100ec:	03050513          	addi	a0,a0,48 # 12030 <__libc_fini_array>
   100f0:	5dd0006f          	j	10ecc <atexit>
   100f4:	00008067          	ret

000100f8 <_start>:
   100f8:	00004197          	auipc	gp,0x4
   100fc:	a0818193          	addi	gp,gp,-1528 # 13b00 <__global_pointer$>
   10100:	00000513          	li	a0,0
   10104:	00050463          	beqz	a0,1010c <_start+0x14>
   10108:	01751073          	csrw	jvt,a0
   1010c:	00003517          	auipc	a0,0x3
   10110:	75c50513          	addi	a0,a0,1884 # 13868 <__stdio_exit_handler>
   10114:	00004617          	auipc	a2,0x4
   10118:	a7c60613          	addi	a2,a2,-1412 # 13b90 <__BSS_END__>
   1011c:	40a60633          	sub	a2,a2,a0
   10120:	00000593          	li	a1,0
   10124:	37d000ef          	jal	10ca0 <memset>
   10128:	00001517          	auipc	a0,0x1
   1012c:	da450513          	addi	a0,a0,-604 # 10ecc <atexit>
   10130:	00050863          	beqz	a0,10140 <_start+0x48>
   10134:	00002517          	auipc	a0,0x2
   10138:	efc50513          	addi	a0,a0,-260 # 12030 <__libc_fini_array>
   1013c:	591000ef          	jal	10ecc <atexit>
   10140:	2cd000ef          	jal	10c0c <__libc_init_array>
   10144:	00012503          	lw	a0,0(sp)
   10148:	00410593          	addi	a1,sp,4
   1014c:	00251613          	slli	a2,a0,0x2
   10150:	00460613          	addi	a2,a2,4
   10154:	00b60633          	add	a2,a2,a1
   10158:	1c4000ef          	jal	1031c <main>
   1015c:	f59ff06f          	j	100b4 <exit>

00010160 <__do_global_dtors_aux>:
   10160:	ff010113          	addi	sp,sp,-16
   10164:	00812423          	sw	s0,8(sp)
   10168:	d841c783          	lbu	a5,-636(gp) # 13884 <completed.1>
   1016c:	00112623          	sw	ra,12(sp)
   10170:	02079263          	bnez	a5,10194 <__do_global_dtors_aux+0x34>
   10174:	00000793          	li	a5,0
   10178:	00078a63          	beqz	a5,1018c <__do_global_dtors_aux+0x2c>
   1017c:	00012537          	lui	a0,0x12
   10180:	2ec50513          	addi	a0,a0,748 # 122ec <__EH_FRAME_BEGIN__>
   10184:	00000097          	auipc	ra,0x0
   10188:	000000e7          	jalr	zero # 0 <exit-0x100b4>
   1018c:	00100793          	li	a5,1
   10190:	d8f18223          	sb	a5,-636(gp) # 13884 <completed.1>
   10194:	00c12083          	lw	ra,12(sp)
   10198:	00812403          	lw	s0,8(sp)
   1019c:	01010113          	addi	sp,sp,16
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	00000793          	li	a5,0
   101a8:	00078c63          	beqz	a5,101c0 <frame_dummy+0x1c>
   101ac:	00012537          	lui	a0,0x12
   101b0:	d8818593          	addi	a1,gp,-632 # 13888 <object.0>
   101b4:	2ec50513          	addi	a0,a0,748 # 122ec <__EH_FRAME_BEGIN__>
   101b8:	00000317          	auipc	t1,0x0
   101bc:	00000067          	jr	zero # 0 <exit-0x100b4>
   101c0:	00008067          	ret

000101c4 <uart_enable_tx>:
   101c4:	ff010113          	addi	sp,sp,-16
   101c8:	00112623          	sw	ra,12(sp)
   101cc:	00812423          	sw	s0,8(sp)
   101d0:	01010413          	addi	s0,sp,16
   101d4:	100007b7          	lui	a5,0x10000
   101d8:	00878793          	addi	a5,a5,8 # 10000008 <__BSS_END__+0xffec478>
   101dc:	00100713          	li	a4,1
   101e0:	00e7a023          	sw	a4,0(a5)
   101e4:	00000013          	nop
   101e8:	00c12083          	lw	ra,12(sp)
   101ec:	00812403          	lw	s0,8(sp)
   101f0:	01010113          	addi	sp,sp,16
   101f4:	00008067          	ret

000101f8 <uart_putc_u32>:
   101f8:	fe010113          	addi	sp,sp,-32
   101fc:	00112e23          	sw	ra,28(sp)
   10200:	00812c23          	sw	s0,24(sp)
   10204:	02010413          	addi	s0,sp,32
   10208:	fea42623          	sw	a0,-20(s0)
   1020c:	100007b7          	lui	a5,0x10000
   10210:	fec42703          	lw	a4,-20(s0)
   10214:	0ff77713          	zext.b	a4,a4
   10218:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec470>
   1021c:	00000013          	nop
   10220:	01c12083          	lw	ra,28(sp)
   10224:	01812403          	lw	s0,24(sp)
   10228:	02010113          	addi	sp,sp,32
   1022c:	00008067          	ret

00010230 <uart_write>:
   10230:	fd010113          	addi	sp,sp,-48
   10234:	02112623          	sw	ra,44(sp)
   10238:	02812423          	sw	s0,40(sp)
   1023c:	03010413          	addi	s0,sp,48
   10240:	fca42e23          	sw	a0,-36(s0)
   10244:	fcb42c23          	sw	a1,-40(s0)
   10248:	fe042623          	sw	zero,-20(s0)
   1024c:	0280006f          	j	10274 <uart_write+0x44>
   10250:	fdc42703          	lw	a4,-36(s0)
   10254:	fec42783          	lw	a5,-20(s0)
   10258:	00f707b3          	add	a5,a4,a5
   1025c:	0007c783          	lbu	a5,0(a5)
   10260:	00078513          	mv	a0,a5
   10264:	f95ff0ef          	jal	101f8 <uart_putc_u32>
   10268:	fec42783          	lw	a5,-20(s0)
   1026c:	00178793          	addi	a5,a5,1
   10270:	fef42623          	sw	a5,-20(s0)
   10274:	fec42703          	lw	a4,-20(s0)
   10278:	fd842783          	lw	a5,-40(s0)
   1027c:	fcf76ae3          	bltu	a4,a5,10250 <uart_write+0x20>
   10280:	00000013          	nop
   10284:	00000013          	nop
   10288:	02c12083          	lw	ra,44(sp)
   1028c:	02812403          	lw	s0,40(sp)
   10290:	03010113          	addi	sp,sp,48
   10294:	00008067          	ret

00010298 <iabs_i32>:
   10298:	fe010113          	addi	sp,sp,-32
   1029c:	00112e23          	sw	ra,28(sp)
   102a0:	00812c23          	sw	s0,24(sp)
   102a4:	02010413          	addi	s0,sp,32
   102a8:	fea42623          	sw	a0,-20(s0)
   102ac:	fec42783          	lw	a5,-20(s0)
   102b0:	41f7d713          	srai	a4,a5,0x1f
   102b4:	fec42783          	lw	a5,-20(s0)
   102b8:	00f747b3          	xor	a5,a4,a5
   102bc:	40e787b3          	sub	a5,a5,a4
   102c0:	00078513          	mv	a0,a5
   102c4:	01c12083          	lw	ra,28(sp)
   102c8:	01812403          	lw	s0,24(sp)
   102cc:	02010113          	addi	sp,sp,32
   102d0:	00008067          	ret

000102d4 <square_mul>:
   102d4:	fd010113          	addi	sp,sp,-48
   102d8:	02112623          	sw	ra,44(sp)
   102dc:	02812423          	sw	s0,40(sp)
   102e0:	03010413          	addi	s0,sp,48
   102e4:	fca42e23          	sw	a0,-36(s0)
   102e8:	fdc42503          	lw	a0,-36(s0)
   102ec:	fadff0ef          	jal	10298 <iabs_i32>
   102f0:	fea42623          	sw	a0,-20(s0)
   102f4:	fec42783          	lw	a5,-20(s0)
   102f8:	fec42703          	lw	a4,-20(s0)
   102fc:	02e787b3          	mul	a5,a5,a4
   10300:	fef42423          	sw	a5,-24(s0)
   10304:	fe842783          	lw	a5,-24(s0)
   10308:	00078513          	mv	a0,a5
   1030c:	02c12083          	lw	ra,44(sp)
   10310:	02812403          	lw	s0,40(sp)
   10314:	03010113          	addi	sp,sp,48
   10318:	00008067          	ret

0001031c <main>:
   1031c:	fd010113          	addi	sp,sp,-48
   10320:	02112623          	sw	ra,44(sp)
   10324:	02812423          	sw	s0,40(sp)
   10328:	03010413          	addi	s0,sp,48
   1032c:	00600793          	li	a5,6
   10330:	fef42223          	sw	a5,-28(s0)
   10334:	fe442503          	lw	a0,-28(s0)
   10338:	f9dff0ef          	jal	102d4 <square_mul>
   1033c:	fea42023          	sw	a0,-32(s0)
   10340:	e85ff0ef          	jal	101c4 <uart_enable_tx>
   10344:	01900593          	li	a1,25
   10348:	000127b7          	lui	a5,0x12
   1034c:	2d078513          	addi	a0,a5,720 # 122d0 <__errno+0x8>
   10350:	ee1ff0ef          	jal	10230 <uart_write>
   10354:	100007b7          	lui	a5,0x10000
   10358:	00a00713          	li	a4,10
   1035c:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec470>
   10360:	fe442783          	lw	a5,-28(s0)
   10364:	40f007b3          	neg	a5,a5
   10368:	fef42623          	sw	a5,-20(s0)
   1036c:	08c0006f          	j	103f8 <main+0xdc>
   10370:	fec42503          	lw	a0,-20(s0)
   10374:	f61ff0ef          	jal	102d4 <square_mul>
   10378:	fca42e23          	sw	a0,-36(s0)
   1037c:	fe442783          	lw	a5,-28(s0)
   10380:	40f007b3          	neg	a5,a5
   10384:	fef42423          	sw	a5,-24(s0)
   10388:	04c0006f          	j	103d4 <main+0xb8>
   1038c:	fe842503          	lw	a0,-24(s0)
   10390:	f45ff0ef          	jal	102d4 <square_mul>
   10394:	fca42c23          	sw	a0,-40(s0)
   10398:	fd842703          	lw	a4,-40(s0)
   1039c:	fdc42783          	lw	a5,-36(s0)
   103a0:	00f707b3          	add	a5,a4,a5
   103a4:	fe042703          	lw	a4,-32(s0)
   103a8:	00f74a63          	blt	a4,a5,103bc <main+0xa0>
   103ac:	100007b7          	lui	a5,0x10000
   103b0:	02a00713          	li	a4,42
   103b4:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec470>
   103b8:	0100006f          	j	103c8 <main+0xac>
   103bc:	100007b7          	lui	a5,0x10000
   103c0:	02000713          	li	a4,32
   103c4:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec470>
   103c8:	fe842783          	lw	a5,-24(s0)
   103cc:	00178793          	addi	a5,a5,1
   103d0:	fef42423          	sw	a5,-24(s0)
   103d4:	fe842703          	lw	a4,-24(s0)
   103d8:	fe442783          	lw	a5,-28(s0)
   103dc:	fae7d8e3          	bge	a5,a4,1038c <main+0x70>
   103e0:	100007b7          	lui	a5,0x10000
   103e4:	00a00713          	li	a4,10
   103e8:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec470>
   103ec:	fec42783          	lw	a5,-20(s0)
   103f0:	00178793          	addi	a5,a5,1
   103f4:	fef42623          	sw	a5,-20(s0)
   103f8:	fec42703          	lw	a4,-20(s0)
   103fc:	fe442783          	lw	a5,-28(s0)
   10400:	f6e7d8e3          	bge	a5,a4,10370 <main+0x54>
   10404:	00000793          	li	a5,0
   10408:	00078513          	mv	a0,a5
   1040c:	02c12083          	lw	ra,44(sp)
   10410:	02812403          	lw	s0,40(sp)
   10414:	03010113          	addi	sp,sp,48
   10418:	00008067          	ret

0001041c <__fp_lock>:
   1041c:	00000513          	li	a0,0
   10420:	00008067          	ret

00010424 <stdio_exit_handler>:
   10424:	00013637          	lui	a2,0x13
   10428:	000125b7          	lui	a1,0x12
   1042c:	00013537          	lui	a0,0x13
   10430:	30060613          	addi	a2,a2,768 # 13300 <__sglue>
   10434:	b7058593          	addi	a1,a1,-1168 # 11b70 <_fclose_r>
   10438:	31050513          	addi	a0,a0,784 # 13310 <_impure_data>
   1043c:	34c0006f          	j	10788 <_fwalk_sglue>

00010440 <cleanup_stdio>:
   10440:	00452583          	lw	a1,4(a0)
   10444:	ff010113          	addi	sp,sp,-16
   10448:	00812423          	sw	s0,8(sp)
   1044c:	00112623          	sw	ra,12(sp)
   10450:	da018793          	addi	a5,gp,-608 # 138a0 <__sf>
   10454:	00050413          	mv	s0,a0
   10458:	00f58463          	beq	a1,a5,10460 <cleanup_stdio+0x20>
   1045c:	714010ef          	jal	11b70 <_fclose_r>
   10460:	00842583          	lw	a1,8(s0)
   10464:	e0818793          	addi	a5,gp,-504 # 13908 <__sf+0x68>
   10468:	00f58663          	beq	a1,a5,10474 <cleanup_stdio+0x34>
   1046c:	00040513          	mv	a0,s0
   10470:	700010ef          	jal	11b70 <_fclose_r>
   10474:	00c42583          	lw	a1,12(s0)
   10478:	e7018793          	addi	a5,gp,-400 # 13970 <__sf+0xd0>
   1047c:	00f58c63          	beq	a1,a5,10494 <cleanup_stdio+0x54>
   10480:	00040513          	mv	a0,s0
   10484:	00812403          	lw	s0,8(sp)
   10488:	00c12083          	lw	ra,12(sp)
   1048c:	01010113          	addi	sp,sp,16
   10490:	6e00106f          	j	11b70 <_fclose_r>
   10494:	00c12083          	lw	ra,12(sp)
   10498:	00812403          	lw	s0,8(sp)
   1049c:	01010113          	addi	sp,sp,16
   104a0:	00008067          	ret

000104a4 <__fp_unlock>:
   104a4:	00000513          	li	a0,0
   104a8:	00008067          	ret

000104ac <global_stdio_init.part.0>:
   104ac:	fe010113          	addi	sp,sp,-32
   104b0:	000107b7          	lui	a5,0x10
   104b4:	00812c23          	sw	s0,24(sp)
   104b8:	42478793          	addi	a5,a5,1060 # 10424 <stdio_exit_handler>
   104bc:	da018413          	addi	s0,gp,-608 # 138a0 <__sf>
   104c0:	00112e23          	sw	ra,28(sp)
   104c4:	00912a23          	sw	s1,20(sp)
   104c8:	01212823          	sw	s2,16(sp)
   104cc:	01312623          	sw	s3,12(sp)
   104d0:	01412423          	sw	s4,8(sp)
   104d4:	d6f1a423          	sw	a5,-664(gp) # 13868 <__stdio_exit_handler>
   104d8:	00800613          	li	a2,8
   104dc:	00400793          	li	a5,4
   104e0:	00000593          	li	a1,0
   104e4:	dfc18513          	addi	a0,gp,-516 # 138fc <__sf+0x5c>
   104e8:	00f42623          	sw	a5,12(s0)
   104ec:	00042023          	sw	zero,0(s0)
   104f0:	00042223          	sw	zero,4(s0)
   104f4:	00042423          	sw	zero,8(s0)
   104f8:	06042223          	sw	zero,100(s0)
   104fc:	00042823          	sw	zero,16(s0)
   10500:	00042a23          	sw	zero,20(s0)
   10504:	00042c23          	sw	zero,24(s0)
   10508:	798000ef          	jal	10ca0 <memset>
   1050c:	00011a37          	lui	s4,0x11
   10510:	000119b7          	lui	s3,0x11
   10514:	00011937          	lui	s2,0x11
   10518:	000114b7          	lui	s1,0x11
   1051c:	000107b7          	lui	a5,0x10
   10520:	83ca0a13          	addi	s4,s4,-1988 # 1083c <__sread>
   10524:	8a098993          	addi	s3,s3,-1888 # 108a0 <__swrite>
   10528:	92890913          	addi	s2,s2,-1752 # 10928 <__sseek>
   1052c:	98c48493          	addi	s1,s1,-1652 # 1098c <__sclose>
   10530:	00978793          	addi	a5,a5,9 # 10009 <exit-0xab>
   10534:	00800613          	li	a2,8
   10538:	00000593          	li	a1,0
   1053c:	e6418513          	addi	a0,gp,-412 # 13964 <__sf+0xc4>
   10540:	06f42a23          	sw	a5,116(s0)
   10544:	03442023          	sw	s4,32(s0)
   10548:	03342223          	sw	s3,36(s0)
   1054c:	03242423          	sw	s2,40(s0)
   10550:	02942623          	sw	s1,44(s0)
   10554:	00842e23          	sw	s0,28(s0)
   10558:	06042423          	sw	zero,104(s0)
   1055c:	06042623          	sw	zero,108(s0)
   10560:	06042823          	sw	zero,112(s0)
   10564:	0c042623          	sw	zero,204(s0)
   10568:	06042c23          	sw	zero,120(s0)
   1056c:	06042e23          	sw	zero,124(s0)
   10570:	08042023          	sw	zero,128(s0)
   10574:	72c000ef          	jal	10ca0 <memset>
   10578:	000207b7          	lui	a5,0x20
   1057c:	01278793          	addi	a5,a5,18 # 20012 <__BSS_END__+0xc482>
   10580:	e0818713          	addi	a4,gp,-504 # 13908 <__sf+0x68>
   10584:	ecc18513          	addi	a0,gp,-308 # 139cc <__sf+0x12c>
   10588:	00800613          	li	a2,8
   1058c:	00000593          	li	a1,0
   10590:	09442423          	sw	s4,136(s0)
   10594:	09342623          	sw	s3,140(s0)
   10598:	09242823          	sw	s2,144(s0)
   1059c:	08942a23          	sw	s1,148(s0)
   105a0:	0cf42e23          	sw	a5,220(s0)
   105a4:	0c042823          	sw	zero,208(s0)
   105a8:	0c042a23          	sw	zero,212(s0)
   105ac:	0c042c23          	sw	zero,216(s0)
   105b0:	12042a23          	sw	zero,308(s0)
   105b4:	0e042023          	sw	zero,224(s0)
   105b8:	0e042223          	sw	zero,228(s0)
   105bc:	0e042423          	sw	zero,232(s0)
   105c0:	08e42223          	sw	a4,132(s0)
   105c4:	6dc000ef          	jal	10ca0 <memset>
   105c8:	e7018793          	addi	a5,gp,-400 # 13970 <__sf+0xd0>
   105cc:	0f442823          	sw	s4,240(s0)
   105d0:	0f342a23          	sw	s3,244(s0)
   105d4:	0f242c23          	sw	s2,248(s0)
   105d8:	0e942e23          	sw	s1,252(s0)
   105dc:	01c12083          	lw	ra,28(sp)
   105e0:	0ef42623          	sw	a5,236(s0)
   105e4:	01812403          	lw	s0,24(sp)
   105e8:	01412483          	lw	s1,20(sp)
   105ec:	01012903          	lw	s2,16(sp)
   105f0:	00c12983          	lw	s3,12(sp)
   105f4:	00812a03          	lw	s4,8(sp)
   105f8:	02010113          	addi	sp,sp,32
   105fc:	00008067          	ret

00010600 <__sfp>:
   10600:	d681a783          	lw	a5,-664(gp) # 13868 <__stdio_exit_handler>
   10604:	fe010113          	addi	sp,sp,-32
   10608:	00912a23          	sw	s1,20(sp)
   1060c:	00112e23          	sw	ra,28(sp)
   10610:	00812c23          	sw	s0,24(sp)
   10614:	00050493          	mv	s1,a0
   10618:	0e078e63          	beqz	a5,10714 <__sfp+0x114>
   1061c:	00013837          	lui	a6,0x13
   10620:	30080813          	addi	a6,a6,768 # 13300 <__sglue>
   10624:	fff00693          	li	a3,-1
   10628:	00482783          	lw	a5,4(a6)
   1062c:	fff78793          	addi	a5,a5,-1
   10630:	0807c063          	bltz	a5,106b0 <__sfp+0xb0>
   10634:	00882403          	lw	s0,8(a6)
   10638:	00c0006f          	j	10644 <__sfp+0x44>
   1063c:	06840413          	addi	s0,s0,104
   10640:	06d78863          	beq	a5,a3,106b0 <__sfp+0xb0>
   10644:	00c41703          	lh	a4,12(s0)
   10648:	fff78793          	addi	a5,a5,-1
   1064c:	fe0718e3          	bnez	a4,1063c <__sfp+0x3c>
   10650:	ffff07b7          	lui	a5,0xffff0
   10654:	00178793          	addi	a5,a5,1 # ffff0001 <__BSS_END__+0xfffdc471>
   10658:	00f42623          	sw	a5,12(s0)
   1065c:	06042223          	sw	zero,100(s0)
   10660:	00042023          	sw	zero,0(s0)
   10664:	00042423          	sw	zero,8(s0)
   10668:	00042223          	sw	zero,4(s0)
   1066c:	00042823          	sw	zero,16(s0)
   10670:	00042a23          	sw	zero,20(s0)
   10674:	00042c23          	sw	zero,24(s0)
   10678:	00800613          	li	a2,8
   1067c:	00000593          	li	a1,0
   10680:	05c40513          	addi	a0,s0,92
   10684:	61c000ef          	jal	10ca0 <memset>
   10688:	02042823          	sw	zero,48(s0)
   1068c:	02042a23          	sw	zero,52(s0)
   10690:	04042223          	sw	zero,68(s0)
   10694:	04042423          	sw	zero,72(s0)
   10698:	01c12083          	lw	ra,28(sp)
   1069c:	00040513          	mv	a0,s0
   106a0:	01812403          	lw	s0,24(sp)
   106a4:	01412483          	lw	s1,20(sp)
   106a8:	02010113          	addi	sp,sp,32
   106ac:	00008067          	ret
   106b0:	00082403          	lw	s0,0(a6)
   106b4:	00040663          	beqz	s0,106c0 <__sfp+0xc0>
   106b8:	00040813          	mv	a6,s0
   106bc:	f6dff06f          	j	10628 <__sfp+0x28>
   106c0:	1ac00593          	li	a1,428
   106c4:	00048513          	mv	a0,s1
   106c8:	01012623          	sw	a6,12(sp)
   106cc:	421000ef          	jal	112ec <_malloc_r>
   106d0:	00c12803          	lw	a6,12(sp)
   106d4:	00050413          	mv	s0,a0
   106d8:	04050263          	beqz	a0,1071c <__sfp+0x11c>
   106dc:	00400793          	li	a5,4
   106e0:	00f52223          	sw	a5,4(a0)
   106e4:	00c50513          	addi	a0,a0,12
   106e8:	00042023          	sw	zero,0(s0)
   106ec:	00a42423          	sw	a0,8(s0)
   106f0:	1a000613          	li	a2,416
   106f4:	00000593          	li	a1,0
   106f8:	01012623          	sw	a6,12(sp)
   106fc:	5a4000ef          	jal	10ca0 <memset>
   10700:	00c12803          	lw	a6,12(sp)
   10704:	fff00693          	li	a3,-1
   10708:	00882023          	sw	s0,0(a6)
   1070c:	00040813          	mv	a6,s0
   10710:	f19ff06f          	j	10628 <__sfp+0x28>
   10714:	d99ff0ef          	jal	104ac <global_stdio_init.part.0>
   10718:	f05ff06f          	j	1061c <__sfp+0x1c>
   1071c:	00082023          	sw	zero,0(a6)
   10720:	00c00793          	li	a5,12
   10724:	00f4a023          	sw	a5,0(s1)
   10728:	f71ff06f          	j	10698 <__sfp+0x98>

0001072c <__sinit>:
   1072c:	03452783          	lw	a5,52(a0)
   10730:	00078463          	beqz	a5,10738 <__sinit+0xc>
   10734:	00008067          	ret
   10738:	000107b7          	lui	a5,0x10
   1073c:	d681a703          	lw	a4,-664(gp) # 13868 <__stdio_exit_handler>
   10740:	44078793          	addi	a5,a5,1088 # 10440 <cleanup_stdio>
   10744:	02f52a23          	sw	a5,52(a0)
   10748:	fe0716e3          	bnez	a4,10734 <__sinit+0x8>
   1074c:	d61ff06f          	j	104ac <global_stdio_init.part.0>

00010750 <__sfp_lock_acquire>:
   10750:	00008067          	ret

00010754 <__sfp_lock_release>:
   10754:	00008067          	ret

00010758 <__fp_lock_all>:
   10758:	00013637          	lui	a2,0x13
   1075c:	000105b7          	lui	a1,0x10
   10760:	30060613          	addi	a2,a2,768 # 13300 <__sglue>
   10764:	41c58593          	addi	a1,a1,1052 # 1041c <__fp_lock>
   10768:	00000513          	li	a0,0
   1076c:	01c0006f          	j	10788 <_fwalk_sglue>

00010770 <__fp_unlock_all>:
   10770:	00013637          	lui	a2,0x13
   10774:	000105b7          	lui	a1,0x10
   10778:	30060613          	addi	a2,a2,768 # 13300 <__sglue>
   1077c:	4a458593          	addi	a1,a1,1188 # 104a4 <__fp_unlock>
   10780:	00000513          	li	a0,0
   10784:	0040006f          	j	10788 <_fwalk_sglue>

00010788 <_fwalk_sglue>:
   10788:	fd010113          	addi	sp,sp,-48
   1078c:	03212023          	sw	s2,32(sp)
   10790:	01312e23          	sw	s3,28(sp)
   10794:	01412c23          	sw	s4,24(sp)
   10798:	01512a23          	sw	s5,20(sp)
   1079c:	01612823          	sw	s6,16(sp)
   107a0:	01712623          	sw	s7,12(sp)
   107a4:	02112623          	sw	ra,44(sp)
   107a8:	02812423          	sw	s0,40(sp)
   107ac:	02912223          	sw	s1,36(sp)
   107b0:	00060a93          	mv	s5,a2
   107b4:	00050b13          	mv	s6,a0
   107b8:	00058b93          	mv	s7,a1
   107bc:	00000a13          	li	s4,0
   107c0:	00100993          	li	s3,1
   107c4:	fff00913          	li	s2,-1
   107c8:	004aa483          	lw	s1,4(s5)
   107cc:	fff48493          	addi	s1,s1,-1
   107d0:	0204ca63          	bltz	s1,10804 <_fwalk_sglue+0x7c>
   107d4:	008aa403          	lw	s0,8(s5)
   107d8:	00c45783          	lhu	a5,12(s0)
   107dc:	00f9fe63          	bgeu	s3,a5,107f8 <_fwalk_sglue+0x70>
   107e0:	00e41783          	lh	a5,14(s0)
   107e4:	00040593          	mv	a1,s0
   107e8:	000b0513          	mv	a0,s6
   107ec:	01278663          	beq	a5,s2,107f8 <_fwalk_sglue+0x70>
   107f0:	000b80e7          	jalr	s7
   107f4:	00aa6a33          	or	s4,s4,a0
   107f8:	fff48493          	addi	s1,s1,-1
   107fc:	06840413          	addi	s0,s0,104
   10800:	fd249ce3          	bne	s1,s2,107d8 <_fwalk_sglue+0x50>
   10804:	000aaa83          	lw	s5,0(s5)
   10808:	fc0a90e3          	bnez	s5,107c8 <_fwalk_sglue+0x40>
   1080c:	02c12083          	lw	ra,44(sp)
   10810:	02812403          	lw	s0,40(sp)
   10814:	02412483          	lw	s1,36(sp)
   10818:	02012903          	lw	s2,32(sp)
   1081c:	01c12983          	lw	s3,28(sp)
   10820:	01412a83          	lw	s5,20(sp)
   10824:	01012b03          	lw	s6,16(sp)
   10828:	00c12b83          	lw	s7,12(sp)
   1082c:	000a0513          	mv	a0,s4
   10830:	01812a03          	lw	s4,24(sp)
   10834:	03010113          	addi	sp,sp,48
   10838:	00008067          	ret

0001083c <__sread>:
   1083c:	ff010113          	addi	sp,sp,-16
   10840:	00812423          	sw	s0,8(sp)
   10844:	00058413          	mv	s0,a1
   10848:	00e59583          	lh	a1,14(a1)
   1084c:	00112623          	sw	ra,12(sp)
   10850:	2ec000ef          	jal	10b3c <_read_r>
   10854:	02054063          	bltz	a0,10874 <__sread+0x38>
   10858:	05042783          	lw	a5,80(s0)
   1085c:	00c12083          	lw	ra,12(sp)
   10860:	00a787b3          	add	a5,a5,a0
   10864:	04f42823          	sw	a5,80(s0)
   10868:	00812403          	lw	s0,8(sp)
   1086c:	01010113          	addi	sp,sp,16
   10870:	00008067          	ret
   10874:	00c45783          	lhu	a5,12(s0)
   10878:	fffff737          	lui	a4,0xfffff
   1087c:	fff70713          	addi	a4,a4,-1 # ffffefff <__BSS_END__+0xfffeb46f>
   10880:	00e7f7b3          	and	a5,a5,a4
   10884:	00c12083          	lw	ra,12(sp)
   10888:	00f41623          	sh	a5,12(s0)
   1088c:	00812403          	lw	s0,8(sp)
   10890:	01010113          	addi	sp,sp,16
   10894:	00008067          	ret

00010898 <__seofread>:
   10898:	00000513          	li	a0,0
   1089c:	00008067          	ret

000108a0 <__swrite>:
   108a0:	00c59783          	lh	a5,12(a1)
   108a4:	fe010113          	addi	sp,sp,-32
   108a8:	00068313          	mv	t1,a3
   108ac:	00112e23          	sw	ra,28(sp)
   108b0:	1007f693          	andi	a3,a5,256
   108b4:	00058713          	mv	a4,a1
   108b8:	00060893          	mv	a7,a2
   108bc:	00050813          	mv	a6,a0
   108c0:	02069863          	bnez	a3,108f0 <__swrite+0x50>
   108c4:	fffff6b7          	lui	a3,0xfffff
   108c8:	fff68693          	addi	a3,a3,-1 # ffffefff <__BSS_END__+0xfffeb46f>
   108cc:	01c12083          	lw	ra,28(sp)
   108d0:	00d7f7b3          	and	a5,a5,a3
   108d4:	00e71583          	lh	a1,14(a4)
   108d8:	00f71623          	sh	a5,12(a4)
   108dc:	00030693          	mv	a3,t1
   108e0:	00088613          	mv	a2,a7
   108e4:	00080513          	mv	a0,a6
   108e8:	02010113          	addi	sp,sp,32
   108ec:	2b80006f          	j	10ba4 <_write_r>
   108f0:	00e59583          	lh	a1,14(a1)
   108f4:	00c12423          	sw	a2,8(sp)
   108f8:	00200693          	li	a3,2
   108fc:	00000613          	li	a2,0
   10900:	00612623          	sw	t1,12(sp)
   10904:	00e12023          	sw	a4,0(sp)
   10908:	00a12223          	sw	a0,4(sp)
   1090c:	1c8000ef          	jal	10ad4 <_lseek_r>
   10910:	00012703          	lw	a4,0(sp)
   10914:	00c12303          	lw	t1,12(sp)
   10918:	00812883          	lw	a7,8(sp)
   1091c:	00c71783          	lh	a5,12(a4)
   10920:	00412803          	lw	a6,4(sp)
   10924:	fa1ff06f          	j	108c4 <__swrite+0x24>

00010928 <__sseek>:
   10928:	ff010113          	addi	sp,sp,-16
   1092c:	00812423          	sw	s0,8(sp)
   10930:	00058413          	mv	s0,a1
   10934:	00e59583          	lh	a1,14(a1)
   10938:	00112623          	sw	ra,12(sp)
   1093c:	198000ef          	jal	10ad4 <_lseek_r>
   10940:	fff00713          	li	a4,-1
   10944:	00c41783          	lh	a5,12(s0)
   10948:	02e50263          	beq	a0,a4,1096c <__sseek+0x44>
   1094c:	00001737          	lui	a4,0x1
   10950:	00e7e7b3          	or	a5,a5,a4
   10954:	00c12083          	lw	ra,12(sp)
   10958:	04a42823          	sw	a0,80(s0)
   1095c:	00f41623          	sh	a5,12(s0)
   10960:	00812403          	lw	s0,8(sp)
   10964:	01010113          	addi	sp,sp,16
   10968:	00008067          	ret
   1096c:	80050713          	addi	a4,a0,-2048
   10970:	80070713          	addi	a4,a4,-2048 # 800 <exit-0xf8b4>
   10974:	00e7f7b3          	and	a5,a5,a4
   10978:	00c12083          	lw	ra,12(sp)
   1097c:	00f41623          	sh	a5,12(s0)
   10980:	00812403          	lw	s0,8(sp)
   10984:	01010113          	addi	sp,sp,16
   10988:	00008067          	ret

0001098c <__sclose>:
   1098c:	00e59583          	lh	a1,14(a1)
   10990:	0040006f          	j	10994 <_close_r>

00010994 <_close_r>:
   10994:	ff010113          	addi	sp,sp,-16
   10998:	00812423          	sw	s0,8(sp)
   1099c:	00912223          	sw	s1,4(sp)
   109a0:	00050493          	mv	s1,a0
   109a4:	00058513          	mv	a0,a1
   109a8:	00112623          	sw	ra,12(sp)
   109ac:	d601a623          	sw	zero,-660(gp) # 1386c <errno>
   109b0:	770010ef          	jal	12120 <_close>
   109b4:	fff00793          	li	a5,-1
   109b8:	00f50c63          	beq	a0,a5,109d0 <_close_r+0x3c>
   109bc:	00c12083          	lw	ra,12(sp)
   109c0:	00812403          	lw	s0,8(sp)
   109c4:	00412483          	lw	s1,4(sp)
   109c8:	01010113          	addi	sp,sp,16
   109cc:	00008067          	ret
   109d0:	d6c1a783          	lw	a5,-660(gp) # 1386c <errno>
   109d4:	fe0784e3          	beqz	a5,109bc <_close_r+0x28>
   109d8:	00c12083          	lw	ra,12(sp)
   109dc:	00812403          	lw	s0,8(sp)
   109e0:	00f4a023          	sw	a5,0(s1)
   109e4:	00412483          	lw	s1,4(sp)
   109e8:	01010113          	addi	sp,sp,16
   109ec:	00008067          	ret

000109f0 <_reclaim_reent>:
   109f0:	d5c1a783          	lw	a5,-676(gp) # 1385c <_impure_ptr>
   109f4:	0ca78e63          	beq	a5,a0,10ad0 <_reclaim_reent+0xe0>
   109f8:	04452583          	lw	a1,68(a0)
   109fc:	fe010113          	addi	sp,sp,-32
   10a00:	00912a23          	sw	s1,20(sp)
   10a04:	00112e23          	sw	ra,28(sp)
   10a08:	00812c23          	sw	s0,24(sp)
   10a0c:	00050493          	mv	s1,a0
   10a10:	04058863          	beqz	a1,10a60 <_reclaim_reent+0x70>
   10a14:	01212823          	sw	s2,16(sp)
   10a18:	01312623          	sw	s3,12(sp)
   10a1c:	00000913          	li	s2,0
   10a20:	08000993          	li	s3,128
   10a24:	012587b3          	add	a5,a1,s2
   10a28:	0007a403          	lw	s0,0(a5)
   10a2c:	00040e63          	beqz	s0,10a48 <_reclaim_reent+0x58>
   10a30:	00040593          	mv	a1,s0
   10a34:	00042403          	lw	s0,0(s0)
   10a38:	00048513          	mv	a0,s1
   10a3c:	5c8000ef          	jal	11004 <_free_r>
   10a40:	fe0418e3          	bnez	s0,10a30 <_reclaim_reent+0x40>
   10a44:	0444a583          	lw	a1,68(s1)
   10a48:	00490913          	addi	s2,s2,4
   10a4c:	fd391ce3          	bne	s2,s3,10a24 <_reclaim_reent+0x34>
   10a50:	00048513          	mv	a0,s1
   10a54:	5b0000ef          	jal	11004 <_free_r>
   10a58:	01012903          	lw	s2,16(sp)
   10a5c:	00c12983          	lw	s3,12(sp)
   10a60:	0384a583          	lw	a1,56(s1)
   10a64:	00058663          	beqz	a1,10a70 <_reclaim_reent+0x80>
   10a68:	00048513          	mv	a0,s1
   10a6c:	598000ef          	jal	11004 <_free_r>
   10a70:	0404a403          	lw	s0,64(s1)
   10a74:	00040c63          	beqz	s0,10a8c <_reclaim_reent+0x9c>
   10a78:	00040593          	mv	a1,s0
   10a7c:	00042403          	lw	s0,0(s0)
   10a80:	00048513          	mv	a0,s1
   10a84:	580000ef          	jal	11004 <_free_r>
   10a88:	fe0418e3          	bnez	s0,10a78 <_reclaim_reent+0x88>
   10a8c:	04c4a583          	lw	a1,76(s1)
   10a90:	00058663          	beqz	a1,10a9c <_reclaim_reent+0xac>
   10a94:	00048513          	mv	a0,s1
   10a98:	56c000ef          	jal	11004 <_free_r>
   10a9c:	0344a783          	lw	a5,52(s1)
   10aa0:	00078e63          	beqz	a5,10abc <_reclaim_reent+0xcc>
   10aa4:	01812403          	lw	s0,24(sp)
   10aa8:	01c12083          	lw	ra,28(sp)
   10aac:	00048513          	mv	a0,s1
   10ab0:	01412483          	lw	s1,20(sp)
   10ab4:	02010113          	addi	sp,sp,32
   10ab8:	00078067          	jr	a5
   10abc:	01c12083          	lw	ra,28(sp)
   10ac0:	01812403          	lw	s0,24(sp)
   10ac4:	01412483          	lw	s1,20(sp)
   10ac8:	02010113          	addi	sp,sp,32
   10acc:	00008067          	ret
   10ad0:	00008067          	ret

00010ad4 <_lseek_r>:
   10ad4:	ff010113          	addi	sp,sp,-16
   10ad8:	00058793          	mv	a5,a1
   10adc:	00812423          	sw	s0,8(sp)
   10ae0:	00912223          	sw	s1,4(sp)
   10ae4:	00060593          	mv	a1,a2
   10ae8:	00050493          	mv	s1,a0
   10aec:	00068613          	mv	a2,a3
   10af0:	00078513          	mv	a0,a5
   10af4:	00112623          	sw	ra,12(sp)
   10af8:	d601a623          	sw	zero,-660(gp) # 1386c <errno>
   10afc:	694010ef          	jal	12190 <_lseek>
   10b00:	fff00793          	li	a5,-1
   10b04:	00f50c63          	beq	a0,a5,10b1c <_lseek_r+0x48>
   10b08:	00c12083          	lw	ra,12(sp)
   10b0c:	00812403          	lw	s0,8(sp)
   10b10:	00412483          	lw	s1,4(sp)
   10b14:	01010113          	addi	sp,sp,16
   10b18:	00008067          	ret
   10b1c:	d6c1a783          	lw	a5,-660(gp) # 1386c <errno>
   10b20:	fe0784e3          	beqz	a5,10b08 <_lseek_r+0x34>
   10b24:	00c12083          	lw	ra,12(sp)
   10b28:	00812403          	lw	s0,8(sp)
   10b2c:	00f4a023          	sw	a5,0(s1)
   10b30:	00412483          	lw	s1,4(sp)
   10b34:	01010113          	addi	sp,sp,16
   10b38:	00008067          	ret

00010b3c <_read_r>:
   10b3c:	ff010113          	addi	sp,sp,-16
   10b40:	00058793          	mv	a5,a1
   10b44:	00812423          	sw	s0,8(sp)
   10b48:	00912223          	sw	s1,4(sp)
   10b4c:	00060593          	mv	a1,a2
   10b50:	00050493          	mv	s1,a0
   10b54:	00068613          	mv	a2,a3
   10b58:	00078513          	mv	a0,a5
   10b5c:	00112623          	sw	ra,12(sp)
   10b60:	d601a623          	sw	zero,-660(gp) # 1386c <errno>
   10b64:	66c010ef          	jal	121d0 <_read>
   10b68:	fff00793          	li	a5,-1
   10b6c:	00f50c63          	beq	a0,a5,10b84 <_read_r+0x48>
   10b70:	00c12083          	lw	ra,12(sp)
   10b74:	00812403          	lw	s0,8(sp)
   10b78:	00412483          	lw	s1,4(sp)
   10b7c:	01010113          	addi	sp,sp,16
   10b80:	00008067          	ret
   10b84:	d6c1a783          	lw	a5,-660(gp) # 1386c <errno>
   10b88:	fe0784e3          	beqz	a5,10b70 <_read_r+0x34>
   10b8c:	00c12083          	lw	ra,12(sp)
   10b90:	00812403          	lw	s0,8(sp)
   10b94:	00f4a023          	sw	a5,0(s1)
   10b98:	00412483          	lw	s1,4(sp)
   10b9c:	01010113          	addi	sp,sp,16
   10ba0:	00008067          	ret

00010ba4 <_write_r>:
   10ba4:	ff010113          	addi	sp,sp,-16
   10ba8:	00058793          	mv	a5,a1
   10bac:	00812423          	sw	s0,8(sp)
   10bb0:	00912223          	sw	s1,4(sp)
   10bb4:	00060593          	mv	a1,a2
   10bb8:	00050493          	mv	s1,a0
   10bbc:	00068613          	mv	a2,a3
   10bc0:	00078513          	mv	a0,a5
   10bc4:	00112623          	sw	ra,12(sp)
   10bc8:	d601a623          	sw	zero,-660(gp) # 1386c <errno>
   10bcc:	6bc010ef          	jal	12288 <_write>
   10bd0:	fff00793          	li	a5,-1
   10bd4:	00f50c63          	beq	a0,a5,10bec <_write_r+0x48>
   10bd8:	00c12083          	lw	ra,12(sp)
   10bdc:	00812403          	lw	s0,8(sp)
   10be0:	00412483          	lw	s1,4(sp)
   10be4:	01010113          	addi	sp,sp,16
   10be8:	00008067          	ret
   10bec:	d6c1a783          	lw	a5,-660(gp) # 1386c <errno>
   10bf0:	fe0784e3          	beqz	a5,10bd8 <_write_r+0x34>
   10bf4:	00c12083          	lw	ra,12(sp)
   10bf8:	00812403          	lw	s0,8(sp)
   10bfc:	00f4a023          	sw	a5,0(s1)
   10c00:	00412483          	lw	s1,4(sp)
   10c04:	01010113          	addi	sp,sp,16
   10c08:	00008067          	ret

00010c0c <__libc_init_array>:
   10c0c:	ff010113          	addi	sp,sp,-16
   10c10:	00812423          	sw	s0,8(sp)
   10c14:	01212023          	sw	s2,0(sp)
   10c18:	00013437          	lui	s0,0x13
   10c1c:	00013937          	lui	s2,0x13
   10c20:	00112623          	sw	ra,12(sp)
   10c24:	00912223          	sw	s1,4(sp)
   10c28:	2f090913          	addi	s2,s2,752 # 132f0 <__init_array_start>
   10c2c:	2f040413          	addi	s0,s0,752 # 132f0 <__init_array_start>
   10c30:	02890263          	beq	s2,s0,10c54 <__libc_init_array+0x48>
   10c34:	40890933          	sub	s2,s2,s0
   10c38:	40295913          	srai	s2,s2,0x2
   10c3c:	00000493          	li	s1,0
   10c40:	00042783          	lw	a5,0(s0)
   10c44:	00148493          	addi	s1,s1,1
   10c48:	00440413          	addi	s0,s0,4
   10c4c:	000780e7          	jalr	a5
   10c50:	ff24e8e3          	bltu	s1,s2,10c40 <__libc_init_array+0x34>
   10c54:	00013937          	lui	s2,0x13
   10c58:	00013437          	lui	s0,0x13
   10c5c:	2f890913          	addi	s2,s2,760 # 132f8 <__do_global_dtors_aux_fini_array_entry>
   10c60:	2f040413          	addi	s0,s0,752 # 132f0 <__init_array_start>
   10c64:	02890263          	beq	s2,s0,10c88 <__libc_init_array+0x7c>
   10c68:	40890933          	sub	s2,s2,s0
   10c6c:	40295913          	srai	s2,s2,0x2
   10c70:	00000493          	li	s1,0
   10c74:	00042783          	lw	a5,0(s0)
   10c78:	00148493          	addi	s1,s1,1
   10c7c:	00440413          	addi	s0,s0,4
   10c80:	000780e7          	jalr	a5
   10c84:	ff24e8e3          	bltu	s1,s2,10c74 <__libc_init_array+0x68>
   10c88:	00c12083          	lw	ra,12(sp)
   10c8c:	00812403          	lw	s0,8(sp)
   10c90:	00412483          	lw	s1,4(sp)
   10c94:	00012903          	lw	s2,0(sp)
   10c98:	01010113          	addi	sp,sp,16
   10c9c:	00008067          	ret

00010ca0 <memset>:
   10ca0:	00f00313          	li	t1,15
   10ca4:	00050713          	mv	a4,a0
   10ca8:	02c37e63          	bgeu	t1,a2,10ce4 <memset+0x44>
   10cac:	00f77793          	andi	a5,a4,15
   10cb0:	0a079063          	bnez	a5,10d50 <memset+0xb0>
   10cb4:	08059263          	bnez	a1,10d38 <memset+0x98>
   10cb8:	ff067693          	andi	a3,a2,-16
   10cbc:	00f67613          	andi	a2,a2,15
   10cc0:	00e686b3          	add	a3,a3,a4
   10cc4:	00b72023          	sw	a1,0(a4)
   10cc8:	00b72223          	sw	a1,4(a4)
   10ccc:	00b72423          	sw	a1,8(a4)
   10cd0:	00b72623          	sw	a1,12(a4)
   10cd4:	01070713          	addi	a4,a4,16
   10cd8:	fed766e3          	bltu	a4,a3,10cc4 <memset+0x24>
   10cdc:	00061463          	bnez	a2,10ce4 <memset+0x44>
   10ce0:	00008067          	ret
   10ce4:	40c306b3          	sub	a3,t1,a2
   10ce8:	00269693          	slli	a3,a3,0x2
   10cec:	00000297          	auipc	t0,0x0
   10cf0:	005686b3          	add	a3,a3,t0
   10cf4:	00c68067          	jr	12(a3)
   10cf8:	00b70723          	sb	a1,14(a4)
   10cfc:	00b706a3          	sb	a1,13(a4)
   10d00:	00b70623          	sb	a1,12(a4)
   10d04:	00b705a3          	sb	a1,11(a4)
   10d08:	00b70523          	sb	a1,10(a4)
   10d0c:	00b704a3          	sb	a1,9(a4)
   10d10:	00b70423          	sb	a1,8(a4)
   10d14:	00b703a3          	sb	a1,7(a4)
   10d18:	00b70323          	sb	a1,6(a4)
   10d1c:	00b702a3          	sb	a1,5(a4)
   10d20:	00b70223          	sb	a1,4(a4)
   10d24:	00b701a3          	sb	a1,3(a4)
   10d28:	00b70123          	sb	a1,2(a4)
   10d2c:	00b700a3          	sb	a1,1(a4)
   10d30:	00b70023          	sb	a1,0(a4)
   10d34:	00008067          	ret
   10d38:	0ff5f593          	zext.b	a1,a1
   10d3c:	00859693          	slli	a3,a1,0x8
   10d40:	00d5e5b3          	or	a1,a1,a3
   10d44:	01059693          	slli	a3,a1,0x10
   10d48:	00d5e5b3          	or	a1,a1,a3
   10d4c:	f6dff06f          	j	10cb8 <memset+0x18>
   10d50:	00279693          	slli	a3,a5,0x2
   10d54:	00000297          	auipc	t0,0x0
   10d58:	005686b3          	add	a3,a3,t0
   10d5c:	00008293          	mv	t0,ra
   10d60:	fa0680e7          	jalr	-96(a3)
   10d64:	00028093          	mv	ra,t0
   10d68:	ff078793          	addi	a5,a5,-16
   10d6c:	40f70733          	sub	a4,a4,a5
   10d70:	00f60633          	add	a2,a2,a5
   10d74:	f6c378e3          	bgeu	t1,a2,10ce4 <memset+0x44>
   10d78:	f3dff06f          	j	10cb4 <memset+0x14>

00010d7c <__call_exitprocs>:
   10d7c:	fd010113          	addi	sp,sp,-48
   10d80:	01412c23          	sw	s4,24(sp)
   10d84:	03212023          	sw	s2,32(sp)
   10d88:	d701a903          	lw	s2,-656(gp) # 13870 <__atexit>
   10d8c:	02112623          	sw	ra,44(sp)
   10d90:	0a090863          	beqz	s2,10e40 <__call_exitprocs+0xc4>
   10d94:	01312e23          	sw	s3,28(sp)
   10d98:	01512a23          	sw	s5,20(sp)
   10d9c:	01612823          	sw	s6,16(sp)
   10da0:	01712623          	sw	s7,12(sp)
   10da4:	02812423          	sw	s0,40(sp)
   10da8:	02912223          	sw	s1,36(sp)
   10dac:	01812423          	sw	s8,8(sp)
   10db0:	00050b13          	mv	s6,a0
   10db4:	00058b93          	mv	s7,a1
   10db8:	fff00993          	li	s3,-1
   10dbc:	00100a93          	li	s5,1
   10dc0:	00492483          	lw	s1,4(s2)
   10dc4:	fff48413          	addi	s0,s1,-1
   10dc8:	04044e63          	bltz	s0,10e24 <__call_exitprocs+0xa8>
   10dcc:	00249493          	slli	s1,s1,0x2
   10dd0:	009904b3          	add	s1,s2,s1
   10dd4:	080b9063          	bnez	s7,10e54 <__call_exitprocs+0xd8>
   10dd8:	00492783          	lw	a5,4(s2)
   10ddc:	0044a683          	lw	a3,4(s1)
   10de0:	fff78793          	addi	a5,a5,-1
   10de4:	0c878463          	beq	a5,s0,10eac <__call_exitprocs+0x130>
   10de8:	0004a223          	sw	zero,4(s1)
   10dec:	02068663          	beqz	a3,10e18 <__call_exitprocs+0x9c>
   10df0:	18892783          	lw	a5,392(s2)
   10df4:	008a9733          	sll	a4,s5,s0
   10df8:	00492c03          	lw	s8,4(s2)
   10dfc:	00f777b3          	and	a5,a4,a5
   10e00:	06079e63          	bnez	a5,10e7c <__call_exitprocs+0x100>
   10e04:	000680e7          	jalr	a3
   10e08:	00492703          	lw	a4,4(s2)
   10e0c:	d701a783          	lw	a5,-656(gp) # 13870 <__atexit>
   10e10:	09871863          	bne	a4,s8,10ea0 <__call_exitprocs+0x124>
   10e14:	09279663          	bne	a5,s2,10ea0 <__call_exitprocs+0x124>
   10e18:	fff40413          	addi	s0,s0,-1
   10e1c:	ffc48493          	addi	s1,s1,-4
   10e20:	fb341ae3          	bne	s0,s3,10dd4 <__call_exitprocs+0x58>
   10e24:	02812403          	lw	s0,40(sp)
   10e28:	02412483          	lw	s1,36(sp)
   10e2c:	01c12983          	lw	s3,28(sp)
   10e30:	01412a83          	lw	s5,20(sp)
   10e34:	01012b03          	lw	s6,16(sp)
   10e38:	00c12b83          	lw	s7,12(sp)
   10e3c:	00812c03          	lw	s8,8(sp)
   10e40:	02c12083          	lw	ra,44(sp)
   10e44:	02012903          	lw	s2,32(sp)
   10e48:	01812a03          	lw	s4,24(sp)
   10e4c:	03010113          	addi	sp,sp,48
   10e50:	00008067          	ret
   10e54:	1044a783          	lw	a5,260(s1)
   10e58:	fff40713          	addi	a4,s0,-1
   10e5c:	f6fb8ee3          	beq	s7,a5,10dd8 <__call_exitprocs+0x5c>
   10e60:	ffe40413          	addi	s0,s0,-2
   10e64:	fd3700e3          	beq	a4,s3,10e24 <__call_exitprocs+0xa8>
   10e68:	1004a783          	lw	a5,256(s1)
   10e6c:	05778463          	beq	a5,s7,10eb4 <__call_exitprocs+0x138>
   10e70:	ff848493          	addi	s1,s1,-8
   10e74:	ff3410e3          	bne	s0,s3,10e54 <__call_exitprocs+0xd8>
   10e78:	fadff06f          	j	10e24 <__call_exitprocs+0xa8>
   10e7c:	18c92783          	lw	a5,396(s2)
   10e80:	0844a583          	lw	a1,132(s1)
   10e84:	00f77733          	and	a4,a4,a5
   10e88:	02071c63          	bnez	a4,10ec0 <__call_exitprocs+0x144>
   10e8c:	000b0513          	mv	a0,s6
   10e90:	000680e7          	jalr	a3
   10e94:	00492703          	lw	a4,4(s2)
   10e98:	d701a783          	lw	a5,-656(gp) # 13870 <__atexit>
   10e9c:	f7870ce3          	beq	a4,s8,10e14 <__call_exitprocs+0x98>
   10ea0:	f80782e3          	beqz	a5,10e24 <__call_exitprocs+0xa8>
   10ea4:	00078913          	mv	s2,a5
   10ea8:	f19ff06f          	j	10dc0 <__call_exitprocs+0x44>
   10eac:	00892223          	sw	s0,4(s2)
   10eb0:	f3dff06f          	j	10dec <__call_exitprocs+0x70>
   10eb4:	00070413          	mv	s0,a4
   10eb8:	ffc48493          	addi	s1,s1,-4
   10ebc:	f1dff06f          	j	10dd8 <__call_exitprocs+0x5c>
   10ec0:	00058513          	mv	a0,a1
   10ec4:	000680e7          	jalr	a3
   10ec8:	f41ff06f          	j	10e08 <__call_exitprocs+0x8c>

00010ecc <atexit>:
   10ecc:	00050593          	mv	a1,a0
   10ed0:	00000693          	li	a3,0
   10ed4:	00000613          	li	a2,0
   10ed8:	00000513          	li	a0,0
   10edc:	1b00106f          	j	1208c <__register_exitproc>

00010ee0 <_malloc_trim_r>:
   10ee0:	fe010113          	addi	sp,sp,-32
   10ee4:	01212823          	sw	s2,16(sp)
   10ee8:	00013937          	lui	s2,0x13
   10eec:	00812c23          	sw	s0,24(sp)
   10ef0:	00912a23          	sw	s1,20(sp)
   10ef4:	01312623          	sw	s3,12(sp)
   10ef8:	00058413          	mv	s0,a1
   10efc:	00112e23          	sw	ra,28(sp)
   10f00:	00050993          	mv	s3,a0
   10f04:	45090913          	addi	s2,s2,1104 # 13450 <__malloc_av_>
   10f08:	461000ef          	jal	11b68 <__malloc_lock>
   10f0c:	00892783          	lw	a5,8(s2)
   10f10:	00001737          	lui	a4,0x1
   10f14:	0047a483          	lw	s1,4(a5)
   10f18:	ffc4f493          	andi	s1,s1,-4
   10f1c:	7ff48793          	addi	a5,s1,2047
   10f20:	7f078793          	addi	a5,a5,2032
   10f24:	40878433          	sub	s0,a5,s0
   10f28:	00c45413          	srli	s0,s0,0xc
   10f2c:	fff40413          	addi	s0,s0,-1
   10f30:	00c41413          	slli	s0,s0,0xc
   10f34:	00e44e63          	blt	s0,a4,10f50 <_malloc_trim_r+0x70>
   10f38:	00000593          	li	a1,0
   10f3c:	00098513          	mv	a0,s3
   10f40:	094010ef          	jal	11fd4 <_sbrk_r>
   10f44:	00892783          	lw	a5,8(s2)
   10f48:	009787b3          	add	a5,a5,s1
   10f4c:	02f50663          	beq	a0,a5,10f78 <_malloc_trim_r+0x98>
   10f50:	00098513          	mv	a0,s3
   10f54:	419000ef          	jal	11b6c <__malloc_unlock>
   10f58:	01c12083          	lw	ra,28(sp)
   10f5c:	01812403          	lw	s0,24(sp)
   10f60:	01412483          	lw	s1,20(sp)
   10f64:	01012903          	lw	s2,16(sp)
   10f68:	00c12983          	lw	s3,12(sp)
   10f6c:	00000513          	li	a0,0
   10f70:	02010113          	addi	sp,sp,32
   10f74:	00008067          	ret
   10f78:	408005b3          	neg	a1,s0
   10f7c:	00098513          	mv	a0,s3
   10f80:	054010ef          	jal	11fd4 <_sbrk_r>
   10f84:	fff00793          	li	a5,-1
   10f88:	04f50463          	beq	a0,a5,10fd0 <_malloc_trim_r+0xf0>
   10f8c:	00892683          	lw	a3,8(s2)
   10f90:	ed81a783          	lw	a5,-296(gp) # 139d8 <__malloc_current_mallinfo>
   10f94:	408484b3          	sub	s1,s1,s0
   10f98:	0014e493          	ori	s1,s1,1
   10f9c:	00098513          	mv	a0,s3
   10fa0:	408787b3          	sub	a5,a5,s0
   10fa4:	0096a223          	sw	s1,4(a3)
   10fa8:	ecf1ac23          	sw	a5,-296(gp) # 139d8 <__malloc_current_mallinfo>
   10fac:	3c1000ef          	jal	11b6c <__malloc_unlock>
   10fb0:	01c12083          	lw	ra,28(sp)
   10fb4:	01812403          	lw	s0,24(sp)
   10fb8:	01412483          	lw	s1,20(sp)
   10fbc:	01012903          	lw	s2,16(sp)
   10fc0:	00c12983          	lw	s3,12(sp)
   10fc4:	00100513          	li	a0,1
   10fc8:	02010113          	addi	sp,sp,32
   10fcc:	00008067          	ret
   10fd0:	00000593          	li	a1,0
   10fd4:	00098513          	mv	a0,s3
   10fd8:	7fd000ef          	jal	11fd4 <_sbrk_r>
   10fdc:	00892703          	lw	a4,8(s2)
   10fe0:	00f00693          	li	a3,15
   10fe4:	40e507b3          	sub	a5,a0,a4
   10fe8:	f6f6d4e3          	bge	a3,a5,10f50 <_malloc_trim_r+0x70>
   10fec:	d601a603          	lw	a2,-672(gp) # 13860 <__malloc_sbrk_base>
   10ff0:	0017e793          	ori	a5,a5,1
   10ff4:	40c50533          	sub	a0,a0,a2
   10ff8:	00f72223          	sw	a5,4(a4) # 1004 <exit-0xf0b0>
   10ffc:	eca1ac23          	sw	a0,-296(gp) # 139d8 <__malloc_current_mallinfo>
   11000:	f51ff06f          	j	10f50 <_malloc_trim_r+0x70>

00011004 <_free_r>:
   11004:	12058463          	beqz	a1,1112c <_free_r+0x128>
   11008:	fe010113          	addi	sp,sp,-32
   1100c:	00812c23          	sw	s0,24(sp)
   11010:	00b12623          	sw	a1,12(sp)
   11014:	00050413          	mv	s0,a0
   11018:	00112e23          	sw	ra,28(sp)
   1101c:	34d000ef          	jal	11b68 <__malloc_lock>
   11020:	00c12583          	lw	a1,12(sp)
   11024:	00013837          	lui	a6,0x13
   11028:	45080813          	addi	a6,a6,1104 # 13450 <__malloc_av_>
   1102c:	ffc5a503          	lw	a0,-4(a1)
   11030:	ff858713          	addi	a4,a1,-8
   11034:	00882883          	lw	a7,8(a6)
   11038:	ffe57793          	andi	a5,a0,-2
   1103c:	00f70633          	add	a2,a4,a5
   11040:	00462683          	lw	a3,4(a2)
   11044:	00157313          	andi	t1,a0,1
   11048:	ffc6f693          	andi	a3,a3,-4
   1104c:	18c88863          	beq	a7,a2,111dc <_free_r+0x1d8>
   11050:	00d62223          	sw	a3,4(a2)
   11054:	00d608b3          	add	a7,a2,a3
   11058:	0048a883          	lw	a7,4(a7)
   1105c:	0018f893          	andi	a7,a7,1
   11060:	08031a63          	bnez	t1,110f4 <_free_r+0xf0>
   11064:	ff85a303          	lw	t1,-8(a1)
   11068:	000135b7          	lui	a1,0x13
   1106c:	45858593          	addi	a1,a1,1112 # 13458 <__malloc_av_+0x8>
   11070:	40670733          	sub	a4,a4,t1
   11074:	00872503          	lw	a0,8(a4)
   11078:	006787b3          	add	a5,a5,t1
   1107c:	12b50a63          	beq	a0,a1,111b0 <_free_r+0x1ac>
   11080:	00c72303          	lw	t1,12(a4)
   11084:	00652623          	sw	t1,12(a0)
   11088:	00a32423          	sw	a0,8(t1) # 101c0 <frame_dummy+0x1c>
   1108c:	18088c63          	beqz	a7,11224 <_free_r+0x220>
   11090:	0017e693          	ori	a3,a5,1
   11094:	00d72223          	sw	a3,4(a4)
   11098:	00f62023          	sw	a5,0(a2)
   1109c:	1ff00693          	li	a3,511
   110a0:	0af6e263          	bltu	a3,a5,11144 <_free_r+0x140>
   110a4:	ff87f693          	andi	a3,a5,-8
   110a8:	00868693          	addi	a3,a3,8
   110ac:	00482583          	lw	a1,4(a6)
   110b0:	00d806b3          	add	a3,a6,a3
   110b4:	0006a603          	lw	a2,0(a3)
   110b8:	0057d513          	srli	a0,a5,0x5
   110bc:	00100793          	li	a5,1
   110c0:	00a797b3          	sll	a5,a5,a0
   110c4:	00b7e7b3          	or	a5,a5,a1
   110c8:	ff868593          	addi	a1,a3,-8
   110cc:	00c72423          	sw	a2,8(a4)
   110d0:	00b72623          	sw	a1,12(a4)
   110d4:	00f82223          	sw	a5,4(a6)
   110d8:	00e6a023          	sw	a4,0(a3)
   110dc:	00e62623          	sw	a4,12(a2)
   110e0:	00040513          	mv	a0,s0
   110e4:	01812403          	lw	s0,24(sp)
   110e8:	01c12083          	lw	ra,28(sp)
   110ec:	02010113          	addi	sp,sp,32
   110f0:	27d0006f          	j	11b6c <__malloc_unlock>
   110f4:	02089e63          	bnez	a7,11130 <_free_r+0x12c>
   110f8:	000135b7          	lui	a1,0x13
   110fc:	00d787b3          	add	a5,a5,a3
   11100:	45858593          	addi	a1,a1,1112 # 13458 <__malloc_av_+0x8>
   11104:	00862683          	lw	a3,8(a2)
   11108:	0017e893          	ori	a7,a5,1
   1110c:	00f70533          	add	a0,a4,a5
   11110:	16b68063          	beq	a3,a1,11270 <_free_r+0x26c>
   11114:	00c62603          	lw	a2,12(a2)
   11118:	00c6a623          	sw	a2,12(a3)
   1111c:	00d62423          	sw	a3,8(a2)
   11120:	01172223          	sw	a7,4(a4)
   11124:	00f52023          	sw	a5,0(a0)
   11128:	f75ff06f          	j	1109c <_free_r+0x98>
   1112c:	00008067          	ret
   11130:	00156513          	ori	a0,a0,1
   11134:	fea5ae23          	sw	a0,-4(a1)
   11138:	00f62023          	sw	a5,0(a2)
   1113c:	1ff00693          	li	a3,511
   11140:	f6f6f2e3          	bgeu	a3,a5,110a4 <_free_r+0xa0>
   11144:	0097d693          	srli	a3,a5,0x9
   11148:	00400613          	li	a2,4
   1114c:	0ed66063          	bltu	a2,a3,1122c <_free_r+0x228>
   11150:	0067d693          	srli	a3,a5,0x6
   11154:	03968593          	addi	a1,a3,57
   11158:	00359593          	slli	a1,a1,0x3
   1115c:	03868613          	addi	a2,a3,56
   11160:	00b805b3          	add	a1,a6,a1
   11164:	0005a683          	lw	a3,0(a1)
   11168:	ff858593          	addi	a1,a1,-8
   1116c:	00d59863          	bne	a1,a3,1117c <_free_r+0x178>
   11170:	11c0006f          	j	1128c <_free_r+0x288>
   11174:	0086a683          	lw	a3,8(a3)
   11178:	00d58863          	beq	a1,a3,11188 <_free_r+0x184>
   1117c:	0046a603          	lw	a2,4(a3)
   11180:	ffc67613          	andi	a2,a2,-4
   11184:	fec7e8e3          	bltu	a5,a2,11174 <_free_r+0x170>
   11188:	00c6a583          	lw	a1,12(a3)
   1118c:	00b72623          	sw	a1,12(a4)
   11190:	00d72423          	sw	a3,8(a4)
   11194:	00040513          	mv	a0,s0
   11198:	01812403          	lw	s0,24(sp)
   1119c:	01c12083          	lw	ra,28(sp)
   111a0:	00e5a423          	sw	a4,8(a1)
   111a4:	00e6a623          	sw	a4,12(a3)
   111a8:	02010113          	addi	sp,sp,32
   111ac:	1c10006f          	j	11b6c <__malloc_unlock>
   111b0:	0a089063          	bnez	a7,11250 <_free_r+0x24c>
   111b4:	00c62583          	lw	a1,12(a2)
   111b8:	00862603          	lw	a2,8(a2)
   111bc:	00f686b3          	add	a3,a3,a5
   111c0:	0016e793          	ori	a5,a3,1
   111c4:	00b62623          	sw	a1,12(a2)
   111c8:	00c5a423          	sw	a2,8(a1)
   111cc:	00f72223          	sw	a5,4(a4)
   111d0:	00d70733          	add	a4,a4,a3
   111d4:	00d72023          	sw	a3,0(a4)
   111d8:	f09ff06f          	j	110e0 <_free_r+0xdc>
   111dc:	00d786b3          	add	a3,a5,a3
   111e0:	02031063          	bnez	t1,11200 <_free_r+0x1fc>
   111e4:	ff85a783          	lw	a5,-8(a1)
   111e8:	40f70733          	sub	a4,a4,a5
   111ec:	00872603          	lw	a2,8(a4)
   111f0:	00f686b3          	add	a3,a3,a5
   111f4:	00c72783          	lw	a5,12(a4)
   111f8:	00f62623          	sw	a5,12(a2)
   111fc:	00c7a423          	sw	a2,8(a5)
   11200:	0016e613          	ori	a2,a3,1
   11204:	d641a783          	lw	a5,-668(gp) # 13864 <__malloc_trim_threshold>
   11208:	00c72223          	sw	a2,4(a4)
   1120c:	00e82423          	sw	a4,8(a6)
   11210:	ecf6e8e3          	bltu	a3,a5,110e0 <_free_r+0xdc>
   11214:	d7c1a583          	lw	a1,-644(gp) # 1387c <__malloc_top_pad>
   11218:	00040513          	mv	a0,s0
   1121c:	cc5ff0ef          	jal	10ee0 <_malloc_trim_r>
   11220:	ec1ff06f          	j	110e0 <_free_r+0xdc>
   11224:	00d787b3          	add	a5,a5,a3
   11228:	eddff06f          	j	11104 <_free_r+0x100>
   1122c:	01400613          	li	a2,20
   11230:	02d67863          	bgeu	a2,a3,11260 <_free_r+0x25c>
   11234:	05400613          	li	a2,84
   11238:	06d66863          	bltu	a2,a3,112a8 <_free_r+0x2a4>
   1123c:	00c7d693          	srli	a3,a5,0xc
   11240:	06f68593          	addi	a1,a3,111
   11244:	00359593          	slli	a1,a1,0x3
   11248:	06e68613          	addi	a2,a3,110
   1124c:	f15ff06f          	j	11160 <_free_r+0x15c>
   11250:	0017e693          	ori	a3,a5,1
   11254:	00d72223          	sw	a3,4(a4)
   11258:	00f62023          	sw	a5,0(a2)
   1125c:	e85ff06f          	j	110e0 <_free_r+0xdc>
   11260:	05c68593          	addi	a1,a3,92
   11264:	00359593          	slli	a1,a1,0x3
   11268:	05b68613          	addi	a2,a3,91
   1126c:	ef5ff06f          	j	11160 <_free_r+0x15c>
   11270:	00e82a23          	sw	a4,20(a6)
   11274:	00e82823          	sw	a4,16(a6)
   11278:	00b72623          	sw	a1,12(a4)
   1127c:	00b72423          	sw	a1,8(a4)
   11280:	01172223          	sw	a7,4(a4)
   11284:	00f52023          	sw	a5,0(a0)
   11288:	e59ff06f          	j	110e0 <_free_r+0xdc>
   1128c:	00482503          	lw	a0,4(a6)
   11290:	40265613          	srai	a2,a2,0x2
   11294:	00100793          	li	a5,1
   11298:	00c797b3          	sll	a5,a5,a2
   1129c:	00a7e7b3          	or	a5,a5,a0
   112a0:	00f82223          	sw	a5,4(a6)
   112a4:	ee9ff06f          	j	1118c <_free_r+0x188>
   112a8:	15400613          	li	a2,340
   112ac:	00d66c63          	bltu	a2,a3,112c4 <_free_r+0x2c0>
   112b0:	00f7d693          	srli	a3,a5,0xf
   112b4:	07868593          	addi	a1,a3,120
   112b8:	00359593          	slli	a1,a1,0x3
   112bc:	07768613          	addi	a2,a3,119
   112c0:	ea1ff06f          	j	11160 <_free_r+0x15c>
   112c4:	55400613          	li	a2,1364
   112c8:	00d66c63          	bltu	a2,a3,112e0 <_free_r+0x2dc>
   112cc:	0127d693          	srli	a3,a5,0x12
   112d0:	07d68593          	addi	a1,a3,125
   112d4:	00359593          	slli	a1,a1,0x3
   112d8:	07c68613          	addi	a2,a3,124
   112dc:	e85ff06f          	j	11160 <_free_r+0x15c>
   112e0:	3f800593          	li	a1,1016
   112e4:	07e00613          	li	a2,126
   112e8:	e79ff06f          	j	11160 <_free_r+0x15c>

000112ec <_malloc_r>:
   112ec:	fc010113          	addi	sp,sp,-64
   112f0:	02812c23          	sw	s0,56(sp)
   112f4:	02112e23          	sw	ra,60(sp)
   112f8:	00b58793          	addi	a5,a1,11
   112fc:	01600713          	li	a4,22
   11300:	00050413          	mv	s0,a0
   11304:	08f76e63          	bltu	a4,a5,113a0 <_malloc_r+0xb4>
   11308:	01000693          	li	a3,16
   1130c:	06b6ec63          	bltu	a3,a1,11384 <_malloc_r+0x98>
   11310:	059000ef          	jal	11b68 <__malloc_lock>
   11314:	01000693          	li	a3,16
   11318:	01800713          	li	a4,24
   1131c:	00200893          	li	a7,2
   11320:	00013837          	lui	a6,0x13
   11324:	45080813          	addi	a6,a6,1104 # 13450 <__malloc_av_>
   11328:	00e80733          	add	a4,a6,a4
   1132c:	00472783          	lw	a5,4(a4)
   11330:	ff870613          	addi	a2,a4,-8
   11334:	44c78c63          	beq	a5,a2,1178c <_malloc_r+0x4a0>
   11338:	0047a703          	lw	a4,4(a5)
   1133c:	00c7a603          	lw	a2,12(a5)
   11340:	0087a583          	lw	a1,8(a5)
   11344:	ffc77713          	andi	a4,a4,-4
   11348:	00e78733          	add	a4,a5,a4
   1134c:	00472683          	lw	a3,4(a4)
   11350:	00c5a623          	sw	a2,12(a1)
   11354:	00f12623          	sw	a5,12(sp)
   11358:	00b62423          	sw	a1,8(a2)
   1135c:	0016e693          	ori	a3,a3,1
   11360:	00040513          	mv	a0,s0
   11364:	00d72223          	sw	a3,4(a4)
   11368:	005000ef          	jal	11b6c <__malloc_unlock>
   1136c:	00c12783          	lw	a5,12(sp)
   11370:	03c12083          	lw	ra,60(sp)
   11374:	03812403          	lw	s0,56(sp)
   11378:	00878513          	addi	a0,a5,8
   1137c:	04010113          	addi	sp,sp,64
   11380:	00008067          	ret
   11384:	00c00793          	li	a5,12
   11388:	00f42023          	sw	a5,0(s0)
   1138c:	00000513          	li	a0,0
   11390:	03c12083          	lw	ra,60(sp)
   11394:	03812403          	lw	s0,56(sp)
   11398:	04010113          	addi	sp,sp,64
   1139c:	00008067          	ret
   113a0:	ff87f693          	andi	a3,a5,-8
   113a4:	fe07c0e3          	bltz	a5,11384 <_malloc_r+0x98>
   113a8:	fcb6eee3          	bltu	a3,a1,11384 <_malloc_r+0x98>
   113ac:	00d12623          	sw	a3,12(sp)
   113b0:	7b8000ef          	jal	11b68 <__malloc_lock>
   113b4:	00c12683          	lw	a3,12(sp)
   113b8:	1f700793          	li	a5,503
   113bc:	4cd7f663          	bgeu	a5,a3,11888 <_malloc_r+0x59c>
   113c0:	0096d793          	srli	a5,a3,0x9
   113c4:	16078e63          	beqz	a5,11540 <_malloc_r+0x254>
   113c8:	00400713          	li	a4,4
   113cc:	42f76863          	bltu	a4,a5,117fc <_malloc_r+0x510>
   113d0:	0066d793          	srli	a5,a3,0x6
   113d4:	03978893          	addi	a7,a5,57
   113d8:	03878e13          	addi	t3,a5,56
   113dc:	00389513          	slli	a0,a7,0x3
   113e0:	00013837          	lui	a6,0x13
   113e4:	45080813          	addi	a6,a6,1104 # 13450 <__malloc_av_>
   113e8:	00a80533          	add	a0,a6,a0
   113ec:	00452783          	lw	a5,4(a0)
   113f0:	ff850513          	addi	a0,a0,-8
   113f4:	02f50863          	beq	a0,a5,11424 <_malloc_r+0x138>
   113f8:	00f00313          	li	t1,15
   113fc:	0140006f          	j	11410 <_malloc_r+0x124>
   11400:	00c7a583          	lw	a1,12(a5)
   11404:	34065463          	bgez	a2,1174c <_malloc_r+0x460>
   11408:	00b50e63          	beq	a0,a1,11424 <_malloc_r+0x138>
   1140c:	00058793          	mv	a5,a1
   11410:	0047a703          	lw	a4,4(a5)
   11414:	ffc77713          	andi	a4,a4,-4
   11418:	40d70633          	sub	a2,a4,a3
   1141c:	fec352e3          	bge	t1,a2,11400 <_malloc_r+0x114>
   11420:	000e0893          	mv	a7,t3
   11424:	01082783          	lw	a5,16(a6)
   11428:	00013e37          	lui	t3,0x13
   1142c:	458e0e13          	addi	t3,t3,1112 # 13458 <__malloc_av_+0x8>
   11430:	2dc78c63          	beq	a5,t3,11708 <_malloc_r+0x41c>
   11434:	0047a703          	lw	a4,4(a5)
   11438:	00f00593          	li	a1,15
   1143c:	ffc77713          	andi	a4,a4,-4
   11440:	40d70633          	sub	a2,a4,a3
   11444:	46c5cc63          	blt	a1,a2,118bc <_malloc_r+0x5d0>
   11448:	01c82a23          	sw	t3,20(a6)
   1144c:	01c82823          	sw	t3,16(a6)
   11450:	44065263          	bgez	a2,11894 <_malloc_r+0x5a8>
   11454:	1ff00613          	li	a2,511
   11458:	00482303          	lw	t1,4(a6)
   1145c:	34e66063          	bltu	a2,a4,1179c <_malloc_r+0x4b0>
   11460:	ff877613          	andi	a2,a4,-8
   11464:	00860613          	addi	a2,a2,8
   11468:	00c80633          	add	a2,a6,a2
   1146c:	00062583          	lw	a1,0(a2)
   11470:	00575513          	srli	a0,a4,0x5
   11474:	00100713          	li	a4,1
   11478:	00a71733          	sll	a4,a4,a0
   1147c:	00e36333          	or	t1,t1,a4
   11480:	ff860713          	addi	a4,a2,-8
   11484:	00b7a423          	sw	a1,8(a5)
   11488:	00e7a623          	sw	a4,12(a5)
   1148c:	00682223          	sw	t1,4(a6)
   11490:	00f62023          	sw	a5,0(a2)
   11494:	00f5a623          	sw	a5,12(a1)
   11498:	4028d793          	srai	a5,a7,0x2
   1149c:	00100513          	li	a0,1
   114a0:	00f51533          	sll	a0,a0,a5
   114a4:	0aa36663          	bltu	t1,a0,11550 <_malloc_r+0x264>
   114a8:	006577b3          	and	a5,a0,t1
   114ac:	02079463          	bnez	a5,114d4 <_malloc_r+0x1e8>
   114b0:	00151513          	slli	a0,a0,0x1
   114b4:	ffc8f893          	andi	a7,a7,-4
   114b8:	006577b3          	and	a5,a0,t1
   114bc:	00488893          	addi	a7,a7,4
   114c0:	00079a63          	bnez	a5,114d4 <_malloc_r+0x1e8>
   114c4:	00151513          	slli	a0,a0,0x1
   114c8:	006577b3          	and	a5,a0,t1
   114cc:	00488893          	addi	a7,a7,4
   114d0:	fe078ae3          	beqz	a5,114c4 <_malloc_r+0x1d8>
   114d4:	00f00e93          	li	t4,15
   114d8:	00389f13          	slli	t5,a7,0x3
   114dc:	01e80f33          	add	t5,a6,t5
   114e0:	000f0313          	mv	t1,t5
   114e4:	00c32703          	lw	a4,12(t1)
   114e8:	00088f93          	mv	t6,a7
   114ec:	32e30a63          	beq	t1,a4,11820 <_malloc_r+0x534>
   114f0:	00472603          	lw	a2,4(a4)
   114f4:	00070793          	mv	a5,a4
   114f8:	00c72703          	lw	a4,12(a4)
   114fc:	ffc67613          	andi	a2,a2,-4
   11500:	40d605b3          	sub	a1,a2,a3
   11504:	32beca63          	blt	t4,a1,11838 <_malloc_r+0x54c>
   11508:	fe05c2e3          	bltz	a1,114ec <_malloc_r+0x200>
   1150c:	00c78633          	add	a2,a5,a2
   11510:	00462683          	lw	a3,4(a2)
   11514:	0087a583          	lw	a1,8(a5)
   11518:	00040513          	mv	a0,s0
   1151c:	0016e693          	ori	a3,a3,1
   11520:	00d62223          	sw	a3,4(a2)
   11524:	00e5a623          	sw	a4,12(a1)
   11528:	00b72423          	sw	a1,8(a4)
   1152c:	00f12623          	sw	a5,12(sp)
   11530:	63c000ef          	jal	11b6c <__malloc_unlock>
   11534:	00c12783          	lw	a5,12(sp)
   11538:	00878513          	addi	a0,a5,8
   1153c:	e55ff06f          	j	11390 <_malloc_r+0xa4>
   11540:	20000513          	li	a0,512
   11544:	04000893          	li	a7,64
   11548:	03f00e13          	li	t3,63
   1154c:	e95ff06f          	j	113e0 <_malloc_r+0xf4>
   11550:	00882783          	lw	a5,8(a6)
   11554:	0047a703          	lw	a4,4(a5)
   11558:	ffc77313          	andi	t1,a4,-4
   1155c:	40d30633          	sub	a2,t1,a3
   11560:	00d36663          	bltu	t1,a3,1156c <_malloc_r+0x280>
   11564:	01062713          	slti	a4,a2,16
   11568:	1a070463          	beqz	a4,11710 <_malloc_r+0x424>
   1156c:	d7c1a583          	lw	a1,-644(gp) # 1387c <__malloc_top_pad>
   11570:	d601a603          	lw	a2,-672(gp) # 13860 <__malloc_sbrk_base>
   11574:	fff00713          	li	a4,-1
   11578:	00b685b3          	add	a1,a3,a1
   1157c:	42e60463          	beq	a2,a4,119a4 <_malloc_r+0x6b8>
   11580:	00001737          	lui	a4,0x1
   11584:	00f70713          	addi	a4,a4,15 # 100f <exit-0xf0a5>
   11588:	00e585b3          	add	a1,a1,a4
   1158c:	fffff737          	lui	a4,0xfffff
   11590:	00e5f5b3          	and	a1,a1,a4
   11594:	00040513          	mv	a0,s0
   11598:	01012e23          	sw	a6,28(sp)
   1159c:	00f12c23          	sw	a5,24(sp)
   115a0:	00d12a23          	sw	a3,20(sp)
   115a4:	00612823          	sw	t1,16(sp)
   115a8:	00b12623          	sw	a1,12(sp)
   115ac:	229000ef          	jal	11fd4 <_sbrk_r>
   115b0:	fff00713          	li	a4,-1
   115b4:	00c12583          	lw	a1,12(sp)
   115b8:	01012303          	lw	t1,16(sp)
   115bc:	01412683          	lw	a3,20(sp)
   115c0:	01812783          	lw	a5,24(sp)
   115c4:	01c12803          	lw	a6,28(sp)
   115c8:	00050e13          	mv	t3,a0
   115cc:	34e50663          	beq	a0,a4,11918 <_malloc_r+0x62c>
   115d0:	00678733          	add	a4,a5,t1
   115d4:	34e56063          	bltu	a0,a4,11914 <_malloc_r+0x628>
   115d8:	ed818e93          	addi	t4,gp,-296 # 139d8 <__malloc_current_mallinfo>
   115dc:	000ea603          	lw	a2,0(t4)
   115e0:	00c58633          	add	a2,a1,a2
   115e4:	00cea023          	sw	a2,0(t4)
   115e8:	48a70a63          	beq	a4,a0,11a7c <_malloc_r+0x790>
   115ec:	d601af03          	lw	t5,-672(gp) # 13860 <__malloc_sbrk_base>
   115f0:	fff00513          	li	a0,-1
   115f4:	4aaf0263          	beq	t5,a0,11a98 <_malloc_r+0x7ac>
   115f8:	40ee0733          	sub	a4,t3,a4
   115fc:	00c70733          	add	a4,a4,a2
   11600:	00eea023          	sw	a4,0(t4)
   11604:	007e7f13          	andi	t5,t3,7
   11608:	3a0f0e63          	beqz	t5,119c4 <_malloc_r+0x6d8>
   1160c:	ff8e7e13          	andi	t3,t3,-8
   11610:	000018b7          	lui	a7,0x1
   11614:	008e0e13          	addi	t3,t3,8
   11618:	00888893          	addi	a7,a7,8 # 1008 <exit-0xf0ac>
   1161c:	00be0633          	add	a2,t3,a1
   11620:	41e885b3          	sub	a1,a7,t5
   11624:	40c585b3          	sub	a1,a1,a2
   11628:	01459593          	slli	a1,a1,0x14
   1162c:	0145d593          	srli	a1,a1,0x14
   11630:	00040513          	mv	a0,s0
   11634:	03012623          	sw	a6,44(sp)
   11638:	03d12423          	sw	t4,40(sp)
   1163c:	02f12223          	sw	a5,36(sp)
   11640:	02d12023          	sw	a3,32(sp)
   11644:	00612e23          	sw	t1,28(sp)
   11648:	01c12c23          	sw	t3,24(sp)
   1164c:	01e12a23          	sw	t5,20(sp)
   11650:	00c12823          	sw	a2,16(sp)
   11654:	00b12623          	sw	a1,12(sp)
   11658:	17d000ef          	jal	11fd4 <_sbrk_r>
   1165c:	00050713          	mv	a4,a0
   11660:	fff00513          	li	a0,-1
   11664:	00c12583          	lw	a1,12(sp)
   11668:	01012603          	lw	a2,16(sp)
   1166c:	01412f03          	lw	t5,20(sp)
   11670:	01812e03          	lw	t3,24(sp)
   11674:	01c12303          	lw	t1,28(sp)
   11678:	02012683          	lw	a3,32(sp)
   1167c:	02412783          	lw	a5,36(sp)
   11680:	02812e83          	lw	t4,40(sp)
   11684:	02c12803          	lw	a6,44(sp)
   11688:	44a70e63          	beq	a4,a0,11ae4 <_malloc_r+0x7f8>
   1168c:	000ea603          	lw	a2,0(t4)
   11690:	41c70733          	sub	a4,a4,t3
   11694:	00b70733          	add	a4,a4,a1
   11698:	00176713          	ori	a4,a4,1
   1169c:	01c82423          	sw	t3,8(a6)
   116a0:	00c58633          	add	a2,a1,a2
   116a4:	00ee2223          	sw	a4,4(t3)
   116a8:	00cea023          	sw	a2,0(t4)
   116ac:	03078e63          	beq	a5,a6,116e8 <_malloc_r+0x3fc>
   116b0:	00f00513          	li	a0,15
   116b4:	3e657663          	bgeu	a0,t1,11aa0 <_malloc_r+0x7b4>
   116b8:	0047a583          	lw	a1,4(a5)
   116bc:	ff430713          	addi	a4,t1,-12
   116c0:	ff877713          	andi	a4,a4,-8
   116c4:	0015f593          	andi	a1,a1,1
   116c8:	00e5e5b3          	or	a1,a1,a4
   116cc:	00b7a223          	sw	a1,4(a5)
   116d0:	00500893          	li	a7,5
   116d4:	00e785b3          	add	a1,a5,a4
   116d8:	0115a223          	sw	a7,4(a1)
   116dc:	0115a423          	sw	a7,8(a1)
   116e0:	40e56a63          	bltu	a0,a4,11af4 <_malloc_r+0x808>
   116e4:	004e2703          	lw	a4,4(t3)
   116e8:	d781a583          	lw	a1,-648(gp) # 13878 <__malloc_max_sbrked_mem>
   116ec:	00c5f463          	bgeu	a1,a2,116f4 <_malloc_r+0x408>
   116f0:	d6c1ac23          	sw	a2,-648(gp) # 13878 <__malloc_max_sbrked_mem>
   116f4:	d741a583          	lw	a1,-652(gp) # 13874 <__malloc_max_total_mem>
   116f8:	00c5f463          	bgeu	a1,a2,11700 <_malloc_r+0x414>
   116fc:	d6c1aa23          	sw	a2,-652(gp) # 13874 <__malloc_max_total_mem>
   11700:	000e0793          	mv	a5,t3
   11704:	21c0006f          	j	11920 <_malloc_r+0x634>
   11708:	00482303          	lw	t1,4(a6)
   1170c:	d8dff06f          	j	11498 <_malloc_r+0x1ac>
   11710:	0016e713          	ori	a4,a3,1
   11714:	00e7a223          	sw	a4,4(a5)
   11718:	00d786b3          	add	a3,a5,a3
   1171c:	00166613          	ori	a2,a2,1
   11720:	00d82423          	sw	a3,8(a6)
   11724:	00040513          	mv	a0,s0
   11728:	00c6a223          	sw	a2,4(a3)
   1172c:	00f12623          	sw	a5,12(sp)
   11730:	43c000ef          	jal	11b6c <__malloc_unlock>
   11734:	00c12783          	lw	a5,12(sp)
   11738:	03c12083          	lw	ra,60(sp)
   1173c:	03812403          	lw	s0,56(sp)
   11740:	00878513          	addi	a0,a5,8
   11744:	04010113          	addi	sp,sp,64
   11748:	00008067          	ret
   1174c:	0087a603          	lw	a2,8(a5)
   11750:	00e78733          	add	a4,a5,a4
   11754:	00472683          	lw	a3,4(a4) # fffff004 <__BSS_END__+0xfffeb474>
   11758:	00b62623          	sw	a1,12(a2)
   1175c:	00f12623          	sw	a5,12(sp)
   11760:	0016e693          	ori	a3,a3,1
   11764:	00c5a423          	sw	a2,8(a1)
   11768:	00040513          	mv	a0,s0
   1176c:	00d72223          	sw	a3,4(a4)
   11770:	3fc000ef          	jal	11b6c <__malloc_unlock>
   11774:	00c12783          	lw	a5,12(sp)
   11778:	03c12083          	lw	ra,60(sp)
   1177c:	03812403          	lw	s0,56(sp)
   11780:	00878513          	addi	a0,a5,8
   11784:	04010113          	addi	sp,sp,64
   11788:	00008067          	ret
   1178c:	00c72783          	lw	a5,12(a4)
   11790:	00288893          	addi	a7,a7,2
   11794:	c8f708e3          	beq	a4,a5,11424 <_malloc_r+0x138>
   11798:	ba1ff06f          	j	11338 <_malloc_r+0x4c>
   1179c:	00975613          	srli	a2,a4,0x9
   117a0:	00400593          	li	a1,4
   117a4:	14c5fe63          	bgeu	a1,a2,11900 <_malloc_r+0x614>
   117a8:	01400593          	li	a1,20
   117ac:	28c5e263          	bltu	a1,a2,11a30 <_malloc_r+0x744>
   117b0:	05c60513          	addi	a0,a2,92
   117b4:	00351513          	slli	a0,a0,0x3
   117b8:	05b60593          	addi	a1,a2,91
   117bc:	00a80533          	add	a0,a6,a0
   117c0:	00052603          	lw	a2,0(a0)
   117c4:	ff850513          	addi	a0,a0,-8
   117c8:	00c51863          	bne	a0,a2,117d8 <_malloc_r+0x4ec>
   117cc:	1e00006f          	j	119ac <_malloc_r+0x6c0>
   117d0:	00862603          	lw	a2,8(a2)
   117d4:	00c50863          	beq	a0,a2,117e4 <_malloc_r+0x4f8>
   117d8:	00462583          	lw	a1,4(a2)
   117dc:	ffc5f593          	andi	a1,a1,-4
   117e0:	feb768e3          	bltu	a4,a1,117d0 <_malloc_r+0x4e4>
   117e4:	00c62503          	lw	a0,12(a2)
   117e8:	00a7a623          	sw	a0,12(a5)
   117ec:	00c7a423          	sw	a2,8(a5)
   117f0:	00f52423          	sw	a5,8(a0)
   117f4:	00f62623          	sw	a5,12(a2)
   117f8:	ca1ff06f          	j	11498 <_malloc_r+0x1ac>
   117fc:	01400713          	li	a4,20
   11800:	14f77063          	bgeu	a4,a5,11940 <_malloc_r+0x654>
   11804:	05400713          	li	a4,84
   11808:	24f76263          	bltu	a4,a5,11a4c <_malloc_r+0x760>
   1180c:	00c6d793          	srli	a5,a3,0xc
   11810:	06f78893          	addi	a7,a5,111
   11814:	06e78e13          	addi	t3,a5,110
   11818:	00389513          	slli	a0,a7,0x3
   1181c:	bc5ff06f          	j	113e0 <_malloc_r+0xf4>
   11820:	001f8f93          	addi	t6,t6,1
   11824:	003ff793          	andi	a5,t6,3
   11828:	00830313          	addi	t1,t1,8
   1182c:	12078863          	beqz	a5,1195c <_malloc_r+0x670>
   11830:	00c32703          	lw	a4,12(t1)
   11834:	cb9ff06f          	j	114ec <_malloc_r+0x200>
   11838:	0087a503          	lw	a0,8(a5)
   1183c:	0016e893          	ori	a7,a3,1
   11840:	0117a223          	sw	a7,4(a5)
   11844:	00e52623          	sw	a4,12(a0)
   11848:	00a72423          	sw	a0,8(a4)
   1184c:	00d786b3          	add	a3,a5,a3
   11850:	00d82a23          	sw	a3,20(a6)
   11854:	00d82823          	sw	a3,16(a6)
   11858:	0015e713          	ori	a4,a1,1
   1185c:	00c78633          	add	a2,a5,a2
   11860:	01c6a623          	sw	t3,12(a3)
   11864:	01c6a423          	sw	t3,8(a3)
   11868:	00e6a223          	sw	a4,4(a3)
   1186c:	00040513          	mv	a0,s0
   11870:	00b62023          	sw	a1,0(a2)
   11874:	00f12623          	sw	a5,12(sp)
   11878:	2f4000ef          	jal	11b6c <__malloc_unlock>
   1187c:	00c12783          	lw	a5,12(sp)
   11880:	00878513          	addi	a0,a5,8
   11884:	b0dff06f          	j	11390 <_malloc_r+0xa4>
   11888:	0036d893          	srli	a7,a3,0x3
   1188c:	00868713          	addi	a4,a3,8
   11890:	a91ff06f          	j	11320 <_malloc_r+0x34>
   11894:	00e78733          	add	a4,a5,a4
   11898:	00472683          	lw	a3,4(a4)
   1189c:	00f12623          	sw	a5,12(sp)
   118a0:	00040513          	mv	a0,s0
   118a4:	0016e693          	ori	a3,a3,1
   118a8:	00d72223          	sw	a3,4(a4)
   118ac:	2c0000ef          	jal	11b6c <__malloc_unlock>
   118b0:	00c12783          	lw	a5,12(sp)
   118b4:	00878513          	addi	a0,a5,8
   118b8:	ad9ff06f          	j	11390 <_malloc_r+0xa4>
   118bc:	0016e593          	ori	a1,a3,1
   118c0:	00b7a223          	sw	a1,4(a5)
   118c4:	00d786b3          	add	a3,a5,a3
   118c8:	00d82a23          	sw	a3,20(a6)
   118cc:	00d82823          	sw	a3,16(a6)
   118d0:	00166593          	ori	a1,a2,1
   118d4:	00e78733          	add	a4,a5,a4
   118d8:	01c6a623          	sw	t3,12(a3)
   118dc:	01c6a423          	sw	t3,8(a3)
   118e0:	00b6a223          	sw	a1,4(a3)
   118e4:	00040513          	mv	a0,s0
   118e8:	00c72023          	sw	a2,0(a4)
   118ec:	00f12623          	sw	a5,12(sp)
   118f0:	27c000ef          	jal	11b6c <__malloc_unlock>
   118f4:	00c12783          	lw	a5,12(sp)
   118f8:	00878513          	addi	a0,a5,8
   118fc:	a95ff06f          	j	11390 <_malloc_r+0xa4>
   11900:	00675613          	srli	a2,a4,0x6
   11904:	03960513          	addi	a0,a2,57
   11908:	00351513          	slli	a0,a0,0x3
   1190c:	03860593          	addi	a1,a2,56
   11910:	eadff06f          	j	117bc <_malloc_r+0x4d0>
   11914:	15078a63          	beq	a5,a6,11a68 <_malloc_r+0x77c>
   11918:	00882783          	lw	a5,8(a6)
   1191c:	0047a703          	lw	a4,4(a5)
   11920:	ffc77713          	andi	a4,a4,-4
   11924:	40d70633          	sub	a2,a4,a3
   11928:	00d76663          	bltu	a4,a3,11934 <_malloc_r+0x648>
   1192c:	01062713          	slti	a4,a2,16
   11930:	de0700e3          	beqz	a4,11710 <_malloc_r+0x424>
   11934:	00040513          	mv	a0,s0
   11938:	234000ef          	jal	11b6c <__malloc_unlock>
   1193c:	a51ff06f          	j	1138c <_malloc_r+0xa0>
   11940:	05c78893          	addi	a7,a5,92
   11944:	05b78e13          	addi	t3,a5,91
   11948:	00389513          	slli	a0,a7,0x3
   1194c:	a95ff06f          	j	113e0 <_malloc_r+0xf4>
   11950:	008f2783          	lw	a5,8(t5)
   11954:	fff88893          	addi	a7,a7,-1
   11958:	21e79463          	bne	a5,t5,11b60 <_malloc_r+0x874>
   1195c:	0038f793          	andi	a5,a7,3
   11960:	ff8f0f13          	addi	t5,t5,-8
   11964:	fe0796e3          	bnez	a5,11950 <_malloc_r+0x664>
   11968:	00482703          	lw	a4,4(a6)
   1196c:	fff54793          	not	a5,a0
   11970:	00e7f7b3          	and	a5,a5,a4
   11974:	00f82223          	sw	a5,4(a6)
   11978:	00151513          	slli	a0,a0,0x1
   1197c:	fff50713          	addi	a4,a0,-1
   11980:	bcf778e3          	bgeu	a4,a5,11550 <_malloc_r+0x264>
   11984:	00f57733          	and	a4,a0,a5
   11988:	00071a63          	bnez	a4,1199c <_malloc_r+0x6b0>
   1198c:	00151513          	slli	a0,a0,0x1
   11990:	00f57733          	and	a4,a0,a5
   11994:	004f8f93          	addi	t6,t6,4
   11998:	fe070ae3          	beqz	a4,1198c <_malloc_r+0x6a0>
   1199c:	000f8893          	mv	a7,t6
   119a0:	b39ff06f          	j	114d8 <_malloc_r+0x1ec>
   119a4:	01058593          	addi	a1,a1,16
   119a8:	bedff06f          	j	11594 <_malloc_r+0x2a8>
   119ac:	4025d593          	srai	a1,a1,0x2
   119b0:	00100713          	li	a4,1
   119b4:	00b71733          	sll	a4,a4,a1
   119b8:	00e36333          	or	t1,t1,a4
   119bc:	00682223          	sw	t1,4(a6)
   119c0:	e29ff06f          	j	117e8 <_malloc_r+0x4fc>
   119c4:	00be0633          	add	a2,t3,a1
   119c8:	40c005b3          	neg	a1,a2
   119cc:	01459593          	slli	a1,a1,0x14
   119d0:	0145d593          	srli	a1,a1,0x14
   119d4:	00040513          	mv	a0,s0
   119d8:	03012423          	sw	a6,40(sp)
   119dc:	03d12223          	sw	t4,36(sp)
   119e0:	02f12023          	sw	a5,32(sp)
   119e4:	00d12e23          	sw	a3,28(sp)
   119e8:	00612c23          	sw	t1,24(sp)
   119ec:	01c12a23          	sw	t3,20(sp)
   119f0:	00b12623          	sw	a1,12(sp)
   119f4:	00c12823          	sw	a2,16(sp)
   119f8:	5dc000ef          	jal	11fd4 <_sbrk_r>
   119fc:	00050713          	mv	a4,a0
   11a00:	fff00513          	li	a0,-1
   11a04:	00c12583          	lw	a1,12(sp)
   11a08:	01412e03          	lw	t3,20(sp)
   11a0c:	01812303          	lw	t1,24(sp)
   11a10:	01c12683          	lw	a3,28(sp)
   11a14:	02012783          	lw	a5,32(sp)
   11a18:	02412e83          	lw	t4,36(sp)
   11a1c:	02812803          	lw	a6,40(sp)
   11a20:	c6a716e3          	bne	a4,a0,1168c <_malloc_r+0x3a0>
   11a24:	01012703          	lw	a4,16(sp)
   11a28:	00000593          	li	a1,0
   11a2c:	c61ff06f          	j	1168c <_malloc_r+0x3a0>
   11a30:	05400593          	li	a1,84
   11a34:	06c5ec63          	bltu	a1,a2,11aac <_malloc_r+0x7c0>
   11a38:	00c75613          	srli	a2,a4,0xc
   11a3c:	06f60513          	addi	a0,a2,111
   11a40:	00351513          	slli	a0,a0,0x3
   11a44:	06e60593          	addi	a1,a2,110
   11a48:	d75ff06f          	j	117bc <_malloc_r+0x4d0>
   11a4c:	15400713          	li	a4,340
   11a50:	06f76c63          	bltu	a4,a5,11ac8 <_malloc_r+0x7dc>
   11a54:	00f6d793          	srli	a5,a3,0xf
   11a58:	07878893          	addi	a7,a5,120
   11a5c:	07778e13          	addi	t3,a5,119
   11a60:	00389513          	slli	a0,a7,0x3
   11a64:	97dff06f          	j	113e0 <_malloc_r+0xf4>
   11a68:	ed818e93          	addi	t4,gp,-296 # 139d8 <__malloc_current_mallinfo>
   11a6c:	000ea603          	lw	a2,0(t4)
   11a70:	00c58633          	add	a2,a1,a2
   11a74:	00cea023          	sw	a2,0(t4)
   11a78:	b75ff06f          	j	115ec <_malloc_r+0x300>
   11a7c:	01451513          	slli	a0,a0,0x14
   11a80:	b60516e3          	bnez	a0,115ec <_malloc_r+0x300>
   11a84:	00882e03          	lw	t3,8(a6)
   11a88:	00b305b3          	add	a1,t1,a1
   11a8c:	0015e713          	ori	a4,a1,1
   11a90:	00ee2223          	sw	a4,4(t3)
   11a94:	c55ff06f          	j	116e8 <_malloc_r+0x3fc>
   11a98:	d7c1a023          	sw	t3,-672(gp) # 13860 <__malloc_sbrk_base>
   11a9c:	b69ff06f          	j	11604 <_malloc_r+0x318>
   11aa0:	00100793          	li	a5,1
   11aa4:	00fe2223          	sw	a5,4(t3)
   11aa8:	e8dff06f          	j	11934 <_malloc_r+0x648>
   11aac:	15400593          	li	a1,340
   11ab0:	06c5ec63          	bltu	a1,a2,11b28 <_malloc_r+0x83c>
   11ab4:	00f75613          	srli	a2,a4,0xf
   11ab8:	07860513          	addi	a0,a2,120
   11abc:	00351513          	slli	a0,a0,0x3
   11ac0:	07760593          	addi	a1,a2,119
   11ac4:	cf9ff06f          	j	117bc <_malloc_r+0x4d0>
   11ac8:	55400713          	li	a4,1364
   11acc:	06f76c63          	bltu	a4,a5,11b44 <_malloc_r+0x858>
   11ad0:	0126d793          	srli	a5,a3,0x12
   11ad4:	07d78893          	addi	a7,a5,125
   11ad8:	07c78e13          	addi	t3,a5,124
   11adc:	00389513          	slli	a0,a7,0x3
   11ae0:	901ff06f          	j	113e0 <_malloc_r+0xf4>
   11ae4:	ff8f0f13          	addi	t5,t5,-8
   11ae8:	01e60733          	add	a4,a2,t5
   11aec:	00000593          	li	a1,0
   11af0:	b9dff06f          	j	1168c <_malloc_r+0x3a0>
   11af4:	00878593          	addi	a1,a5,8
   11af8:	00040513          	mv	a0,s0
   11afc:	01012a23          	sw	a6,20(sp)
   11b00:	01d12823          	sw	t4,16(sp)
   11b04:	00d12623          	sw	a3,12(sp)
   11b08:	cfcff0ef          	jal	11004 <_free_r>
   11b0c:	01412803          	lw	a6,20(sp)
   11b10:	01012e83          	lw	t4,16(sp)
   11b14:	00c12683          	lw	a3,12(sp)
   11b18:	00882e03          	lw	t3,8(a6)
   11b1c:	000ea603          	lw	a2,0(t4)
   11b20:	004e2703          	lw	a4,4(t3)
   11b24:	bc5ff06f          	j	116e8 <_malloc_r+0x3fc>
   11b28:	55400593          	li	a1,1364
   11b2c:	02c5e463          	bltu	a1,a2,11b54 <_malloc_r+0x868>
   11b30:	01275613          	srli	a2,a4,0x12
   11b34:	07d60513          	addi	a0,a2,125
   11b38:	00351513          	slli	a0,a0,0x3
   11b3c:	07c60593          	addi	a1,a2,124
   11b40:	c7dff06f          	j	117bc <_malloc_r+0x4d0>
   11b44:	3f800513          	li	a0,1016
   11b48:	07f00893          	li	a7,127
   11b4c:	07e00e13          	li	t3,126
   11b50:	891ff06f          	j	113e0 <_malloc_r+0xf4>
   11b54:	3f800513          	li	a0,1016
   11b58:	07e00593          	li	a1,126
   11b5c:	c61ff06f          	j	117bc <_malloc_r+0x4d0>
   11b60:	00482783          	lw	a5,4(a6)
   11b64:	e15ff06f          	j	11978 <_malloc_r+0x68c>

00011b68 <__malloc_lock>:
   11b68:	00008067          	ret

00011b6c <__malloc_unlock>:
   11b6c:	00008067          	ret

00011b70 <_fclose_r>:
   11b70:	ff010113          	addi	sp,sp,-16
   11b74:	00112623          	sw	ra,12(sp)
   11b78:	01212023          	sw	s2,0(sp)
   11b7c:	02058863          	beqz	a1,11bac <_fclose_r+0x3c>
   11b80:	00812423          	sw	s0,8(sp)
   11b84:	00912223          	sw	s1,4(sp)
   11b88:	00058413          	mv	s0,a1
   11b8c:	00050493          	mv	s1,a0
   11b90:	00050663          	beqz	a0,11b9c <_fclose_r+0x2c>
   11b94:	03452783          	lw	a5,52(a0)
   11b98:	0c078c63          	beqz	a5,11c70 <_fclose_r+0x100>
   11b9c:	00c41783          	lh	a5,12(s0)
   11ba0:	02079263          	bnez	a5,11bc4 <_fclose_r+0x54>
   11ba4:	00812403          	lw	s0,8(sp)
   11ba8:	00412483          	lw	s1,4(sp)
   11bac:	00c12083          	lw	ra,12(sp)
   11bb0:	00000913          	li	s2,0
   11bb4:	00090513          	mv	a0,s2
   11bb8:	00012903          	lw	s2,0(sp)
   11bbc:	01010113          	addi	sp,sp,16
   11bc0:	00008067          	ret
   11bc4:	00040593          	mv	a1,s0
   11bc8:	00048513          	mv	a0,s1
   11bcc:	0b8000ef          	jal	11c84 <__sflush_r>
   11bd0:	02c42783          	lw	a5,44(s0)
   11bd4:	00050913          	mv	s2,a0
   11bd8:	00078a63          	beqz	a5,11bec <_fclose_r+0x7c>
   11bdc:	01c42583          	lw	a1,28(s0)
   11be0:	00048513          	mv	a0,s1
   11be4:	000780e7          	jalr	a5
   11be8:	06054463          	bltz	a0,11c50 <_fclose_r+0xe0>
   11bec:	00c45783          	lhu	a5,12(s0)
   11bf0:	0807f793          	andi	a5,a5,128
   11bf4:	06079663          	bnez	a5,11c60 <_fclose_r+0xf0>
   11bf8:	03042583          	lw	a1,48(s0)
   11bfc:	00058c63          	beqz	a1,11c14 <_fclose_r+0xa4>
   11c00:	04040793          	addi	a5,s0,64
   11c04:	00f58663          	beq	a1,a5,11c10 <_fclose_r+0xa0>
   11c08:	00048513          	mv	a0,s1
   11c0c:	bf8ff0ef          	jal	11004 <_free_r>
   11c10:	02042823          	sw	zero,48(s0)
   11c14:	04442583          	lw	a1,68(s0)
   11c18:	00058863          	beqz	a1,11c28 <_fclose_r+0xb8>
   11c1c:	00048513          	mv	a0,s1
   11c20:	be4ff0ef          	jal	11004 <_free_r>
   11c24:	04042223          	sw	zero,68(s0)
   11c28:	b29fe0ef          	jal	10750 <__sfp_lock_acquire>
   11c2c:	00041623          	sh	zero,12(s0)
   11c30:	b25fe0ef          	jal	10754 <__sfp_lock_release>
   11c34:	00c12083          	lw	ra,12(sp)
   11c38:	00812403          	lw	s0,8(sp)
   11c3c:	00412483          	lw	s1,4(sp)
   11c40:	00090513          	mv	a0,s2
   11c44:	00012903          	lw	s2,0(sp)
   11c48:	01010113          	addi	sp,sp,16
   11c4c:	00008067          	ret
   11c50:	00c45783          	lhu	a5,12(s0)
   11c54:	fff00913          	li	s2,-1
   11c58:	0807f793          	andi	a5,a5,128
   11c5c:	f8078ee3          	beqz	a5,11bf8 <_fclose_r+0x88>
   11c60:	01042583          	lw	a1,16(s0)
   11c64:	00048513          	mv	a0,s1
   11c68:	b9cff0ef          	jal	11004 <_free_r>
   11c6c:	f8dff06f          	j	11bf8 <_fclose_r+0x88>
   11c70:	abdfe0ef          	jal	1072c <__sinit>
   11c74:	f29ff06f          	j	11b9c <_fclose_r+0x2c>

00011c78 <fclose>:
   11c78:	00050593          	mv	a1,a0
   11c7c:	d5c1a503          	lw	a0,-676(gp) # 1385c <_impure_ptr>
   11c80:	ef1ff06f          	j	11b70 <_fclose_r>

00011c84 <__sflush_r>:
   11c84:	00c59703          	lh	a4,12(a1)
   11c88:	fe010113          	addi	sp,sp,-32
   11c8c:	00812c23          	sw	s0,24(sp)
   11c90:	01312623          	sw	s3,12(sp)
   11c94:	00112e23          	sw	ra,28(sp)
   11c98:	00877793          	andi	a5,a4,8
   11c9c:	00058413          	mv	s0,a1
   11ca0:	00050993          	mv	s3,a0
   11ca4:	12079263          	bnez	a5,11dc8 <__sflush_r+0x144>
   11ca8:	000017b7          	lui	a5,0x1
   11cac:	80078793          	addi	a5,a5,-2048 # 800 <exit-0xf8b4>
   11cb0:	0045a683          	lw	a3,4(a1)
   11cb4:	00f767b3          	or	a5,a4,a5
   11cb8:	00f59623          	sh	a5,12(a1)
   11cbc:	18d05c63          	blez	a3,11e54 <__sflush_r+0x1d0>
   11cc0:	02842803          	lw	a6,40(s0)
   11cc4:	0e080663          	beqz	a6,11db0 <__sflush_r+0x12c>
   11cc8:	00912a23          	sw	s1,20(sp)
   11ccc:	01371693          	slli	a3,a4,0x13
   11cd0:	0009a483          	lw	s1,0(s3)
   11cd4:	0009a023          	sw	zero,0(s3)
   11cd8:	1806ca63          	bltz	a3,11e6c <__sflush_r+0x1e8>
   11cdc:	01c42583          	lw	a1,28(s0)
   11ce0:	00000613          	li	a2,0
   11ce4:	00100693          	li	a3,1
   11ce8:	00098513          	mv	a0,s3
   11cec:	000800e7          	jalr	a6
   11cf0:	fff00793          	li	a5,-1
   11cf4:	00050613          	mv	a2,a0
   11cf8:	1af50c63          	beq	a0,a5,11eb0 <__sflush_r+0x22c>
   11cfc:	00c41783          	lh	a5,12(s0)
   11d00:	02842803          	lw	a6,40(s0)
   11d04:	0047f793          	andi	a5,a5,4
   11d08:	00078e63          	beqz	a5,11d24 <__sflush_r+0xa0>
   11d0c:	00442703          	lw	a4,4(s0)
   11d10:	03042783          	lw	a5,48(s0)
   11d14:	40e60633          	sub	a2,a2,a4
   11d18:	00078663          	beqz	a5,11d24 <__sflush_r+0xa0>
   11d1c:	03c42783          	lw	a5,60(s0)
   11d20:	40f60633          	sub	a2,a2,a5
   11d24:	01c42583          	lw	a1,28(s0)
   11d28:	00000693          	li	a3,0
   11d2c:	00098513          	mv	a0,s3
   11d30:	000800e7          	jalr	a6
   11d34:	fff00713          	li	a4,-1
   11d38:	00c41783          	lh	a5,12(s0)
   11d3c:	12e51c63          	bne	a0,a4,11e74 <__sflush_r+0x1f0>
   11d40:	0009a683          	lw	a3,0(s3)
   11d44:	01d00713          	li	a4,29
   11d48:	18d76263          	bltu	a4,a3,11ecc <__sflush_r+0x248>
   11d4c:	20400737          	lui	a4,0x20400
   11d50:	00170713          	addi	a4,a4,1 # 20400001 <__BSS_END__+0x203ec471>
   11d54:	00d75733          	srl	a4,a4,a3
   11d58:	00177713          	andi	a4,a4,1
   11d5c:	16070863          	beqz	a4,11ecc <__sflush_r+0x248>
   11d60:	01042683          	lw	a3,16(s0)
   11d64:	fffff737          	lui	a4,0xfffff
   11d68:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebc6f>
   11d6c:	00e7f733          	and	a4,a5,a4
   11d70:	00e41623          	sh	a4,12(s0)
   11d74:	00042223          	sw	zero,4(s0)
   11d78:	00d42023          	sw	a3,0(s0)
   11d7c:	01379713          	slli	a4,a5,0x13
   11d80:	00075663          	bgez	a4,11d8c <__sflush_r+0x108>
   11d84:	0009a783          	lw	a5,0(s3)
   11d88:	10078863          	beqz	a5,11e98 <__sflush_r+0x214>
   11d8c:	03042583          	lw	a1,48(s0)
   11d90:	0099a023          	sw	s1,0(s3)
   11d94:	10058a63          	beqz	a1,11ea8 <__sflush_r+0x224>
   11d98:	04040793          	addi	a5,s0,64
   11d9c:	00f58663          	beq	a1,a5,11da8 <__sflush_r+0x124>
   11da0:	00098513          	mv	a0,s3
   11da4:	a60ff0ef          	jal	11004 <_free_r>
   11da8:	01412483          	lw	s1,20(sp)
   11dac:	02042823          	sw	zero,48(s0)
   11db0:	01c12083          	lw	ra,28(sp)
   11db4:	01812403          	lw	s0,24(sp)
   11db8:	00c12983          	lw	s3,12(sp)
   11dbc:	00000513          	li	a0,0
   11dc0:	02010113          	addi	sp,sp,32
   11dc4:	00008067          	ret
   11dc8:	01212823          	sw	s2,16(sp)
   11dcc:	0105a903          	lw	s2,16(a1)
   11dd0:	08090a63          	beqz	s2,11e64 <__sflush_r+0x1e0>
   11dd4:	00912a23          	sw	s1,20(sp)
   11dd8:	0005a483          	lw	s1,0(a1)
   11ddc:	00377713          	andi	a4,a4,3
   11de0:	0125a023          	sw	s2,0(a1)
   11de4:	412484b3          	sub	s1,s1,s2
   11de8:	00000793          	li	a5,0
   11dec:	00071463          	bnez	a4,11df4 <__sflush_r+0x170>
   11df0:	0145a783          	lw	a5,20(a1)
   11df4:	00f42423          	sw	a5,8(s0)
   11df8:	00904863          	bgtz	s1,11e08 <__sflush_r+0x184>
   11dfc:	0640006f          	j	11e60 <__sflush_r+0x1dc>
   11e00:	00a90933          	add	s2,s2,a0
   11e04:	04905e63          	blez	s1,11e60 <__sflush_r+0x1dc>
   11e08:	02442783          	lw	a5,36(s0)
   11e0c:	01c42583          	lw	a1,28(s0)
   11e10:	00048693          	mv	a3,s1
   11e14:	00090613          	mv	a2,s2
   11e18:	00098513          	mv	a0,s3
   11e1c:	000780e7          	jalr	a5
   11e20:	40a484b3          	sub	s1,s1,a0
   11e24:	fca04ee3          	bgtz	a0,11e00 <__sflush_r+0x17c>
   11e28:	00c45783          	lhu	a5,12(s0)
   11e2c:	01012903          	lw	s2,16(sp)
   11e30:	0407e793          	ori	a5,a5,64
   11e34:	01c12083          	lw	ra,28(sp)
   11e38:	00f41623          	sh	a5,12(s0)
   11e3c:	01812403          	lw	s0,24(sp)
   11e40:	01412483          	lw	s1,20(sp)
   11e44:	00c12983          	lw	s3,12(sp)
   11e48:	fff00513          	li	a0,-1
   11e4c:	02010113          	addi	sp,sp,32
   11e50:	00008067          	ret
   11e54:	03c5a683          	lw	a3,60(a1)
   11e58:	e6d044e3          	bgtz	a3,11cc0 <__sflush_r+0x3c>
   11e5c:	f55ff06f          	j	11db0 <__sflush_r+0x12c>
   11e60:	01412483          	lw	s1,20(sp)
   11e64:	01012903          	lw	s2,16(sp)
   11e68:	f49ff06f          	j	11db0 <__sflush_r+0x12c>
   11e6c:	05042603          	lw	a2,80(s0)
   11e70:	e95ff06f          	j	11d04 <__sflush_r+0x80>
   11e74:	01042683          	lw	a3,16(s0)
   11e78:	fffff737          	lui	a4,0xfffff
   11e7c:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebc6f>
   11e80:	00e7f733          	and	a4,a5,a4
   11e84:	00e41623          	sh	a4,12(s0)
   11e88:	00042223          	sw	zero,4(s0)
   11e8c:	00d42023          	sw	a3,0(s0)
   11e90:	01379713          	slli	a4,a5,0x13
   11e94:	ee075ce3          	bgez	a4,11d8c <__sflush_r+0x108>
   11e98:	03042583          	lw	a1,48(s0)
   11e9c:	04a42823          	sw	a0,80(s0)
   11ea0:	0099a023          	sw	s1,0(s3)
   11ea4:	ee059ae3          	bnez	a1,11d98 <__sflush_r+0x114>
   11ea8:	01412483          	lw	s1,20(sp)
   11eac:	f05ff06f          	j	11db0 <__sflush_r+0x12c>
   11eb0:	0009a783          	lw	a5,0(s3)
   11eb4:	e40784e3          	beqz	a5,11cfc <__sflush_r+0x78>
   11eb8:	fe378713          	addi	a4,a5,-29
   11ebc:	00070c63          	beqz	a4,11ed4 <__sflush_r+0x250>
   11ec0:	fea78793          	addi	a5,a5,-22
   11ec4:	00078863          	beqz	a5,11ed4 <__sflush_r+0x250>
   11ec8:	00c45783          	lhu	a5,12(s0)
   11ecc:	0407e793          	ori	a5,a5,64
   11ed0:	f65ff06f          	j	11e34 <__sflush_r+0x1b0>
   11ed4:	0099a023          	sw	s1,0(s3)
   11ed8:	01412483          	lw	s1,20(sp)
   11edc:	ed5ff06f          	j	11db0 <__sflush_r+0x12c>

00011ee0 <_fflush_r>:
   11ee0:	00050793          	mv	a5,a0
   11ee4:	00050663          	beqz	a0,11ef0 <_fflush_r+0x10>
   11ee8:	03452703          	lw	a4,52(a0)
   11eec:	00070e63          	beqz	a4,11f08 <_fflush_r+0x28>
   11ef0:	00c59703          	lh	a4,12(a1)
   11ef4:	00071663          	bnez	a4,11f00 <_fflush_r+0x20>
   11ef8:	00000513          	li	a0,0
   11efc:	00008067          	ret
   11f00:	00078513          	mv	a0,a5
   11f04:	d81ff06f          	j	11c84 <__sflush_r>
   11f08:	fe010113          	addi	sp,sp,-32
   11f0c:	00b12623          	sw	a1,12(sp)
   11f10:	00112e23          	sw	ra,28(sp)
   11f14:	00a12423          	sw	a0,8(sp)
   11f18:	815fe0ef          	jal	1072c <__sinit>
   11f1c:	00c12583          	lw	a1,12(sp)
   11f20:	00812783          	lw	a5,8(sp)
   11f24:	00c59703          	lh	a4,12(a1)
   11f28:	00070a63          	beqz	a4,11f3c <_fflush_r+0x5c>
   11f2c:	01c12083          	lw	ra,28(sp)
   11f30:	00078513          	mv	a0,a5
   11f34:	02010113          	addi	sp,sp,32
   11f38:	d4dff06f          	j	11c84 <__sflush_r>
   11f3c:	01c12083          	lw	ra,28(sp)
   11f40:	00000513          	li	a0,0
   11f44:	02010113          	addi	sp,sp,32
   11f48:	00008067          	ret

00011f4c <fflush>:
   11f4c:	06050063          	beqz	a0,11fac <fflush+0x60>
   11f50:	00050593          	mv	a1,a0
   11f54:	d5c1a503          	lw	a0,-676(gp) # 1385c <_impure_ptr>
   11f58:	00050663          	beqz	a0,11f64 <fflush+0x18>
   11f5c:	03452783          	lw	a5,52(a0)
   11f60:	00078c63          	beqz	a5,11f78 <fflush+0x2c>
   11f64:	00c59783          	lh	a5,12(a1)
   11f68:	00079663          	bnez	a5,11f74 <fflush+0x28>
   11f6c:	00000513          	li	a0,0
   11f70:	00008067          	ret
   11f74:	d11ff06f          	j	11c84 <__sflush_r>
   11f78:	fe010113          	addi	sp,sp,-32
   11f7c:	00b12623          	sw	a1,12(sp)
   11f80:	00a12423          	sw	a0,8(sp)
   11f84:	00112e23          	sw	ra,28(sp)
   11f88:	fa4fe0ef          	jal	1072c <__sinit>
   11f8c:	00c12583          	lw	a1,12(sp)
   11f90:	00812503          	lw	a0,8(sp)
   11f94:	00c59783          	lh	a5,12(a1)
   11f98:	02079863          	bnez	a5,11fc8 <fflush+0x7c>
   11f9c:	01c12083          	lw	ra,28(sp)
   11fa0:	00000513          	li	a0,0
   11fa4:	02010113          	addi	sp,sp,32
   11fa8:	00008067          	ret
   11fac:	00013637          	lui	a2,0x13
   11fb0:	000125b7          	lui	a1,0x12
   11fb4:	00013537          	lui	a0,0x13
   11fb8:	30060613          	addi	a2,a2,768 # 13300 <__sglue>
   11fbc:	ee058593          	addi	a1,a1,-288 # 11ee0 <_fflush_r>
   11fc0:	31050513          	addi	a0,a0,784 # 13310 <_impure_data>
   11fc4:	fc4fe06f          	j	10788 <_fwalk_sglue>
   11fc8:	01c12083          	lw	ra,28(sp)
   11fcc:	02010113          	addi	sp,sp,32
   11fd0:	cb5ff06f          	j	11c84 <__sflush_r>

00011fd4 <_sbrk_r>:
   11fd4:	ff010113          	addi	sp,sp,-16
   11fd8:	00812423          	sw	s0,8(sp)
   11fdc:	00912223          	sw	s1,4(sp)
   11fe0:	00050493          	mv	s1,a0
   11fe4:	00058513          	mv	a0,a1
   11fe8:	00112623          	sw	ra,12(sp)
   11fec:	d601a623          	sw	zero,-660(gp) # 1386c <errno>
   11ff0:	220000ef          	jal	12210 <_sbrk>
   11ff4:	fff00793          	li	a5,-1
   11ff8:	00f50c63          	beq	a0,a5,12010 <_sbrk_r+0x3c>
   11ffc:	00c12083          	lw	ra,12(sp)
   12000:	00812403          	lw	s0,8(sp)
   12004:	00412483          	lw	s1,4(sp)
   12008:	01010113          	addi	sp,sp,16
   1200c:	00008067          	ret
   12010:	d6c1a783          	lw	a5,-660(gp) # 1386c <errno>
   12014:	fe0784e3          	beqz	a5,11ffc <_sbrk_r+0x28>
   12018:	00c12083          	lw	ra,12(sp)
   1201c:	00812403          	lw	s0,8(sp)
   12020:	00f4a023          	sw	a5,0(s1)
   12024:	00412483          	lw	s1,4(sp)
   12028:	01010113          	addi	sp,sp,16
   1202c:	00008067          	ret

00012030 <__libc_fini_array>:
   12030:	ff010113          	addi	sp,sp,-16
   12034:	00812423          	sw	s0,8(sp)
   12038:	000137b7          	lui	a5,0x13
   1203c:	00013437          	lui	s0,0x13
   12040:	2fc78793          	addi	a5,a5,764 # 132fc <__fini_array_end>
   12044:	2f840413          	addi	s0,s0,760 # 132f8 <__do_global_dtors_aux_fini_array_entry>
   12048:	408787b3          	sub	a5,a5,s0
   1204c:	00912223          	sw	s1,4(sp)
   12050:	00112623          	sw	ra,12(sp)
   12054:	4027d493          	srai	s1,a5,0x2
   12058:	02048063          	beqz	s1,12078 <__libc_fini_array+0x48>
   1205c:	ffc40413          	addi	s0,s0,-4
   12060:	00f40433          	add	s0,s0,a5
   12064:	00042783          	lw	a5,0(s0)
   12068:	fff48493          	addi	s1,s1,-1
   1206c:	ffc40413          	addi	s0,s0,-4
   12070:	000780e7          	jalr	a5
   12074:	fe0498e3          	bnez	s1,12064 <__libc_fini_array+0x34>
   12078:	00c12083          	lw	ra,12(sp)
   1207c:	00812403          	lw	s0,8(sp)
   12080:	00412483          	lw	s1,4(sp)
   12084:	01010113          	addi	sp,sp,16
   12088:	00008067          	ret

0001208c <__register_exitproc>:
   1208c:	d701a783          	lw	a5,-656(gp) # 13870 <__atexit>
   12090:	04078c63          	beqz	a5,120e8 <__register_exitproc+0x5c>
   12094:	0047a703          	lw	a4,4(a5)
   12098:	01f00813          	li	a6,31
   1209c:	06e84e63          	blt	a6,a4,12118 <__register_exitproc+0x8c>
   120a0:	00271813          	slli	a6,a4,0x2
   120a4:	02050663          	beqz	a0,120d0 <__register_exitproc+0x44>
   120a8:	01078333          	add	t1,a5,a6
   120ac:	08c32423          	sw	a2,136(t1)
   120b0:	1887a883          	lw	a7,392(a5)
   120b4:	00100613          	li	a2,1
   120b8:	00e61633          	sll	a2,a2,a4
   120bc:	00c8e8b3          	or	a7,a7,a2
   120c0:	1917a423          	sw	a7,392(a5)
   120c4:	10d32423          	sw	a3,264(t1)
   120c8:	00200693          	li	a3,2
   120cc:	02d50463          	beq	a0,a3,120f4 <__register_exitproc+0x68>
   120d0:	00170713          	addi	a4,a4,1
   120d4:	00e7a223          	sw	a4,4(a5)
   120d8:	010787b3          	add	a5,a5,a6
   120dc:	00b7a423          	sw	a1,8(a5)
   120e0:	00000513          	li	a0,0
   120e4:	00008067          	ret
   120e8:	f0018793          	addi	a5,gp,-256 # 13a00 <__atexit0>
   120ec:	d6f1a823          	sw	a5,-656(gp) # 13870 <__atexit>
   120f0:	fa5ff06f          	j	12094 <__register_exitproc+0x8>
   120f4:	18c7a683          	lw	a3,396(a5)
   120f8:	00170713          	addi	a4,a4,1
   120fc:	00e7a223          	sw	a4,4(a5)
   12100:	00c6e6b3          	or	a3,a3,a2
   12104:	18d7a623          	sw	a3,396(a5)
   12108:	010787b3          	add	a5,a5,a6
   1210c:	00b7a423          	sw	a1,8(a5)
   12110:	00000513          	li	a0,0
   12114:	00008067          	ret
   12118:	fff00513          	li	a0,-1
   1211c:	00008067          	ret

00012120 <_close>:
   12120:	03900893          	li	a7,57
   12124:	00000073          	ecall
   12128:	00054463          	bltz	a0,12130 <_close+0x10>
   1212c:	00008067          	ret
   12130:	fe010113          	addi	sp,sp,-32
   12134:	00112e23          	sw	ra,28(sp)
   12138:	00a12623          	sw	a0,12(sp)
   1213c:	18c000ef          	jal	122c8 <__errno>
   12140:	00c12783          	lw	a5,12(sp)
   12144:	01c12083          	lw	ra,28(sp)
   12148:	40f007b3          	neg	a5,a5
   1214c:	00f52023          	sw	a5,0(a0)
   12150:	fff00793          	li	a5,-1
   12154:	00078513          	mv	a0,a5
   12158:	02010113          	addi	sp,sp,32
   1215c:	00008067          	ret

00012160 <_exit>:
   12160:	05d00893          	li	a7,93
   12164:	00000073          	ecall
   12168:	00054463          	bltz	a0,12170 <_exit+0x10>
   1216c:	0000006f          	j	1216c <_exit+0xc>
   12170:	fe010113          	addi	sp,sp,-32
   12174:	00112e23          	sw	ra,28(sp)
   12178:	00a12623          	sw	a0,12(sp)
   1217c:	14c000ef          	jal	122c8 <__errno>
   12180:	00c12783          	lw	a5,12(sp)
   12184:	40f007b3          	neg	a5,a5
   12188:	00f52023          	sw	a5,0(a0)
   1218c:	0000006f          	j	1218c <_exit+0x2c>

00012190 <_lseek>:
   12190:	03e00893          	li	a7,62
   12194:	00000073          	ecall
   12198:	00054463          	bltz	a0,121a0 <_lseek+0x10>
   1219c:	00008067          	ret
   121a0:	fe010113          	addi	sp,sp,-32
   121a4:	00112e23          	sw	ra,28(sp)
   121a8:	00a12623          	sw	a0,12(sp)
   121ac:	11c000ef          	jal	122c8 <__errno>
   121b0:	00c12783          	lw	a5,12(sp)
   121b4:	01c12083          	lw	ra,28(sp)
   121b8:	40f007b3          	neg	a5,a5
   121bc:	00f52023          	sw	a5,0(a0)
   121c0:	fff00793          	li	a5,-1
   121c4:	00078513          	mv	a0,a5
   121c8:	02010113          	addi	sp,sp,32
   121cc:	00008067          	ret

000121d0 <_read>:
   121d0:	03f00893          	li	a7,63
   121d4:	00000073          	ecall
   121d8:	00054463          	bltz	a0,121e0 <_read+0x10>
   121dc:	00008067          	ret
   121e0:	fe010113          	addi	sp,sp,-32
   121e4:	00112e23          	sw	ra,28(sp)
   121e8:	00a12623          	sw	a0,12(sp)
   121ec:	0dc000ef          	jal	122c8 <__errno>
   121f0:	00c12783          	lw	a5,12(sp)
   121f4:	01c12083          	lw	ra,28(sp)
   121f8:	40f007b3          	neg	a5,a5
   121fc:	00f52023          	sw	a5,0(a0)
   12200:	fff00793          	li	a5,-1
   12204:	00078513          	mv	a0,a5
   12208:	02010113          	addi	sp,sp,32
   1220c:	00008067          	ret

00012210 <_sbrk>:
   12210:	d801a783          	lw	a5,-640(gp) # 13880 <heap_end.0>
   12214:	ff010113          	addi	sp,sp,-16
   12218:	00112623          	sw	ra,12(sp)
   1221c:	00050713          	mv	a4,a0
   12220:	02079063          	bnez	a5,12240 <_sbrk+0x30>
   12224:	0d600893          	li	a7,214
   12228:	00000513          	li	a0,0
   1222c:	00000073          	ecall
   12230:	fff00793          	li	a5,-1
   12234:	02f50c63          	beq	a0,a5,1226c <_sbrk+0x5c>
   12238:	00050793          	mv	a5,a0
   1223c:	d8a1a023          	sw	a0,-640(gp) # 13880 <heap_end.0>
   12240:	00f70533          	add	a0,a4,a5
   12244:	0d600893          	li	a7,214
   12248:	00000073          	ecall
   1224c:	d801a783          	lw	a5,-640(gp) # 13880 <heap_end.0>
   12250:	00f70733          	add	a4,a4,a5
   12254:	00e51c63          	bne	a0,a4,1226c <_sbrk+0x5c>
   12258:	00c12083          	lw	ra,12(sp)
   1225c:	d8a1a023          	sw	a0,-640(gp) # 13880 <heap_end.0>
   12260:	00078513          	mv	a0,a5
   12264:	01010113          	addi	sp,sp,16
   12268:	00008067          	ret
   1226c:	05c000ef          	jal	122c8 <__errno>
   12270:	00c12083          	lw	ra,12(sp)
   12274:	00c00793          	li	a5,12
   12278:	00f52023          	sw	a5,0(a0)
   1227c:	fff00513          	li	a0,-1
   12280:	01010113          	addi	sp,sp,16
   12284:	00008067          	ret

00012288 <_write>:
   12288:	04000893          	li	a7,64
   1228c:	00000073          	ecall
   12290:	00054463          	bltz	a0,12298 <_write+0x10>
   12294:	00008067          	ret
   12298:	fe010113          	addi	sp,sp,-32
   1229c:	00112e23          	sw	ra,28(sp)
   122a0:	00a12623          	sw	a0,12(sp)
   122a4:	024000ef          	jal	122c8 <__errno>
   122a8:	00c12783          	lw	a5,12(sp)
   122ac:	01c12083          	lw	ra,28(sp)
   122b0:	40f007b3          	neg	a5,a5
   122b4:	00f52023          	sw	a5,0(a0)
   122b8:	fff00793          	li	a5,-1
   122bc:	00078513          	mv	a0,a5
   122c0:	02010113          	addi	sp,sp,32
   122c4:	00008067          	ret

000122c8 <__errno>:
   122c8:	d5c1a503          	lw	a0,-676(gp) # 1385c <_impure_ptr>
   122cc:	00008067          	ret
