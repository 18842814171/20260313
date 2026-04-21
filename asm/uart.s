
out/timer_uart_test:     file format elf32-littleriscv


Disassembly of section .text:

000100b4 <exit>:
   100b4:	ff010113          	addi	sp,sp,-16
   100b8:	00000593          	li	a1,0
   100bc:	00812423          	sw	s0,8(sp)
   100c0:	00112623          	sw	ra,12(sp)
   100c4:	00050413          	mv	s0,a0
   100c8:	631000ef          	jal	10ef8 <__call_exitprocs>
   100cc:	d681a783          	lw	a5,-664(gp) # 13a78 <__stdio_exit_handler>
   100d0:	00078463          	beqz	a5,100d8 <exit+0x24>
   100d4:	000780e7          	jalr	a5
   100d8:	00040513          	mv	a0,s0
   100dc:	200020ef          	jal	122dc <_exit>

000100e0 <register_fini>:
   100e0:	00000793          	li	a5,0
   100e4:	00078863          	beqz	a5,100f4 <register_fini+0x14>
   100e8:	00012537          	lui	a0,0x12
   100ec:	1ac50513          	addi	a0,a0,428 # 121ac <__libc_fini_array>
   100f0:	7590006f          	j	11048 <atexit>
   100f4:	00008067          	ret

000100f8 <_start>:
   100f8:	00004197          	auipc	gp,0x4
   100fc:	c1818193          	addi	gp,gp,-1000 # 13d10 <__global_pointer$>
   10100:	00000513          	li	a0,0
   10104:	00050463          	beqz	a0,1010c <_start+0x14>
   10108:	01751073          	csrw	jvt,a0
   1010c:	00004517          	auipc	a0,0x4
   10110:	96c50513          	addi	a0,a0,-1684 # 13a78 <__stdio_exit_handler>
   10114:	00004617          	auipc	a2,0x4
   10118:	c8c60613          	addi	a2,a2,-884 # 13da0 <__BSS_END__>
   1011c:	40a60633          	sub	a2,a2,a0
   10120:	00000593          	li	a1,0
   10124:	4f9000ef          	jal	10e1c <memset>
   10128:	00001517          	auipc	a0,0x1
   1012c:	f2050513          	addi	a0,a0,-224 # 11048 <atexit>
   10130:	00050863          	beqz	a0,10140 <_start+0x48>
   10134:	00002517          	auipc	a0,0x2
   10138:	07850513          	addi	a0,a0,120 # 121ac <__libc_fini_array>
   1013c:	70d000ef          	jal	11048 <atexit>
   10140:	449000ef          	jal	10d88 <__libc_init_array>
   10144:	00012503          	lw	a0,0(sp)
   10148:	00410593          	addi	a1,sp,4
   1014c:	00251613          	slli	a2,a0,0x2
   10150:	00460613          	addi	a2,a2,4
   10154:	00b60633          	add	a2,a2,a1
   10158:	318000ef          	jal	10470 <main>
   1015c:	f59ff06f          	j	100b4 <exit>

00010160 <__do_global_dtors_aux>:
   10160:	ff010113          	addi	sp,sp,-16
   10164:	00812423          	sw	s0,8(sp)
   10168:	d841c783          	lbu	a5,-636(gp) # 13a94 <completed.1>
   1016c:	00112623          	sw	ra,12(sp)
   10170:	02079263          	bnez	a5,10194 <__do_global_dtors_aux+0x34>
   10174:	00000793          	li	a5,0
   10178:	00078a63          	beqz	a5,1018c <__do_global_dtors_aux+0x2c>
   1017c:	00012537          	lui	a0,0x12
   10180:	4fc50513          	addi	a0,a0,1276 # 124fc <__EH_FRAME_BEGIN__>
   10184:	00000097          	auipc	ra,0x0
   10188:	000000e7          	jalr	zero # 0 <exit-0x100b4>
   1018c:	00100793          	li	a5,1
   10190:	d8f18223          	sb	a5,-636(gp) # 13a94 <completed.1>
   10194:	00c12083          	lw	ra,12(sp)
   10198:	00812403          	lw	s0,8(sp)
   1019c:	01010113          	addi	sp,sp,16
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	00000793          	li	a5,0
   101a8:	00078c63          	beqz	a5,101c0 <frame_dummy+0x1c>
   101ac:	00012537          	lui	a0,0x12
   101b0:	d8818593          	addi	a1,gp,-632 # 13a98 <object.0>
   101b4:	4fc50513          	addi	a0,a0,1276 # 124fc <__EH_FRAME_BEGIN__>
   101b8:	00000317          	auipc	t1,0x0
   101bc:	00000067          	jr	zero # 0 <exit-0x100b4>
   101c0:	00008067          	ret

000101c4 <uart_putc>:
   101c4:	fe010113          	addi	sp,sp,-32
   101c8:	00112e23          	sw	ra,28(sp)
   101cc:	00812c23          	sw	s0,24(sp)
   101d0:	02010413          	addi	s0,sp,32
   101d4:	00050793          	mv	a5,a0
   101d8:	fef407a3          	sb	a5,-17(s0)
   101dc:	00000013          	nop
   101e0:	100007b7          	lui	a5,0x10000
   101e4:	0007a783          	lw	a5,0(a5) # 10000000 <__BSS_END__+0xffec260>
   101e8:	fe07cce3          	bltz	a5,101e0 <uart_putc+0x1c>
   101ec:	100007b7          	lui	a5,0x10000
   101f0:	fef44703          	lbu	a4,-17(s0)
   101f4:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec260>
   101f8:	00000013          	nop
   101fc:	01c12083          	lw	ra,28(sp)
   10200:	01812403          	lw	s0,24(sp)
   10204:	02010113          	addi	sp,sp,32
   10208:	00008067          	ret

0001020c <uart_puts>:
   1020c:	fe010113          	addi	sp,sp,-32
   10210:	00112e23          	sw	ra,28(sp)
   10214:	00812c23          	sw	s0,24(sp)
   10218:	02010413          	addi	s0,sp,32
   1021c:	fea42623          	sw	a0,-20(s0)
   10220:	01c0006f          	j	1023c <uart_puts+0x30>
   10224:	fec42783          	lw	a5,-20(s0)
   10228:	00178713          	addi	a4,a5,1
   1022c:	fee42623          	sw	a4,-20(s0)
   10230:	0007c783          	lbu	a5,0(a5)
   10234:	00078513          	mv	a0,a5
   10238:	f8dff0ef          	jal	101c4 <uart_putc>
   1023c:	fec42783          	lw	a5,-20(s0)
   10240:	0007c783          	lbu	a5,0(a5)
   10244:	fe0790e3          	bnez	a5,10224 <uart_puts+0x18>
   10248:	00000013          	nop
   1024c:	00000013          	nop
   10250:	01c12083          	lw	ra,28(sp)
   10254:	01812403          	lw	s0,24(sp)
   10258:	02010113          	addi	sp,sp,32
   1025c:	00008067          	ret

00010260 <uart_puts_nl>:
   10260:	ff010113          	addi	sp,sp,-16
   10264:	00112623          	sw	ra,12(sp)
   10268:	00812423          	sw	s0,8(sp)
   1026c:	01010413          	addi	s0,sp,16
   10270:	00d00513          	li	a0,13
   10274:	f51ff0ef          	jal	101c4 <uart_putc>
   10278:	00a00513          	li	a0,10
   1027c:	f49ff0ef          	jal	101c4 <uart_putc>
   10280:	00000013          	nop
   10284:	00c12083          	lw	ra,12(sp)
   10288:	00812403          	lw	s0,8(sp)
   1028c:	01010113          	addi	sp,sp,16
   10290:	00008067          	ret

00010294 <print_hex32>:
   10294:	fc010113          	addi	sp,sp,-64
   10298:	02112e23          	sw	ra,60(sp)
   1029c:	02812c23          	sw	s0,56(sp)
   102a0:	04010413          	addi	s0,sp,64
   102a4:	fca42623          	sw	a0,-52(s0)
   102a8:	000127b7          	lui	a5,0x12
   102ac:	45078793          	addi	a5,a5,1104 # 12450 <__errno+0xc>
   102b0:	0007a603          	lw	a2,0(a5)
   102b4:	0047a683          	lw	a3,4(a5)
   102b8:	0087a703          	lw	a4,8(a5)
   102bc:	fcc42c23          	sw	a2,-40(s0)
   102c0:	fcd42e23          	sw	a3,-36(s0)
   102c4:	fee42023          	sw	a4,-32(s0)
   102c8:	00c7a703          	lw	a4,12(a5)
   102cc:	fee42223          	sw	a4,-28(s0)
   102d0:	0107c783          	lbu	a5,16(a5)
   102d4:	fef40423          	sb	a5,-24(s0)
   102d8:	000127b7          	lui	a5,0x12
   102dc:	44c78513          	addi	a0,a5,1100 # 1244c <__errno+0x8>
   102e0:	f2dff0ef          	jal	1020c <uart_puts>
   102e4:	01c00793          	li	a5,28
   102e8:	fef42623          	sw	a5,-20(s0)
   102ec:	0340006f          	j	10320 <print_hex32+0x8c>
   102f0:	fec42783          	lw	a5,-20(s0)
   102f4:	fcc42703          	lw	a4,-52(s0)
   102f8:	00f757b3          	srl	a5,a4,a5
   102fc:	00f7f793          	andi	a5,a5,15
   10300:	ff078793          	addi	a5,a5,-16
   10304:	008787b3          	add	a5,a5,s0
   10308:	fe87c783          	lbu	a5,-24(a5)
   1030c:	00078513          	mv	a0,a5
   10310:	eb5ff0ef          	jal	101c4 <uart_putc>
   10314:	fec42783          	lw	a5,-20(s0)
   10318:	ffc78793          	addi	a5,a5,-4
   1031c:	fef42623          	sw	a5,-20(s0)
   10320:	fec42783          	lw	a5,-20(s0)
   10324:	fc07d6e3          	bgez	a5,102f0 <print_hex32+0x5c>
   10328:	00000013          	nop
   1032c:	00000013          	nop
   10330:	03c12083          	lw	ra,60(sp)
   10334:	03812403          	lw	s0,56(sp)
   10338:	04010113          	addi	sp,sp,64
   1033c:	00008067          	ret

00010340 <uart_has_data>:
   10340:	ff010113          	addi	sp,sp,-16
   10344:	00112623          	sw	ra,12(sp)
   10348:	00812423          	sw	s0,8(sp)
   1034c:	01010413          	addi	s0,sp,16
   10350:	100007b7          	lui	a5,0x10000
   10354:	00478793          	addi	a5,a5,4 # 10000004 <__BSS_END__+0xffec264>
   10358:	0007a783          	lw	a5,0(a5)
   1035c:	fff7c793          	not	a5,a5
   10360:	01f7d793          	srli	a5,a5,0x1f
   10364:	0ff7f793          	zext.b	a5,a5
   10368:	00078513          	mv	a0,a5
   1036c:	00c12083          	lw	ra,12(sp)
   10370:	00812403          	lw	s0,8(sp)
   10374:	01010113          	addi	sp,sp,16
   10378:	00008067          	ret

0001037c <uart_read>:
   1037c:	fe010113          	addi	sp,sp,-32
   10380:	00112e23          	sw	ra,28(sp)
   10384:	00812c23          	sw	s0,24(sp)
   10388:	02010413          	addi	s0,sp,32
   1038c:	00000013          	nop
   10390:	100007b7          	lui	a5,0x10000
   10394:	00478793          	addi	a5,a5,4 # 10000004 <__BSS_END__+0xffec264>
   10398:	0007a783          	lw	a5,0(a5)
   1039c:	fef42623          	sw	a5,-20(s0)
   103a0:	fec42783          	lw	a5,-20(s0)
   103a4:	fe07c6e3          	bltz	a5,10390 <uart_read+0x14>
   103a8:	fec42783          	lw	a5,-20(s0)
   103ac:	0ff7f793          	zext.b	a5,a5
   103b0:	00078513          	mv	a0,a5
   103b4:	01c12083          	lw	ra,28(sp)
   103b8:	01812403          	lw	s0,24(sp)
   103bc:	02010113          	addi	sp,sp,32
   103c0:	00008067          	ret

000103c4 <uart_getline>:
   103c4:	fd010113          	addi	sp,sp,-48
   103c8:	02112623          	sw	ra,44(sp)
   103cc:	02812423          	sw	s0,40(sp)
   103d0:	03010413          	addi	s0,sp,48
   103d4:	fca42e23          	sw	a0,-36(s0)
   103d8:	fcb42c23          	sw	a1,-40(s0)
   103dc:	fe042623          	sw	zero,-20(s0)
   103e0:	05c0006f          	j	1043c <uart_getline+0x78>
   103e4:	f99ff0ef          	jal	1037c <uart_read>
   103e8:	00050793          	mv	a5,a0
   103ec:	fef405a3          	sb	a5,-21(s0)
   103f0:	feb44783          	lbu	a5,-21(s0)
   103f4:	00078513          	mv	a0,a5
   103f8:	dcdff0ef          	jal	101c4 <uart_putc>
   103fc:	feb44703          	lbu	a4,-21(s0)
   10400:	00d00793          	li	a5,13
   10404:	00f70863          	beq	a4,a5,10414 <uart_getline+0x50>
   10408:	feb44703          	lbu	a4,-21(s0)
   1040c:	00a00793          	li	a5,10
   10410:	00f71663          	bne	a4,a5,1041c <uart_getline+0x58>
   10414:	e4dff0ef          	jal	10260 <uart_puts_nl>
   10418:	0340006f          	j	1044c <uart_getline+0x88>
   1041c:	fec42783          	lw	a5,-20(s0)
   10420:	00178713          	addi	a4,a5,1
   10424:	fee42623          	sw	a4,-20(s0)
   10428:	00078713          	mv	a4,a5
   1042c:	fdc42783          	lw	a5,-36(s0)
   10430:	00e787b3          	add	a5,a5,a4
   10434:	feb44703          	lbu	a4,-21(s0)
   10438:	00e78023          	sb	a4,0(a5)
   1043c:	fd842783          	lw	a5,-40(s0)
   10440:	fff78793          	addi	a5,a5,-1
   10444:	fec42703          	lw	a4,-20(s0)
   10448:	f8f74ee3          	blt	a4,a5,103e4 <uart_getline+0x20>
   1044c:	fec42783          	lw	a5,-20(s0)
   10450:	fdc42703          	lw	a4,-36(s0)
   10454:	00f707b3          	add	a5,a4,a5
   10458:	00078023          	sb	zero,0(a5)
   1045c:	00000013          	nop
   10460:	02c12083          	lw	ra,44(sp)
   10464:	02812403          	lw	s0,40(sp)
   10468:	03010113          	addi	sp,sp,48
   1046c:	00008067          	ret

00010470 <main>:
   10470:	fa010113          	addi	sp,sp,-96
   10474:	04112e23          	sw	ra,92(sp)
   10478:	04812c23          	sw	s0,88(sp)
   1047c:	05212a23          	sw	s2,84(sp)
   10480:	05312823          	sw	s3,80(sp)
   10484:	06010413          	addi	s0,sp,96
   10488:	100007b7          	lui	a5,0x10000
   1048c:	00878793          	addi	a5,a5,8 # 10000008 <__BSS_END__+0xffec268>
   10490:	00100713          	li	a4,1
   10494:	00e7a023          	sw	a4,0(a5)
   10498:	100007b7          	lui	a5,0x10000
   1049c:	00c78793          	addi	a5,a5,12 # 1000000c <__BSS_END__+0xffec26c>
   104a0:	00100713          	li	a4,1
   104a4:	00e7a023          	sw	a4,0(a5)
   104a8:	000127b7          	lui	a5,0x12
   104ac:	46478513          	addi	a0,a5,1124 # 12464 <__errno+0x20>
   104b0:	d5dff0ef          	jal	1020c <uart_puts>
   104b4:	dadff0ef          	jal	10260 <uart_puts_nl>
   104b8:	000127b7          	lui	a5,0x12
   104bc:	49078513          	addi	a0,a5,1168 # 12490 <__errno+0x4c>
   104c0:	d4dff0ef          	jal	1020c <uart_puts>
   104c4:	d9dff0ef          	jal	10260 <uart_puts_nl>
   104c8:	000127b7          	lui	a5,0x12
   104cc:	46478513          	addi	a0,a5,1124 # 12464 <__errno+0x20>
   104d0:	d3dff0ef          	jal	1020c <uart_puts>
   104d4:	d8dff0ef          	jal	10260 <uart_puts_nl>
   104d8:	d89ff0ef          	jal	10260 <uart_puts_nl>
   104dc:	000127b7          	lui	a5,0x12
   104e0:	4b478513          	addi	a0,a5,1204 # 124b4 <__errno+0x70>
   104e4:	d29ff0ef          	jal	1020c <uart_puts>
   104e8:	d79ff0ef          	jal	10260 <uart_puts_nl>
   104ec:	fa840793          	addi	a5,s0,-88
   104f0:	04000593          	li	a1,64
   104f4:	00078513          	mv	a0,a5
   104f8:	ecdff0ef          	jal	103c4 <uart_getline>
   104fc:	000127b7          	lui	a5,0x12
   10500:	4d478513          	addi	a0,a5,1236 # 124d4 <__errno+0x90>
   10504:	d09ff0ef          	jal	1020c <uart_puts>
   10508:	fa840793          	addi	a5,s0,-88
   1050c:	00078513          	mv	a0,a5
   10510:	cfdff0ef          	jal	1020c <uart_puts>
   10514:	d4dff0ef          	jal	10260 <uart_puts_nl>
   10518:	000127b7          	lui	a5,0x12
   1051c:	4e078513          	addi	a0,a5,1248 # 124e0 <__errno+0x9c>
   10520:	cedff0ef          	jal	1020c <uart_puts>
   10524:	020047b7          	lui	a5,0x2004
   10528:	0007a703          	lw	a4,0(a5) # 2004000 <__BSS_END__+0x1ff0260>
   1052c:	0047a783          	lw	a5,4(a5)
   10530:	fee42423          	sw	a4,-24(s0)
   10534:	fef42623          	sw	a5,-20(s0)
   10538:	fec42783          	lw	a5,-20(s0)
   1053c:	0007d913          	srli	s2,a5,0x0
   10540:	00000993          	li	s3,0
   10544:	00090793          	mv	a5,s2
   10548:	00078513          	mv	a0,a5
   1054c:	d49ff0ef          	jal	10294 <print_hex32>
   10550:	fe842783          	lw	a5,-24(s0)
   10554:	00078513          	mv	a0,a5
   10558:	d3dff0ef          	jal	10294 <print_hex32>
   1055c:	d05ff0ef          	jal	10260 <uart_puts_nl>
   10560:	fa844703          	lbu	a4,-88(s0)
   10564:	07100793          	li	a5,113
   10568:	f6f71ae3          	bne	a4,a5,104dc <main+0x6c>
   1056c:	fa944783          	lbu	a5,-87(s0)
   10570:	f60796e3          	bnez	a5,104dc <main+0x6c>
   10574:	000127b7          	lui	a5,0x12
   10578:	4f078513          	addi	a0,a5,1264 # 124f0 <__errno+0xac>
   1057c:	c91ff0ef          	jal	1020c <uart_puts>
   10580:	ce1ff0ef          	jal	10260 <uart_puts_nl>
   10584:	00000013          	nop
   10588:	05d00893          	li	a7,93
   1058c:	00000513          	li	a0,0
   10590:	00000073          	ecall
   10594:	0000006f          	j	10594 <main+0x124>

00010598 <__fp_lock>:
   10598:	00000513          	li	a0,0
   1059c:	00008067          	ret

000105a0 <stdio_exit_handler>:
   105a0:	00013637          	lui	a2,0x13
   105a4:	000125b7          	lui	a1,0x12
   105a8:	00013537          	lui	a0,0x13
   105ac:	51060613          	addi	a2,a2,1296 # 13510 <__sglue>
   105b0:	cec58593          	addi	a1,a1,-788 # 11cec <_fclose_r>
   105b4:	52050513          	addi	a0,a0,1312 # 13520 <_impure_data>
   105b8:	34c0006f          	j	10904 <_fwalk_sglue>

000105bc <cleanup_stdio>:
   105bc:	00452583          	lw	a1,4(a0)
   105c0:	ff010113          	addi	sp,sp,-16
   105c4:	00812423          	sw	s0,8(sp)
   105c8:	00112623          	sw	ra,12(sp)
   105cc:	da018793          	addi	a5,gp,-608 # 13ab0 <__sf>
   105d0:	00050413          	mv	s0,a0
   105d4:	00f58463          	beq	a1,a5,105dc <cleanup_stdio+0x20>
   105d8:	714010ef          	jal	11cec <_fclose_r>
   105dc:	00842583          	lw	a1,8(s0)
   105e0:	e0818793          	addi	a5,gp,-504 # 13b18 <__sf+0x68>
   105e4:	00f58663          	beq	a1,a5,105f0 <cleanup_stdio+0x34>
   105e8:	00040513          	mv	a0,s0
   105ec:	700010ef          	jal	11cec <_fclose_r>
   105f0:	00c42583          	lw	a1,12(s0)
   105f4:	e7018793          	addi	a5,gp,-400 # 13b80 <__sf+0xd0>
   105f8:	00f58c63          	beq	a1,a5,10610 <cleanup_stdio+0x54>
   105fc:	00040513          	mv	a0,s0
   10600:	00812403          	lw	s0,8(sp)
   10604:	00c12083          	lw	ra,12(sp)
   10608:	01010113          	addi	sp,sp,16
   1060c:	6e00106f          	j	11cec <_fclose_r>
   10610:	00c12083          	lw	ra,12(sp)
   10614:	00812403          	lw	s0,8(sp)
   10618:	01010113          	addi	sp,sp,16
   1061c:	00008067          	ret

00010620 <__fp_unlock>:
   10620:	00000513          	li	a0,0
   10624:	00008067          	ret

00010628 <global_stdio_init.part.0>:
   10628:	fe010113          	addi	sp,sp,-32
   1062c:	000107b7          	lui	a5,0x10
   10630:	00812c23          	sw	s0,24(sp)
   10634:	5a078793          	addi	a5,a5,1440 # 105a0 <stdio_exit_handler>
   10638:	da018413          	addi	s0,gp,-608 # 13ab0 <__sf>
   1063c:	00112e23          	sw	ra,28(sp)
   10640:	00912a23          	sw	s1,20(sp)
   10644:	01212823          	sw	s2,16(sp)
   10648:	01312623          	sw	s3,12(sp)
   1064c:	01412423          	sw	s4,8(sp)
   10650:	d6f1a423          	sw	a5,-664(gp) # 13a78 <__stdio_exit_handler>
   10654:	00800613          	li	a2,8
   10658:	00400793          	li	a5,4
   1065c:	00000593          	li	a1,0
   10660:	dfc18513          	addi	a0,gp,-516 # 13b0c <__sf+0x5c>
   10664:	00f42623          	sw	a5,12(s0)
   10668:	00042023          	sw	zero,0(s0)
   1066c:	00042223          	sw	zero,4(s0)
   10670:	00042423          	sw	zero,8(s0)
   10674:	06042223          	sw	zero,100(s0)
   10678:	00042823          	sw	zero,16(s0)
   1067c:	00042a23          	sw	zero,20(s0)
   10680:	00042c23          	sw	zero,24(s0)
   10684:	798000ef          	jal	10e1c <memset>
   10688:	00011a37          	lui	s4,0x11
   1068c:	000119b7          	lui	s3,0x11
   10690:	00011937          	lui	s2,0x11
   10694:	000114b7          	lui	s1,0x11
   10698:	000107b7          	lui	a5,0x10
   1069c:	9b8a0a13          	addi	s4,s4,-1608 # 109b8 <__sread>
   106a0:	a1c98993          	addi	s3,s3,-1508 # 10a1c <__swrite>
   106a4:	aa490913          	addi	s2,s2,-1372 # 10aa4 <__sseek>
   106a8:	b0848493          	addi	s1,s1,-1272 # 10b08 <__sclose>
   106ac:	00978793          	addi	a5,a5,9 # 10009 <exit-0xab>
   106b0:	00800613          	li	a2,8
   106b4:	00000593          	li	a1,0
   106b8:	e6418513          	addi	a0,gp,-412 # 13b74 <__sf+0xc4>
   106bc:	06f42a23          	sw	a5,116(s0)
   106c0:	03442023          	sw	s4,32(s0)
   106c4:	03342223          	sw	s3,36(s0)
   106c8:	03242423          	sw	s2,40(s0)
   106cc:	02942623          	sw	s1,44(s0)
   106d0:	00842e23          	sw	s0,28(s0)
   106d4:	06042423          	sw	zero,104(s0)
   106d8:	06042623          	sw	zero,108(s0)
   106dc:	06042823          	sw	zero,112(s0)
   106e0:	0c042623          	sw	zero,204(s0)
   106e4:	06042c23          	sw	zero,120(s0)
   106e8:	06042e23          	sw	zero,124(s0)
   106ec:	08042023          	sw	zero,128(s0)
   106f0:	72c000ef          	jal	10e1c <memset>
   106f4:	000207b7          	lui	a5,0x20
   106f8:	01278793          	addi	a5,a5,18 # 20012 <__BSS_END__+0xc272>
   106fc:	e0818713          	addi	a4,gp,-504 # 13b18 <__sf+0x68>
   10700:	ecc18513          	addi	a0,gp,-308 # 13bdc <__sf+0x12c>
   10704:	00800613          	li	a2,8
   10708:	00000593          	li	a1,0
   1070c:	09442423          	sw	s4,136(s0)
   10710:	09342623          	sw	s3,140(s0)
   10714:	09242823          	sw	s2,144(s0)
   10718:	08942a23          	sw	s1,148(s0)
   1071c:	0cf42e23          	sw	a5,220(s0)
   10720:	0c042823          	sw	zero,208(s0)
   10724:	0c042a23          	sw	zero,212(s0)
   10728:	0c042c23          	sw	zero,216(s0)
   1072c:	12042a23          	sw	zero,308(s0)
   10730:	0e042023          	sw	zero,224(s0)
   10734:	0e042223          	sw	zero,228(s0)
   10738:	0e042423          	sw	zero,232(s0)
   1073c:	08e42223          	sw	a4,132(s0)
   10740:	6dc000ef          	jal	10e1c <memset>
   10744:	e7018793          	addi	a5,gp,-400 # 13b80 <__sf+0xd0>
   10748:	0f442823          	sw	s4,240(s0)
   1074c:	0f342a23          	sw	s3,244(s0)
   10750:	0f242c23          	sw	s2,248(s0)
   10754:	0e942e23          	sw	s1,252(s0)
   10758:	01c12083          	lw	ra,28(sp)
   1075c:	0ef42623          	sw	a5,236(s0)
   10760:	01812403          	lw	s0,24(sp)
   10764:	01412483          	lw	s1,20(sp)
   10768:	01012903          	lw	s2,16(sp)
   1076c:	00c12983          	lw	s3,12(sp)
   10770:	00812a03          	lw	s4,8(sp)
   10774:	02010113          	addi	sp,sp,32
   10778:	00008067          	ret

0001077c <__sfp>:
   1077c:	d681a783          	lw	a5,-664(gp) # 13a78 <__stdio_exit_handler>
   10780:	fe010113          	addi	sp,sp,-32
   10784:	00912a23          	sw	s1,20(sp)
   10788:	00112e23          	sw	ra,28(sp)
   1078c:	00812c23          	sw	s0,24(sp)
   10790:	00050493          	mv	s1,a0
   10794:	0e078e63          	beqz	a5,10890 <__sfp+0x114>
   10798:	00013837          	lui	a6,0x13
   1079c:	51080813          	addi	a6,a6,1296 # 13510 <__sglue>
   107a0:	fff00693          	li	a3,-1
   107a4:	00482783          	lw	a5,4(a6)
   107a8:	fff78793          	addi	a5,a5,-1
   107ac:	0807c063          	bltz	a5,1082c <__sfp+0xb0>
   107b0:	00882403          	lw	s0,8(a6)
   107b4:	00c0006f          	j	107c0 <__sfp+0x44>
   107b8:	06840413          	addi	s0,s0,104
   107bc:	06d78863          	beq	a5,a3,1082c <__sfp+0xb0>
   107c0:	00c41703          	lh	a4,12(s0)
   107c4:	fff78793          	addi	a5,a5,-1
   107c8:	fe0718e3          	bnez	a4,107b8 <__sfp+0x3c>
   107cc:	ffff07b7          	lui	a5,0xffff0
   107d0:	00178793          	addi	a5,a5,1 # ffff0001 <__BSS_END__+0xfffdc261>
   107d4:	00f42623          	sw	a5,12(s0)
   107d8:	06042223          	sw	zero,100(s0)
   107dc:	00042023          	sw	zero,0(s0)
   107e0:	00042423          	sw	zero,8(s0)
   107e4:	00042223          	sw	zero,4(s0)
   107e8:	00042823          	sw	zero,16(s0)
   107ec:	00042a23          	sw	zero,20(s0)
   107f0:	00042c23          	sw	zero,24(s0)
   107f4:	00800613          	li	a2,8
   107f8:	00000593          	li	a1,0
   107fc:	05c40513          	addi	a0,s0,92
   10800:	61c000ef          	jal	10e1c <memset>
   10804:	02042823          	sw	zero,48(s0)
   10808:	02042a23          	sw	zero,52(s0)
   1080c:	04042223          	sw	zero,68(s0)
   10810:	04042423          	sw	zero,72(s0)
   10814:	01c12083          	lw	ra,28(sp)
   10818:	00040513          	mv	a0,s0
   1081c:	01812403          	lw	s0,24(sp)
   10820:	01412483          	lw	s1,20(sp)
   10824:	02010113          	addi	sp,sp,32
   10828:	00008067          	ret
   1082c:	00082403          	lw	s0,0(a6)
   10830:	00040663          	beqz	s0,1083c <__sfp+0xc0>
   10834:	00040813          	mv	a6,s0
   10838:	f6dff06f          	j	107a4 <__sfp+0x28>
   1083c:	1ac00593          	li	a1,428
   10840:	00048513          	mv	a0,s1
   10844:	01012623          	sw	a6,12(sp)
   10848:	421000ef          	jal	11468 <_malloc_r>
   1084c:	00c12803          	lw	a6,12(sp)
   10850:	00050413          	mv	s0,a0
   10854:	04050263          	beqz	a0,10898 <__sfp+0x11c>
   10858:	00400793          	li	a5,4
   1085c:	00f52223          	sw	a5,4(a0)
   10860:	00c50513          	addi	a0,a0,12
   10864:	00042023          	sw	zero,0(s0)
   10868:	00a42423          	sw	a0,8(s0)
   1086c:	1a000613          	li	a2,416
   10870:	00000593          	li	a1,0
   10874:	01012623          	sw	a6,12(sp)
   10878:	5a4000ef          	jal	10e1c <memset>
   1087c:	00c12803          	lw	a6,12(sp)
   10880:	fff00693          	li	a3,-1
   10884:	00882023          	sw	s0,0(a6)
   10888:	00040813          	mv	a6,s0
   1088c:	f19ff06f          	j	107a4 <__sfp+0x28>
   10890:	d99ff0ef          	jal	10628 <global_stdio_init.part.0>
   10894:	f05ff06f          	j	10798 <__sfp+0x1c>
   10898:	00082023          	sw	zero,0(a6)
   1089c:	00c00793          	li	a5,12
   108a0:	00f4a023          	sw	a5,0(s1)
   108a4:	f71ff06f          	j	10814 <__sfp+0x98>

000108a8 <__sinit>:
   108a8:	03452783          	lw	a5,52(a0)
   108ac:	00078463          	beqz	a5,108b4 <__sinit+0xc>
   108b0:	00008067          	ret
   108b4:	000107b7          	lui	a5,0x10
   108b8:	d681a703          	lw	a4,-664(gp) # 13a78 <__stdio_exit_handler>
   108bc:	5bc78793          	addi	a5,a5,1468 # 105bc <cleanup_stdio>
   108c0:	02f52a23          	sw	a5,52(a0)
   108c4:	fe0716e3          	bnez	a4,108b0 <__sinit+0x8>
   108c8:	d61ff06f          	j	10628 <global_stdio_init.part.0>

000108cc <__sfp_lock_acquire>:
   108cc:	00008067          	ret

000108d0 <__sfp_lock_release>:
   108d0:	00008067          	ret

000108d4 <__fp_lock_all>:
   108d4:	00013637          	lui	a2,0x13
   108d8:	000105b7          	lui	a1,0x10
   108dc:	51060613          	addi	a2,a2,1296 # 13510 <__sglue>
   108e0:	59858593          	addi	a1,a1,1432 # 10598 <__fp_lock>
   108e4:	00000513          	li	a0,0
   108e8:	01c0006f          	j	10904 <_fwalk_sglue>

000108ec <__fp_unlock_all>:
   108ec:	00013637          	lui	a2,0x13
   108f0:	000105b7          	lui	a1,0x10
   108f4:	51060613          	addi	a2,a2,1296 # 13510 <__sglue>
   108f8:	62058593          	addi	a1,a1,1568 # 10620 <__fp_unlock>
   108fc:	00000513          	li	a0,0
   10900:	0040006f          	j	10904 <_fwalk_sglue>

00010904 <_fwalk_sglue>:
   10904:	fd010113          	addi	sp,sp,-48
   10908:	03212023          	sw	s2,32(sp)
   1090c:	01312e23          	sw	s3,28(sp)
   10910:	01412c23          	sw	s4,24(sp)
   10914:	01512a23          	sw	s5,20(sp)
   10918:	01612823          	sw	s6,16(sp)
   1091c:	01712623          	sw	s7,12(sp)
   10920:	02112623          	sw	ra,44(sp)
   10924:	02812423          	sw	s0,40(sp)
   10928:	02912223          	sw	s1,36(sp)
   1092c:	00060a93          	mv	s5,a2
   10930:	00050b13          	mv	s6,a0
   10934:	00058b93          	mv	s7,a1
   10938:	00000a13          	li	s4,0
   1093c:	00100993          	li	s3,1
   10940:	fff00913          	li	s2,-1
   10944:	004aa483          	lw	s1,4(s5)
   10948:	fff48493          	addi	s1,s1,-1
   1094c:	0204ca63          	bltz	s1,10980 <_fwalk_sglue+0x7c>
   10950:	008aa403          	lw	s0,8(s5)
   10954:	00c45783          	lhu	a5,12(s0)
   10958:	00f9fe63          	bgeu	s3,a5,10974 <_fwalk_sglue+0x70>
   1095c:	00e41783          	lh	a5,14(s0)
   10960:	00040593          	mv	a1,s0
   10964:	000b0513          	mv	a0,s6
   10968:	01278663          	beq	a5,s2,10974 <_fwalk_sglue+0x70>
   1096c:	000b80e7          	jalr	s7
   10970:	00aa6a33          	or	s4,s4,a0
   10974:	fff48493          	addi	s1,s1,-1
   10978:	06840413          	addi	s0,s0,104
   1097c:	fd249ce3          	bne	s1,s2,10954 <_fwalk_sglue+0x50>
   10980:	000aaa83          	lw	s5,0(s5)
   10984:	fc0a90e3          	bnez	s5,10944 <_fwalk_sglue+0x40>
   10988:	02c12083          	lw	ra,44(sp)
   1098c:	02812403          	lw	s0,40(sp)
   10990:	02412483          	lw	s1,36(sp)
   10994:	02012903          	lw	s2,32(sp)
   10998:	01c12983          	lw	s3,28(sp)
   1099c:	01412a83          	lw	s5,20(sp)
   109a0:	01012b03          	lw	s6,16(sp)
   109a4:	00c12b83          	lw	s7,12(sp)
   109a8:	000a0513          	mv	a0,s4
   109ac:	01812a03          	lw	s4,24(sp)
   109b0:	03010113          	addi	sp,sp,48
   109b4:	00008067          	ret

000109b8 <__sread>:
   109b8:	ff010113          	addi	sp,sp,-16
   109bc:	00812423          	sw	s0,8(sp)
   109c0:	00058413          	mv	s0,a1
   109c4:	00e59583          	lh	a1,14(a1)
   109c8:	00112623          	sw	ra,12(sp)
   109cc:	2ec000ef          	jal	10cb8 <_read_r>
   109d0:	02054063          	bltz	a0,109f0 <__sread+0x38>
   109d4:	05042783          	lw	a5,80(s0)
   109d8:	00c12083          	lw	ra,12(sp)
   109dc:	00a787b3          	add	a5,a5,a0
   109e0:	04f42823          	sw	a5,80(s0)
   109e4:	00812403          	lw	s0,8(sp)
   109e8:	01010113          	addi	sp,sp,16
   109ec:	00008067          	ret
   109f0:	00c45783          	lhu	a5,12(s0)
   109f4:	fffff737          	lui	a4,0xfffff
   109f8:	fff70713          	addi	a4,a4,-1 # ffffefff <__BSS_END__+0xfffeb25f>
   109fc:	00e7f7b3          	and	a5,a5,a4
   10a00:	00c12083          	lw	ra,12(sp)
   10a04:	00f41623          	sh	a5,12(s0)
   10a08:	00812403          	lw	s0,8(sp)
   10a0c:	01010113          	addi	sp,sp,16
   10a10:	00008067          	ret

00010a14 <__seofread>:
   10a14:	00000513          	li	a0,0
   10a18:	00008067          	ret

00010a1c <__swrite>:
   10a1c:	00c59783          	lh	a5,12(a1)
   10a20:	fe010113          	addi	sp,sp,-32
   10a24:	00068313          	mv	t1,a3
   10a28:	00112e23          	sw	ra,28(sp)
   10a2c:	1007f693          	andi	a3,a5,256
   10a30:	00058713          	mv	a4,a1
   10a34:	00060893          	mv	a7,a2
   10a38:	00050813          	mv	a6,a0
   10a3c:	02069863          	bnez	a3,10a6c <__swrite+0x50>
   10a40:	fffff6b7          	lui	a3,0xfffff
   10a44:	fff68693          	addi	a3,a3,-1 # ffffefff <__BSS_END__+0xfffeb25f>
   10a48:	01c12083          	lw	ra,28(sp)
   10a4c:	00d7f7b3          	and	a5,a5,a3
   10a50:	00e71583          	lh	a1,14(a4)
   10a54:	00f71623          	sh	a5,12(a4)
   10a58:	00030693          	mv	a3,t1
   10a5c:	00088613          	mv	a2,a7
   10a60:	00080513          	mv	a0,a6
   10a64:	02010113          	addi	sp,sp,32
   10a68:	2b80006f          	j	10d20 <_write_r>
   10a6c:	00e59583          	lh	a1,14(a1)
   10a70:	00c12423          	sw	a2,8(sp)
   10a74:	00200693          	li	a3,2
   10a78:	00000613          	li	a2,0
   10a7c:	00612623          	sw	t1,12(sp)
   10a80:	00e12023          	sw	a4,0(sp)
   10a84:	00a12223          	sw	a0,4(sp)
   10a88:	1c8000ef          	jal	10c50 <_lseek_r>
   10a8c:	00012703          	lw	a4,0(sp)
   10a90:	00c12303          	lw	t1,12(sp)
   10a94:	00812883          	lw	a7,8(sp)
   10a98:	00c71783          	lh	a5,12(a4)
   10a9c:	00412803          	lw	a6,4(sp)
   10aa0:	fa1ff06f          	j	10a40 <__swrite+0x24>

00010aa4 <__sseek>:
   10aa4:	ff010113          	addi	sp,sp,-16
   10aa8:	00812423          	sw	s0,8(sp)
   10aac:	00058413          	mv	s0,a1
   10ab0:	00e59583          	lh	a1,14(a1)
   10ab4:	00112623          	sw	ra,12(sp)
   10ab8:	198000ef          	jal	10c50 <_lseek_r>
   10abc:	fff00713          	li	a4,-1
   10ac0:	00c41783          	lh	a5,12(s0)
   10ac4:	02e50263          	beq	a0,a4,10ae8 <__sseek+0x44>
   10ac8:	00001737          	lui	a4,0x1
   10acc:	00e7e7b3          	or	a5,a5,a4
   10ad0:	00c12083          	lw	ra,12(sp)
   10ad4:	04a42823          	sw	a0,80(s0)
   10ad8:	00f41623          	sh	a5,12(s0)
   10adc:	00812403          	lw	s0,8(sp)
   10ae0:	01010113          	addi	sp,sp,16
   10ae4:	00008067          	ret
   10ae8:	80050713          	addi	a4,a0,-2048
   10aec:	80070713          	addi	a4,a4,-2048 # 800 <exit-0xf8b4>
   10af0:	00e7f7b3          	and	a5,a5,a4
   10af4:	00c12083          	lw	ra,12(sp)
   10af8:	00f41623          	sh	a5,12(s0)
   10afc:	00812403          	lw	s0,8(sp)
   10b00:	01010113          	addi	sp,sp,16
   10b04:	00008067          	ret

00010b08 <__sclose>:
   10b08:	00e59583          	lh	a1,14(a1)
   10b0c:	0040006f          	j	10b10 <_close_r>

00010b10 <_close_r>:
   10b10:	ff010113          	addi	sp,sp,-16
   10b14:	00812423          	sw	s0,8(sp)
   10b18:	00912223          	sw	s1,4(sp)
   10b1c:	00050493          	mv	s1,a0
   10b20:	00058513          	mv	a0,a1
   10b24:	00112623          	sw	ra,12(sp)
   10b28:	d601a623          	sw	zero,-660(gp) # 13a7c <errno>
   10b2c:	770010ef          	jal	1229c <_close>
   10b30:	fff00793          	li	a5,-1
   10b34:	00f50c63          	beq	a0,a5,10b4c <_close_r+0x3c>
   10b38:	00c12083          	lw	ra,12(sp)
   10b3c:	00812403          	lw	s0,8(sp)
   10b40:	00412483          	lw	s1,4(sp)
   10b44:	01010113          	addi	sp,sp,16
   10b48:	00008067          	ret
   10b4c:	d6c1a783          	lw	a5,-660(gp) # 13a7c <errno>
   10b50:	fe0784e3          	beqz	a5,10b38 <_close_r+0x28>
   10b54:	00c12083          	lw	ra,12(sp)
   10b58:	00812403          	lw	s0,8(sp)
   10b5c:	00f4a023          	sw	a5,0(s1)
   10b60:	00412483          	lw	s1,4(sp)
   10b64:	01010113          	addi	sp,sp,16
   10b68:	00008067          	ret

00010b6c <_reclaim_reent>:
   10b6c:	d5c1a783          	lw	a5,-676(gp) # 13a6c <_impure_ptr>
   10b70:	0ca78e63          	beq	a5,a0,10c4c <_reclaim_reent+0xe0>
   10b74:	04452583          	lw	a1,68(a0)
   10b78:	fe010113          	addi	sp,sp,-32
   10b7c:	00912a23          	sw	s1,20(sp)
   10b80:	00112e23          	sw	ra,28(sp)
   10b84:	00812c23          	sw	s0,24(sp)
   10b88:	00050493          	mv	s1,a0
   10b8c:	04058863          	beqz	a1,10bdc <_reclaim_reent+0x70>
   10b90:	01212823          	sw	s2,16(sp)
   10b94:	01312623          	sw	s3,12(sp)
   10b98:	00000913          	li	s2,0
   10b9c:	08000993          	li	s3,128
   10ba0:	012587b3          	add	a5,a1,s2
   10ba4:	0007a403          	lw	s0,0(a5)
   10ba8:	00040e63          	beqz	s0,10bc4 <_reclaim_reent+0x58>
   10bac:	00040593          	mv	a1,s0
   10bb0:	00042403          	lw	s0,0(s0)
   10bb4:	00048513          	mv	a0,s1
   10bb8:	5c8000ef          	jal	11180 <_free_r>
   10bbc:	fe0418e3          	bnez	s0,10bac <_reclaim_reent+0x40>
   10bc0:	0444a583          	lw	a1,68(s1)
   10bc4:	00490913          	addi	s2,s2,4
   10bc8:	fd391ce3          	bne	s2,s3,10ba0 <_reclaim_reent+0x34>
   10bcc:	00048513          	mv	a0,s1
   10bd0:	5b0000ef          	jal	11180 <_free_r>
   10bd4:	01012903          	lw	s2,16(sp)
   10bd8:	00c12983          	lw	s3,12(sp)
   10bdc:	0384a583          	lw	a1,56(s1)
   10be0:	00058663          	beqz	a1,10bec <_reclaim_reent+0x80>
   10be4:	00048513          	mv	a0,s1
   10be8:	598000ef          	jal	11180 <_free_r>
   10bec:	0404a403          	lw	s0,64(s1)
   10bf0:	00040c63          	beqz	s0,10c08 <_reclaim_reent+0x9c>
   10bf4:	00040593          	mv	a1,s0
   10bf8:	00042403          	lw	s0,0(s0)
   10bfc:	00048513          	mv	a0,s1
   10c00:	580000ef          	jal	11180 <_free_r>
   10c04:	fe0418e3          	bnez	s0,10bf4 <_reclaim_reent+0x88>
   10c08:	04c4a583          	lw	a1,76(s1)
   10c0c:	00058663          	beqz	a1,10c18 <_reclaim_reent+0xac>
   10c10:	00048513          	mv	a0,s1
   10c14:	56c000ef          	jal	11180 <_free_r>
   10c18:	0344a783          	lw	a5,52(s1)
   10c1c:	00078e63          	beqz	a5,10c38 <_reclaim_reent+0xcc>
   10c20:	01812403          	lw	s0,24(sp)
   10c24:	01c12083          	lw	ra,28(sp)
   10c28:	00048513          	mv	a0,s1
   10c2c:	01412483          	lw	s1,20(sp)
   10c30:	02010113          	addi	sp,sp,32
   10c34:	00078067          	jr	a5
   10c38:	01c12083          	lw	ra,28(sp)
   10c3c:	01812403          	lw	s0,24(sp)
   10c40:	01412483          	lw	s1,20(sp)
   10c44:	02010113          	addi	sp,sp,32
   10c48:	00008067          	ret
   10c4c:	00008067          	ret

00010c50 <_lseek_r>:
   10c50:	ff010113          	addi	sp,sp,-16
   10c54:	00058793          	mv	a5,a1
   10c58:	00812423          	sw	s0,8(sp)
   10c5c:	00912223          	sw	s1,4(sp)
   10c60:	00060593          	mv	a1,a2
   10c64:	00050493          	mv	s1,a0
   10c68:	00068613          	mv	a2,a3
   10c6c:	00078513          	mv	a0,a5
   10c70:	00112623          	sw	ra,12(sp)
   10c74:	d601a623          	sw	zero,-660(gp) # 13a7c <errno>
   10c78:	694010ef          	jal	1230c <_lseek>
   10c7c:	fff00793          	li	a5,-1
   10c80:	00f50c63          	beq	a0,a5,10c98 <_lseek_r+0x48>
   10c84:	00c12083          	lw	ra,12(sp)
   10c88:	00812403          	lw	s0,8(sp)
   10c8c:	00412483          	lw	s1,4(sp)
   10c90:	01010113          	addi	sp,sp,16
   10c94:	00008067          	ret
   10c98:	d6c1a783          	lw	a5,-660(gp) # 13a7c <errno>
   10c9c:	fe0784e3          	beqz	a5,10c84 <_lseek_r+0x34>
   10ca0:	00c12083          	lw	ra,12(sp)
   10ca4:	00812403          	lw	s0,8(sp)
   10ca8:	00f4a023          	sw	a5,0(s1)
   10cac:	00412483          	lw	s1,4(sp)
   10cb0:	01010113          	addi	sp,sp,16
   10cb4:	00008067          	ret

00010cb8 <_read_r>:
   10cb8:	ff010113          	addi	sp,sp,-16
   10cbc:	00058793          	mv	a5,a1
   10cc0:	00812423          	sw	s0,8(sp)
   10cc4:	00912223          	sw	s1,4(sp)
   10cc8:	00060593          	mv	a1,a2
   10ccc:	00050493          	mv	s1,a0
   10cd0:	00068613          	mv	a2,a3
   10cd4:	00078513          	mv	a0,a5
   10cd8:	00112623          	sw	ra,12(sp)
   10cdc:	d601a623          	sw	zero,-660(gp) # 13a7c <errno>
   10ce0:	66c010ef          	jal	1234c <_read>
   10ce4:	fff00793          	li	a5,-1
   10ce8:	00f50c63          	beq	a0,a5,10d00 <_read_r+0x48>
   10cec:	00c12083          	lw	ra,12(sp)
   10cf0:	00812403          	lw	s0,8(sp)
   10cf4:	00412483          	lw	s1,4(sp)
   10cf8:	01010113          	addi	sp,sp,16
   10cfc:	00008067          	ret
   10d00:	d6c1a783          	lw	a5,-660(gp) # 13a7c <errno>
   10d04:	fe0784e3          	beqz	a5,10cec <_read_r+0x34>
   10d08:	00c12083          	lw	ra,12(sp)
   10d0c:	00812403          	lw	s0,8(sp)
   10d10:	00f4a023          	sw	a5,0(s1)
   10d14:	00412483          	lw	s1,4(sp)
   10d18:	01010113          	addi	sp,sp,16
   10d1c:	00008067          	ret

00010d20 <_write_r>:
   10d20:	ff010113          	addi	sp,sp,-16
   10d24:	00058793          	mv	a5,a1
   10d28:	00812423          	sw	s0,8(sp)
   10d2c:	00912223          	sw	s1,4(sp)
   10d30:	00060593          	mv	a1,a2
   10d34:	00050493          	mv	s1,a0
   10d38:	00068613          	mv	a2,a3
   10d3c:	00078513          	mv	a0,a5
   10d40:	00112623          	sw	ra,12(sp)
   10d44:	d601a623          	sw	zero,-660(gp) # 13a7c <errno>
   10d48:	6bc010ef          	jal	12404 <_write>
   10d4c:	fff00793          	li	a5,-1
   10d50:	00f50c63          	beq	a0,a5,10d68 <_write_r+0x48>
   10d54:	00c12083          	lw	ra,12(sp)
   10d58:	00812403          	lw	s0,8(sp)
   10d5c:	00412483          	lw	s1,4(sp)
   10d60:	01010113          	addi	sp,sp,16
   10d64:	00008067          	ret
   10d68:	d6c1a783          	lw	a5,-660(gp) # 13a7c <errno>
   10d6c:	fe0784e3          	beqz	a5,10d54 <_write_r+0x34>
   10d70:	00c12083          	lw	ra,12(sp)
   10d74:	00812403          	lw	s0,8(sp)
   10d78:	00f4a023          	sw	a5,0(s1)
   10d7c:	00412483          	lw	s1,4(sp)
   10d80:	01010113          	addi	sp,sp,16
   10d84:	00008067          	ret

00010d88 <__libc_init_array>:
   10d88:	ff010113          	addi	sp,sp,-16
   10d8c:	00812423          	sw	s0,8(sp)
   10d90:	01212023          	sw	s2,0(sp)
   10d94:	00013437          	lui	s0,0x13
   10d98:	00013937          	lui	s2,0x13
   10d9c:	00112623          	sw	ra,12(sp)
   10da0:	00912223          	sw	s1,4(sp)
   10da4:	50090913          	addi	s2,s2,1280 # 13500 <__init_array_start>
   10da8:	50040413          	addi	s0,s0,1280 # 13500 <__init_array_start>
   10dac:	02890263          	beq	s2,s0,10dd0 <__libc_init_array+0x48>
   10db0:	40890933          	sub	s2,s2,s0
   10db4:	40295913          	srai	s2,s2,0x2
   10db8:	00000493          	li	s1,0
   10dbc:	00042783          	lw	a5,0(s0)
   10dc0:	00148493          	addi	s1,s1,1
   10dc4:	00440413          	addi	s0,s0,4
   10dc8:	000780e7          	jalr	a5
   10dcc:	ff24e8e3          	bltu	s1,s2,10dbc <__libc_init_array+0x34>
   10dd0:	00013937          	lui	s2,0x13
   10dd4:	00013437          	lui	s0,0x13
   10dd8:	50890913          	addi	s2,s2,1288 # 13508 <__do_global_dtors_aux_fini_array_entry>
   10ddc:	50040413          	addi	s0,s0,1280 # 13500 <__init_array_start>
   10de0:	02890263          	beq	s2,s0,10e04 <__libc_init_array+0x7c>
   10de4:	40890933          	sub	s2,s2,s0
   10de8:	40295913          	srai	s2,s2,0x2
   10dec:	00000493          	li	s1,0
   10df0:	00042783          	lw	a5,0(s0)
   10df4:	00148493          	addi	s1,s1,1
   10df8:	00440413          	addi	s0,s0,4
   10dfc:	000780e7          	jalr	a5
   10e00:	ff24e8e3          	bltu	s1,s2,10df0 <__libc_init_array+0x68>
   10e04:	00c12083          	lw	ra,12(sp)
   10e08:	00812403          	lw	s0,8(sp)
   10e0c:	00412483          	lw	s1,4(sp)
   10e10:	00012903          	lw	s2,0(sp)
   10e14:	01010113          	addi	sp,sp,16
   10e18:	00008067          	ret

00010e1c <memset>:
   10e1c:	00f00313          	li	t1,15
   10e20:	00050713          	mv	a4,a0
   10e24:	02c37e63          	bgeu	t1,a2,10e60 <memset+0x44>
   10e28:	00f77793          	andi	a5,a4,15
   10e2c:	0a079063          	bnez	a5,10ecc <memset+0xb0>
   10e30:	08059263          	bnez	a1,10eb4 <memset+0x98>
   10e34:	ff067693          	andi	a3,a2,-16
   10e38:	00f67613          	andi	a2,a2,15
   10e3c:	00e686b3          	add	a3,a3,a4
   10e40:	00b72023          	sw	a1,0(a4)
   10e44:	00b72223          	sw	a1,4(a4)
   10e48:	00b72423          	sw	a1,8(a4)
   10e4c:	00b72623          	sw	a1,12(a4)
   10e50:	01070713          	addi	a4,a4,16
   10e54:	fed766e3          	bltu	a4,a3,10e40 <memset+0x24>
   10e58:	00061463          	bnez	a2,10e60 <memset+0x44>
   10e5c:	00008067          	ret
   10e60:	40c306b3          	sub	a3,t1,a2
   10e64:	00269693          	slli	a3,a3,0x2
   10e68:	00000297          	auipc	t0,0x0
   10e6c:	005686b3          	add	a3,a3,t0
   10e70:	00c68067          	jr	12(a3)
   10e74:	00b70723          	sb	a1,14(a4)
   10e78:	00b706a3          	sb	a1,13(a4)
   10e7c:	00b70623          	sb	a1,12(a4)
   10e80:	00b705a3          	sb	a1,11(a4)
   10e84:	00b70523          	sb	a1,10(a4)
   10e88:	00b704a3          	sb	a1,9(a4)
   10e8c:	00b70423          	sb	a1,8(a4)
   10e90:	00b703a3          	sb	a1,7(a4)
   10e94:	00b70323          	sb	a1,6(a4)
   10e98:	00b702a3          	sb	a1,5(a4)
   10e9c:	00b70223          	sb	a1,4(a4)
   10ea0:	00b701a3          	sb	a1,3(a4)
   10ea4:	00b70123          	sb	a1,2(a4)
   10ea8:	00b700a3          	sb	a1,1(a4)
   10eac:	00b70023          	sb	a1,0(a4)
   10eb0:	00008067          	ret
   10eb4:	0ff5f593          	zext.b	a1,a1
   10eb8:	00859693          	slli	a3,a1,0x8
   10ebc:	00d5e5b3          	or	a1,a1,a3
   10ec0:	01059693          	slli	a3,a1,0x10
   10ec4:	00d5e5b3          	or	a1,a1,a3
   10ec8:	f6dff06f          	j	10e34 <memset+0x18>
   10ecc:	00279693          	slli	a3,a5,0x2
   10ed0:	00000297          	auipc	t0,0x0
   10ed4:	005686b3          	add	a3,a3,t0
   10ed8:	00008293          	mv	t0,ra
   10edc:	fa0680e7          	jalr	-96(a3)
   10ee0:	00028093          	mv	ra,t0
   10ee4:	ff078793          	addi	a5,a5,-16
   10ee8:	40f70733          	sub	a4,a4,a5
   10eec:	00f60633          	add	a2,a2,a5
   10ef0:	f6c378e3          	bgeu	t1,a2,10e60 <memset+0x44>
   10ef4:	f3dff06f          	j	10e30 <memset+0x14>

00010ef8 <__call_exitprocs>:
   10ef8:	fd010113          	addi	sp,sp,-48
   10efc:	01412c23          	sw	s4,24(sp)
   10f00:	03212023          	sw	s2,32(sp)
   10f04:	d701a903          	lw	s2,-656(gp) # 13a80 <__atexit>
   10f08:	02112623          	sw	ra,44(sp)
   10f0c:	0a090863          	beqz	s2,10fbc <__call_exitprocs+0xc4>
   10f10:	01312e23          	sw	s3,28(sp)
   10f14:	01512a23          	sw	s5,20(sp)
   10f18:	01612823          	sw	s6,16(sp)
   10f1c:	01712623          	sw	s7,12(sp)
   10f20:	02812423          	sw	s0,40(sp)
   10f24:	02912223          	sw	s1,36(sp)
   10f28:	01812423          	sw	s8,8(sp)
   10f2c:	00050b13          	mv	s6,a0
   10f30:	00058b93          	mv	s7,a1
   10f34:	fff00993          	li	s3,-1
   10f38:	00100a93          	li	s5,1
   10f3c:	00492483          	lw	s1,4(s2)
   10f40:	fff48413          	addi	s0,s1,-1
   10f44:	04044e63          	bltz	s0,10fa0 <__call_exitprocs+0xa8>
   10f48:	00249493          	slli	s1,s1,0x2
   10f4c:	009904b3          	add	s1,s2,s1
   10f50:	080b9063          	bnez	s7,10fd0 <__call_exitprocs+0xd8>
   10f54:	00492783          	lw	a5,4(s2)
   10f58:	0044a683          	lw	a3,4(s1)
   10f5c:	fff78793          	addi	a5,a5,-1
   10f60:	0c878463          	beq	a5,s0,11028 <__call_exitprocs+0x130>
   10f64:	0004a223          	sw	zero,4(s1)
   10f68:	02068663          	beqz	a3,10f94 <__call_exitprocs+0x9c>
   10f6c:	18892783          	lw	a5,392(s2)
   10f70:	008a9733          	sll	a4,s5,s0
   10f74:	00492c03          	lw	s8,4(s2)
   10f78:	00f777b3          	and	a5,a4,a5
   10f7c:	06079e63          	bnez	a5,10ff8 <__call_exitprocs+0x100>
   10f80:	000680e7          	jalr	a3
   10f84:	00492703          	lw	a4,4(s2)
   10f88:	d701a783          	lw	a5,-656(gp) # 13a80 <__atexit>
   10f8c:	09871863          	bne	a4,s8,1101c <__call_exitprocs+0x124>
   10f90:	09279663          	bne	a5,s2,1101c <__call_exitprocs+0x124>
   10f94:	fff40413          	addi	s0,s0,-1
   10f98:	ffc48493          	addi	s1,s1,-4
   10f9c:	fb341ae3          	bne	s0,s3,10f50 <__call_exitprocs+0x58>
   10fa0:	02812403          	lw	s0,40(sp)
   10fa4:	02412483          	lw	s1,36(sp)
   10fa8:	01c12983          	lw	s3,28(sp)
   10fac:	01412a83          	lw	s5,20(sp)
   10fb0:	01012b03          	lw	s6,16(sp)
   10fb4:	00c12b83          	lw	s7,12(sp)
   10fb8:	00812c03          	lw	s8,8(sp)
   10fbc:	02c12083          	lw	ra,44(sp)
   10fc0:	02012903          	lw	s2,32(sp)
   10fc4:	01812a03          	lw	s4,24(sp)
   10fc8:	03010113          	addi	sp,sp,48
   10fcc:	00008067          	ret
   10fd0:	1044a783          	lw	a5,260(s1)
   10fd4:	fff40713          	addi	a4,s0,-1
   10fd8:	f6fb8ee3          	beq	s7,a5,10f54 <__call_exitprocs+0x5c>
   10fdc:	ffe40413          	addi	s0,s0,-2
   10fe0:	fd3700e3          	beq	a4,s3,10fa0 <__call_exitprocs+0xa8>
   10fe4:	1004a783          	lw	a5,256(s1)
   10fe8:	05778463          	beq	a5,s7,11030 <__call_exitprocs+0x138>
   10fec:	ff848493          	addi	s1,s1,-8
   10ff0:	ff3410e3          	bne	s0,s3,10fd0 <__call_exitprocs+0xd8>
   10ff4:	fadff06f          	j	10fa0 <__call_exitprocs+0xa8>
   10ff8:	18c92783          	lw	a5,396(s2)
   10ffc:	0844a583          	lw	a1,132(s1)
   11000:	00f77733          	and	a4,a4,a5
   11004:	02071c63          	bnez	a4,1103c <__call_exitprocs+0x144>
   11008:	000b0513          	mv	a0,s6
   1100c:	000680e7          	jalr	a3
   11010:	00492703          	lw	a4,4(s2)
   11014:	d701a783          	lw	a5,-656(gp) # 13a80 <__atexit>
   11018:	f7870ce3          	beq	a4,s8,10f90 <__call_exitprocs+0x98>
   1101c:	f80782e3          	beqz	a5,10fa0 <__call_exitprocs+0xa8>
   11020:	00078913          	mv	s2,a5
   11024:	f19ff06f          	j	10f3c <__call_exitprocs+0x44>
   11028:	00892223          	sw	s0,4(s2)
   1102c:	f3dff06f          	j	10f68 <__call_exitprocs+0x70>
   11030:	00070413          	mv	s0,a4
   11034:	ffc48493          	addi	s1,s1,-4
   11038:	f1dff06f          	j	10f54 <__call_exitprocs+0x5c>
   1103c:	00058513          	mv	a0,a1
   11040:	000680e7          	jalr	a3
   11044:	f41ff06f          	j	10f84 <__call_exitprocs+0x8c>

00011048 <atexit>:
   11048:	00050593          	mv	a1,a0
   1104c:	00000693          	li	a3,0
   11050:	00000613          	li	a2,0
   11054:	00000513          	li	a0,0
   11058:	1b00106f          	j	12208 <__register_exitproc>

0001105c <_malloc_trim_r>:
   1105c:	fe010113          	addi	sp,sp,-32
   11060:	01212823          	sw	s2,16(sp)
   11064:	00013937          	lui	s2,0x13
   11068:	00812c23          	sw	s0,24(sp)
   1106c:	00912a23          	sw	s1,20(sp)
   11070:	01312623          	sw	s3,12(sp)
   11074:	00058413          	mv	s0,a1
   11078:	00112e23          	sw	ra,28(sp)
   1107c:	00050993          	mv	s3,a0
   11080:	66090913          	addi	s2,s2,1632 # 13660 <__malloc_av_>
   11084:	461000ef          	jal	11ce4 <__malloc_lock>
   11088:	00892783          	lw	a5,8(s2)
   1108c:	00001737          	lui	a4,0x1
   11090:	0047a483          	lw	s1,4(a5)
   11094:	ffc4f493          	andi	s1,s1,-4
   11098:	7ff48793          	addi	a5,s1,2047
   1109c:	7f078793          	addi	a5,a5,2032
   110a0:	40878433          	sub	s0,a5,s0
   110a4:	00c45413          	srli	s0,s0,0xc
   110a8:	fff40413          	addi	s0,s0,-1
   110ac:	00c41413          	slli	s0,s0,0xc
   110b0:	00e44e63          	blt	s0,a4,110cc <_malloc_trim_r+0x70>
   110b4:	00000593          	li	a1,0
   110b8:	00098513          	mv	a0,s3
   110bc:	094010ef          	jal	12150 <_sbrk_r>
   110c0:	00892783          	lw	a5,8(s2)
   110c4:	009787b3          	add	a5,a5,s1
   110c8:	02f50663          	beq	a0,a5,110f4 <_malloc_trim_r+0x98>
   110cc:	00098513          	mv	a0,s3
   110d0:	419000ef          	jal	11ce8 <__malloc_unlock>
   110d4:	01c12083          	lw	ra,28(sp)
   110d8:	01812403          	lw	s0,24(sp)
   110dc:	01412483          	lw	s1,20(sp)
   110e0:	01012903          	lw	s2,16(sp)
   110e4:	00c12983          	lw	s3,12(sp)
   110e8:	00000513          	li	a0,0
   110ec:	02010113          	addi	sp,sp,32
   110f0:	00008067          	ret
   110f4:	408005b3          	neg	a1,s0
   110f8:	00098513          	mv	a0,s3
   110fc:	054010ef          	jal	12150 <_sbrk_r>
   11100:	fff00793          	li	a5,-1
   11104:	04f50463          	beq	a0,a5,1114c <_malloc_trim_r+0xf0>
   11108:	00892683          	lw	a3,8(s2)
   1110c:	ed81a783          	lw	a5,-296(gp) # 13be8 <__malloc_current_mallinfo>
   11110:	408484b3          	sub	s1,s1,s0
   11114:	0014e493          	ori	s1,s1,1
   11118:	00098513          	mv	a0,s3
   1111c:	408787b3          	sub	a5,a5,s0
   11120:	0096a223          	sw	s1,4(a3)
   11124:	ecf1ac23          	sw	a5,-296(gp) # 13be8 <__malloc_current_mallinfo>
   11128:	3c1000ef          	jal	11ce8 <__malloc_unlock>
   1112c:	01c12083          	lw	ra,28(sp)
   11130:	01812403          	lw	s0,24(sp)
   11134:	01412483          	lw	s1,20(sp)
   11138:	01012903          	lw	s2,16(sp)
   1113c:	00c12983          	lw	s3,12(sp)
   11140:	00100513          	li	a0,1
   11144:	02010113          	addi	sp,sp,32
   11148:	00008067          	ret
   1114c:	00000593          	li	a1,0
   11150:	00098513          	mv	a0,s3
   11154:	7fd000ef          	jal	12150 <_sbrk_r>
   11158:	00892703          	lw	a4,8(s2)
   1115c:	00f00693          	li	a3,15
   11160:	40e507b3          	sub	a5,a0,a4
   11164:	f6f6d4e3          	bge	a3,a5,110cc <_malloc_trim_r+0x70>
   11168:	d601a603          	lw	a2,-672(gp) # 13a70 <__malloc_sbrk_base>
   1116c:	0017e793          	ori	a5,a5,1
   11170:	40c50533          	sub	a0,a0,a2
   11174:	00f72223          	sw	a5,4(a4) # 1004 <exit-0xf0b0>
   11178:	eca1ac23          	sw	a0,-296(gp) # 13be8 <__malloc_current_mallinfo>
   1117c:	f51ff06f          	j	110cc <_malloc_trim_r+0x70>

00011180 <_free_r>:
   11180:	12058463          	beqz	a1,112a8 <_free_r+0x128>
   11184:	fe010113          	addi	sp,sp,-32
   11188:	00812c23          	sw	s0,24(sp)
   1118c:	00b12623          	sw	a1,12(sp)
   11190:	00050413          	mv	s0,a0
   11194:	00112e23          	sw	ra,28(sp)
   11198:	34d000ef          	jal	11ce4 <__malloc_lock>
   1119c:	00c12583          	lw	a1,12(sp)
   111a0:	00013837          	lui	a6,0x13
   111a4:	66080813          	addi	a6,a6,1632 # 13660 <__malloc_av_>
   111a8:	ffc5a503          	lw	a0,-4(a1)
   111ac:	ff858713          	addi	a4,a1,-8
   111b0:	00882883          	lw	a7,8(a6)
   111b4:	ffe57793          	andi	a5,a0,-2
   111b8:	00f70633          	add	a2,a4,a5
   111bc:	00462683          	lw	a3,4(a2)
   111c0:	00157313          	andi	t1,a0,1
   111c4:	ffc6f693          	andi	a3,a3,-4
   111c8:	18c88863          	beq	a7,a2,11358 <_free_r+0x1d8>
   111cc:	00d62223          	sw	a3,4(a2)
   111d0:	00d608b3          	add	a7,a2,a3
   111d4:	0048a883          	lw	a7,4(a7)
   111d8:	0018f893          	andi	a7,a7,1
   111dc:	08031a63          	bnez	t1,11270 <_free_r+0xf0>
   111e0:	ff85a303          	lw	t1,-8(a1)
   111e4:	000135b7          	lui	a1,0x13
   111e8:	66858593          	addi	a1,a1,1640 # 13668 <__malloc_av_+0x8>
   111ec:	40670733          	sub	a4,a4,t1
   111f0:	00872503          	lw	a0,8(a4)
   111f4:	006787b3          	add	a5,a5,t1
   111f8:	12b50a63          	beq	a0,a1,1132c <_free_r+0x1ac>
   111fc:	00c72303          	lw	t1,12(a4)
   11200:	00652623          	sw	t1,12(a0)
   11204:	00a32423          	sw	a0,8(t1) # 101c0 <frame_dummy+0x1c>
   11208:	18088c63          	beqz	a7,113a0 <_free_r+0x220>
   1120c:	0017e693          	ori	a3,a5,1
   11210:	00d72223          	sw	a3,4(a4)
   11214:	00f62023          	sw	a5,0(a2)
   11218:	1ff00693          	li	a3,511
   1121c:	0af6e263          	bltu	a3,a5,112c0 <_free_r+0x140>
   11220:	ff87f693          	andi	a3,a5,-8
   11224:	00868693          	addi	a3,a3,8
   11228:	00482583          	lw	a1,4(a6)
   1122c:	00d806b3          	add	a3,a6,a3
   11230:	0006a603          	lw	a2,0(a3)
   11234:	0057d513          	srli	a0,a5,0x5
   11238:	00100793          	li	a5,1
   1123c:	00a797b3          	sll	a5,a5,a0
   11240:	00b7e7b3          	or	a5,a5,a1
   11244:	ff868593          	addi	a1,a3,-8
   11248:	00c72423          	sw	a2,8(a4)
   1124c:	00b72623          	sw	a1,12(a4)
   11250:	00f82223          	sw	a5,4(a6)
   11254:	00e6a023          	sw	a4,0(a3)
   11258:	00e62623          	sw	a4,12(a2)
   1125c:	00040513          	mv	a0,s0
   11260:	01812403          	lw	s0,24(sp)
   11264:	01c12083          	lw	ra,28(sp)
   11268:	02010113          	addi	sp,sp,32
   1126c:	27d0006f          	j	11ce8 <__malloc_unlock>
   11270:	02089e63          	bnez	a7,112ac <_free_r+0x12c>
   11274:	000135b7          	lui	a1,0x13
   11278:	00d787b3          	add	a5,a5,a3
   1127c:	66858593          	addi	a1,a1,1640 # 13668 <__malloc_av_+0x8>
   11280:	00862683          	lw	a3,8(a2)
   11284:	0017e893          	ori	a7,a5,1
   11288:	00f70533          	add	a0,a4,a5
   1128c:	16b68063          	beq	a3,a1,113ec <_free_r+0x26c>
   11290:	00c62603          	lw	a2,12(a2)
   11294:	00c6a623          	sw	a2,12(a3)
   11298:	00d62423          	sw	a3,8(a2)
   1129c:	01172223          	sw	a7,4(a4)
   112a0:	00f52023          	sw	a5,0(a0)
   112a4:	f75ff06f          	j	11218 <_free_r+0x98>
   112a8:	00008067          	ret
   112ac:	00156513          	ori	a0,a0,1
   112b0:	fea5ae23          	sw	a0,-4(a1)
   112b4:	00f62023          	sw	a5,0(a2)
   112b8:	1ff00693          	li	a3,511
   112bc:	f6f6f2e3          	bgeu	a3,a5,11220 <_free_r+0xa0>
   112c0:	0097d693          	srli	a3,a5,0x9
   112c4:	00400613          	li	a2,4
   112c8:	0ed66063          	bltu	a2,a3,113a8 <_free_r+0x228>
   112cc:	0067d693          	srli	a3,a5,0x6
   112d0:	03968593          	addi	a1,a3,57
   112d4:	00359593          	slli	a1,a1,0x3
   112d8:	03868613          	addi	a2,a3,56
   112dc:	00b805b3          	add	a1,a6,a1
   112e0:	0005a683          	lw	a3,0(a1)
   112e4:	ff858593          	addi	a1,a1,-8
   112e8:	00d59863          	bne	a1,a3,112f8 <_free_r+0x178>
   112ec:	11c0006f          	j	11408 <_free_r+0x288>
   112f0:	0086a683          	lw	a3,8(a3)
   112f4:	00d58863          	beq	a1,a3,11304 <_free_r+0x184>
   112f8:	0046a603          	lw	a2,4(a3)
   112fc:	ffc67613          	andi	a2,a2,-4
   11300:	fec7e8e3          	bltu	a5,a2,112f0 <_free_r+0x170>
   11304:	00c6a583          	lw	a1,12(a3)
   11308:	00b72623          	sw	a1,12(a4)
   1130c:	00d72423          	sw	a3,8(a4)
   11310:	00040513          	mv	a0,s0
   11314:	01812403          	lw	s0,24(sp)
   11318:	01c12083          	lw	ra,28(sp)
   1131c:	00e5a423          	sw	a4,8(a1)
   11320:	00e6a623          	sw	a4,12(a3)
   11324:	02010113          	addi	sp,sp,32
   11328:	1c10006f          	j	11ce8 <__malloc_unlock>
   1132c:	0a089063          	bnez	a7,113cc <_free_r+0x24c>
   11330:	00c62583          	lw	a1,12(a2)
   11334:	00862603          	lw	a2,8(a2)
   11338:	00f686b3          	add	a3,a3,a5
   1133c:	0016e793          	ori	a5,a3,1
   11340:	00b62623          	sw	a1,12(a2)
   11344:	00c5a423          	sw	a2,8(a1)
   11348:	00f72223          	sw	a5,4(a4)
   1134c:	00d70733          	add	a4,a4,a3
   11350:	00d72023          	sw	a3,0(a4)
   11354:	f09ff06f          	j	1125c <_free_r+0xdc>
   11358:	00d786b3          	add	a3,a5,a3
   1135c:	02031063          	bnez	t1,1137c <_free_r+0x1fc>
   11360:	ff85a783          	lw	a5,-8(a1)
   11364:	40f70733          	sub	a4,a4,a5
   11368:	00872603          	lw	a2,8(a4)
   1136c:	00f686b3          	add	a3,a3,a5
   11370:	00c72783          	lw	a5,12(a4)
   11374:	00f62623          	sw	a5,12(a2)
   11378:	00c7a423          	sw	a2,8(a5)
   1137c:	0016e613          	ori	a2,a3,1
   11380:	d641a783          	lw	a5,-668(gp) # 13a74 <__malloc_trim_threshold>
   11384:	00c72223          	sw	a2,4(a4)
   11388:	00e82423          	sw	a4,8(a6)
   1138c:	ecf6e8e3          	bltu	a3,a5,1125c <_free_r+0xdc>
   11390:	d7c1a583          	lw	a1,-644(gp) # 13a8c <__malloc_top_pad>
   11394:	00040513          	mv	a0,s0
   11398:	cc5ff0ef          	jal	1105c <_malloc_trim_r>
   1139c:	ec1ff06f          	j	1125c <_free_r+0xdc>
   113a0:	00d787b3          	add	a5,a5,a3
   113a4:	eddff06f          	j	11280 <_free_r+0x100>
   113a8:	01400613          	li	a2,20
   113ac:	02d67863          	bgeu	a2,a3,113dc <_free_r+0x25c>
   113b0:	05400613          	li	a2,84
   113b4:	06d66863          	bltu	a2,a3,11424 <_free_r+0x2a4>
   113b8:	00c7d693          	srli	a3,a5,0xc
   113bc:	06f68593          	addi	a1,a3,111
   113c0:	00359593          	slli	a1,a1,0x3
   113c4:	06e68613          	addi	a2,a3,110
   113c8:	f15ff06f          	j	112dc <_free_r+0x15c>
   113cc:	0017e693          	ori	a3,a5,1
   113d0:	00d72223          	sw	a3,4(a4)
   113d4:	00f62023          	sw	a5,0(a2)
   113d8:	e85ff06f          	j	1125c <_free_r+0xdc>
   113dc:	05c68593          	addi	a1,a3,92
   113e0:	00359593          	slli	a1,a1,0x3
   113e4:	05b68613          	addi	a2,a3,91
   113e8:	ef5ff06f          	j	112dc <_free_r+0x15c>
   113ec:	00e82a23          	sw	a4,20(a6)
   113f0:	00e82823          	sw	a4,16(a6)
   113f4:	00b72623          	sw	a1,12(a4)
   113f8:	00b72423          	sw	a1,8(a4)
   113fc:	01172223          	sw	a7,4(a4)
   11400:	00f52023          	sw	a5,0(a0)
   11404:	e59ff06f          	j	1125c <_free_r+0xdc>
   11408:	00482503          	lw	a0,4(a6)
   1140c:	40265613          	srai	a2,a2,0x2
   11410:	00100793          	li	a5,1
   11414:	00c797b3          	sll	a5,a5,a2
   11418:	00a7e7b3          	or	a5,a5,a0
   1141c:	00f82223          	sw	a5,4(a6)
   11420:	ee9ff06f          	j	11308 <_free_r+0x188>
   11424:	15400613          	li	a2,340
   11428:	00d66c63          	bltu	a2,a3,11440 <_free_r+0x2c0>
   1142c:	00f7d693          	srli	a3,a5,0xf
   11430:	07868593          	addi	a1,a3,120
   11434:	00359593          	slli	a1,a1,0x3
   11438:	07768613          	addi	a2,a3,119
   1143c:	ea1ff06f          	j	112dc <_free_r+0x15c>
   11440:	55400613          	li	a2,1364
   11444:	00d66c63          	bltu	a2,a3,1145c <_free_r+0x2dc>
   11448:	0127d693          	srli	a3,a5,0x12
   1144c:	07d68593          	addi	a1,a3,125
   11450:	00359593          	slli	a1,a1,0x3
   11454:	07c68613          	addi	a2,a3,124
   11458:	e85ff06f          	j	112dc <_free_r+0x15c>
   1145c:	3f800593          	li	a1,1016
   11460:	07e00613          	li	a2,126
   11464:	e79ff06f          	j	112dc <_free_r+0x15c>

00011468 <_malloc_r>:
   11468:	fc010113          	addi	sp,sp,-64
   1146c:	02812c23          	sw	s0,56(sp)
   11470:	02112e23          	sw	ra,60(sp)
   11474:	00b58793          	addi	a5,a1,11
   11478:	01600713          	li	a4,22
   1147c:	00050413          	mv	s0,a0
   11480:	08f76e63          	bltu	a4,a5,1151c <_malloc_r+0xb4>
   11484:	01000693          	li	a3,16
   11488:	06b6ec63          	bltu	a3,a1,11500 <_malloc_r+0x98>
   1148c:	059000ef          	jal	11ce4 <__malloc_lock>
   11490:	01000693          	li	a3,16
   11494:	01800713          	li	a4,24
   11498:	00200893          	li	a7,2
   1149c:	00013837          	lui	a6,0x13
   114a0:	66080813          	addi	a6,a6,1632 # 13660 <__malloc_av_>
   114a4:	00e80733          	add	a4,a6,a4
   114a8:	00472783          	lw	a5,4(a4)
   114ac:	ff870613          	addi	a2,a4,-8
   114b0:	44c78c63          	beq	a5,a2,11908 <_malloc_r+0x4a0>
   114b4:	0047a703          	lw	a4,4(a5)
   114b8:	00c7a603          	lw	a2,12(a5)
   114bc:	0087a583          	lw	a1,8(a5)
   114c0:	ffc77713          	andi	a4,a4,-4
   114c4:	00e78733          	add	a4,a5,a4
   114c8:	00472683          	lw	a3,4(a4)
   114cc:	00c5a623          	sw	a2,12(a1)
   114d0:	00f12623          	sw	a5,12(sp)
   114d4:	00b62423          	sw	a1,8(a2)
   114d8:	0016e693          	ori	a3,a3,1
   114dc:	00040513          	mv	a0,s0
   114e0:	00d72223          	sw	a3,4(a4)
   114e4:	005000ef          	jal	11ce8 <__malloc_unlock>
   114e8:	00c12783          	lw	a5,12(sp)
   114ec:	03c12083          	lw	ra,60(sp)
   114f0:	03812403          	lw	s0,56(sp)
   114f4:	00878513          	addi	a0,a5,8
   114f8:	04010113          	addi	sp,sp,64
   114fc:	00008067          	ret
   11500:	00c00793          	li	a5,12
   11504:	00f42023          	sw	a5,0(s0)
   11508:	00000513          	li	a0,0
   1150c:	03c12083          	lw	ra,60(sp)
   11510:	03812403          	lw	s0,56(sp)
   11514:	04010113          	addi	sp,sp,64
   11518:	00008067          	ret
   1151c:	ff87f693          	andi	a3,a5,-8
   11520:	fe07c0e3          	bltz	a5,11500 <_malloc_r+0x98>
   11524:	fcb6eee3          	bltu	a3,a1,11500 <_malloc_r+0x98>
   11528:	00d12623          	sw	a3,12(sp)
   1152c:	7b8000ef          	jal	11ce4 <__malloc_lock>
   11530:	00c12683          	lw	a3,12(sp)
   11534:	1f700793          	li	a5,503
   11538:	4cd7f663          	bgeu	a5,a3,11a04 <_malloc_r+0x59c>
   1153c:	0096d793          	srli	a5,a3,0x9
   11540:	16078e63          	beqz	a5,116bc <_malloc_r+0x254>
   11544:	00400713          	li	a4,4
   11548:	42f76863          	bltu	a4,a5,11978 <_malloc_r+0x510>
   1154c:	0066d793          	srli	a5,a3,0x6
   11550:	03978893          	addi	a7,a5,57
   11554:	03878e13          	addi	t3,a5,56
   11558:	00389513          	slli	a0,a7,0x3
   1155c:	00013837          	lui	a6,0x13
   11560:	66080813          	addi	a6,a6,1632 # 13660 <__malloc_av_>
   11564:	00a80533          	add	a0,a6,a0
   11568:	00452783          	lw	a5,4(a0)
   1156c:	ff850513          	addi	a0,a0,-8
   11570:	02f50863          	beq	a0,a5,115a0 <_malloc_r+0x138>
   11574:	00f00313          	li	t1,15
   11578:	0140006f          	j	1158c <_malloc_r+0x124>
   1157c:	00c7a583          	lw	a1,12(a5)
   11580:	34065463          	bgez	a2,118c8 <_malloc_r+0x460>
   11584:	00b50e63          	beq	a0,a1,115a0 <_malloc_r+0x138>
   11588:	00058793          	mv	a5,a1
   1158c:	0047a703          	lw	a4,4(a5)
   11590:	ffc77713          	andi	a4,a4,-4
   11594:	40d70633          	sub	a2,a4,a3
   11598:	fec352e3          	bge	t1,a2,1157c <_malloc_r+0x114>
   1159c:	000e0893          	mv	a7,t3
   115a0:	01082783          	lw	a5,16(a6)
   115a4:	00013e37          	lui	t3,0x13
   115a8:	668e0e13          	addi	t3,t3,1640 # 13668 <__malloc_av_+0x8>
   115ac:	2dc78c63          	beq	a5,t3,11884 <_malloc_r+0x41c>
   115b0:	0047a703          	lw	a4,4(a5)
   115b4:	00f00593          	li	a1,15
   115b8:	ffc77713          	andi	a4,a4,-4
   115bc:	40d70633          	sub	a2,a4,a3
   115c0:	46c5cc63          	blt	a1,a2,11a38 <_malloc_r+0x5d0>
   115c4:	01c82a23          	sw	t3,20(a6)
   115c8:	01c82823          	sw	t3,16(a6)
   115cc:	44065263          	bgez	a2,11a10 <_malloc_r+0x5a8>
   115d0:	1ff00613          	li	a2,511
   115d4:	00482303          	lw	t1,4(a6)
   115d8:	34e66063          	bltu	a2,a4,11918 <_malloc_r+0x4b0>
   115dc:	ff877613          	andi	a2,a4,-8
   115e0:	00860613          	addi	a2,a2,8
   115e4:	00c80633          	add	a2,a6,a2
   115e8:	00062583          	lw	a1,0(a2)
   115ec:	00575513          	srli	a0,a4,0x5
   115f0:	00100713          	li	a4,1
   115f4:	00a71733          	sll	a4,a4,a0
   115f8:	00e36333          	or	t1,t1,a4
   115fc:	ff860713          	addi	a4,a2,-8
   11600:	00b7a423          	sw	a1,8(a5)
   11604:	00e7a623          	sw	a4,12(a5)
   11608:	00682223          	sw	t1,4(a6)
   1160c:	00f62023          	sw	a5,0(a2)
   11610:	00f5a623          	sw	a5,12(a1)
   11614:	4028d793          	srai	a5,a7,0x2
   11618:	00100513          	li	a0,1
   1161c:	00f51533          	sll	a0,a0,a5
   11620:	0aa36663          	bltu	t1,a0,116cc <_malloc_r+0x264>
   11624:	006577b3          	and	a5,a0,t1
   11628:	02079463          	bnez	a5,11650 <_malloc_r+0x1e8>
   1162c:	00151513          	slli	a0,a0,0x1
   11630:	ffc8f893          	andi	a7,a7,-4
   11634:	006577b3          	and	a5,a0,t1
   11638:	00488893          	addi	a7,a7,4
   1163c:	00079a63          	bnez	a5,11650 <_malloc_r+0x1e8>
   11640:	00151513          	slli	a0,a0,0x1
   11644:	006577b3          	and	a5,a0,t1
   11648:	00488893          	addi	a7,a7,4
   1164c:	fe078ae3          	beqz	a5,11640 <_malloc_r+0x1d8>
   11650:	00f00e93          	li	t4,15
   11654:	00389f13          	slli	t5,a7,0x3
   11658:	01e80f33          	add	t5,a6,t5
   1165c:	000f0313          	mv	t1,t5
   11660:	00c32703          	lw	a4,12(t1)
   11664:	00088f93          	mv	t6,a7
   11668:	32e30a63          	beq	t1,a4,1199c <_malloc_r+0x534>
   1166c:	00472603          	lw	a2,4(a4)
   11670:	00070793          	mv	a5,a4
   11674:	00c72703          	lw	a4,12(a4)
   11678:	ffc67613          	andi	a2,a2,-4
   1167c:	40d605b3          	sub	a1,a2,a3
   11680:	32beca63          	blt	t4,a1,119b4 <_malloc_r+0x54c>
   11684:	fe05c2e3          	bltz	a1,11668 <_malloc_r+0x200>
   11688:	00c78633          	add	a2,a5,a2
   1168c:	00462683          	lw	a3,4(a2)
   11690:	0087a583          	lw	a1,8(a5)
   11694:	00040513          	mv	a0,s0
   11698:	0016e693          	ori	a3,a3,1
   1169c:	00d62223          	sw	a3,4(a2)
   116a0:	00e5a623          	sw	a4,12(a1)
   116a4:	00b72423          	sw	a1,8(a4)
   116a8:	00f12623          	sw	a5,12(sp)
   116ac:	63c000ef          	jal	11ce8 <__malloc_unlock>
   116b0:	00c12783          	lw	a5,12(sp)
   116b4:	00878513          	addi	a0,a5,8
   116b8:	e55ff06f          	j	1150c <_malloc_r+0xa4>
   116bc:	20000513          	li	a0,512
   116c0:	04000893          	li	a7,64
   116c4:	03f00e13          	li	t3,63
   116c8:	e95ff06f          	j	1155c <_malloc_r+0xf4>
   116cc:	00882783          	lw	a5,8(a6)
   116d0:	0047a703          	lw	a4,4(a5)
   116d4:	ffc77313          	andi	t1,a4,-4
   116d8:	40d30633          	sub	a2,t1,a3
   116dc:	00d36663          	bltu	t1,a3,116e8 <_malloc_r+0x280>
   116e0:	01062713          	slti	a4,a2,16
   116e4:	1a070463          	beqz	a4,1188c <_malloc_r+0x424>
   116e8:	d7c1a583          	lw	a1,-644(gp) # 13a8c <__malloc_top_pad>
   116ec:	d601a603          	lw	a2,-672(gp) # 13a70 <__malloc_sbrk_base>
   116f0:	fff00713          	li	a4,-1
   116f4:	00b685b3          	add	a1,a3,a1
   116f8:	42e60463          	beq	a2,a4,11b20 <_malloc_r+0x6b8>
   116fc:	00001737          	lui	a4,0x1
   11700:	00f70713          	addi	a4,a4,15 # 100f <exit-0xf0a5>
   11704:	00e585b3          	add	a1,a1,a4
   11708:	fffff737          	lui	a4,0xfffff
   1170c:	00e5f5b3          	and	a1,a1,a4
   11710:	00040513          	mv	a0,s0
   11714:	01012e23          	sw	a6,28(sp)
   11718:	00f12c23          	sw	a5,24(sp)
   1171c:	00d12a23          	sw	a3,20(sp)
   11720:	00612823          	sw	t1,16(sp)
   11724:	00b12623          	sw	a1,12(sp)
   11728:	229000ef          	jal	12150 <_sbrk_r>
   1172c:	fff00713          	li	a4,-1
   11730:	00c12583          	lw	a1,12(sp)
   11734:	01012303          	lw	t1,16(sp)
   11738:	01412683          	lw	a3,20(sp)
   1173c:	01812783          	lw	a5,24(sp)
   11740:	01c12803          	lw	a6,28(sp)
   11744:	00050e13          	mv	t3,a0
   11748:	34e50663          	beq	a0,a4,11a94 <_malloc_r+0x62c>
   1174c:	00678733          	add	a4,a5,t1
   11750:	34e56063          	bltu	a0,a4,11a90 <_malloc_r+0x628>
   11754:	ed818e93          	addi	t4,gp,-296 # 13be8 <__malloc_current_mallinfo>
   11758:	000ea603          	lw	a2,0(t4)
   1175c:	00c58633          	add	a2,a1,a2
   11760:	00cea023          	sw	a2,0(t4)
   11764:	48a70a63          	beq	a4,a0,11bf8 <_malloc_r+0x790>
   11768:	d601af03          	lw	t5,-672(gp) # 13a70 <__malloc_sbrk_base>
   1176c:	fff00513          	li	a0,-1
   11770:	4aaf0263          	beq	t5,a0,11c14 <_malloc_r+0x7ac>
   11774:	40ee0733          	sub	a4,t3,a4
   11778:	00c70733          	add	a4,a4,a2
   1177c:	00eea023          	sw	a4,0(t4)
   11780:	007e7f13          	andi	t5,t3,7
   11784:	3a0f0e63          	beqz	t5,11b40 <_malloc_r+0x6d8>
   11788:	ff8e7e13          	andi	t3,t3,-8
   1178c:	000018b7          	lui	a7,0x1
   11790:	008e0e13          	addi	t3,t3,8
   11794:	00888893          	addi	a7,a7,8 # 1008 <exit-0xf0ac>
   11798:	00be0633          	add	a2,t3,a1
   1179c:	41e885b3          	sub	a1,a7,t5
   117a0:	40c585b3          	sub	a1,a1,a2
   117a4:	01459593          	slli	a1,a1,0x14
   117a8:	0145d593          	srli	a1,a1,0x14
   117ac:	00040513          	mv	a0,s0
   117b0:	03012623          	sw	a6,44(sp)
   117b4:	03d12423          	sw	t4,40(sp)
   117b8:	02f12223          	sw	a5,36(sp)
   117bc:	02d12023          	sw	a3,32(sp)
   117c0:	00612e23          	sw	t1,28(sp)
   117c4:	01c12c23          	sw	t3,24(sp)
   117c8:	01e12a23          	sw	t5,20(sp)
   117cc:	00c12823          	sw	a2,16(sp)
   117d0:	00b12623          	sw	a1,12(sp)
   117d4:	17d000ef          	jal	12150 <_sbrk_r>
   117d8:	00050713          	mv	a4,a0
   117dc:	fff00513          	li	a0,-1
   117e0:	00c12583          	lw	a1,12(sp)
   117e4:	01012603          	lw	a2,16(sp)
   117e8:	01412f03          	lw	t5,20(sp)
   117ec:	01812e03          	lw	t3,24(sp)
   117f0:	01c12303          	lw	t1,28(sp)
   117f4:	02012683          	lw	a3,32(sp)
   117f8:	02412783          	lw	a5,36(sp)
   117fc:	02812e83          	lw	t4,40(sp)
   11800:	02c12803          	lw	a6,44(sp)
   11804:	44a70e63          	beq	a4,a0,11c60 <_malloc_r+0x7f8>
   11808:	000ea603          	lw	a2,0(t4)
   1180c:	41c70733          	sub	a4,a4,t3
   11810:	00b70733          	add	a4,a4,a1
   11814:	00176713          	ori	a4,a4,1
   11818:	01c82423          	sw	t3,8(a6)
   1181c:	00c58633          	add	a2,a1,a2
   11820:	00ee2223          	sw	a4,4(t3)
   11824:	00cea023          	sw	a2,0(t4)
   11828:	03078e63          	beq	a5,a6,11864 <_malloc_r+0x3fc>
   1182c:	00f00513          	li	a0,15
   11830:	3e657663          	bgeu	a0,t1,11c1c <_malloc_r+0x7b4>
   11834:	0047a583          	lw	a1,4(a5)
   11838:	ff430713          	addi	a4,t1,-12
   1183c:	ff877713          	andi	a4,a4,-8
   11840:	0015f593          	andi	a1,a1,1
   11844:	00e5e5b3          	or	a1,a1,a4
   11848:	00b7a223          	sw	a1,4(a5)
   1184c:	00500893          	li	a7,5
   11850:	00e785b3          	add	a1,a5,a4
   11854:	0115a223          	sw	a7,4(a1)
   11858:	0115a423          	sw	a7,8(a1)
   1185c:	40e56a63          	bltu	a0,a4,11c70 <_malloc_r+0x808>
   11860:	004e2703          	lw	a4,4(t3)
   11864:	d781a583          	lw	a1,-648(gp) # 13a88 <__malloc_max_sbrked_mem>
   11868:	00c5f463          	bgeu	a1,a2,11870 <_malloc_r+0x408>
   1186c:	d6c1ac23          	sw	a2,-648(gp) # 13a88 <__malloc_max_sbrked_mem>
   11870:	d741a583          	lw	a1,-652(gp) # 13a84 <__malloc_max_total_mem>
   11874:	00c5f463          	bgeu	a1,a2,1187c <_malloc_r+0x414>
   11878:	d6c1aa23          	sw	a2,-652(gp) # 13a84 <__malloc_max_total_mem>
   1187c:	000e0793          	mv	a5,t3
   11880:	21c0006f          	j	11a9c <_malloc_r+0x634>
   11884:	00482303          	lw	t1,4(a6)
   11888:	d8dff06f          	j	11614 <_malloc_r+0x1ac>
   1188c:	0016e713          	ori	a4,a3,1
   11890:	00e7a223          	sw	a4,4(a5)
   11894:	00d786b3          	add	a3,a5,a3
   11898:	00166613          	ori	a2,a2,1
   1189c:	00d82423          	sw	a3,8(a6)
   118a0:	00040513          	mv	a0,s0
   118a4:	00c6a223          	sw	a2,4(a3)
   118a8:	00f12623          	sw	a5,12(sp)
   118ac:	43c000ef          	jal	11ce8 <__malloc_unlock>
   118b0:	00c12783          	lw	a5,12(sp)
   118b4:	03c12083          	lw	ra,60(sp)
   118b8:	03812403          	lw	s0,56(sp)
   118bc:	00878513          	addi	a0,a5,8
   118c0:	04010113          	addi	sp,sp,64
   118c4:	00008067          	ret
   118c8:	0087a603          	lw	a2,8(a5)
   118cc:	00e78733          	add	a4,a5,a4
   118d0:	00472683          	lw	a3,4(a4) # fffff004 <__BSS_END__+0xfffeb264>
   118d4:	00b62623          	sw	a1,12(a2)
   118d8:	00f12623          	sw	a5,12(sp)
   118dc:	0016e693          	ori	a3,a3,1
   118e0:	00c5a423          	sw	a2,8(a1)
   118e4:	00040513          	mv	a0,s0
   118e8:	00d72223          	sw	a3,4(a4)
   118ec:	3fc000ef          	jal	11ce8 <__malloc_unlock>
   118f0:	00c12783          	lw	a5,12(sp)
   118f4:	03c12083          	lw	ra,60(sp)
   118f8:	03812403          	lw	s0,56(sp)
   118fc:	00878513          	addi	a0,a5,8
   11900:	04010113          	addi	sp,sp,64
   11904:	00008067          	ret
   11908:	00c72783          	lw	a5,12(a4)
   1190c:	00288893          	addi	a7,a7,2
   11910:	c8f708e3          	beq	a4,a5,115a0 <_malloc_r+0x138>
   11914:	ba1ff06f          	j	114b4 <_malloc_r+0x4c>
   11918:	00975613          	srli	a2,a4,0x9
   1191c:	00400593          	li	a1,4
   11920:	14c5fe63          	bgeu	a1,a2,11a7c <_malloc_r+0x614>
   11924:	01400593          	li	a1,20
   11928:	28c5e263          	bltu	a1,a2,11bac <_malloc_r+0x744>
   1192c:	05c60513          	addi	a0,a2,92
   11930:	00351513          	slli	a0,a0,0x3
   11934:	05b60593          	addi	a1,a2,91
   11938:	00a80533          	add	a0,a6,a0
   1193c:	00052603          	lw	a2,0(a0)
   11940:	ff850513          	addi	a0,a0,-8
   11944:	00c51863          	bne	a0,a2,11954 <_malloc_r+0x4ec>
   11948:	1e00006f          	j	11b28 <_malloc_r+0x6c0>
   1194c:	00862603          	lw	a2,8(a2)
   11950:	00c50863          	beq	a0,a2,11960 <_malloc_r+0x4f8>
   11954:	00462583          	lw	a1,4(a2)
   11958:	ffc5f593          	andi	a1,a1,-4
   1195c:	feb768e3          	bltu	a4,a1,1194c <_malloc_r+0x4e4>
   11960:	00c62503          	lw	a0,12(a2)
   11964:	00a7a623          	sw	a0,12(a5)
   11968:	00c7a423          	sw	a2,8(a5)
   1196c:	00f52423          	sw	a5,8(a0)
   11970:	00f62623          	sw	a5,12(a2)
   11974:	ca1ff06f          	j	11614 <_malloc_r+0x1ac>
   11978:	01400713          	li	a4,20
   1197c:	14f77063          	bgeu	a4,a5,11abc <_malloc_r+0x654>
   11980:	05400713          	li	a4,84
   11984:	24f76263          	bltu	a4,a5,11bc8 <_malloc_r+0x760>
   11988:	00c6d793          	srli	a5,a3,0xc
   1198c:	06f78893          	addi	a7,a5,111
   11990:	06e78e13          	addi	t3,a5,110
   11994:	00389513          	slli	a0,a7,0x3
   11998:	bc5ff06f          	j	1155c <_malloc_r+0xf4>
   1199c:	001f8f93          	addi	t6,t6,1
   119a0:	003ff793          	andi	a5,t6,3
   119a4:	00830313          	addi	t1,t1,8
   119a8:	12078863          	beqz	a5,11ad8 <_malloc_r+0x670>
   119ac:	00c32703          	lw	a4,12(t1)
   119b0:	cb9ff06f          	j	11668 <_malloc_r+0x200>
   119b4:	0087a503          	lw	a0,8(a5)
   119b8:	0016e893          	ori	a7,a3,1
   119bc:	0117a223          	sw	a7,4(a5)
   119c0:	00e52623          	sw	a4,12(a0)
   119c4:	00a72423          	sw	a0,8(a4)
   119c8:	00d786b3          	add	a3,a5,a3
   119cc:	00d82a23          	sw	a3,20(a6)
   119d0:	00d82823          	sw	a3,16(a6)
   119d4:	0015e713          	ori	a4,a1,1
   119d8:	00c78633          	add	a2,a5,a2
   119dc:	01c6a623          	sw	t3,12(a3)
   119e0:	01c6a423          	sw	t3,8(a3)
   119e4:	00e6a223          	sw	a4,4(a3)
   119e8:	00040513          	mv	a0,s0
   119ec:	00b62023          	sw	a1,0(a2)
   119f0:	00f12623          	sw	a5,12(sp)
   119f4:	2f4000ef          	jal	11ce8 <__malloc_unlock>
   119f8:	00c12783          	lw	a5,12(sp)
   119fc:	00878513          	addi	a0,a5,8
   11a00:	b0dff06f          	j	1150c <_malloc_r+0xa4>
   11a04:	0036d893          	srli	a7,a3,0x3
   11a08:	00868713          	addi	a4,a3,8
   11a0c:	a91ff06f          	j	1149c <_malloc_r+0x34>
   11a10:	00e78733          	add	a4,a5,a4
   11a14:	00472683          	lw	a3,4(a4)
   11a18:	00f12623          	sw	a5,12(sp)
   11a1c:	00040513          	mv	a0,s0
   11a20:	0016e693          	ori	a3,a3,1
   11a24:	00d72223          	sw	a3,4(a4)
   11a28:	2c0000ef          	jal	11ce8 <__malloc_unlock>
   11a2c:	00c12783          	lw	a5,12(sp)
   11a30:	00878513          	addi	a0,a5,8
   11a34:	ad9ff06f          	j	1150c <_malloc_r+0xa4>
   11a38:	0016e593          	ori	a1,a3,1
   11a3c:	00b7a223          	sw	a1,4(a5)
   11a40:	00d786b3          	add	a3,a5,a3
   11a44:	00d82a23          	sw	a3,20(a6)
   11a48:	00d82823          	sw	a3,16(a6)
   11a4c:	00166593          	ori	a1,a2,1
   11a50:	00e78733          	add	a4,a5,a4
   11a54:	01c6a623          	sw	t3,12(a3)
   11a58:	01c6a423          	sw	t3,8(a3)
   11a5c:	00b6a223          	sw	a1,4(a3)
   11a60:	00040513          	mv	a0,s0
   11a64:	00c72023          	sw	a2,0(a4)
   11a68:	00f12623          	sw	a5,12(sp)
   11a6c:	27c000ef          	jal	11ce8 <__malloc_unlock>
   11a70:	00c12783          	lw	a5,12(sp)
   11a74:	00878513          	addi	a0,a5,8
   11a78:	a95ff06f          	j	1150c <_malloc_r+0xa4>
   11a7c:	00675613          	srli	a2,a4,0x6
   11a80:	03960513          	addi	a0,a2,57
   11a84:	00351513          	slli	a0,a0,0x3
   11a88:	03860593          	addi	a1,a2,56
   11a8c:	eadff06f          	j	11938 <_malloc_r+0x4d0>
   11a90:	15078a63          	beq	a5,a6,11be4 <_malloc_r+0x77c>
   11a94:	00882783          	lw	a5,8(a6)
   11a98:	0047a703          	lw	a4,4(a5)
   11a9c:	ffc77713          	andi	a4,a4,-4
   11aa0:	40d70633          	sub	a2,a4,a3
   11aa4:	00d76663          	bltu	a4,a3,11ab0 <_malloc_r+0x648>
   11aa8:	01062713          	slti	a4,a2,16
   11aac:	de0700e3          	beqz	a4,1188c <_malloc_r+0x424>
   11ab0:	00040513          	mv	a0,s0
   11ab4:	234000ef          	jal	11ce8 <__malloc_unlock>
   11ab8:	a51ff06f          	j	11508 <_malloc_r+0xa0>
   11abc:	05c78893          	addi	a7,a5,92
   11ac0:	05b78e13          	addi	t3,a5,91
   11ac4:	00389513          	slli	a0,a7,0x3
   11ac8:	a95ff06f          	j	1155c <_malloc_r+0xf4>
   11acc:	008f2783          	lw	a5,8(t5)
   11ad0:	fff88893          	addi	a7,a7,-1
   11ad4:	21e79463          	bne	a5,t5,11cdc <_malloc_r+0x874>
   11ad8:	0038f793          	andi	a5,a7,3
   11adc:	ff8f0f13          	addi	t5,t5,-8
   11ae0:	fe0796e3          	bnez	a5,11acc <_malloc_r+0x664>
   11ae4:	00482703          	lw	a4,4(a6)
   11ae8:	fff54793          	not	a5,a0
   11aec:	00e7f7b3          	and	a5,a5,a4
   11af0:	00f82223          	sw	a5,4(a6)
   11af4:	00151513          	slli	a0,a0,0x1
   11af8:	fff50713          	addi	a4,a0,-1
   11afc:	bcf778e3          	bgeu	a4,a5,116cc <_malloc_r+0x264>
   11b00:	00f57733          	and	a4,a0,a5
   11b04:	00071a63          	bnez	a4,11b18 <_malloc_r+0x6b0>
   11b08:	00151513          	slli	a0,a0,0x1
   11b0c:	00f57733          	and	a4,a0,a5
   11b10:	004f8f93          	addi	t6,t6,4
   11b14:	fe070ae3          	beqz	a4,11b08 <_malloc_r+0x6a0>
   11b18:	000f8893          	mv	a7,t6
   11b1c:	b39ff06f          	j	11654 <_malloc_r+0x1ec>
   11b20:	01058593          	addi	a1,a1,16
   11b24:	bedff06f          	j	11710 <_malloc_r+0x2a8>
   11b28:	4025d593          	srai	a1,a1,0x2
   11b2c:	00100713          	li	a4,1
   11b30:	00b71733          	sll	a4,a4,a1
   11b34:	00e36333          	or	t1,t1,a4
   11b38:	00682223          	sw	t1,4(a6)
   11b3c:	e29ff06f          	j	11964 <_malloc_r+0x4fc>
   11b40:	00be0633          	add	a2,t3,a1
   11b44:	40c005b3          	neg	a1,a2
   11b48:	01459593          	slli	a1,a1,0x14
   11b4c:	0145d593          	srli	a1,a1,0x14
   11b50:	00040513          	mv	a0,s0
   11b54:	03012423          	sw	a6,40(sp)
   11b58:	03d12223          	sw	t4,36(sp)
   11b5c:	02f12023          	sw	a5,32(sp)
   11b60:	00d12e23          	sw	a3,28(sp)
   11b64:	00612c23          	sw	t1,24(sp)
   11b68:	01c12a23          	sw	t3,20(sp)
   11b6c:	00b12623          	sw	a1,12(sp)
   11b70:	00c12823          	sw	a2,16(sp)
   11b74:	5dc000ef          	jal	12150 <_sbrk_r>
   11b78:	00050713          	mv	a4,a0
   11b7c:	fff00513          	li	a0,-1
   11b80:	00c12583          	lw	a1,12(sp)
   11b84:	01412e03          	lw	t3,20(sp)
   11b88:	01812303          	lw	t1,24(sp)
   11b8c:	01c12683          	lw	a3,28(sp)
   11b90:	02012783          	lw	a5,32(sp)
   11b94:	02412e83          	lw	t4,36(sp)
   11b98:	02812803          	lw	a6,40(sp)
   11b9c:	c6a716e3          	bne	a4,a0,11808 <_malloc_r+0x3a0>
   11ba0:	01012703          	lw	a4,16(sp)
   11ba4:	00000593          	li	a1,0
   11ba8:	c61ff06f          	j	11808 <_malloc_r+0x3a0>
   11bac:	05400593          	li	a1,84
   11bb0:	06c5ec63          	bltu	a1,a2,11c28 <_malloc_r+0x7c0>
   11bb4:	00c75613          	srli	a2,a4,0xc
   11bb8:	06f60513          	addi	a0,a2,111
   11bbc:	00351513          	slli	a0,a0,0x3
   11bc0:	06e60593          	addi	a1,a2,110
   11bc4:	d75ff06f          	j	11938 <_malloc_r+0x4d0>
   11bc8:	15400713          	li	a4,340
   11bcc:	06f76c63          	bltu	a4,a5,11c44 <_malloc_r+0x7dc>
   11bd0:	00f6d793          	srli	a5,a3,0xf
   11bd4:	07878893          	addi	a7,a5,120
   11bd8:	07778e13          	addi	t3,a5,119
   11bdc:	00389513          	slli	a0,a7,0x3
   11be0:	97dff06f          	j	1155c <_malloc_r+0xf4>
   11be4:	ed818e93          	addi	t4,gp,-296 # 13be8 <__malloc_current_mallinfo>
   11be8:	000ea603          	lw	a2,0(t4)
   11bec:	00c58633          	add	a2,a1,a2
   11bf0:	00cea023          	sw	a2,0(t4)
   11bf4:	b75ff06f          	j	11768 <_malloc_r+0x300>
   11bf8:	01451513          	slli	a0,a0,0x14
   11bfc:	b60516e3          	bnez	a0,11768 <_malloc_r+0x300>
   11c00:	00882e03          	lw	t3,8(a6)
   11c04:	00b305b3          	add	a1,t1,a1
   11c08:	0015e713          	ori	a4,a1,1
   11c0c:	00ee2223          	sw	a4,4(t3)
   11c10:	c55ff06f          	j	11864 <_malloc_r+0x3fc>
   11c14:	d7c1a023          	sw	t3,-672(gp) # 13a70 <__malloc_sbrk_base>
   11c18:	b69ff06f          	j	11780 <_malloc_r+0x318>
   11c1c:	00100793          	li	a5,1
   11c20:	00fe2223          	sw	a5,4(t3)
   11c24:	e8dff06f          	j	11ab0 <_malloc_r+0x648>
   11c28:	15400593          	li	a1,340
   11c2c:	06c5ec63          	bltu	a1,a2,11ca4 <_malloc_r+0x83c>
   11c30:	00f75613          	srli	a2,a4,0xf
   11c34:	07860513          	addi	a0,a2,120
   11c38:	00351513          	slli	a0,a0,0x3
   11c3c:	07760593          	addi	a1,a2,119
   11c40:	cf9ff06f          	j	11938 <_malloc_r+0x4d0>
   11c44:	55400713          	li	a4,1364
   11c48:	06f76c63          	bltu	a4,a5,11cc0 <_malloc_r+0x858>
   11c4c:	0126d793          	srli	a5,a3,0x12
   11c50:	07d78893          	addi	a7,a5,125
   11c54:	07c78e13          	addi	t3,a5,124
   11c58:	00389513          	slli	a0,a7,0x3
   11c5c:	901ff06f          	j	1155c <_malloc_r+0xf4>
   11c60:	ff8f0f13          	addi	t5,t5,-8
   11c64:	01e60733          	add	a4,a2,t5
   11c68:	00000593          	li	a1,0
   11c6c:	b9dff06f          	j	11808 <_malloc_r+0x3a0>
   11c70:	00878593          	addi	a1,a5,8
   11c74:	00040513          	mv	a0,s0
   11c78:	01012a23          	sw	a6,20(sp)
   11c7c:	01d12823          	sw	t4,16(sp)
   11c80:	00d12623          	sw	a3,12(sp)
   11c84:	cfcff0ef          	jal	11180 <_free_r>
   11c88:	01412803          	lw	a6,20(sp)
   11c8c:	01012e83          	lw	t4,16(sp)
   11c90:	00c12683          	lw	a3,12(sp)
   11c94:	00882e03          	lw	t3,8(a6)
   11c98:	000ea603          	lw	a2,0(t4)
   11c9c:	004e2703          	lw	a4,4(t3)
   11ca0:	bc5ff06f          	j	11864 <_malloc_r+0x3fc>
   11ca4:	55400593          	li	a1,1364
   11ca8:	02c5e463          	bltu	a1,a2,11cd0 <_malloc_r+0x868>
   11cac:	01275613          	srli	a2,a4,0x12
   11cb0:	07d60513          	addi	a0,a2,125
   11cb4:	00351513          	slli	a0,a0,0x3
   11cb8:	07c60593          	addi	a1,a2,124
   11cbc:	c7dff06f          	j	11938 <_malloc_r+0x4d0>
   11cc0:	3f800513          	li	a0,1016
   11cc4:	07f00893          	li	a7,127
   11cc8:	07e00e13          	li	t3,126
   11ccc:	891ff06f          	j	1155c <_malloc_r+0xf4>
   11cd0:	3f800513          	li	a0,1016
   11cd4:	07e00593          	li	a1,126
   11cd8:	c61ff06f          	j	11938 <_malloc_r+0x4d0>
   11cdc:	00482783          	lw	a5,4(a6)
   11ce0:	e15ff06f          	j	11af4 <_malloc_r+0x68c>

00011ce4 <__malloc_lock>:
   11ce4:	00008067          	ret

00011ce8 <__malloc_unlock>:
   11ce8:	00008067          	ret

00011cec <_fclose_r>:
   11cec:	ff010113          	addi	sp,sp,-16
   11cf0:	00112623          	sw	ra,12(sp)
   11cf4:	01212023          	sw	s2,0(sp)
   11cf8:	02058863          	beqz	a1,11d28 <_fclose_r+0x3c>
   11cfc:	00812423          	sw	s0,8(sp)
   11d00:	00912223          	sw	s1,4(sp)
   11d04:	00058413          	mv	s0,a1
   11d08:	00050493          	mv	s1,a0
   11d0c:	00050663          	beqz	a0,11d18 <_fclose_r+0x2c>
   11d10:	03452783          	lw	a5,52(a0)
   11d14:	0c078c63          	beqz	a5,11dec <_fclose_r+0x100>
   11d18:	00c41783          	lh	a5,12(s0)
   11d1c:	02079263          	bnez	a5,11d40 <_fclose_r+0x54>
   11d20:	00812403          	lw	s0,8(sp)
   11d24:	00412483          	lw	s1,4(sp)
   11d28:	00c12083          	lw	ra,12(sp)
   11d2c:	00000913          	li	s2,0
   11d30:	00090513          	mv	a0,s2
   11d34:	00012903          	lw	s2,0(sp)
   11d38:	01010113          	addi	sp,sp,16
   11d3c:	00008067          	ret
   11d40:	00040593          	mv	a1,s0
   11d44:	00048513          	mv	a0,s1
   11d48:	0b8000ef          	jal	11e00 <__sflush_r>
   11d4c:	02c42783          	lw	a5,44(s0)
   11d50:	00050913          	mv	s2,a0
   11d54:	00078a63          	beqz	a5,11d68 <_fclose_r+0x7c>
   11d58:	01c42583          	lw	a1,28(s0)
   11d5c:	00048513          	mv	a0,s1
   11d60:	000780e7          	jalr	a5
   11d64:	06054463          	bltz	a0,11dcc <_fclose_r+0xe0>
   11d68:	00c45783          	lhu	a5,12(s0)
   11d6c:	0807f793          	andi	a5,a5,128
   11d70:	06079663          	bnez	a5,11ddc <_fclose_r+0xf0>
   11d74:	03042583          	lw	a1,48(s0)
   11d78:	00058c63          	beqz	a1,11d90 <_fclose_r+0xa4>
   11d7c:	04040793          	addi	a5,s0,64
   11d80:	00f58663          	beq	a1,a5,11d8c <_fclose_r+0xa0>
   11d84:	00048513          	mv	a0,s1
   11d88:	bf8ff0ef          	jal	11180 <_free_r>
   11d8c:	02042823          	sw	zero,48(s0)
   11d90:	04442583          	lw	a1,68(s0)
   11d94:	00058863          	beqz	a1,11da4 <_fclose_r+0xb8>
   11d98:	00048513          	mv	a0,s1
   11d9c:	be4ff0ef          	jal	11180 <_free_r>
   11da0:	04042223          	sw	zero,68(s0)
   11da4:	b29fe0ef          	jal	108cc <__sfp_lock_acquire>
   11da8:	00041623          	sh	zero,12(s0)
   11dac:	b25fe0ef          	jal	108d0 <__sfp_lock_release>
   11db0:	00c12083          	lw	ra,12(sp)
   11db4:	00812403          	lw	s0,8(sp)
   11db8:	00412483          	lw	s1,4(sp)
   11dbc:	00090513          	mv	a0,s2
   11dc0:	00012903          	lw	s2,0(sp)
   11dc4:	01010113          	addi	sp,sp,16
   11dc8:	00008067          	ret
   11dcc:	00c45783          	lhu	a5,12(s0)
   11dd0:	fff00913          	li	s2,-1
   11dd4:	0807f793          	andi	a5,a5,128
   11dd8:	f8078ee3          	beqz	a5,11d74 <_fclose_r+0x88>
   11ddc:	01042583          	lw	a1,16(s0)
   11de0:	00048513          	mv	a0,s1
   11de4:	b9cff0ef          	jal	11180 <_free_r>
   11de8:	f8dff06f          	j	11d74 <_fclose_r+0x88>
   11dec:	abdfe0ef          	jal	108a8 <__sinit>
   11df0:	f29ff06f          	j	11d18 <_fclose_r+0x2c>

00011df4 <fclose>:
   11df4:	00050593          	mv	a1,a0
   11df8:	d5c1a503          	lw	a0,-676(gp) # 13a6c <_impure_ptr>
   11dfc:	ef1ff06f          	j	11cec <_fclose_r>

00011e00 <__sflush_r>:
   11e00:	00c59703          	lh	a4,12(a1)
   11e04:	fe010113          	addi	sp,sp,-32
   11e08:	00812c23          	sw	s0,24(sp)
   11e0c:	01312623          	sw	s3,12(sp)
   11e10:	00112e23          	sw	ra,28(sp)
   11e14:	00877793          	andi	a5,a4,8
   11e18:	00058413          	mv	s0,a1
   11e1c:	00050993          	mv	s3,a0
   11e20:	12079263          	bnez	a5,11f44 <__sflush_r+0x144>
   11e24:	000017b7          	lui	a5,0x1
   11e28:	80078793          	addi	a5,a5,-2048 # 800 <exit-0xf8b4>
   11e2c:	0045a683          	lw	a3,4(a1)
   11e30:	00f767b3          	or	a5,a4,a5
   11e34:	00f59623          	sh	a5,12(a1)
   11e38:	18d05c63          	blez	a3,11fd0 <__sflush_r+0x1d0>
   11e3c:	02842803          	lw	a6,40(s0)
   11e40:	0e080663          	beqz	a6,11f2c <__sflush_r+0x12c>
   11e44:	00912a23          	sw	s1,20(sp)
   11e48:	01371693          	slli	a3,a4,0x13
   11e4c:	0009a483          	lw	s1,0(s3)
   11e50:	0009a023          	sw	zero,0(s3)
   11e54:	1806ca63          	bltz	a3,11fe8 <__sflush_r+0x1e8>
   11e58:	01c42583          	lw	a1,28(s0)
   11e5c:	00000613          	li	a2,0
   11e60:	00100693          	li	a3,1
   11e64:	00098513          	mv	a0,s3
   11e68:	000800e7          	jalr	a6
   11e6c:	fff00793          	li	a5,-1
   11e70:	00050613          	mv	a2,a0
   11e74:	1af50c63          	beq	a0,a5,1202c <__sflush_r+0x22c>
   11e78:	00c41783          	lh	a5,12(s0)
   11e7c:	02842803          	lw	a6,40(s0)
   11e80:	0047f793          	andi	a5,a5,4
   11e84:	00078e63          	beqz	a5,11ea0 <__sflush_r+0xa0>
   11e88:	00442703          	lw	a4,4(s0)
   11e8c:	03042783          	lw	a5,48(s0)
   11e90:	40e60633          	sub	a2,a2,a4
   11e94:	00078663          	beqz	a5,11ea0 <__sflush_r+0xa0>
   11e98:	03c42783          	lw	a5,60(s0)
   11e9c:	40f60633          	sub	a2,a2,a5
   11ea0:	01c42583          	lw	a1,28(s0)
   11ea4:	00000693          	li	a3,0
   11ea8:	00098513          	mv	a0,s3
   11eac:	000800e7          	jalr	a6
   11eb0:	fff00713          	li	a4,-1
   11eb4:	00c41783          	lh	a5,12(s0)
   11eb8:	12e51c63          	bne	a0,a4,11ff0 <__sflush_r+0x1f0>
   11ebc:	0009a683          	lw	a3,0(s3)
   11ec0:	01d00713          	li	a4,29
   11ec4:	18d76263          	bltu	a4,a3,12048 <__sflush_r+0x248>
   11ec8:	20400737          	lui	a4,0x20400
   11ecc:	00170713          	addi	a4,a4,1 # 20400001 <__BSS_END__+0x203ec261>
   11ed0:	00d75733          	srl	a4,a4,a3
   11ed4:	00177713          	andi	a4,a4,1
   11ed8:	16070863          	beqz	a4,12048 <__sflush_r+0x248>
   11edc:	01042683          	lw	a3,16(s0)
   11ee0:	fffff737          	lui	a4,0xfffff
   11ee4:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffeba5f>
   11ee8:	00e7f733          	and	a4,a5,a4
   11eec:	00e41623          	sh	a4,12(s0)
   11ef0:	00042223          	sw	zero,4(s0)
   11ef4:	00d42023          	sw	a3,0(s0)
   11ef8:	01379713          	slli	a4,a5,0x13
   11efc:	00075663          	bgez	a4,11f08 <__sflush_r+0x108>
   11f00:	0009a783          	lw	a5,0(s3)
   11f04:	10078863          	beqz	a5,12014 <__sflush_r+0x214>
   11f08:	03042583          	lw	a1,48(s0)
   11f0c:	0099a023          	sw	s1,0(s3)
   11f10:	10058a63          	beqz	a1,12024 <__sflush_r+0x224>
   11f14:	04040793          	addi	a5,s0,64
   11f18:	00f58663          	beq	a1,a5,11f24 <__sflush_r+0x124>
   11f1c:	00098513          	mv	a0,s3
   11f20:	a60ff0ef          	jal	11180 <_free_r>
   11f24:	01412483          	lw	s1,20(sp)
   11f28:	02042823          	sw	zero,48(s0)
   11f2c:	01c12083          	lw	ra,28(sp)
   11f30:	01812403          	lw	s0,24(sp)
   11f34:	00c12983          	lw	s3,12(sp)
   11f38:	00000513          	li	a0,0
   11f3c:	02010113          	addi	sp,sp,32
   11f40:	00008067          	ret
   11f44:	01212823          	sw	s2,16(sp)
   11f48:	0105a903          	lw	s2,16(a1)
   11f4c:	08090a63          	beqz	s2,11fe0 <__sflush_r+0x1e0>
   11f50:	00912a23          	sw	s1,20(sp)
   11f54:	0005a483          	lw	s1,0(a1)
   11f58:	00377713          	andi	a4,a4,3
   11f5c:	0125a023          	sw	s2,0(a1)
   11f60:	412484b3          	sub	s1,s1,s2
   11f64:	00000793          	li	a5,0
   11f68:	00071463          	bnez	a4,11f70 <__sflush_r+0x170>
   11f6c:	0145a783          	lw	a5,20(a1)
   11f70:	00f42423          	sw	a5,8(s0)
   11f74:	00904863          	bgtz	s1,11f84 <__sflush_r+0x184>
   11f78:	0640006f          	j	11fdc <__sflush_r+0x1dc>
   11f7c:	00a90933          	add	s2,s2,a0
   11f80:	04905e63          	blez	s1,11fdc <__sflush_r+0x1dc>
   11f84:	02442783          	lw	a5,36(s0)
   11f88:	01c42583          	lw	a1,28(s0)
   11f8c:	00048693          	mv	a3,s1
   11f90:	00090613          	mv	a2,s2
   11f94:	00098513          	mv	a0,s3
   11f98:	000780e7          	jalr	a5
   11f9c:	40a484b3          	sub	s1,s1,a0
   11fa0:	fca04ee3          	bgtz	a0,11f7c <__sflush_r+0x17c>
   11fa4:	00c45783          	lhu	a5,12(s0)
   11fa8:	01012903          	lw	s2,16(sp)
   11fac:	0407e793          	ori	a5,a5,64
   11fb0:	01c12083          	lw	ra,28(sp)
   11fb4:	00f41623          	sh	a5,12(s0)
   11fb8:	01812403          	lw	s0,24(sp)
   11fbc:	01412483          	lw	s1,20(sp)
   11fc0:	00c12983          	lw	s3,12(sp)
   11fc4:	fff00513          	li	a0,-1
   11fc8:	02010113          	addi	sp,sp,32
   11fcc:	00008067          	ret
   11fd0:	03c5a683          	lw	a3,60(a1)
   11fd4:	e6d044e3          	bgtz	a3,11e3c <__sflush_r+0x3c>
   11fd8:	f55ff06f          	j	11f2c <__sflush_r+0x12c>
   11fdc:	01412483          	lw	s1,20(sp)
   11fe0:	01012903          	lw	s2,16(sp)
   11fe4:	f49ff06f          	j	11f2c <__sflush_r+0x12c>
   11fe8:	05042603          	lw	a2,80(s0)
   11fec:	e95ff06f          	j	11e80 <__sflush_r+0x80>
   11ff0:	01042683          	lw	a3,16(s0)
   11ff4:	fffff737          	lui	a4,0xfffff
   11ff8:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffeba5f>
   11ffc:	00e7f733          	and	a4,a5,a4
   12000:	00e41623          	sh	a4,12(s0)
   12004:	00042223          	sw	zero,4(s0)
   12008:	00d42023          	sw	a3,0(s0)
   1200c:	01379713          	slli	a4,a5,0x13
   12010:	ee075ce3          	bgez	a4,11f08 <__sflush_r+0x108>
   12014:	03042583          	lw	a1,48(s0)
   12018:	04a42823          	sw	a0,80(s0)
   1201c:	0099a023          	sw	s1,0(s3)
   12020:	ee059ae3          	bnez	a1,11f14 <__sflush_r+0x114>
   12024:	01412483          	lw	s1,20(sp)
   12028:	f05ff06f          	j	11f2c <__sflush_r+0x12c>
   1202c:	0009a783          	lw	a5,0(s3)
   12030:	e40784e3          	beqz	a5,11e78 <__sflush_r+0x78>
   12034:	fe378713          	addi	a4,a5,-29
   12038:	00070c63          	beqz	a4,12050 <__sflush_r+0x250>
   1203c:	fea78793          	addi	a5,a5,-22
   12040:	00078863          	beqz	a5,12050 <__sflush_r+0x250>
   12044:	00c45783          	lhu	a5,12(s0)
   12048:	0407e793          	ori	a5,a5,64
   1204c:	f65ff06f          	j	11fb0 <__sflush_r+0x1b0>
   12050:	0099a023          	sw	s1,0(s3)
   12054:	01412483          	lw	s1,20(sp)
   12058:	ed5ff06f          	j	11f2c <__sflush_r+0x12c>

0001205c <_fflush_r>:
   1205c:	00050793          	mv	a5,a0
   12060:	00050663          	beqz	a0,1206c <_fflush_r+0x10>
   12064:	03452703          	lw	a4,52(a0)
   12068:	00070e63          	beqz	a4,12084 <_fflush_r+0x28>
   1206c:	00c59703          	lh	a4,12(a1)
   12070:	00071663          	bnez	a4,1207c <_fflush_r+0x20>
   12074:	00000513          	li	a0,0
   12078:	00008067          	ret
   1207c:	00078513          	mv	a0,a5
   12080:	d81ff06f          	j	11e00 <__sflush_r>
   12084:	fe010113          	addi	sp,sp,-32
   12088:	00b12623          	sw	a1,12(sp)
   1208c:	00112e23          	sw	ra,28(sp)
   12090:	00a12423          	sw	a0,8(sp)
   12094:	815fe0ef          	jal	108a8 <__sinit>
   12098:	00c12583          	lw	a1,12(sp)
   1209c:	00812783          	lw	a5,8(sp)
   120a0:	00c59703          	lh	a4,12(a1)
   120a4:	00070a63          	beqz	a4,120b8 <_fflush_r+0x5c>
   120a8:	01c12083          	lw	ra,28(sp)
   120ac:	00078513          	mv	a0,a5
   120b0:	02010113          	addi	sp,sp,32
   120b4:	d4dff06f          	j	11e00 <__sflush_r>
   120b8:	01c12083          	lw	ra,28(sp)
   120bc:	00000513          	li	a0,0
   120c0:	02010113          	addi	sp,sp,32
   120c4:	00008067          	ret

000120c8 <fflush>:
   120c8:	06050063          	beqz	a0,12128 <fflush+0x60>
   120cc:	00050593          	mv	a1,a0
   120d0:	d5c1a503          	lw	a0,-676(gp) # 13a6c <_impure_ptr>
   120d4:	00050663          	beqz	a0,120e0 <fflush+0x18>
   120d8:	03452783          	lw	a5,52(a0)
   120dc:	00078c63          	beqz	a5,120f4 <fflush+0x2c>
   120e0:	00c59783          	lh	a5,12(a1)
   120e4:	00079663          	bnez	a5,120f0 <fflush+0x28>
   120e8:	00000513          	li	a0,0
   120ec:	00008067          	ret
   120f0:	d11ff06f          	j	11e00 <__sflush_r>
   120f4:	fe010113          	addi	sp,sp,-32
   120f8:	00b12623          	sw	a1,12(sp)
   120fc:	00a12423          	sw	a0,8(sp)
   12100:	00112e23          	sw	ra,28(sp)
   12104:	fa4fe0ef          	jal	108a8 <__sinit>
   12108:	00c12583          	lw	a1,12(sp)
   1210c:	00812503          	lw	a0,8(sp)
   12110:	00c59783          	lh	a5,12(a1)
   12114:	02079863          	bnez	a5,12144 <fflush+0x7c>
   12118:	01c12083          	lw	ra,28(sp)
   1211c:	00000513          	li	a0,0
   12120:	02010113          	addi	sp,sp,32
   12124:	00008067          	ret
   12128:	00013637          	lui	a2,0x13
   1212c:	000125b7          	lui	a1,0x12
   12130:	00013537          	lui	a0,0x13
   12134:	51060613          	addi	a2,a2,1296 # 13510 <__sglue>
   12138:	05c58593          	addi	a1,a1,92 # 1205c <_fflush_r>
   1213c:	52050513          	addi	a0,a0,1312 # 13520 <_impure_data>
   12140:	fc4fe06f          	j	10904 <_fwalk_sglue>
   12144:	01c12083          	lw	ra,28(sp)
   12148:	02010113          	addi	sp,sp,32
   1214c:	cb5ff06f          	j	11e00 <__sflush_r>

00012150 <_sbrk_r>:
   12150:	ff010113          	addi	sp,sp,-16
   12154:	00812423          	sw	s0,8(sp)
   12158:	00912223          	sw	s1,4(sp)
   1215c:	00050493          	mv	s1,a0
   12160:	00058513          	mv	a0,a1
   12164:	00112623          	sw	ra,12(sp)
   12168:	d601a623          	sw	zero,-660(gp) # 13a7c <errno>
   1216c:	220000ef          	jal	1238c <_sbrk>
   12170:	fff00793          	li	a5,-1
   12174:	00f50c63          	beq	a0,a5,1218c <_sbrk_r+0x3c>
   12178:	00c12083          	lw	ra,12(sp)
   1217c:	00812403          	lw	s0,8(sp)
   12180:	00412483          	lw	s1,4(sp)
   12184:	01010113          	addi	sp,sp,16
   12188:	00008067          	ret
   1218c:	d6c1a783          	lw	a5,-660(gp) # 13a7c <errno>
   12190:	fe0784e3          	beqz	a5,12178 <_sbrk_r+0x28>
   12194:	00c12083          	lw	ra,12(sp)
   12198:	00812403          	lw	s0,8(sp)
   1219c:	00f4a023          	sw	a5,0(s1)
   121a0:	00412483          	lw	s1,4(sp)
   121a4:	01010113          	addi	sp,sp,16
   121a8:	00008067          	ret

000121ac <__libc_fini_array>:
   121ac:	ff010113          	addi	sp,sp,-16
   121b0:	00812423          	sw	s0,8(sp)
   121b4:	000137b7          	lui	a5,0x13
   121b8:	00013437          	lui	s0,0x13
   121bc:	50c78793          	addi	a5,a5,1292 # 1350c <__fini_array_end>
   121c0:	50840413          	addi	s0,s0,1288 # 13508 <__do_global_dtors_aux_fini_array_entry>
   121c4:	408787b3          	sub	a5,a5,s0
   121c8:	00912223          	sw	s1,4(sp)
   121cc:	00112623          	sw	ra,12(sp)
   121d0:	4027d493          	srai	s1,a5,0x2
   121d4:	02048063          	beqz	s1,121f4 <__libc_fini_array+0x48>
   121d8:	ffc40413          	addi	s0,s0,-4
   121dc:	00f40433          	add	s0,s0,a5
   121e0:	00042783          	lw	a5,0(s0)
   121e4:	fff48493          	addi	s1,s1,-1
   121e8:	ffc40413          	addi	s0,s0,-4
   121ec:	000780e7          	jalr	a5
   121f0:	fe0498e3          	bnez	s1,121e0 <__libc_fini_array+0x34>
   121f4:	00c12083          	lw	ra,12(sp)
   121f8:	00812403          	lw	s0,8(sp)
   121fc:	00412483          	lw	s1,4(sp)
   12200:	01010113          	addi	sp,sp,16
   12204:	00008067          	ret

00012208 <__register_exitproc>:
   12208:	d701a783          	lw	a5,-656(gp) # 13a80 <__atexit>
   1220c:	04078c63          	beqz	a5,12264 <__register_exitproc+0x5c>
   12210:	0047a703          	lw	a4,4(a5)
   12214:	01f00813          	li	a6,31
   12218:	06e84e63          	blt	a6,a4,12294 <__register_exitproc+0x8c>
   1221c:	00271813          	slli	a6,a4,0x2
   12220:	02050663          	beqz	a0,1224c <__register_exitproc+0x44>
   12224:	01078333          	add	t1,a5,a6
   12228:	08c32423          	sw	a2,136(t1)
   1222c:	1887a883          	lw	a7,392(a5)
   12230:	00100613          	li	a2,1
   12234:	00e61633          	sll	a2,a2,a4
   12238:	00c8e8b3          	or	a7,a7,a2
   1223c:	1917a423          	sw	a7,392(a5)
   12240:	10d32423          	sw	a3,264(t1)
   12244:	00200693          	li	a3,2
   12248:	02d50463          	beq	a0,a3,12270 <__register_exitproc+0x68>
   1224c:	00170713          	addi	a4,a4,1
   12250:	00e7a223          	sw	a4,4(a5)
   12254:	010787b3          	add	a5,a5,a6
   12258:	00b7a423          	sw	a1,8(a5)
   1225c:	00000513          	li	a0,0
   12260:	00008067          	ret
   12264:	f0018793          	addi	a5,gp,-256 # 13c10 <__atexit0>
   12268:	d6f1a823          	sw	a5,-656(gp) # 13a80 <__atexit>
   1226c:	fa5ff06f          	j	12210 <__register_exitproc+0x8>
   12270:	18c7a683          	lw	a3,396(a5)
   12274:	00170713          	addi	a4,a4,1
   12278:	00e7a223          	sw	a4,4(a5)
   1227c:	00c6e6b3          	or	a3,a3,a2
   12280:	18d7a623          	sw	a3,396(a5)
   12284:	010787b3          	add	a5,a5,a6
   12288:	00b7a423          	sw	a1,8(a5)
   1228c:	00000513          	li	a0,0
   12290:	00008067          	ret
   12294:	fff00513          	li	a0,-1
   12298:	00008067          	ret

0001229c <_close>:
   1229c:	03900893          	li	a7,57
   122a0:	00000073          	ecall
   122a4:	00054463          	bltz	a0,122ac <_close+0x10>
   122a8:	00008067          	ret
   122ac:	fe010113          	addi	sp,sp,-32
   122b0:	00112e23          	sw	ra,28(sp)
   122b4:	00a12623          	sw	a0,12(sp)
   122b8:	18c000ef          	jal	12444 <__errno>
   122bc:	00c12783          	lw	a5,12(sp)
   122c0:	01c12083          	lw	ra,28(sp)
   122c4:	40f007b3          	neg	a5,a5
   122c8:	00f52023          	sw	a5,0(a0)
   122cc:	fff00793          	li	a5,-1
   122d0:	00078513          	mv	a0,a5
   122d4:	02010113          	addi	sp,sp,32
   122d8:	00008067          	ret

000122dc <_exit>:
   122dc:	05d00893          	li	a7,93
   122e0:	00000073          	ecall
   122e4:	00054463          	bltz	a0,122ec <_exit+0x10>
   122e8:	0000006f          	j	122e8 <_exit+0xc>
   122ec:	fe010113          	addi	sp,sp,-32
   122f0:	00112e23          	sw	ra,28(sp)
   122f4:	00a12623          	sw	a0,12(sp)
   122f8:	14c000ef          	jal	12444 <__errno>
   122fc:	00c12783          	lw	a5,12(sp)
   12300:	40f007b3          	neg	a5,a5
   12304:	00f52023          	sw	a5,0(a0)
   12308:	0000006f          	j	12308 <_exit+0x2c>

0001230c <_lseek>:
   1230c:	03e00893          	li	a7,62
   12310:	00000073          	ecall
   12314:	00054463          	bltz	a0,1231c <_lseek+0x10>
   12318:	00008067          	ret
   1231c:	fe010113          	addi	sp,sp,-32
   12320:	00112e23          	sw	ra,28(sp)
   12324:	00a12623          	sw	a0,12(sp)
   12328:	11c000ef          	jal	12444 <__errno>
   1232c:	00c12783          	lw	a5,12(sp)
   12330:	01c12083          	lw	ra,28(sp)
   12334:	40f007b3          	neg	a5,a5
   12338:	00f52023          	sw	a5,0(a0)
   1233c:	fff00793          	li	a5,-1
   12340:	00078513          	mv	a0,a5
   12344:	02010113          	addi	sp,sp,32
   12348:	00008067          	ret

0001234c <_read>:
   1234c:	03f00893          	li	a7,63
   12350:	00000073          	ecall
   12354:	00054463          	bltz	a0,1235c <_read+0x10>
   12358:	00008067          	ret
   1235c:	fe010113          	addi	sp,sp,-32
   12360:	00112e23          	sw	ra,28(sp)
   12364:	00a12623          	sw	a0,12(sp)
   12368:	0dc000ef          	jal	12444 <__errno>
   1236c:	00c12783          	lw	a5,12(sp)
   12370:	01c12083          	lw	ra,28(sp)
   12374:	40f007b3          	neg	a5,a5
   12378:	00f52023          	sw	a5,0(a0)
   1237c:	fff00793          	li	a5,-1
   12380:	00078513          	mv	a0,a5
   12384:	02010113          	addi	sp,sp,32
   12388:	00008067          	ret

0001238c <_sbrk>:
   1238c:	d801a783          	lw	a5,-640(gp) # 13a90 <heap_end.0>
   12390:	ff010113          	addi	sp,sp,-16
   12394:	00112623          	sw	ra,12(sp)
   12398:	00050713          	mv	a4,a0
   1239c:	02079063          	bnez	a5,123bc <_sbrk+0x30>
   123a0:	0d600893          	li	a7,214
   123a4:	00000513          	li	a0,0
   123a8:	00000073          	ecall
   123ac:	fff00793          	li	a5,-1
   123b0:	02f50c63          	beq	a0,a5,123e8 <_sbrk+0x5c>
   123b4:	00050793          	mv	a5,a0
   123b8:	d8a1a023          	sw	a0,-640(gp) # 13a90 <heap_end.0>
   123bc:	00f70533          	add	a0,a4,a5
   123c0:	0d600893          	li	a7,214
   123c4:	00000073          	ecall
   123c8:	d801a783          	lw	a5,-640(gp) # 13a90 <heap_end.0>
   123cc:	00f70733          	add	a4,a4,a5
   123d0:	00e51c63          	bne	a0,a4,123e8 <_sbrk+0x5c>
   123d4:	00c12083          	lw	ra,12(sp)
   123d8:	d8a1a023          	sw	a0,-640(gp) # 13a90 <heap_end.0>
   123dc:	00078513          	mv	a0,a5
   123e0:	01010113          	addi	sp,sp,16
   123e4:	00008067          	ret
   123e8:	05c000ef          	jal	12444 <__errno>
   123ec:	00c12083          	lw	ra,12(sp)
   123f0:	00c00793          	li	a5,12
   123f4:	00f52023          	sw	a5,0(a0)
   123f8:	fff00513          	li	a0,-1
   123fc:	01010113          	addi	sp,sp,16
   12400:	00008067          	ret

00012404 <_write>:
   12404:	04000893          	li	a7,64
   12408:	00000073          	ecall
   1240c:	00054463          	bltz	a0,12414 <_write+0x10>
   12410:	00008067          	ret
   12414:	fe010113          	addi	sp,sp,-32
   12418:	00112e23          	sw	ra,28(sp)
   1241c:	00a12623          	sw	a0,12(sp)
   12420:	024000ef          	jal	12444 <__errno>
   12424:	00c12783          	lw	a5,12(sp)
   12428:	01c12083          	lw	ra,28(sp)
   1242c:	40f007b3          	neg	a5,a5
   12430:	00f52023          	sw	a5,0(a0)
   12434:	fff00793          	li	a5,-1
   12438:	00078513          	mv	a0,a5
   1243c:	02010113          	addi	sp,sp,32
   12440:	00008067          	ret

00012444 <__errno>:
   12444:	d5c1a503          	lw	a0,-676(gp) # 13a6c <_impure_ptr>
   12448:	00008067          	ret
