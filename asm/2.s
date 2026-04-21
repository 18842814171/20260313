
out/2:     file format elf32-littleriscv


Disassembly of section .text:

000100b4 <exit>:
   100b4:	ff010113          	addi	sp,sp,-16
   100b8:	00000593          	li	a1,0
   100bc:	00812423          	sw	s0,8(sp)
   100c0:	00112623          	sw	ra,12(sp)
   100c4:	00050413          	mv	s0,a0
   100c8:	529000ef          	jal	10df0 <__call_exitprocs>
   100cc:	d681a783          	lw	a5,-664(gp) # 13988 <__stdio_exit_handler>
   100d0:	00078463          	beqz	a5,100d8 <exit+0x24>
   100d4:	000780e7          	jalr	a5
   100d8:	00040513          	mv	a0,s0
   100dc:	0f8020ef          	jal	121d4 <_exit>

000100e0 <register_fini>:
   100e0:	00000793          	li	a5,0
   100e4:	00078863          	beqz	a5,100f4 <register_fini+0x14>
   100e8:	00012537          	lui	a0,0x12
   100ec:	0a450513          	addi	a0,a0,164 # 120a4 <__libc_fini_array>
   100f0:	6510006f          	j	10f40 <atexit>
   100f4:	00008067          	ret

000100f8 <_start>:
   100f8:	00004197          	auipc	gp,0x4
   100fc:	b2818193          	addi	gp,gp,-1240 # 13c20 <__global_pointer$>
   10100:	00000513          	li	a0,0
   10104:	00050463          	beqz	a0,1010c <_start+0x14>
   10108:	01751073          	csrw	jvt,a0
   1010c:	00004517          	auipc	a0,0x4
   10110:	87c50513          	addi	a0,a0,-1924 # 13988 <__stdio_exit_handler>
   10114:	00004617          	auipc	a2,0x4
   10118:	b9c60613          	addi	a2,a2,-1124 # 13cb0 <__BSS_END__>
   1011c:	40a60633          	sub	a2,a2,a0
   10120:	00000593          	li	a1,0
   10124:	3f1000ef          	jal	10d14 <memset>
   10128:	00001517          	auipc	a0,0x1
   1012c:	e1850513          	addi	a0,a0,-488 # 10f40 <atexit>
   10130:	00050863          	beqz	a0,10140 <_start+0x48>
   10134:	00002517          	auipc	a0,0x2
   10138:	f7050513          	addi	a0,a0,-144 # 120a4 <__libc_fini_array>
   1013c:	605000ef          	jal	10f40 <atexit>
   10140:	341000ef          	jal	10c80 <__libc_init_array>
   10144:	00012503          	lw	a0,0(sp)
   10148:	00410593          	addi	a1,sp,4
   1014c:	00251613          	slli	a2,a0,0x2
   10150:	00460613          	addi	a2,a2,4
   10154:	00b60633          	add	a2,a2,a1
   10158:	234000ef          	jal	1038c <main>
   1015c:	f59ff06f          	j	100b4 <exit>

00010160 <__do_global_dtors_aux>:
   10160:	ff010113          	addi	sp,sp,-16
   10164:	00812423          	sw	s0,8(sp)
   10168:	d841c783          	lbu	a5,-636(gp) # 139a4 <completed.1>
   1016c:	00112623          	sw	ra,12(sp)
   10170:	02079263          	bnez	a5,10194 <__do_global_dtors_aux+0x34>
   10174:	00000793          	li	a5,0
   10178:	00078a63          	beqz	a5,1018c <__do_global_dtors_aux+0x2c>
   1017c:	00012537          	lui	a0,0x12
   10180:	41050513          	addi	a0,a0,1040 # 12410 <__EH_FRAME_BEGIN__>
   10184:	00000097          	auipc	ra,0x0
   10188:	000000e7          	jalr	zero # 0 <exit-0x100b4>
   1018c:	00100793          	li	a5,1
   10190:	d8f18223          	sb	a5,-636(gp) # 139a4 <completed.1>
   10194:	00c12083          	lw	ra,12(sp)
   10198:	00812403          	lw	s0,8(sp)
   1019c:	01010113          	addi	sp,sp,16
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	00000793          	li	a5,0
   101a8:	00078c63          	beqz	a5,101c0 <frame_dummy+0x1c>
   101ac:	00012537          	lui	a0,0x12
   101b0:	d8818593          	addi	a1,gp,-632 # 139a8 <object.0>
   101b4:	41050513          	addi	a0,a0,1040 # 12410 <__EH_FRAME_BEGIN__>
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
   101dc:	100007b7          	lui	a5,0x10000
   101e0:	fef44703          	lbu	a4,-17(s0)
   101e4:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec350>
   101e8:	00000013          	nop
   101ec:	01c12083          	lw	ra,28(sp)
   101f0:	01812403          	lw	s0,24(sp)
   101f4:	02010113          	addi	sp,sp,32
   101f8:	00008067          	ret

000101fc <uart_puts>:
   101fc:	fe010113          	addi	sp,sp,-32
   10200:	00112e23          	sw	ra,28(sp)
   10204:	00812c23          	sw	s0,24(sp)
   10208:	02010413          	addi	s0,sp,32
   1020c:	fea42623          	sw	a0,-20(s0)
   10210:	01c0006f          	j	1022c <uart_puts+0x30>
   10214:	fec42783          	lw	a5,-20(s0)
   10218:	00178713          	addi	a4,a5,1
   1021c:	fee42623          	sw	a4,-20(s0)
   10220:	0007c783          	lbu	a5,0(a5)
   10224:	00078513          	mv	a0,a5
   10228:	f9dff0ef          	jal	101c4 <uart_putc>
   1022c:	fec42783          	lw	a5,-20(s0)
   10230:	0007c783          	lbu	a5,0(a5)
   10234:	fe0790e3          	bnez	a5,10214 <uart_puts+0x18>
   10238:	00000013          	nop
   1023c:	00000013          	nop
   10240:	01c12083          	lw	ra,28(sp)
   10244:	01812403          	lw	s0,24(sp)
   10248:	02010113          	addi	sp,sp,32
   1024c:	00008067          	ret

00010250 <println>:
   10250:	ff010113          	addi	sp,sp,-16
   10254:	00112623          	sw	ra,12(sp)
   10258:	00812423          	sw	s0,8(sp)
   1025c:	01010413          	addi	s0,sp,16
   10260:	00a00513          	li	a0,10
   10264:	f61ff0ef          	jal	101c4 <uart_putc>
   10268:	00000013          	nop
   1026c:	00c12083          	lw	ra,12(sp)
   10270:	00812403          	lw	s0,8(sp)
   10274:	01010113          	addi	sp,sp,16
   10278:	00008067          	ret

0001027c <uart_getc>:
   1027c:	fe010113          	addi	sp,sp,-32
   10280:	00112e23          	sw	ra,28(sp)
   10284:	00812c23          	sw	s0,24(sp)
   10288:	02010413          	addi	s0,sp,32
   1028c:	100007b7          	lui	a5,0x10000
   10290:	00478793          	addi	a5,a5,4 # 10000004 <__BSS_END__+0xffec354>
   10294:	0007a783          	lw	a5,0(a5)
   10298:	fef42623          	sw	a5,-20(s0)
   1029c:	fec42783          	lw	a5,-20(s0)
   102a0:	fe07c6e3          	bltz	a5,1028c <uart_getc+0x10>
   102a4:	fec42783          	lw	a5,-20(s0)
   102a8:	0ff7f793          	zext.b	a5,a5
   102ac:	00078513          	mv	a0,a5
   102b0:	01c12083          	lw	ra,28(sp)
   102b4:	01812403          	lw	s0,24(sp)
   102b8:	02010113          	addi	sp,sp,32
   102bc:	00008067          	ret

000102c0 <print_hex>:
   102c0:	fb010113          	addi	sp,sp,-80
   102c4:	04112623          	sw	ra,76(sp)
   102c8:	04812423          	sw	s0,72(sp)
   102cc:	05010413          	addi	s0,sp,80
   102d0:	faa42e23          	sw	a0,-68(s0)
   102d4:	000127b7          	lui	a5,0x12
   102d8:	34478793          	addi	a5,a5,836 # 12344 <__errno+0x8>
   102dc:	0007a603          	lw	a2,0(a5)
   102e0:	0047a683          	lw	a3,4(a5)
   102e4:	0087a703          	lw	a4,8(a5)
   102e8:	fcc42c23          	sw	a2,-40(s0)
   102ec:	fcd42e23          	sw	a3,-36(s0)
   102f0:	fee42023          	sw	a4,-32(s0)
   102f4:	00c7a703          	lw	a4,12(a5)
   102f8:	fee42223          	sw	a4,-28(s0)
   102fc:	0107c783          	lbu	a5,16(a5)
   10300:	fef40423          	sb	a5,-24(s0)
   10304:	03000793          	li	a5,48
   10308:	fcf40623          	sb	a5,-52(s0)
   1030c:	07800793          	li	a5,120
   10310:	fcf406a3          	sb	a5,-51(s0)
   10314:	fc040b23          	sb	zero,-42(s0)
   10318:	00900793          	li	a5,9
   1031c:	fef42623          	sw	a5,-20(s0)
   10320:	0400006f          	j	10360 <print_hex+0xa0>
   10324:	fbc42783          	lw	a5,-68(s0)
   10328:	00f7f793          	andi	a5,a5,15
   1032c:	ff078793          	addi	a5,a5,-16
   10330:	008787b3          	add	a5,a5,s0
   10334:	fe87c703          	lbu	a4,-24(a5)
   10338:	fec42783          	lw	a5,-20(s0)
   1033c:	ff078793          	addi	a5,a5,-16
   10340:	008787b3          	add	a5,a5,s0
   10344:	fce78e23          	sb	a4,-36(a5)
   10348:	fbc42783          	lw	a5,-68(s0)
   1034c:	0047d793          	srli	a5,a5,0x4
   10350:	faf42e23          	sw	a5,-68(s0)
   10354:	fec42783          	lw	a5,-20(s0)
   10358:	fff78793          	addi	a5,a5,-1
   1035c:	fef42623          	sw	a5,-20(s0)
   10360:	fec42703          	lw	a4,-20(s0)
   10364:	00100793          	li	a5,1
   10368:	fae7cee3          	blt	a5,a4,10324 <print_hex+0x64>
   1036c:	fcc40793          	addi	a5,s0,-52
   10370:	00078513          	mv	a0,a5
   10374:	e89ff0ef          	jal	101fc <uart_puts>
   10378:	00000013          	nop
   1037c:	04c12083          	lw	ra,76(sp)
   10380:	04812403          	lw	s0,72(sp)
   10384:	05010113          	addi	sp,sp,80
   10388:	00008067          	ret

0001038c <main>:
   1038c:	fe010113          	addi	sp,sp,-32
   10390:	00112e23          	sw	ra,28(sp)
   10394:	00812c23          	sw	s0,24(sp)
   10398:	02010413          	addi	s0,sp,32
   1039c:	100007b7          	lui	a5,0x10000
   103a0:	00878793          	addi	a5,a5,8 # 10000008 <__BSS_END__+0xffec358>
   103a4:	00100713          	li	a4,1
   103a8:	00e7a023          	sw	a4,0(a5)
   103ac:	100007b7          	lui	a5,0x10000
   103b0:	00c78793          	addi	a5,a5,12 # 1000000c <__BSS_END__+0xffec35c>
   103b4:	00100713          	li	a4,1
   103b8:	00e7a023          	sw	a4,0(a5)
   103bc:	100007b7          	lui	a5,0x10000
   103c0:	01878793          	addi	a5,a5,24 # 10000018 <__BSS_END__+0xffec368>
   103c4:	01000713          	li	a4,16
   103c8:	00e7a023          	sw	a4,0(a5)
   103cc:	000127b7          	lui	a5,0x12
   103d0:	35878513          	addi	a0,a5,856 # 12358 <__errno+0x1c>
   103d4:	e29ff0ef          	jal	101fc <uart_puts>
   103d8:	000127b7          	lui	a5,0x12
   103dc:	37878513          	addi	a0,a5,888 # 12378 <__errno+0x3c>
   103e0:	e1dff0ef          	jal	101fc <uart_puts>
   103e4:	000127b7          	lui	a5,0x12
   103e8:	3a478513          	addi	a0,a5,932 # 123a4 <__errno+0x68>
   103ec:	e11ff0ef          	jal	101fc <uart_puts>
   103f0:	000127b7          	lui	a5,0x12
   103f4:	3c478513          	addi	a0,a5,964 # 123c4 <__errno+0x88>
   103f8:	e05ff0ef          	jal	101fc <uart_puts>
   103fc:	e81ff0ef          	jal	1027c <uart_getc>
   10400:	00050793          	mv	a5,a0
   10404:	fef407a3          	sb	a5,-17(s0)
   10408:	000127b7          	lui	a5,0x12
   1040c:	3dc78513          	addi	a0,a5,988 # 123dc <__errno+0xa0>
   10410:	dedff0ef          	jal	101fc <uart_puts>
   10414:	fef44783          	lbu	a5,-17(s0)
   10418:	00078513          	mv	a0,a5
   1041c:	da9ff0ef          	jal	101c4 <uart_putc>
   10420:	000127b7          	lui	a5,0x12
   10424:	3e878513          	addi	a0,a5,1000 # 123e8 <__errno+0xac>
   10428:	dd5ff0ef          	jal	101fc <uart_puts>
   1042c:	fef44783          	lbu	a5,-17(s0)
   10430:	00078513          	mv	a0,a5
   10434:	e8dff0ef          	jal	102c0 <print_hex>
   10438:	000127b7          	lui	a5,0x12
   1043c:	3ec78513          	addi	a0,a5,1004 # 123ec <__errno+0xb0>
   10440:	dbdff0ef          	jal	101fc <uart_puts>
   10444:	e0dff0ef          	jal	10250 <println>
   10448:	000127b7          	lui	a5,0x12
   1044c:	3f078513          	addi	a0,a5,1008 # 123f0 <__errno+0xb4>
   10450:	dadff0ef          	jal	101fc <uart_puts>
   10454:	fef44783          	lbu	a5,-17(s0)
   10458:	00078513          	mv	a0,a5
   1045c:	d69ff0ef          	jal	101c4 <uart_putc>
   10460:	df1ff0ef          	jal	10250 <println>
   10464:	fef44703          	lbu	a4,-17(s0)
   10468:	07100793          	li	a5,113
   1046c:	f8f718e3          	bne	a4,a5,103fc <main+0x70>
   10470:	000127b7          	lui	a5,0x12
   10474:	3f878513          	addi	a0,a5,1016 # 123f8 <__errno+0xbc>
   10478:	d85ff0ef          	jal	101fc <uart_puts>
   1047c:	00000013          	nop
   10480:	05d00893          	li	a7,93
   10484:	00000513          	li	a0,0
   10488:	00000073          	ecall
   1048c:	0000006f          	j	1048c <main+0x100>

00010490 <__fp_lock>:
   10490:	00000513          	li	a0,0
   10494:	00008067          	ret

00010498 <stdio_exit_handler>:
   10498:	00013637          	lui	a2,0x13
   1049c:	000125b7          	lui	a1,0x12
   104a0:	00013537          	lui	a0,0x13
   104a4:	42060613          	addi	a2,a2,1056 # 13420 <__sglue>
   104a8:	be458593          	addi	a1,a1,-1052 # 11be4 <_fclose_r>
   104ac:	43050513          	addi	a0,a0,1072 # 13430 <_impure_data>
   104b0:	34c0006f          	j	107fc <_fwalk_sglue>

000104b4 <cleanup_stdio>:
   104b4:	00452583          	lw	a1,4(a0)
   104b8:	ff010113          	addi	sp,sp,-16
   104bc:	00812423          	sw	s0,8(sp)
   104c0:	00112623          	sw	ra,12(sp)
   104c4:	da018793          	addi	a5,gp,-608 # 139c0 <__sf>
   104c8:	00050413          	mv	s0,a0
   104cc:	00f58463          	beq	a1,a5,104d4 <cleanup_stdio+0x20>
   104d0:	714010ef          	jal	11be4 <_fclose_r>
   104d4:	00842583          	lw	a1,8(s0)
   104d8:	e0818793          	addi	a5,gp,-504 # 13a28 <__sf+0x68>
   104dc:	00f58663          	beq	a1,a5,104e8 <cleanup_stdio+0x34>
   104e0:	00040513          	mv	a0,s0
   104e4:	700010ef          	jal	11be4 <_fclose_r>
   104e8:	00c42583          	lw	a1,12(s0)
   104ec:	e7018793          	addi	a5,gp,-400 # 13a90 <__sf+0xd0>
   104f0:	00f58c63          	beq	a1,a5,10508 <cleanup_stdio+0x54>
   104f4:	00040513          	mv	a0,s0
   104f8:	00812403          	lw	s0,8(sp)
   104fc:	00c12083          	lw	ra,12(sp)
   10500:	01010113          	addi	sp,sp,16
   10504:	6e00106f          	j	11be4 <_fclose_r>
   10508:	00c12083          	lw	ra,12(sp)
   1050c:	00812403          	lw	s0,8(sp)
   10510:	01010113          	addi	sp,sp,16
   10514:	00008067          	ret

00010518 <__fp_unlock>:
   10518:	00000513          	li	a0,0
   1051c:	00008067          	ret

00010520 <global_stdio_init.part.0>:
   10520:	fe010113          	addi	sp,sp,-32
   10524:	000107b7          	lui	a5,0x10
   10528:	00812c23          	sw	s0,24(sp)
   1052c:	49878793          	addi	a5,a5,1176 # 10498 <stdio_exit_handler>
   10530:	da018413          	addi	s0,gp,-608 # 139c0 <__sf>
   10534:	00112e23          	sw	ra,28(sp)
   10538:	00912a23          	sw	s1,20(sp)
   1053c:	01212823          	sw	s2,16(sp)
   10540:	01312623          	sw	s3,12(sp)
   10544:	01412423          	sw	s4,8(sp)
   10548:	d6f1a423          	sw	a5,-664(gp) # 13988 <__stdio_exit_handler>
   1054c:	00800613          	li	a2,8
   10550:	00400793          	li	a5,4
   10554:	00000593          	li	a1,0
   10558:	dfc18513          	addi	a0,gp,-516 # 13a1c <__sf+0x5c>
   1055c:	00f42623          	sw	a5,12(s0)
   10560:	00042023          	sw	zero,0(s0)
   10564:	00042223          	sw	zero,4(s0)
   10568:	00042423          	sw	zero,8(s0)
   1056c:	06042223          	sw	zero,100(s0)
   10570:	00042823          	sw	zero,16(s0)
   10574:	00042a23          	sw	zero,20(s0)
   10578:	00042c23          	sw	zero,24(s0)
   1057c:	798000ef          	jal	10d14 <memset>
   10580:	00011a37          	lui	s4,0x11
   10584:	000119b7          	lui	s3,0x11
   10588:	00011937          	lui	s2,0x11
   1058c:	000114b7          	lui	s1,0x11
   10590:	000107b7          	lui	a5,0x10
   10594:	8b0a0a13          	addi	s4,s4,-1872 # 108b0 <__sread>
   10598:	91498993          	addi	s3,s3,-1772 # 10914 <__swrite>
   1059c:	99c90913          	addi	s2,s2,-1636 # 1099c <__sseek>
   105a0:	a0048493          	addi	s1,s1,-1536 # 10a00 <__sclose>
   105a4:	00978793          	addi	a5,a5,9 # 10009 <exit-0xab>
   105a8:	00800613          	li	a2,8
   105ac:	00000593          	li	a1,0
   105b0:	e6418513          	addi	a0,gp,-412 # 13a84 <__sf+0xc4>
   105b4:	06f42a23          	sw	a5,116(s0)
   105b8:	03442023          	sw	s4,32(s0)
   105bc:	03342223          	sw	s3,36(s0)
   105c0:	03242423          	sw	s2,40(s0)
   105c4:	02942623          	sw	s1,44(s0)
   105c8:	00842e23          	sw	s0,28(s0)
   105cc:	06042423          	sw	zero,104(s0)
   105d0:	06042623          	sw	zero,108(s0)
   105d4:	06042823          	sw	zero,112(s0)
   105d8:	0c042623          	sw	zero,204(s0)
   105dc:	06042c23          	sw	zero,120(s0)
   105e0:	06042e23          	sw	zero,124(s0)
   105e4:	08042023          	sw	zero,128(s0)
   105e8:	72c000ef          	jal	10d14 <memset>
   105ec:	000207b7          	lui	a5,0x20
   105f0:	01278793          	addi	a5,a5,18 # 20012 <__BSS_END__+0xc362>
   105f4:	e0818713          	addi	a4,gp,-504 # 13a28 <__sf+0x68>
   105f8:	ecc18513          	addi	a0,gp,-308 # 13aec <__sf+0x12c>
   105fc:	00800613          	li	a2,8
   10600:	00000593          	li	a1,0
   10604:	09442423          	sw	s4,136(s0)
   10608:	09342623          	sw	s3,140(s0)
   1060c:	09242823          	sw	s2,144(s0)
   10610:	08942a23          	sw	s1,148(s0)
   10614:	0cf42e23          	sw	a5,220(s0)
   10618:	0c042823          	sw	zero,208(s0)
   1061c:	0c042a23          	sw	zero,212(s0)
   10620:	0c042c23          	sw	zero,216(s0)
   10624:	12042a23          	sw	zero,308(s0)
   10628:	0e042023          	sw	zero,224(s0)
   1062c:	0e042223          	sw	zero,228(s0)
   10630:	0e042423          	sw	zero,232(s0)
   10634:	08e42223          	sw	a4,132(s0)
   10638:	6dc000ef          	jal	10d14 <memset>
   1063c:	e7018793          	addi	a5,gp,-400 # 13a90 <__sf+0xd0>
   10640:	0f442823          	sw	s4,240(s0)
   10644:	0f342a23          	sw	s3,244(s0)
   10648:	0f242c23          	sw	s2,248(s0)
   1064c:	0e942e23          	sw	s1,252(s0)
   10650:	01c12083          	lw	ra,28(sp)
   10654:	0ef42623          	sw	a5,236(s0)
   10658:	01812403          	lw	s0,24(sp)
   1065c:	01412483          	lw	s1,20(sp)
   10660:	01012903          	lw	s2,16(sp)
   10664:	00c12983          	lw	s3,12(sp)
   10668:	00812a03          	lw	s4,8(sp)
   1066c:	02010113          	addi	sp,sp,32
   10670:	00008067          	ret

00010674 <__sfp>:
   10674:	d681a783          	lw	a5,-664(gp) # 13988 <__stdio_exit_handler>
   10678:	fe010113          	addi	sp,sp,-32
   1067c:	00912a23          	sw	s1,20(sp)
   10680:	00112e23          	sw	ra,28(sp)
   10684:	00812c23          	sw	s0,24(sp)
   10688:	00050493          	mv	s1,a0
   1068c:	0e078e63          	beqz	a5,10788 <__sfp+0x114>
   10690:	00013837          	lui	a6,0x13
   10694:	42080813          	addi	a6,a6,1056 # 13420 <__sglue>
   10698:	fff00693          	li	a3,-1
   1069c:	00482783          	lw	a5,4(a6)
   106a0:	fff78793          	addi	a5,a5,-1
   106a4:	0807c063          	bltz	a5,10724 <__sfp+0xb0>
   106a8:	00882403          	lw	s0,8(a6)
   106ac:	00c0006f          	j	106b8 <__sfp+0x44>
   106b0:	06840413          	addi	s0,s0,104
   106b4:	06d78863          	beq	a5,a3,10724 <__sfp+0xb0>
   106b8:	00c41703          	lh	a4,12(s0)
   106bc:	fff78793          	addi	a5,a5,-1
   106c0:	fe0718e3          	bnez	a4,106b0 <__sfp+0x3c>
   106c4:	ffff07b7          	lui	a5,0xffff0
   106c8:	00178793          	addi	a5,a5,1 # ffff0001 <__BSS_END__+0xfffdc351>
   106cc:	00f42623          	sw	a5,12(s0)
   106d0:	06042223          	sw	zero,100(s0)
   106d4:	00042023          	sw	zero,0(s0)
   106d8:	00042423          	sw	zero,8(s0)
   106dc:	00042223          	sw	zero,4(s0)
   106e0:	00042823          	sw	zero,16(s0)
   106e4:	00042a23          	sw	zero,20(s0)
   106e8:	00042c23          	sw	zero,24(s0)
   106ec:	00800613          	li	a2,8
   106f0:	00000593          	li	a1,0
   106f4:	05c40513          	addi	a0,s0,92
   106f8:	61c000ef          	jal	10d14 <memset>
   106fc:	02042823          	sw	zero,48(s0)
   10700:	02042a23          	sw	zero,52(s0)
   10704:	04042223          	sw	zero,68(s0)
   10708:	04042423          	sw	zero,72(s0)
   1070c:	01c12083          	lw	ra,28(sp)
   10710:	00040513          	mv	a0,s0
   10714:	01812403          	lw	s0,24(sp)
   10718:	01412483          	lw	s1,20(sp)
   1071c:	02010113          	addi	sp,sp,32
   10720:	00008067          	ret
   10724:	00082403          	lw	s0,0(a6)
   10728:	00040663          	beqz	s0,10734 <__sfp+0xc0>
   1072c:	00040813          	mv	a6,s0
   10730:	f6dff06f          	j	1069c <__sfp+0x28>
   10734:	1ac00593          	li	a1,428
   10738:	00048513          	mv	a0,s1
   1073c:	01012623          	sw	a6,12(sp)
   10740:	421000ef          	jal	11360 <_malloc_r>
   10744:	00c12803          	lw	a6,12(sp)
   10748:	00050413          	mv	s0,a0
   1074c:	04050263          	beqz	a0,10790 <__sfp+0x11c>
   10750:	00400793          	li	a5,4
   10754:	00f52223          	sw	a5,4(a0)
   10758:	00c50513          	addi	a0,a0,12
   1075c:	00042023          	sw	zero,0(s0)
   10760:	00a42423          	sw	a0,8(s0)
   10764:	1a000613          	li	a2,416
   10768:	00000593          	li	a1,0
   1076c:	01012623          	sw	a6,12(sp)
   10770:	5a4000ef          	jal	10d14 <memset>
   10774:	00c12803          	lw	a6,12(sp)
   10778:	fff00693          	li	a3,-1
   1077c:	00882023          	sw	s0,0(a6)
   10780:	00040813          	mv	a6,s0
   10784:	f19ff06f          	j	1069c <__sfp+0x28>
   10788:	d99ff0ef          	jal	10520 <global_stdio_init.part.0>
   1078c:	f05ff06f          	j	10690 <__sfp+0x1c>
   10790:	00082023          	sw	zero,0(a6)
   10794:	00c00793          	li	a5,12
   10798:	00f4a023          	sw	a5,0(s1)
   1079c:	f71ff06f          	j	1070c <__sfp+0x98>

000107a0 <__sinit>:
   107a0:	03452783          	lw	a5,52(a0)
   107a4:	00078463          	beqz	a5,107ac <__sinit+0xc>
   107a8:	00008067          	ret
   107ac:	000107b7          	lui	a5,0x10
   107b0:	d681a703          	lw	a4,-664(gp) # 13988 <__stdio_exit_handler>
   107b4:	4b478793          	addi	a5,a5,1204 # 104b4 <cleanup_stdio>
   107b8:	02f52a23          	sw	a5,52(a0)
   107bc:	fe0716e3          	bnez	a4,107a8 <__sinit+0x8>
   107c0:	d61ff06f          	j	10520 <global_stdio_init.part.0>

000107c4 <__sfp_lock_acquire>:
   107c4:	00008067          	ret

000107c8 <__sfp_lock_release>:
   107c8:	00008067          	ret

000107cc <__fp_lock_all>:
   107cc:	00013637          	lui	a2,0x13
   107d0:	000105b7          	lui	a1,0x10
   107d4:	42060613          	addi	a2,a2,1056 # 13420 <__sglue>
   107d8:	49058593          	addi	a1,a1,1168 # 10490 <__fp_lock>
   107dc:	00000513          	li	a0,0
   107e0:	01c0006f          	j	107fc <_fwalk_sglue>

000107e4 <__fp_unlock_all>:
   107e4:	00013637          	lui	a2,0x13
   107e8:	000105b7          	lui	a1,0x10
   107ec:	42060613          	addi	a2,a2,1056 # 13420 <__sglue>
   107f0:	51858593          	addi	a1,a1,1304 # 10518 <__fp_unlock>
   107f4:	00000513          	li	a0,0
   107f8:	0040006f          	j	107fc <_fwalk_sglue>

000107fc <_fwalk_sglue>:
   107fc:	fd010113          	addi	sp,sp,-48
   10800:	03212023          	sw	s2,32(sp)
   10804:	01312e23          	sw	s3,28(sp)
   10808:	01412c23          	sw	s4,24(sp)
   1080c:	01512a23          	sw	s5,20(sp)
   10810:	01612823          	sw	s6,16(sp)
   10814:	01712623          	sw	s7,12(sp)
   10818:	02112623          	sw	ra,44(sp)
   1081c:	02812423          	sw	s0,40(sp)
   10820:	02912223          	sw	s1,36(sp)
   10824:	00060a93          	mv	s5,a2
   10828:	00050b13          	mv	s6,a0
   1082c:	00058b93          	mv	s7,a1
   10830:	00000a13          	li	s4,0
   10834:	00100993          	li	s3,1
   10838:	fff00913          	li	s2,-1
   1083c:	004aa483          	lw	s1,4(s5)
   10840:	fff48493          	addi	s1,s1,-1
   10844:	0204ca63          	bltz	s1,10878 <_fwalk_sglue+0x7c>
   10848:	008aa403          	lw	s0,8(s5)
   1084c:	00c45783          	lhu	a5,12(s0)
   10850:	00f9fe63          	bgeu	s3,a5,1086c <_fwalk_sglue+0x70>
   10854:	00e41783          	lh	a5,14(s0)
   10858:	00040593          	mv	a1,s0
   1085c:	000b0513          	mv	a0,s6
   10860:	01278663          	beq	a5,s2,1086c <_fwalk_sglue+0x70>
   10864:	000b80e7          	jalr	s7
   10868:	00aa6a33          	or	s4,s4,a0
   1086c:	fff48493          	addi	s1,s1,-1
   10870:	06840413          	addi	s0,s0,104
   10874:	fd249ce3          	bne	s1,s2,1084c <_fwalk_sglue+0x50>
   10878:	000aaa83          	lw	s5,0(s5)
   1087c:	fc0a90e3          	bnez	s5,1083c <_fwalk_sglue+0x40>
   10880:	02c12083          	lw	ra,44(sp)
   10884:	02812403          	lw	s0,40(sp)
   10888:	02412483          	lw	s1,36(sp)
   1088c:	02012903          	lw	s2,32(sp)
   10890:	01c12983          	lw	s3,28(sp)
   10894:	01412a83          	lw	s5,20(sp)
   10898:	01012b03          	lw	s6,16(sp)
   1089c:	00c12b83          	lw	s7,12(sp)
   108a0:	000a0513          	mv	a0,s4
   108a4:	01812a03          	lw	s4,24(sp)
   108a8:	03010113          	addi	sp,sp,48
   108ac:	00008067          	ret

000108b0 <__sread>:
   108b0:	ff010113          	addi	sp,sp,-16
   108b4:	00812423          	sw	s0,8(sp)
   108b8:	00058413          	mv	s0,a1
   108bc:	00e59583          	lh	a1,14(a1)
   108c0:	00112623          	sw	ra,12(sp)
   108c4:	2ec000ef          	jal	10bb0 <_read_r>
   108c8:	02054063          	bltz	a0,108e8 <__sread+0x38>
   108cc:	05042783          	lw	a5,80(s0)
   108d0:	00c12083          	lw	ra,12(sp)
   108d4:	00a787b3          	add	a5,a5,a0
   108d8:	04f42823          	sw	a5,80(s0)
   108dc:	00812403          	lw	s0,8(sp)
   108e0:	01010113          	addi	sp,sp,16
   108e4:	00008067          	ret
   108e8:	00c45783          	lhu	a5,12(s0)
   108ec:	fffff737          	lui	a4,0xfffff
   108f0:	fff70713          	addi	a4,a4,-1 # ffffefff <__BSS_END__+0xfffeb34f>
   108f4:	00e7f7b3          	and	a5,a5,a4
   108f8:	00c12083          	lw	ra,12(sp)
   108fc:	00f41623          	sh	a5,12(s0)
   10900:	00812403          	lw	s0,8(sp)
   10904:	01010113          	addi	sp,sp,16
   10908:	00008067          	ret

0001090c <__seofread>:
   1090c:	00000513          	li	a0,0
   10910:	00008067          	ret

00010914 <__swrite>:
   10914:	00c59783          	lh	a5,12(a1)
   10918:	fe010113          	addi	sp,sp,-32
   1091c:	00068313          	mv	t1,a3
   10920:	00112e23          	sw	ra,28(sp)
   10924:	1007f693          	andi	a3,a5,256
   10928:	00058713          	mv	a4,a1
   1092c:	00060893          	mv	a7,a2
   10930:	00050813          	mv	a6,a0
   10934:	02069863          	bnez	a3,10964 <__swrite+0x50>
   10938:	fffff6b7          	lui	a3,0xfffff
   1093c:	fff68693          	addi	a3,a3,-1 # ffffefff <__BSS_END__+0xfffeb34f>
   10940:	01c12083          	lw	ra,28(sp)
   10944:	00d7f7b3          	and	a5,a5,a3
   10948:	00e71583          	lh	a1,14(a4)
   1094c:	00f71623          	sh	a5,12(a4)
   10950:	00030693          	mv	a3,t1
   10954:	00088613          	mv	a2,a7
   10958:	00080513          	mv	a0,a6
   1095c:	02010113          	addi	sp,sp,32
   10960:	2b80006f          	j	10c18 <_write_r>
   10964:	00e59583          	lh	a1,14(a1)
   10968:	00c12423          	sw	a2,8(sp)
   1096c:	00200693          	li	a3,2
   10970:	00000613          	li	a2,0
   10974:	00612623          	sw	t1,12(sp)
   10978:	00e12023          	sw	a4,0(sp)
   1097c:	00a12223          	sw	a0,4(sp)
   10980:	1c8000ef          	jal	10b48 <_lseek_r>
   10984:	00012703          	lw	a4,0(sp)
   10988:	00c12303          	lw	t1,12(sp)
   1098c:	00812883          	lw	a7,8(sp)
   10990:	00c71783          	lh	a5,12(a4)
   10994:	00412803          	lw	a6,4(sp)
   10998:	fa1ff06f          	j	10938 <__swrite+0x24>

0001099c <__sseek>:
   1099c:	ff010113          	addi	sp,sp,-16
   109a0:	00812423          	sw	s0,8(sp)
   109a4:	00058413          	mv	s0,a1
   109a8:	00e59583          	lh	a1,14(a1)
   109ac:	00112623          	sw	ra,12(sp)
   109b0:	198000ef          	jal	10b48 <_lseek_r>
   109b4:	fff00713          	li	a4,-1
   109b8:	00c41783          	lh	a5,12(s0)
   109bc:	02e50263          	beq	a0,a4,109e0 <__sseek+0x44>
   109c0:	00001737          	lui	a4,0x1
   109c4:	00e7e7b3          	or	a5,a5,a4
   109c8:	00c12083          	lw	ra,12(sp)
   109cc:	04a42823          	sw	a0,80(s0)
   109d0:	00f41623          	sh	a5,12(s0)
   109d4:	00812403          	lw	s0,8(sp)
   109d8:	01010113          	addi	sp,sp,16
   109dc:	00008067          	ret
   109e0:	80050713          	addi	a4,a0,-2048
   109e4:	80070713          	addi	a4,a4,-2048 # 800 <exit-0xf8b4>
   109e8:	00e7f7b3          	and	a5,a5,a4
   109ec:	00c12083          	lw	ra,12(sp)
   109f0:	00f41623          	sh	a5,12(s0)
   109f4:	00812403          	lw	s0,8(sp)
   109f8:	01010113          	addi	sp,sp,16
   109fc:	00008067          	ret

00010a00 <__sclose>:
   10a00:	00e59583          	lh	a1,14(a1)
   10a04:	0040006f          	j	10a08 <_close_r>

00010a08 <_close_r>:
   10a08:	ff010113          	addi	sp,sp,-16
   10a0c:	00812423          	sw	s0,8(sp)
   10a10:	00912223          	sw	s1,4(sp)
   10a14:	00050493          	mv	s1,a0
   10a18:	00058513          	mv	a0,a1
   10a1c:	00112623          	sw	ra,12(sp)
   10a20:	d601a623          	sw	zero,-660(gp) # 1398c <errno>
   10a24:	770010ef          	jal	12194 <_close>
   10a28:	fff00793          	li	a5,-1
   10a2c:	00f50c63          	beq	a0,a5,10a44 <_close_r+0x3c>
   10a30:	00c12083          	lw	ra,12(sp)
   10a34:	00812403          	lw	s0,8(sp)
   10a38:	00412483          	lw	s1,4(sp)
   10a3c:	01010113          	addi	sp,sp,16
   10a40:	00008067          	ret
   10a44:	d6c1a783          	lw	a5,-660(gp) # 1398c <errno>
   10a48:	fe0784e3          	beqz	a5,10a30 <_close_r+0x28>
   10a4c:	00c12083          	lw	ra,12(sp)
   10a50:	00812403          	lw	s0,8(sp)
   10a54:	00f4a023          	sw	a5,0(s1)
   10a58:	00412483          	lw	s1,4(sp)
   10a5c:	01010113          	addi	sp,sp,16
   10a60:	00008067          	ret

00010a64 <_reclaim_reent>:
   10a64:	d5c1a783          	lw	a5,-676(gp) # 1397c <_impure_ptr>
   10a68:	0ca78e63          	beq	a5,a0,10b44 <_reclaim_reent+0xe0>
   10a6c:	04452583          	lw	a1,68(a0)
   10a70:	fe010113          	addi	sp,sp,-32
   10a74:	00912a23          	sw	s1,20(sp)
   10a78:	00112e23          	sw	ra,28(sp)
   10a7c:	00812c23          	sw	s0,24(sp)
   10a80:	00050493          	mv	s1,a0
   10a84:	04058863          	beqz	a1,10ad4 <_reclaim_reent+0x70>
   10a88:	01212823          	sw	s2,16(sp)
   10a8c:	01312623          	sw	s3,12(sp)
   10a90:	00000913          	li	s2,0
   10a94:	08000993          	li	s3,128
   10a98:	012587b3          	add	a5,a1,s2
   10a9c:	0007a403          	lw	s0,0(a5)
   10aa0:	00040e63          	beqz	s0,10abc <_reclaim_reent+0x58>
   10aa4:	00040593          	mv	a1,s0
   10aa8:	00042403          	lw	s0,0(s0)
   10aac:	00048513          	mv	a0,s1
   10ab0:	5c8000ef          	jal	11078 <_free_r>
   10ab4:	fe0418e3          	bnez	s0,10aa4 <_reclaim_reent+0x40>
   10ab8:	0444a583          	lw	a1,68(s1)
   10abc:	00490913          	addi	s2,s2,4
   10ac0:	fd391ce3          	bne	s2,s3,10a98 <_reclaim_reent+0x34>
   10ac4:	00048513          	mv	a0,s1
   10ac8:	5b0000ef          	jal	11078 <_free_r>
   10acc:	01012903          	lw	s2,16(sp)
   10ad0:	00c12983          	lw	s3,12(sp)
   10ad4:	0384a583          	lw	a1,56(s1)
   10ad8:	00058663          	beqz	a1,10ae4 <_reclaim_reent+0x80>
   10adc:	00048513          	mv	a0,s1
   10ae0:	598000ef          	jal	11078 <_free_r>
   10ae4:	0404a403          	lw	s0,64(s1)
   10ae8:	00040c63          	beqz	s0,10b00 <_reclaim_reent+0x9c>
   10aec:	00040593          	mv	a1,s0
   10af0:	00042403          	lw	s0,0(s0)
   10af4:	00048513          	mv	a0,s1
   10af8:	580000ef          	jal	11078 <_free_r>
   10afc:	fe0418e3          	bnez	s0,10aec <_reclaim_reent+0x88>
   10b00:	04c4a583          	lw	a1,76(s1)
   10b04:	00058663          	beqz	a1,10b10 <_reclaim_reent+0xac>
   10b08:	00048513          	mv	a0,s1
   10b0c:	56c000ef          	jal	11078 <_free_r>
   10b10:	0344a783          	lw	a5,52(s1)
   10b14:	00078e63          	beqz	a5,10b30 <_reclaim_reent+0xcc>
   10b18:	01812403          	lw	s0,24(sp)
   10b1c:	01c12083          	lw	ra,28(sp)
   10b20:	00048513          	mv	a0,s1
   10b24:	01412483          	lw	s1,20(sp)
   10b28:	02010113          	addi	sp,sp,32
   10b2c:	00078067          	jr	a5
   10b30:	01c12083          	lw	ra,28(sp)
   10b34:	01812403          	lw	s0,24(sp)
   10b38:	01412483          	lw	s1,20(sp)
   10b3c:	02010113          	addi	sp,sp,32
   10b40:	00008067          	ret
   10b44:	00008067          	ret

00010b48 <_lseek_r>:
   10b48:	ff010113          	addi	sp,sp,-16
   10b4c:	00058793          	mv	a5,a1
   10b50:	00812423          	sw	s0,8(sp)
   10b54:	00912223          	sw	s1,4(sp)
   10b58:	00060593          	mv	a1,a2
   10b5c:	00050493          	mv	s1,a0
   10b60:	00068613          	mv	a2,a3
   10b64:	00078513          	mv	a0,a5
   10b68:	00112623          	sw	ra,12(sp)
   10b6c:	d601a623          	sw	zero,-660(gp) # 1398c <errno>
   10b70:	694010ef          	jal	12204 <_lseek>
   10b74:	fff00793          	li	a5,-1
   10b78:	00f50c63          	beq	a0,a5,10b90 <_lseek_r+0x48>
   10b7c:	00c12083          	lw	ra,12(sp)
   10b80:	00812403          	lw	s0,8(sp)
   10b84:	00412483          	lw	s1,4(sp)
   10b88:	01010113          	addi	sp,sp,16
   10b8c:	00008067          	ret
   10b90:	d6c1a783          	lw	a5,-660(gp) # 1398c <errno>
   10b94:	fe0784e3          	beqz	a5,10b7c <_lseek_r+0x34>
   10b98:	00c12083          	lw	ra,12(sp)
   10b9c:	00812403          	lw	s0,8(sp)
   10ba0:	00f4a023          	sw	a5,0(s1)
   10ba4:	00412483          	lw	s1,4(sp)
   10ba8:	01010113          	addi	sp,sp,16
   10bac:	00008067          	ret

00010bb0 <_read_r>:
   10bb0:	ff010113          	addi	sp,sp,-16
   10bb4:	00058793          	mv	a5,a1
   10bb8:	00812423          	sw	s0,8(sp)
   10bbc:	00912223          	sw	s1,4(sp)
   10bc0:	00060593          	mv	a1,a2
   10bc4:	00050493          	mv	s1,a0
   10bc8:	00068613          	mv	a2,a3
   10bcc:	00078513          	mv	a0,a5
   10bd0:	00112623          	sw	ra,12(sp)
   10bd4:	d601a623          	sw	zero,-660(gp) # 1398c <errno>
   10bd8:	66c010ef          	jal	12244 <_read>
   10bdc:	fff00793          	li	a5,-1
   10be0:	00f50c63          	beq	a0,a5,10bf8 <_read_r+0x48>
   10be4:	00c12083          	lw	ra,12(sp)
   10be8:	00812403          	lw	s0,8(sp)
   10bec:	00412483          	lw	s1,4(sp)
   10bf0:	01010113          	addi	sp,sp,16
   10bf4:	00008067          	ret
   10bf8:	d6c1a783          	lw	a5,-660(gp) # 1398c <errno>
   10bfc:	fe0784e3          	beqz	a5,10be4 <_read_r+0x34>
   10c00:	00c12083          	lw	ra,12(sp)
   10c04:	00812403          	lw	s0,8(sp)
   10c08:	00f4a023          	sw	a5,0(s1)
   10c0c:	00412483          	lw	s1,4(sp)
   10c10:	01010113          	addi	sp,sp,16
   10c14:	00008067          	ret

00010c18 <_write_r>:
   10c18:	ff010113          	addi	sp,sp,-16
   10c1c:	00058793          	mv	a5,a1
   10c20:	00812423          	sw	s0,8(sp)
   10c24:	00912223          	sw	s1,4(sp)
   10c28:	00060593          	mv	a1,a2
   10c2c:	00050493          	mv	s1,a0
   10c30:	00068613          	mv	a2,a3
   10c34:	00078513          	mv	a0,a5
   10c38:	00112623          	sw	ra,12(sp)
   10c3c:	d601a623          	sw	zero,-660(gp) # 1398c <errno>
   10c40:	6bc010ef          	jal	122fc <_write>
   10c44:	fff00793          	li	a5,-1
   10c48:	00f50c63          	beq	a0,a5,10c60 <_write_r+0x48>
   10c4c:	00c12083          	lw	ra,12(sp)
   10c50:	00812403          	lw	s0,8(sp)
   10c54:	00412483          	lw	s1,4(sp)
   10c58:	01010113          	addi	sp,sp,16
   10c5c:	00008067          	ret
   10c60:	d6c1a783          	lw	a5,-660(gp) # 1398c <errno>
   10c64:	fe0784e3          	beqz	a5,10c4c <_write_r+0x34>
   10c68:	00c12083          	lw	ra,12(sp)
   10c6c:	00812403          	lw	s0,8(sp)
   10c70:	00f4a023          	sw	a5,0(s1)
   10c74:	00412483          	lw	s1,4(sp)
   10c78:	01010113          	addi	sp,sp,16
   10c7c:	00008067          	ret

00010c80 <__libc_init_array>:
   10c80:	ff010113          	addi	sp,sp,-16
   10c84:	00812423          	sw	s0,8(sp)
   10c88:	01212023          	sw	s2,0(sp)
   10c8c:	00013437          	lui	s0,0x13
   10c90:	00013937          	lui	s2,0x13
   10c94:	00112623          	sw	ra,12(sp)
   10c98:	00912223          	sw	s1,4(sp)
   10c9c:	41490913          	addi	s2,s2,1044 # 13414 <__init_array_start>
   10ca0:	41440413          	addi	s0,s0,1044 # 13414 <__init_array_start>
   10ca4:	02890263          	beq	s2,s0,10cc8 <__libc_init_array+0x48>
   10ca8:	40890933          	sub	s2,s2,s0
   10cac:	40295913          	srai	s2,s2,0x2
   10cb0:	00000493          	li	s1,0
   10cb4:	00042783          	lw	a5,0(s0)
   10cb8:	00148493          	addi	s1,s1,1
   10cbc:	00440413          	addi	s0,s0,4
   10cc0:	000780e7          	jalr	a5
   10cc4:	ff24e8e3          	bltu	s1,s2,10cb4 <__libc_init_array+0x34>
   10cc8:	00013937          	lui	s2,0x13
   10ccc:	00013437          	lui	s0,0x13
   10cd0:	41c90913          	addi	s2,s2,1052 # 1341c <__do_global_dtors_aux_fini_array_entry>
   10cd4:	41440413          	addi	s0,s0,1044 # 13414 <__init_array_start>
   10cd8:	02890263          	beq	s2,s0,10cfc <__libc_init_array+0x7c>
   10cdc:	40890933          	sub	s2,s2,s0
   10ce0:	40295913          	srai	s2,s2,0x2
   10ce4:	00000493          	li	s1,0
   10ce8:	00042783          	lw	a5,0(s0)
   10cec:	00148493          	addi	s1,s1,1
   10cf0:	00440413          	addi	s0,s0,4
   10cf4:	000780e7          	jalr	a5
   10cf8:	ff24e8e3          	bltu	s1,s2,10ce8 <__libc_init_array+0x68>
   10cfc:	00c12083          	lw	ra,12(sp)
   10d00:	00812403          	lw	s0,8(sp)
   10d04:	00412483          	lw	s1,4(sp)
   10d08:	00012903          	lw	s2,0(sp)
   10d0c:	01010113          	addi	sp,sp,16
   10d10:	00008067          	ret

00010d14 <memset>:
   10d14:	00f00313          	li	t1,15
   10d18:	00050713          	mv	a4,a0
   10d1c:	02c37e63          	bgeu	t1,a2,10d58 <memset+0x44>
   10d20:	00f77793          	andi	a5,a4,15
   10d24:	0a079063          	bnez	a5,10dc4 <memset+0xb0>
   10d28:	08059263          	bnez	a1,10dac <memset+0x98>
   10d2c:	ff067693          	andi	a3,a2,-16
   10d30:	00f67613          	andi	a2,a2,15
   10d34:	00e686b3          	add	a3,a3,a4
   10d38:	00b72023          	sw	a1,0(a4)
   10d3c:	00b72223          	sw	a1,4(a4)
   10d40:	00b72423          	sw	a1,8(a4)
   10d44:	00b72623          	sw	a1,12(a4)
   10d48:	01070713          	addi	a4,a4,16
   10d4c:	fed766e3          	bltu	a4,a3,10d38 <memset+0x24>
   10d50:	00061463          	bnez	a2,10d58 <memset+0x44>
   10d54:	00008067          	ret
   10d58:	40c306b3          	sub	a3,t1,a2
   10d5c:	00269693          	slli	a3,a3,0x2
   10d60:	00000297          	auipc	t0,0x0
   10d64:	005686b3          	add	a3,a3,t0
   10d68:	00c68067          	jr	12(a3)
   10d6c:	00b70723          	sb	a1,14(a4)
   10d70:	00b706a3          	sb	a1,13(a4)
   10d74:	00b70623          	sb	a1,12(a4)
   10d78:	00b705a3          	sb	a1,11(a4)
   10d7c:	00b70523          	sb	a1,10(a4)
   10d80:	00b704a3          	sb	a1,9(a4)
   10d84:	00b70423          	sb	a1,8(a4)
   10d88:	00b703a3          	sb	a1,7(a4)
   10d8c:	00b70323          	sb	a1,6(a4)
   10d90:	00b702a3          	sb	a1,5(a4)
   10d94:	00b70223          	sb	a1,4(a4)
   10d98:	00b701a3          	sb	a1,3(a4)
   10d9c:	00b70123          	sb	a1,2(a4)
   10da0:	00b700a3          	sb	a1,1(a4)
   10da4:	00b70023          	sb	a1,0(a4)
   10da8:	00008067          	ret
   10dac:	0ff5f593          	zext.b	a1,a1
   10db0:	00859693          	slli	a3,a1,0x8
   10db4:	00d5e5b3          	or	a1,a1,a3
   10db8:	01059693          	slli	a3,a1,0x10
   10dbc:	00d5e5b3          	or	a1,a1,a3
   10dc0:	f6dff06f          	j	10d2c <memset+0x18>
   10dc4:	00279693          	slli	a3,a5,0x2
   10dc8:	00000297          	auipc	t0,0x0
   10dcc:	005686b3          	add	a3,a3,t0
   10dd0:	00008293          	mv	t0,ra
   10dd4:	fa0680e7          	jalr	-96(a3)
   10dd8:	00028093          	mv	ra,t0
   10ddc:	ff078793          	addi	a5,a5,-16
   10de0:	40f70733          	sub	a4,a4,a5
   10de4:	00f60633          	add	a2,a2,a5
   10de8:	f6c378e3          	bgeu	t1,a2,10d58 <memset+0x44>
   10dec:	f3dff06f          	j	10d28 <memset+0x14>

00010df0 <__call_exitprocs>:
   10df0:	fd010113          	addi	sp,sp,-48
   10df4:	01412c23          	sw	s4,24(sp)
   10df8:	03212023          	sw	s2,32(sp)
   10dfc:	d701a903          	lw	s2,-656(gp) # 13990 <__atexit>
   10e00:	02112623          	sw	ra,44(sp)
   10e04:	0a090863          	beqz	s2,10eb4 <__call_exitprocs+0xc4>
   10e08:	01312e23          	sw	s3,28(sp)
   10e0c:	01512a23          	sw	s5,20(sp)
   10e10:	01612823          	sw	s6,16(sp)
   10e14:	01712623          	sw	s7,12(sp)
   10e18:	02812423          	sw	s0,40(sp)
   10e1c:	02912223          	sw	s1,36(sp)
   10e20:	01812423          	sw	s8,8(sp)
   10e24:	00050b13          	mv	s6,a0
   10e28:	00058b93          	mv	s7,a1
   10e2c:	fff00993          	li	s3,-1
   10e30:	00100a93          	li	s5,1
   10e34:	00492483          	lw	s1,4(s2)
   10e38:	fff48413          	addi	s0,s1,-1
   10e3c:	04044e63          	bltz	s0,10e98 <__call_exitprocs+0xa8>
   10e40:	00249493          	slli	s1,s1,0x2
   10e44:	009904b3          	add	s1,s2,s1
   10e48:	080b9063          	bnez	s7,10ec8 <__call_exitprocs+0xd8>
   10e4c:	00492783          	lw	a5,4(s2)
   10e50:	0044a683          	lw	a3,4(s1)
   10e54:	fff78793          	addi	a5,a5,-1
   10e58:	0c878463          	beq	a5,s0,10f20 <__call_exitprocs+0x130>
   10e5c:	0004a223          	sw	zero,4(s1)
   10e60:	02068663          	beqz	a3,10e8c <__call_exitprocs+0x9c>
   10e64:	18892783          	lw	a5,392(s2)
   10e68:	008a9733          	sll	a4,s5,s0
   10e6c:	00492c03          	lw	s8,4(s2)
   10e70:	00f777b3          	and	a5,a4,a5
   10e74:	06079e63          	bnez	a5,10ef0 <__call_exitprocs+0x100>
   10e78:	000680e7          	jalr	a3
   10e7c:	00492703          	lw	a4,4(s2)
   10e80:	d701a783          	lw	a5,-656(gp) # 13990 <__atexit>
   10e84:	09871863          	bne	a4,s8,10f14 <__call_exitprocs+0x124>
   10e88:	09279663          	bne	a5,s2,10f14 <__call_exitprocs+0x124>
   10e8c:	fff40413          	addi	s0,s0,-1
   10e90:	ffc48493          	addi	s1,s1,-4
   10e94:	fb341ae3          	bne	s0,s3,10e48 <__call_exitprocs+0x58>
   10e98:	02812403          	lw	s0,40(sp)
   10e9c:	02412483          	lw	s1,36(sp)
   10ea0:	01c12983          	lw	s3,28(sp)
   10ea4:	01412a83          	lw	s5,20(sp)
   10ea8:	01012b03          	lw	s6,16(sp)
   10eac:	00c12b83          	lw	s7,12(sp)
   10eb0:	00812c03          	lw	s8,8(sp)
   10eb4:	02c12083          	lw	ra,44(sp)
   10eb8:	02012903          	lw	s2,32(sp)
   10ebc:	01812a03          	lw	s4,24(sp)
   10ec0:	03010113          	addi	sp,sp,48
   10ec4:	00008067          	ret
   10ec8:	1044a783          	lw	a5,260(s1)
   10ecc:	fff40713          	addi	a4,s0,-1
   10ed0:	f6fb8ee3          	beq	s7,a5,10e4c <__call_exitprocs+0x5c>
   10ed4:	ffe40413          	addi	s0,s0,-2
   10ed8:	fd3700e3          	beq	a4,s3,10e98 <__call_exitprocs+0xa8>
   10edc:	1004a783          	lw	a5,256(s1)
   10ee0:	05778463          	beq	a5,s7,10f28 <__call_exitprocs+0x138>
   10ee4:	ff848493          	addi	s1,s1,-8
   10ee8:	ff3410e3          	bne	s0,s3,10ec8 <__call_exitprocs+0xd8>
   10eec:	fadff06f          	j	10e98 <__call_exitprocs+0xa8>
   10ef0:	18c92783          	lw	a5,396(s2)
   10ef4:	0844a583          	lw	a1,132(s1)
   10ef8:	00f77733          	and	a4,a4,a5
   10efc:	02071c63          	bnez	a4,10f34 <__call_exitprocs+0x144>
   10f00:	000b0513          	mv	a0,s6
   10f04:	000680e7          	jalr	a3
   10f08:	00492703          	lw	a4,4(s2)
   10f0c:	d701a783          	lw	a5,-656(gp) # 13990 <__atexit>
   10f10:	f7870ce3          	beq	a4,s8,10e88 <__call_exitprocs+0x98>
   10f14:	f80782e3          	beqz	a5,10e98 <__call_exitprocs+0xa8>
   10f18:	00078913          	mv	s2,a5
   10f1c:	f19ff06f          	j	10e34 <__call_exitprocs+0x44>
   10f20:	00892223          	sw	s0,4(s2)
   10f24:	f3dff06f          	j	10e60 <__call_exitprocs+0x70>
   10f28:	00070413          	mv	s0,a4
   10f2c:	ffc48493          	addi	s1,s1,-4
   10f30:	f1dff06f          	j	10e4c <__call_exitprocs+0x5c>
   10f34:	00058513          	mv	a0,a1
   10f38:	000680e7          	jalr	a3
   10f3c:	f41ff06f          	j	10e7c <__call_exitprocs+0x8c>

00010f40 <atexit>:
   10f40:	00050593          	mv	a1,a0
   10f44:	00000693          	li	a3,0
   10f48:	00000613          	li	a2,0
   10f4c:	00000513          	li	a0,0
   10f50:	1b00106f          	j	12100 <__register_exitproc>

00010f54 <_malloc_trim_r>:
   10f54:	fe010113          	addi	sp,sp,-32
   10f58:	01212823          	sw	s2,16(sp)
   10f5c:	00013937          	lui	s2,0x13
   10f60:	00812c23          	sw	s0,24(sp)
   10f64:	00912a23          	sw	s1,20(sp)
   10f68:	01312623          	sw	s3,12(sp)
   10f6c:	00058413          	mv	s0,a1
   10f70:	00112e23          	sw	ra,28(sp)
   10f74:	00050993          	mv	s3,a0
   10f78:	57090913          	addi	s2,s2,1392 # 13570 <__malloc_av_>
   10f7c:	461000ef          	jal	11bdc <__malloc_lock>
   10f80:	00892783          	lw	a5,8(s2)
   10f84:	00001737          	lui	a4,0x1
   10f88:	0047a483          	lw	s1,4(a5)
   10f8c:	ffc4f493          	andi	s1,s1,-4
   10f90:	7ff48793          	addi	a5,s1,2047
   10f94:	7f078793          	addi	a5,a5,2032
   10f98:	40878433          	sub	s0,a5,s0
   10f9c:	00c45413          	srli	s0,s0,0xc
   10fa0:	fff40413          	addi	s0,s0,-1
   10fa4:	00c41413          	slli	s0,s0,0xc
   10fa8:	00e44e63          	blt	s0,a4,10fc4 <_malloc_trim_r+0x70>
   10fac:	00000593          	li	a1,0
   10fb0:	00098513          	mv	a0,s3
   10fb4:	094010ef          	jal	12048 <_sbrk_r>
   10fb8:	00892783          	lw	a5,8(s2)
   10fbc:	009787b3          	add	a5,a5,s1
   10fc0:	02f50663          	beq	a0,a5,10fec <_malloc_trim_r+0x98>
   10fc4:	00098513          	mv	a0,s3
   10fc8:	419000ef          	jal	11be0 <__malloc_unlock>
   10fcc:	01c12083          	lw	ra,28(sp)
   10fd0:	01812403          	lw	s0,24(sp)
   10fd4:	01412483          	lw	s1,20(sp)
   10fd8:	01012903          	lw	s2,16(sp)
   10fdc:	00c12983          	lw	s3,12(sp)
   10fe0:	00000513          	li	a0,0
   10fe4:	02010113          	addi	sp,sp,32
   10fe8:	00008067          	ret
   10fec:	408005b3          	neg	a1,s0
   10ff0:	00098513          	mv	a0,s3
   10ff4:	054010ef          	jal	12048 <_sbrk_r>
   10ff8:	fff00793          	li	a5,-1
   10ffc:	04f50463          	beq	a0,a5,11044 <_malloc_trim_r+0xf0>
   11000:	00892683          	lw	a3,8(s2)
   11004:	ed81a783          	lw	a5,-296(gp) # 13af8 <__malloc_current_mallinfo>
   11008:	408484b3          	sub	s1,s1,s0
   1100c:	0014e493          	ori	s1,s1,1
   11010:	00098513          	mv	a0,s3
   11014:	408787b3          	sub	a5,a5,s0
   11018:	0096a223          	sw	s1,4(a3)
   1101c:	ecf1ac23          	sw	a5,-296(gp) # 13af8 <__malloc_current_mallinfo>
   11020:	3c1000ef          	jal	11be0 <__malloc_unlock>
   11024:	01c12083          	lw	ra,28(sp)
   11028:	01812403          	lw	s0,24(sp)
   1102c:	01412483          	lw	s1,20(sp)
   11030:	01012903          	lw	s2,16(sp)
   11034:	00c12983          	lw	s3,12(sp)
   11038:	00100513          	li	a0,1
   1103c:	02010113          	addi	sp,sp,32
   11040:	00008067          	ret
   11044:	00000593          	li	a1,0
   11048:	00098513          	mv	a0,s3
   1104c:	7fd000ef          	jal	12048 <_sbrk_r>
   11050:	00892703          	lw	a4,8(s2)
   11054:	00f00693          	li	a3,15
   11058:	40e507b3          	sub	a5,a0,a4
   1105c:	f6f6d4e3          	bge	a3,a5,10fc4 <_malloc_trim_r+0x70>
   11060:	d601a603          	lw	a2,-672(gp) # 13980 <__malloc_sbrk_base>
   11064:	0017e793          	ori	a5,a5,1
   11068:	40c50533          	sub	a0,a0,a2
   1106c:	00f72223          	sw	a5,4(a4) # 1004 <exit-0xf0b0>
   11070:	eca1ac23          	sw	a0,-296(gp) # 13af8 <__malloc_current_mallinfo>
   11074:	f51ff06f          	j	10fc4 <_malloc_trim_r+0x70>

00011078 <_free_r>:
   11078:	12058463          	beqz	a1,111a0 <_free_r+0x128>
   1107c:	fe010113          	addi	sp,sp,-32
   11080:	00812c23          	sw	s0,24(sp)
   11084:	00b12623          	sw	a1,12(sp)
   11088:	00050413          	mv	s0,a0
   1108c:	00112e23          	sw	ra,28(sp)
   11090:	34d000ef          	jal	11bdc <__malloc_lock>
   11094:	00c12583          	lw	a1,12(sp)
   11098:	00013837          	lui	a6,0x13
   1109c:	57080813          	addi	a6,a6,1392 # 13570 <__malloc_av_>
   110a0:	ffc5a503          	lw	a0,-4(a1)
   110a4:	ff858713          	addi	a4,a1,-8
   110a8:	00882883          	lw	a7,8(a6)
   110ac:	ffe57793          	andi	a5,a0,-2
   110b0:	00f70633          	add	a2,a4,a5
   110b4:	00462683          	lw	a3,4(a2)
   110b8:	00157313          	andi	t1,a0,1
   110bc:	ffc6f693          	andi	a3,a3,-4
   110c0:	18c88863          	beq	a7,a2,11250 <_free_r+0x1d8>
   110c4:	00d62223          	sw	a3,4(a2)
   110c8:	00d608b3          	add	a7,a2,a3
   110cc:	0048a883          	lw	a7,4(a7)
   110d0:	0018f893          	andi	a7,a7,1
   110d4:	08031a63          	bnez	t1,11168 <_free_r+0xf0>
   110d8:	ff85a303          	lw	t1,-8(a1)
   110dc:	000135b7          	lui	a1,0x13
   110e0:	57858593          	addi	a1,a1,1400 # 13578 <__malloc_av_+0x8>
   110e4:	40670733          	sub	a4,a4,t1
   110e8:	00872503          	lw	a0,8(a4)
   110ec:	006787b3          	add	a5,a5,t1
   110f0:	12b50a63          	beq	a0,a1,11224 <_free_r+0x1ac>
   110f4:	00c72303          	lw	t1,12(a4)
   110f8:	00652623          	sw	t1,12(a0)
   110fc:	00a32423          	sw	a0,8(t1) # 101c0 <frame_dummy+0x1c>
   11100:	18088c63          	beqz	a7,11298 <_free_r+0x220>
   11104:	0017e693          	ori	a3,a5,1
   11108:	00d72223          	sw	a3,4(a4)
   1110c:	00f62023          	sw	a5,0(a2)
   11110:	1ff00693          	li	a3,511
   11114:	0af6e263          	bltu	a3,a5,111b8 <_free_r+0x140>
   11118:	ff87f693          	andi	a3,a5,-8
   1111c:	00868693          	addi	a3,a3,8
   11120:	00482583          	lw	a1,4(a6)
   11124:	00d806b3          	add	a3,a6,a3
   11128:	0006a603          	lw	a2,0(a3)
   1112c:	0057d513          	srli	a0,a5,0x5
   11130:	00100793          	li	a5,1
   11134:	00a797b3          	sll	a5,a5,a0
   11138:	00b7e7b3          	or	a5,a5,a1
   1113c:	ff868593          	addi	a1,a3,-8
   11140:	00c72423          	sw	a2,8(a4)
   11144:	00b72623          	sw	a1,12(a4)
   11148:	00f82223          	sw	a5,4(a6)
   1114c:	00e6a023          	sw	a4,0(a3)
   11150:	00e62623          	sw	a4,12(a2)
   11154:	00040513          	mv	a0,s0
   11158:	01812403          	lw	s0,24(sp)
   1115c:	01c12083          	lw	ra,28(sp)
   11160:	02010113          	addi	sp,sp,32
   11164:	27d0006f          	j	11be0 <__malloc_unlock>
   11168:	02089e63          	bnez	a7,111a4 <_free_r+0x12c>
   1116c:	000135b7          	lui	a1,0x13
   11170:	00d787b3          	add	a5,a5,a3
   11174:	57858593          	addi	a1,a1,1400 # 13578 <__malloc_av_+0x8>
   11178:	00862683          	lw	a3,8(a2)
   1117c:	0017e893          	ori	a7,a5,1
   11180:	00f70533          	add	a0,a4,a5
   11184:	16b68063          	beq	a3,a1,112e4 <_free_r+0x26c>
   11188:	00c62603          	lw	a2,12(a2)
   1118c:	00c6a623          	sw	a2,12(a3)
   11190:	00d62423          	sw	a3,8(a2)
   11194:	01172223          	sw	a7,4(a4)
   11198:	00f52023          	sw	a5,0(a0)
   1119c:	f75ff06f          	j	11110 <_free_r+0x98>
   111a0:	00008067          	ret
   111a4:	00156513          	ori	a0,a0,1
   111a8:	fea5ae23          	sw	a0,-4(a1)
   111ac:	00f62023          	sw	a5,0(a2)
   111b0:	1ff00693          	li	a3,511
   111b4:	f6f6f2e3          	bgeu	a3,a5,11118 <_free_r+0xa0>
   111b8:	0097d693          	srli	a3,a5,0x9
   111bc:	00400613          	li	a2,4
   111c0:	0ed66063          	bltu	a2,a3,112a0 <_free_r+0x228>
   111c4:	0067d693          	srli	a3,a5,0x6
   111c8:	03968593          	addi	a1,a3,57
   111cc:	00359593          	slli	a1,a1,0x3
   111d0:	03868613          	addi	a2,a3,56
   111d4:	00b805b3          	add	a1,a6,a1
   111d8:	0005a683          	lw	a3,0(a1)
   111dc:	ff858593          	addi	a1,a1,-8
   111e0:	00d59863          	bne	a1,a3,111f0 <_free_r+0x178>
   111e4:	11c0006f          	j	11300 <_free_r+0x288>
   111e8:	0086a683          	lw	a3,8(a3)
   111ec:	00d58863          	beq	a1,a3,111fc <_free_r+0x184>
   111f0:	0046a603          	lw	a2,4(a3)
   111f4:	ffc67613          	andi	a2,a2,-4
   111f8:	fec7e8e3          	bltu	a5,a2,111e8 <_free_r+0x170>
   111fc:	00c6a583          	lw	a1,12(a3)
   11200:	00b72623          	sw	a1,12(a4)
   11204:	00d72423          	sw	a3,8(a4)
   11208:	00040513          	mv	a0,s0
   1120c:	01812403          	lw	s0,24(sp)
   11210:	01c12083          	lw	ra,28(sp)
   11214:	00e5a423          	sw	a4,8(a1)
   11218:	00e6a623          	sw	a4,12(a3)
   1121c:	02010113          	addi	sp,sp,32
   11220:	1c10006f          	j	11be0 <__malloc_unlock>
   11224:	0a089063          	bnez	a7,112c4 <_free_r+0x24c>
   11228:	00c62583          	lw	a1,12(a2)
   1122c:	00862603          	lw	a2,8(a2)
   11230:	00f686b3          	add	a3,a3,a5
   11234:	0016e793          	ori	a5,a3,1
   11238:	00b62623          	sw	a1,12(a2)
   1123c:	00c5a423          	sw	a2,8(a1)
   11240:	00f72223          	sw	a5,4(a4)
   11244:	00d70733          	add	a4,a4,a3
   11248:	00d72023          	sw	a3,0(a4)
   1124c:	f09ff06f          	j	11154 <_free_r+0xdc>
   11250:	00d786b3          	add	a3,a5,a3
   11254:	02031063          	bnez	t1,11274 <_free_r+0x1fc>
   11258:	ff85a783          	lw	a5,-8(a1)
   1125c:	40f70733          	sub	a4,a4,a5
   11260:	00872603          	lw	a2,8(a4)
   11264:	00f686b3          	add	a3,a3,a5
   11268:	00c72783          	lw	a5,12(a4)
   1126c:	00f62623          	sw	a5,12(a2)
   11270:	00c7a423          	sw	a2,8(a5)
   11274:	0016e613          	ori	a2,a3,1
   11278:	d641a783          	lw	a5,-668(gp) # 13984 <__malloc_trim_threshold>
   1127c:	00c72223          	sw	a2,4(a4)
   11280:	00e82423          	sw	a4,8(a6)
   11284:	ecf6e8e3          	bltu	a3,a5,11154 <_free_r+0xdc>
   11288:	d7c1a583          	lw	a1,-644(gp) # 1399c <__malloc_top_pad>
   1128c:	00040513          	mv	a0,s0
   11290:	cc5ff0ef          	jal	10f54 <_malloc_trim_r>
   11294:	ec1ff06f          	j	11154 <_free_r+0xdc>
   11298:	00d787b3          	add	a5,a5,a3
   1129c:	eddff06f          	j	11178 <_free_r+0x100>
   112a0:	01400613          	li	a2,20
   112a4:	02d67863          	bgeu	a2,a3,112d4 <_free_r+0x25c>
   112a8:	05400613          	li	a2,84
   112ac:	06d66863          	bltu	a2,a3,1131c <_free_r+0x2a4>
   112b0:	00c7d693          	srli	a3,a5,0xc
   112b4:	06f68593          	addi	a1,a3,111
   112b8:	00359593          	slli	a1,a1,0x3
   112bc:	06e68613          	addi	a2,a3,110
   112c0:	f15ff06f          	j	111d4 <_free_r+0x15c>
   112c4:	0017e693          	ori	a3,a5,1
   112c8:	00d72223          	sw	a3,4(a4)
   112cc:	00f62023          	sw	a5,0(a2)
   112d0:	e85ff06f          	j	11154 <_free_r+0xdc>
   112d4:	05c68593          	addi	a1,a3,92
   112d8:	00359593          	slli	a1,a1,0x3
   112dc:	05b68613          	addi	a2,a3,91
   112e0:	ef5ff06f          	j	111d4 <_free_r+0x15c>
   112e4:	00e82a23          	sw	a4,20(a6)
   112e8:	00e82823          	sw	a4,16(a6)
   112ec:	00b72623          	sw	a1,12(a4)
   112f0:	00b72423          	sw	a1,8(a4)
   112f4:	01172223          	sw	a7,4(a4)
   112f8:	00f52023          	sw	a5,0(a0)
   112fc:	e59ff06f          	j	11154 <_free_r+0xdc>
   11300:	00482503          	lw	a0,4(a6)
   11304:	40265613          	srai	a2,a2,0x2
   11308:	00100793          	li	a5,1
   1130c:	00c797b3          	sll	a5,a5,a2
   11310:	00a7e7b3          	or	a5,a5,a0
   11314:	00f82223          	sw	a5,4(a6)
   11318:	ee9ff06f          	j	11200 <_free_r+0x188>
   1131c:	15400613          	li	a2,340
   11320:	00d66c63          	bltu	a2,a3,11338 <_free_r+0x2c0>
   11324:	00f7d693          	srli	a3,a5,0xf
   11328:	07868593          	addi	a1,a3,120
   1132c:	00359593          	slli	a1,a1,0x3
   11330:	07768613          	addi	a2,a3,119
   11334:	ea1ff06f          	j	111d4 <_free_r+0x15c>
   11338:	55400613          	li	a2,1364
   1133c:	00d66c63          	bltu	a2,a3,11354 <_free_r+0x2dc>
   11340:	0127d693          	srli	a3,a5,0x12
   11344:	07d68593          	addi	a1,a3,125
   11348:	00359593          	slli	a1,a1,0x3
   1134c:	07c68613          	addi	a2,a3,124
   11350:	e85ff06f          	j	111d4 <_free_r+0x15c>
   11354:	3f800593          	li	a1,1016
   11358:	07e00613          	li	a2,126
   1135c:	e79ff06f          	j	111d4 <_free_r+0x15c>

00011360 <_malloc_r>:
   11360:	fc010113          	addi	sp,sp,-64
   11364:	02812c23          	sw	s0,56(sp)
   11368:	02112e23          	sw	ra,60(sp)
   1136c:	00b58793          	addi	a5,a1,11
   11370:	01600713          	li	a4,22
   11374:	00050413          	mv	s0,a0
   11378:	08f76e63          	bltu	a4,a5,11414 <_malloc_r+0xb4>
   1137c:	01000693          	li	a3,16
   11380:	06b6ec63          	bltu	a3,a1,113f8 <_malloc_r+0x98>
   11384:	059000ef          	jal	11bdc <__malloc_lock>
   11388:	01000693          	li	a3,16
   1138c:	01800713          	li	a4,24
   11390:	00200893          	li	a7,2
   11394:	00013837          	lui	a6,0x13
   11398:	57080813          	addi	a6,a6,1392 # 13570 <__malloc_av_>
   1139c:	00e80733          	add	a4,a6,a4
   113a0:	00472783          	lw	a5,4(a4)
   113a4:	ff870613          	addi	a2,a4,-8
   113a8:	44c78c63          	beq	a5,a2,11800 <_malloc_r+0x4a0>
   113ac:	0047a703          	lw	a4,4(a5)
   113b0:	00c7a603          	lw	a2,12(a5)
   113b4:	0087a583          	lw	a1,8(a5)
   113b8:	ffc77713          	andi	a4,a4,-4
   113bc:	00e78733          	add	a4,a5,a4
   113c0:	00472683          	lw	a3,4(a4)
   113c4:	00c5a623          	sw	a2,12(a1)
   113c8:	00f12623          	sw	a5,12(sp)
   113cc:	00b62423          	sw	a1,8(a2)
   113d0:	0016e693          	ori	a3,a3,1
   113d4:	00040513          	mv	a0,s0
   113d8:	00d72223          	sw	a3,4(a4)
   113dc:	005000ef          	jal	11be0 <__malloc_unlock>
   113e0:	00c12783          	lw	a5,12(sp)
   113e4:	03c12083          	lw	ra,60(sp)
   113e8:	03812403          	lw	s0,56(sp)
   113ec:	00878513          	addi	a0,a5,8
   113f0:	04010113          	addi	sp,sp,64
   113f4:	00008067          	ret
   113f8:	00c00793          	li	a5,12
   113fc:	00f42023          	sw	a5,0(s0)
   11400:	00000513          	li	a0,0
   11404:	03c12083          	lw	ra,60(sp)
   11408:	03812403          	lw	s0,56(sp)
   1140c:	04010113          	addi	sp,sp,64
   11410:	00008067          	ret
   11414:	ff87f693          	andi	a3,a5,-8
   11418:	fe07c0e3          	bltz	a5,113f8 <_malloc_r+0x98>
   1141c:	fcb6eee3          	bltu	a3,a1,113f8 <_malloc_r+0x98>
   11420:	00d12623          	sw	a3,12(sp)
   11424:	7b8000ef          	jal	11bdc <__malloc_lock>
   11428:	00c12683          	lw	a3,12(sp)
   1142c:	1f700793          	li	a5,503
   11430:	4cd7f663          	bgeu	a5,a3,118fc <_malloc_r+0x59c>
   11434:	0096d793          	srli	a5,a3,0x9
   11438:	16078e63          	beqz	a5,115b4 <_malloc_r+0x254>
   1143c:	00400713          	li	a4,4
   11440:	42f76863          	bltu	a4,a5,11870 <_malloc_r+0x510>
   11444:	0066d793          	srli	a5,a3,0x6
   11448:	03978893          	addi	a7,a5,57
   1144c:	03878e13          	addi	t3,a5,56
   11450:	00389513          	slli	a0,a7,0x3
   11454:	00013837          	lui	a6,0x13
   11458:	57080813          	addi	a6,a6,1392 # 13570 <__malloc_av_>
   1145c:	00a80533          	add	a0,a6,a0
   11460:	00452783          	lw	a5,4(a0)
   11464:	ff850513          	addi	a0,a0,-8
   11468:	02f50863          	beq	a0,a5,11498 <_malloc_r+0x138>
   1146c:	00f00313          	li	t1,15
   11470:	0140006f          	j	11484 <_malloc_r+0x124>
   11474:	00c7a583          	lw	a1,12(a5)
   11478:	34065463          	bgez	a2,117c0 <_malloc_r+0x460>
   1147c:	00b50e63          	beq	a0,a1,11498 <_malloc_r+0x138>
   11480:	00058793          	mv	a5,a1
   11484:	0047a703          	lw	a4,4(a5)
   11488:	ffc77713          	andi	a4,a4,-4
   1148c:	40d70633          	sub	a2,a4,a3
   11490:	fec352e3          	bge	t1,a2,11474 <_malloc_r+0x114>
   11494:	000e0893          	mv	a7,t3
   11498:	01082783          	lw	a5,16(a6)
   1149c:	00013e37          	lui	t3,0x13
   114a0:	578e0e13          	addi	t3,t3,1400 # 13578 <__malloc_av_+0x8>
   114a4:	2dc78c63          	beq	a5,t3,1177c <_malloc_r+0x41c>
   114a8:	0047a703          	lw	a4,4(a5)
   114ac:	00f00593          	li	a1,15
   114b0:	ffc77713          	andi	a4,a4,-4
   114b4:	40d70633          	sub	a2,a4,a3
   114b8:	46c5cc63          	blt	a1,a2,11930 <_malloc_r+0x5d0>
   114bc:	01c82a23          	sw	t3,20(a6)
   114c0:	01c82823          	sw	t3,16(a6)
   114c4:	44065263          	bgez	a2,11908 <_malloc_r+0x5a8>
   114c8:	1ff00613          	li	a2,511
   114cc:	00482303          	lw	t1,4(a6)
   114d0:	34e66063          	bltu	a2,a4,11810 <_malloc_r+0x4b0>
   114d4:	ff877613          	andi	a2,a4,-8
   114d8:	00860613          	addi	a2,a2,8
   114dc:	00c80633          	add	a2,a6,a2
   114e0:	00062583          	lw	a1,0(a2)
   114e4:	00575513          	srli	a0,a4,0x5
   114e8:	00100713          	li	a4,1
   114ec:	00a71733          	sll	a4,a4,a0
   114f0:	00e36333          	or	t1,t1,a4
   114f4:	ff860713          	addi	a4,a2,-8
   114f8:	00b7a423          	sw	a1,8(a5)
   114fc:	00e7a623          	sw	a4,12(a5)
   11500:	00682223          	sw	t1,4(a6)
   11504:	00f62023          	sw	a5,0(a2)
   11508:	00f5a623          	sw	a5,12(a1)
   1150c:	4028d793          	srai	a5,a7,0x2
   11510:	00100513          	li	a0,1
   11514:	00f51533          	sll	a0,a0,a5
   11518:	0aa36663          	bltu	t1,a0,115c4 <_malloc_r+0x264>
   1151c:	006577b3          	and	a5,a0,t1
   11520:	02079463          	bnez	a5,11548 <_malloc_r+0x1e8>
   11524:	00151513          	slli	a0,a0,0x1
   11528:	ffc8f893          	andi	a7,a7,-4
   1152c:	006577b3          	and	a5,a0,t1
   11530:	00488893          	addi	a7,a7,4
   11534:	00079a63          	bnez	a5,11548 <_malloc_r+0x1e8>
   11538:	00151513          	slli	a0,a0,0x1
   1153c:	006577b3          	and	a5,a0,t1
   11540:	00488893          	addi	a7,a7,4
   11544:	fe078ae3          	beqz	a5,11538 <_malloc_r+0x1d8>
   11548:	00f00e93          	li	t4,15
   1154c:	00389f13          	slli	t5,a7,0x3
   11550:	01e80f33          	add	t5,a6,t5
   11554:	000f0313          	mv	t1,t5
   11558:	00c32703          	lw	a4,12(t1)
   1155c:	00088f93          	mv	t6,a7
   11560:	32e30a63          	beq	t1,a4,11894 <_malloc_r+0x534>
   11564:	00472603          	lw	a2,4(a4)
   11568:	00070793          	mv	a5,a4
   1156c:	00c72703          	lw	a4,12(a4)
   11570:	ffc67613          	andi	a2,a2,-4
   11574:	40d605b3          	sub	a1,a2,a3
   11578:	32beca63          	blt	t4,a1,118ac <_malloc_r+0x54c>
   1157c:	fe05c2e3          	bltz	a1,11560 <_malloc_r+0x200>
   11580:	00c78633          	add	a2,a5,a2
   11584:	00462683          	lw	a3,4(a2)
   11588:	0087a583          	lw	a1,8(a5)
   1158c:	00040513          	mv	a0,s0
   11590:	0016e693          	ori	a3,a3,1
   11594:	00d62223          	sw	a3,4(a2)
   11598:	00e5a623          	sw	a4,12(a1)
   1159c:	00b72423          	sw	a1,8(a4)
   115a0:	00f12623          	sw	a5,12(sp)
   115a4:	63c000ef          	jal	11be0 <__malloc_unlock>
   115a8:	00c12783          	lw	a5,12(sp)
   115ac:	00878513          	addi	a0,a5,8
   115b0:	e55ff06f          	j	11404 <_malloc_r+0xa4>
   115b4:	20000513          	li	a0,512
   115b8:	04000893          	li	a7,64
   115bc:	03f00e13          	li	t3,63
   115c0:	e95ff06f          	j	11454 <_malloc_r+0xf4>
   115c4:	00882783          	lw	a5,8(a6)
   115c8:	0047a703          	lw	a4,4(a5)
   115cc:	ffc77313          	andi	t1,a4,-4
   115d0:	40d30633          	sub	a2,t1,a3
   115d4:	00d36663          	bltu	t1,a3,115e0 <_malloc_r+0x280>
   115d8:	01062713          	slti	a4,a2,16
   115dc:	1a070463          	beqz	a4,11784 <_malloc_r+0x424>
   115e0:	d7c1a583          	lw	a1,-644(gp) # 1399c <__malloc_top_pad>
   115e4:	d601a603          	lw	a2,-672(gp) # 13980 <__malloc_sbrk_base>
   115e8:	fff00713          	li	a4,-1
   115ec:	00b685b3          	add	a1,a3,a1
   115f0:	42e60463          	beq	a2,a4,11a18 <_malloc_r+0x6b8>
   115f4:	00001737          	lui	a4,0x1
   115f8:	00f70713          	addi	a4,a4,15 # 100f <exit-0xf0a5>
   115fc:	00e585b3          	add	a1,a1,a4
   11600:	fffff737          	lui	a4,0xfffff
   11604:	00e5f5b3          	and	a1,a1,a4
   11608:	00040513          	mv	a0,s0
   1160c:	01012e23          	sw	a6,28(sp)
   11610:	00f12c23          	sw	a5,24(sp)
   11614:	00d12a23          	sw	a3,20(sp)
   11618:	00612823          	sw	t1,16(sp)
   1161c:	00b12623          	sw	a1,12(sp)
   11620:	229000ef          	jal	12048 <_sbrk_r>
   11624:	fff00713          	li	a4,-1
   11628:	00c12583          	lw	a1,12(sp)
   1162c:	01012303          	lw	t1,16(sp)
   11630:	01412683          	lw	a3,20(sp)
   11634:	01812783          	lw	a5,24(sp)
   11638:	01c12803          	lw	a6,28(sp)
   1163c:	00050e13          	mv	t3,a0
   11640:	34e50663          	beq	a0,a4,1198c <_malloc_r+0x62c>
   11644:	00678733          	add	a4,a5,t1
   11648:	34e56063          	bltu	a0,a4,11988 <_malloc_r+0x628>
   1164c:	ed818e93          	addi	t4,gp,-296 # 13af8 <__malloc_current_mallinfo>
   11650:	000ea603          	lw	a2,0(t4)
   11654:	00c58633          	add	a2,a1,a2
   11658:	00cea023          	sw	a2,0(t4)
   1165c:	48a70a63          	beq	a4,a0,11af0 <_malloc_r+0x790>
   11660:	d601af03          	lw	t5,-672(gp) # 13980 <__malloc_sbrk_base>
   11664:	fff00513          	li	a0,-1
   11668:	4aaf0263          	beq	t5,a0,11b0c <_malloc_r+0x7ac>
   1166c:	40ee0733          	sub	a4,t3,a4
   11670:	00c70733          	add	a4,a4,a2
   11674:	00eea023          	sw	a4,0(t4)
   11678:	007e7f13          	andi	t5,t3,7
   1167c:	3a0f0e63          	beqz	t5,11a38 <_malloc_r+0x6d8>
   11680:	ff8e7e13          	andi	t3,t3,-8
   11684:	000018b7          	lui	a7,0x1
   11688:	008e0e13          	addi	t3,t3,8
   1168c:	00888893          	addi	a7,a7,8 # 1008 <exit-0xf0ac>
   11690:	00be0633          	add	a2,t3,a1
   11694:	41e885b3          	sub	a1,a7,t5
   11698:	40c585b3          	sub	a1,a1,a2
   1169c:	01459593          	slli	a1,a1,0x14
   116a0:	0145d593          	srli	a1,a1,0x14
   116a4:	00040513          	mv	a0,s0
   116a8:	03012623          	sw	a6,44(sp)
   116ac:	03d12423          	sw	t4,40(sp)
   116b0:	02f12223          	sw	a5,36(sp)
   116b4:	02d12023          	sw	a3,32(sp)
   116b8:	00612e23          	sw	t1,28(sp)
   116bc:	01c12c23          	sw	t3,24(sp)
   116c0:	01e12a23          	sw	t5,20(sp)
   116c4:	00c12823          	sw	a2,16(sp)
   116c8:	00b12623          	sw	a1,12(sp)
   116cc:	17d000ef          	jal	12048 <_sbrk_r>
   116d0:	00050713          	mv	a4,a0
   116d4:	fff00513          	li	a0,-1
   116d8:	00c12583          	lw	a1,12(sp)
   116dc:	01012603          	lw	a2,16(sp)
   116e0:	01412f03          	lw	t5,20(sp)
   116e4:	01812e03          	lw	t3,24(sp)
   116e8:	01c12303          	lw	t1,28(sp)
   116ec:	02012683          	lw	a3,32(sp)
   116f0:	02412783          	lw	a5,36(sp)
   116f4:	02812e83          	lw	t4,40(sp)
   116f8:	02c12803          	lw	a6,44(sp)
   116fc:	44a70e63          	beq	a4,a0,11b58 <_malloc_r+0x7f8>
   11700:	000ea603          	lw	a2,0(t4)
   11704:	41c70733          	sub	a4,a4,t3
   11708:	00b70733          	add	a4,a4,a1
   1170c:	00176713          	ori	a4,a4,1
   11710:	01c82423          	sw	t3,8(a6)
   11714:	00c58633          	add	a2,a1,a2
   11718:	00ee2223          	sw	a4,4(t3)
   1171c:	00cea023          	sw	a2,0(t4)
   11720:	03078e63          	beq	a5,a6,1175c <_malloc_r+0x3fc>
   11724:	00f00513          	li	a0,15
   11728:	3e657663          	bgeu	a0,t1,11b14 <_malloc_r+0x7b4>
   1172c:	0047a583          	lw	a1,4(a5)
   11730:	ff430713          	addi	a4,t1,-12
   11734:	ff877713          	andi	a4,a4,-8
   11738:	0015f593          	andi	a1,a1,1
   1173c:	00e5e5b3          	or	a1,a1,a4
   11740:	00b7a223          	sw	a1,4(a5)
   11744:	00500893          	li	a7,5
   11748:	00e785b3          	add	a1,a5,a4
   1174c:	0115a223          	sw	a7,4(a1)
   11750:	0115a423          	sw	a7,8(a1)
   11754:	40e56a63          	bltu	a0,a4,11b68 <_malloc_r+0x808>
   11758:	004e2703          	lw	a4,4(t3)
   1175c:	d781a583          	lw	a1,-648(gp) # 13998 <__malloc_max_sbrked_mem>
   11760:	00c5f463          	bgeu	a1,a2,11768 <_malloc_r+0x408>
   11764:	d6c1ac23          	sw	a2,-648(gp) # 13998 <__malloc_max_sbrked_mem>
   11768:	d741a583          	lw	a1,-652(gp) # 13994 <__malloc_max_total_mem>
   1176c:	00c5f463          	bgeu	a1,a2,11774 <_malloc_r+0x414>
   11770:	d6c1aa23          	sw	a2,-652(gp) # 13994 <__malloc_max_total_mem>
   11774:	000e0793          	mv	a5,t3
   11778:	21c0006f          	j	11994 <_malloc_r+0x634>
   1177c:	00482303          	lw	t1,4(a6)
   11780:	d8dff06f          	j	1150c <_malloc_r+0x1ac>
   11784:	0016e713          	ori	a4,a3,1
   11788:	00e7a223          	sw	a4,4(a5)
   1178c:	00d786b3          	add	a3,a5,a3
   11790:	00166613          	ori	a2,a2,1
   11794:	00d82423          	sw	a3,8(a6)
   11798:	00040513          	mv	a0,s0
   1179c:	00c6a223          	sw	a2,4(a3)
   117a0:	00f12623          	sw	a5,12(sp)
   117a4:	43c000ef          	jal	11be0 <__malloc_unlock>
   117a8:	00c12783          	lw	a5,12(sp)
   117ac:	03c12083          	lw	ra,60(sp)
   117b0:	03812403          	lw	s0,56(sp)
   117b4:	00878513          	addi	a0,a5,8
   117b8:	04010113          	addi	sp,sp,64
   117bc:	00008067          	ret
   117c0:	0087a603          	lw	a2,8(a5)
   117c4:	00e78733          	add	a4,a5,a4
   117c8:	00472683          	lw	a3,4(a4) # fffff004 <__BSS_END__+0xfffeb354>
   117cc:	00b62623          	sw	a1,12(a2)
   117d0:	00f12623          	sw	a5,12(sp)
   117d4:	0016e693          	ori	a3,a3,1
   117d8:	00c5a423          	sw	a2,8(a1)
   117dc:	00040513          	mv	a0,s0
   117e0:	00d72223          	sw	a3,4(a4)
   117e4:	3fc000ef          	jal	11be0 <__malloc_unlock>
   117e8:	00c12783          	lw	a5,12(sp)
   117ec:	03c12083          	lw	ra,60(sp)
   117f0:	03812403          	lw	s0,56(sp)
   117f4:	00878513          	addi	a0,a5,8
   117f8:	04010113          	addi	sp,sp,64
   117fc:	00008067          	ret
   11800:	00c72783          	lw	a5,12(a4)
   11804:	00288893          	addi	a7,a7,2
   11808:	c8f708e3          	beq	a4,a5,11498 <_malloc_r+0x138>
   1180c:	ba1ff06f          	j	113ac <_malloc_r+0x4c>
   11810:	00975613          	srli	a2,a4,0x9
   11814:	00400593          	li	a1,4
   11818:	14c5fe63          	bgeu	a1,a2,11974 <_malloc_r+0x614>
   1181c:	01400593          	li	a1,20
   11820:	28c5e263          	bltu	a1,a2,11aa4 <_malloc_r+0x744>
   11824:	05c60513          	addi	a0,a2,92
   11828:	00351513          	slli	a0,a0,0x3
   1182c:	05b60593          	addi	a1,a2,91
   11830:	00a80533          	add	a0,a6,a0
   11834:	00052603          	lw	a2,0(a0)
   11838:	ff850513          	addi	a0,a0,-8
   1183c:	00c51863          	bne	a0,a2,1184c <_malloc_r+0x4ec>
   11840:	1e00006f          	j	11a20 <_malloc_r+0x6c0>
   11844:	00862603          	lw	a2,8(a2)
   11848:	00c50863          	beq	a0,a2,11858 <_malloc_r+0x4f8>
   1184c:	00462583          	lw	a1,4(a2)
   11850:	ffc5f593          	andi	a1,a1,-4
   11854:	feb768e3          	bltu	a4,a1,11844 <_malloc_r+0x4e4>
   11858:	00c62503          	lw	a0,12(a2)
   1185c:	00a7a623          	sw	a0,12(a5)
   11860:	00c7a423          	sw	a2,8(a5)
   11864:	00f52423          	sw	a5,8(a0)
   11868:	00f62623          	sw	a5,12(a2)
   1186c:	ca1ff06f          	j	1150c <_malloc_r+0x1ac>
   11870:	01400713          	li	a4,20
   11874:	14f77063          	bgeu	a4,a5,119b4 <_malloc_r+0x654>
   11878:	05400713          	li	a4,84
   1187c:	24f76263          	bltu	a4,a5,11ac0 <_malloc_r+0x760>
   11880:	00c6d793          	srli	a5,a3,0xc
   11884:	06f78893          	addi	a7,a5,111
   11888:	06e78e13          	addi	t3,a5,110
   1188c:	00389513          	slli	a0,a7,0x3
   11890:	bc5ff06f          	j	11454 <_malloc_r+0xf4>
   11894:	001f8f93          	addi	t6,t6,1
   11898:	003ff793          	andi	a5,t6,3
   1189c:	00830313          	addi	t1,t1,8
   118a0:	12078863          	beqz	a5,119d0 <_malloc_r+0x670>
   118a4:	00c32703          	lw	a4,12(t1)
   118a8:	cb9ff06f          	j	11560 <_malloc_r+0x200>
   118ac:	0087a503          	lw	a0,8(a5)
   118b0:	0016e893          	ori	a7,a3,1
   118b4:	0117a223          	sw	a7,4(a5)
   118b8:	00e52623          	sw	a4,12(a0)
   118bc:	00a72423          	sw	a0,8(a4)
   118c0:	00d786b3          	add	a3,a5,a3
   118c4:	00d82a23          	sw	a3,20(a6)
   118c8:	00d82823          	sw	a3,16(a6)
   118cc:	0015e713          	ori	a4,a1,1
   118d0:	00c78633          	add	a2,a5,a2
   118d4:	01c6a623          	sw	t3,12(a3)
   118d8:	01c6a423          	sw	t3,8(a3)
   118dc:	00e6a223          	sw	a4,4(a3)
   118e0:	00040513          	mv	a0,s0
   118e4:	00b62023          	sw	a1,0(a2)
   118e8:	00f12623          	sw	a5,12(sp)
   118ec:	2f4000ef          	jal	11be0 <__malloc_unlock>
   118f0:	00c12783          	lw	a5,12(sp)
   118f4:	00878513          	addi	a0,a5,8
   118f8:	b0dff06f          	j	11404 <_malloc_r+0xa4>
   118fc:	0036d893          	srli	a7,a3,0x3
   11900:	00868713          	addi	a4,a3,8
   11904:	a91ff06f          	j	11394 <_malloc_r+0x34>
   11908:	00e78733          	add	a4,a5,a4
   1190c:	00472683          	lw	a3,4(a4)
   11910:	00f12623          	sw	a5,12(sp)
   11914:	00040513          	mv	a0,s0
   11918:	0016e693          	ori	a3,a3,1
   1191c:	00d72223          	sw	a3,4(a4)
   11920:	2c0000ef          	jal	11be0 <__malloc_unlock>
   11924:	00c12783          	lw	a5,12(sp)
   11928:	00878513          	addi	a0,a5,8
   1192c:	ad9ff06f          	j	11404 <_malloc_r+0xa4>
   11930:	0016e593          	ori	a1,a3,1
   11934:	00b7a223          	sw	a1,4(a5)
   11938:	00d786b3          	add	a3,a5,a3
   1193c:	00d82a23          	sw	a3,20(a6)
   11940:	00d82823          	sw	a3,16(a6)
   11944:	00166593          	ori	a1,a2,1
   11948:	00e78733          	add	a4,a5,a4
   1194c:	01c6a623          	sw	t3,12(a3)
   11950:	01c6a423          	sw	t3,8(a3)
   11954:	00b6a223          	sw	a1,4(a3)
   11958:	00040513          	mv	a0,s0
   1195c:	00c72023          	sw	a2,0(a4)
   11960:	00f12623          	sw	a5,12(sp)
   11964:	27c000ef          	jal	11be0 <__malloc_unlock>
   11968:	00c12783          	lw	a5,12(sp)
   1196c:	00878513          	addi	a0,a5,8
   11970:	a95ff06f          	j	11404 <_malloc_r+0xa4>
   11974:	00675613          	srli	a2,a4,0x6
   11978:	03960513          	addi	a0,a2,57
   1197c:	00351513          	slli	a0,a0,0x3
   11980:	03860593          	addi	a1,a2,56
   11984:	eadff06f          	j	11830 <_malloc_r+0x4d0>
   11988:	15078a63          	beq	a5,a6,11adc <_malloc_r+0x77c>
   1198c:	00882783          	lw	a5,8(a6)
   11990:	0047a703          	lw	a4,4(a5)
   11994:	ffc77713          	andi	a4,a4,-4
   11998:	40d70633          	sub	a2,a4,a3
   1199c:	00d76663          	bltu	a4,a3,119a8 <_malloc_r+0x648>
   119a0:	01062713          	slti	a4,a2,16
   119a4:	de0700e3          	beqz	a4,11784 <_malloc_r+0x424>
   119a8:	00040513          	mv	a0,s0
   119ac:	234000ef          	jal	11be0 <__malloc_unlock>
   119b0:	a51ff06f          	j	11400 <_malloc_r+0xa0>
   119b4:	05c78893          	addi	a7,a5,92
   119b8:	05b78e13          	addi	t3,a5,91
   119bc:	00389513          	slli	a0,a7,0x3
   119c0:	a95ff06f          	j	11454 <_malloc_r+0xf4>
   119c4:	008f2783          	lw	a5,8(t5)
   119c8:	fff88893          	addi	a7,a7,-1
   119cc:	21e79463          	bne	a5,t5,11bd4 <_malloc_r+0x874>
   119d0:	0038f793          	andi	a5,a7,3
   119d4:	ff8f0f13          	addi	t5,t5,-8
   119d8:	fe0796e3          	bnez	a5,119c4 <_malloc_r+0x664>
   119dc:	00482703          	lw	a4,4(a6)
   119e0:	fff54793          	not	a5,a0
   119e4:	00e7f7b3          	and	a5,a5,a4
   119e8:	00f82223          	sw	a5,4(a6)
   119ec:	00151513          	slli	a0,a0,0x1
   119f0:	fff50713          	addi	a4,a0,-1
   119f4:	bcf778e3          	bgeu	a4,a5,115c4 <_malloc_r+0x264>
   119f8:	00f57733          	and	a4,a0,a5
   119fc:	00071a63          	bnez	a4,11a10 <_malloc_r+0x6b0>
   11a00:	00151513          	slli	a0,a0,0x1
   11a04:	00f57733          	and	a4,a0,a5
   11a08:	004f8f93          	addi	t6,t6,4
   11a0c:	fe070ae3          	beqz	a4,11a00 <_malloc_r+0x6a0>
   11a10:	000f8893          	mv	a7,t6
   11a14:	b39ff06f          	j	1154c <_malloc_r+0x1ec>
   11a18:	01058593          	addi	a1,a1,16
   11a1c:	bedff06f          	j	11608 <_malloc_r+0x2a8>
   11a20:	4025d593          	srai	a1,a1,0x2
   11a24:	00100713          	li	a4,1
   11a28:	00b71733          	sll	a4,a4,a1
   11a2c:	00e36333          	or	t1,t1,a4
   11a30:	00682223          	sw	t1,4(a6)
   11a34:	e29ff06f          	j	1185c <_malloc_r+0x4fc>
   11a38:	00be0633          	add	a2,t3,a1
   11a3c:	40c005b3          	neg	a1,a2
   11a40:	01459593          	slli	a1,a1,0x14
   11a44:	0145d593          	srli	a1,a1,0x14
   11a48:	00040513          	mv	a0,s0
   11a4c:	03012423          	sw	a6,40(sp)
   11a50:	03d12223          	sw	t4,36(sp)
   11a54:	02f12023          	sw	a5,32(sp)
   11a58:	00d12e23          	sw	a3,28(sp)
   11a5c:	00612c23          	sw	t1,24(sp)
   11a60:	01c12a23          	sw	t3,20(sp)
   11a64:	00b12623          	sw	a1,12(sp)
   11a68:	00c12823          	sw	a2,16(sp)
   11a6c:	5dc000ef          	jal	12048 <_sbrk_r>
   11a70:	00050713          	mv	a4,a0
   11a74:	fff00513          	li	a0,-1
   11a78:	00c12583          	lw	a1,12(sp)
   11a7c:	01412e03          	lw	t3,20(sp)
   11a80:	01812303          	lw	t1,24(sp)
   11a84:	01c12683          	lw	a3,28(sp)
   11a88:	02012783          	lw	a5,32(sp)
   11a8c:	02412e83          	lw	t4,36(sp)
   11a90:	02812803          	lw	a6,40(sp)
   11a94:	c6a716e3          	bne	a4,a0,11700 <_malloc_r+0x3a0>
   11a98:	01012703          	lw	a4,16(sp)
   11a9c:	00000593          	li	a1,0
   11aa0:	c61ff06f          	j	11700 <_malloc_r+0x3a0>
   11aa4:	05400593          	li	a1,84
   11aa8:	06c5ec63          	bltu	a1,a2,11b20 <_malloc_r+0x7c0>
   11aac:	00c75613          	srli	a2,a4,0xc
   11ab0:	06f60513          	addi	a0,a2,111
   11ab4:	00351513          	slli	a0,a0,0x3
   11ab8:	06e60593          	addi	a1,a2,110
   11abc:	d75ff06f          	j	11830 <_malloc_r+0x4d0>
   11ac0:	15400713          	li	a4,340
   11ac4:	06f76c63          	bltu	a4,a5,11b3c <_malloc_r+0x7dc>
   11ac8:	00f6d793          	srli	a5,a3,0xf
   11acc:	07878893          	addi	a7,a5,120
   11ad0:	07778e13          	addi	t3,a5,119
   11ad4:	00389513          	slli	a0,a7,0x3
   11ad8:	97dff06f          	j	11454 <_malloc_r+0xf4>
   11adc:	ed818e93          	addi	t4,gp,-296 # 13af8 <__malloc_current_mallinfo>
   11ae0:	000ea603          	lw	a2,0(t4)
   11ae4:	00c58633          	add	a2,a1,a2
   11ae8:	00cea023          	sw	a2,0(t4)
   11aec:	b75ff06f          	j	11660 <_malloc_r+0x300>
   11af0:	01451513          	slli	a0,a0,0x14
   11af4:	b60516e3          	bnez	a0,11660 <_malloc_r+0x300>
   11af8:	00882e03          	lw	t3,8(a6)
   11afc:	00b305b3          	add	a1,t1,a1
   11b00:	0015e713          	ori	a4,a1,1
   11b04:	00ee2223          	sw	a4,4(t3)
   11b08:	c55ff06f          	j	1175c <_malloc_r+0x3fc>
   11b0c:	d7c1a023          	sw	t3,-672(gp) # 13980 <__malloc_sbrk_base>
   11b10:	b69ff06f          	j	11678 <_malloc_r+0x318>
   11b14:	00100793          	li	a5,1
   11b18:	00fe2223          	sw	a5,4(t3)
   11b1c:	e8dff06f          	j	119a8 <_malloc_r+0x648>
   11b20:	15400593          	li	a1,340
   11b24:	06c5ec63          	bltu	a1,a2,11b9c <_malloc_r+0x83c>
   11b28:	00f75613          	srli	a2,a4,0xf
   11b2c:	07860513          	addi	a0,a2,120
   11b30:	00351513          	slli	a0,a0,0x3
   11b34:	07760593          	addi	a1,a2,119
   11b38:	cf9ff06f          	j	11830 <_malloc_r+0x4d0>
   11b3c:	55400713          	li	a4,1364
   11b40:	06f76c63          	bltu	a4,a5,11bb8 <_malloc_r+0x858>
   11b44:	0126d793          	srli	a5,a3,0x12
   11b48:	07d78893          	addi	a7,a5,125
   11b4c:	07c78e13          	addi	t3,a5,124
   11b50:	00389513          	slli	a0,a7,0x3
   11b54:	901ff06f          	j	11454 <_malloc_r+0xf4>
   11b58:	ff8f0f13          	addi	t5,t5,-8
   11b5c:	01e60733          	add	a4,a2,t5
   11b60:	00000593          	li	a1,0
   11b64:	b9dff06f          	j	11700 <_malloc_r+0x3a0>
   11b68:	00878593          	addi	a1,a5,8
   11b6c:	00040513          	mv	a0,s0
   11b70:	01012a23          	sw	a6,20(sp)
   11b74:	01d12823          	sw	t4,16(sp)
   11b78:	00d12623          	sw	a3,12(sp)
   11b7c:	cfcff0ef          	jal	11078 <_free_r>
   11b80:	01412803          	lw	a6,20(sp)
   11b84:	01012e83          	lw	t4,16(sp)
   11b88:	00c12683          	lw	a3,12(sp)
   11b8c:	00882e03          	lw	t3,8(a6)
   11b90:	000ea603          	lw	a2,0(t4)
   11b94:	004e2703          	lw	a4,4(t3)
   11b98:	bc5ff06f          	j	1175c <_malloc_r+0x3fc>
   11b9c:	55400593          	li	a1,1364
   11ba0:	02c5e463          	bltu	a1,a2,11bc8 <_malloc_r+0x868>
   11ba4:	01275613          	srli	a2,a4,0x12
   11ba8:	07d60513          	addi	a0,a2,125
   11bac:	00351513          	slli	a0,a0,0x3
   11bb0:	07c60593          	addi	a1,a2,124
   11bb4:	c7dff06f          	j	11830 <_malloc_r+0x4d0>
   11bb8:	3f800513          	li	a0,1016
   11bbc:	07f00893          	li	a7,127
   11bc0:	07e00e13          	li	t3,126
   11bc4:	891ff06f          	j	11454 <_malloc_r+0xf4>
   11bc8:	3f800513          	li	a0,1016
   11bcc:	07e00593          	li	a1,126
   11bd0:	c61ff06f          	j	11830 <_malloc_r+0x4d0>
   11bd4:	00482783          	lw	a5,4(a6)
   11bd8:	e15ff06f          	j	119ec <_malloc_r+0x68c>

00011bdc <__malloc_lock>:
   11bdc:	00008067          	ret

00011be0 <__malloc_unlock>:
   11be0:	00008067          	ret

00011be4 <_fclose_r>:
   11be4:	ff010113          	addi	sp,sp,-16
   11be8:	00112623          	sw	ra,12(sp)
   11bec:	01212023          	sw	s2,0(sp)
   11bf0:	02058863          	beqz	a1,11c20 <_fclose_r+0x3c>
   11bf4:	00812423          	sw	s0,8(sp)
   11bf8:	00912223          	sw	s1,4(sp)
   11bfc:	00058413          	mv	s0,a1
   11c00:	00050493          	mv	s1,a0
   11c04:	00050663          	beqz	a0,11c10 <_fclose_r+0x2c>
   11c08:	03452783          	lw	a5,52(a0)
   11c0c:	0c078c63          	beqz	a5,11ce4 <_fclose_r+0x100>
   11c10:	00c41783          	lh	a5,12(s0)
   11c14:	02079263          	bnez	a5,11c38 <_fclose_r+0x54>
   11c18:	00812403          	lw	s0,8(sp)
   11c1c:	00412483          	lw	s1,4(sp)
   11c20:	00c12083          	lw	ra,12(sp)
   11c24:	00000913          	li	s2,0
   11c28:	00090513          	mv	a0,s2
   11c2c:	00012903          	lw	s2,0(sp)
   11c30:	01010113          	addi	sp,sp,16
   11c34:	00008067          	ret
   11c38:	00040593          	mv	a1,s0
   11c3c:	00048513          	mv	a0,s1
   11c40:	0b8000ef          	jal	11cf8 <__sflush_r>
   11c44:	02c42783          	lw	a5,44(s0)
   11c48:	00050913          	mv	s2,a0
   11c4c:	00078a63          	beqz	a5,11c60 <_fclose_r+0x7c>
   11c50:	01c42583          	lw	a1,28(s0)
   11c54:	00048513          	mv	a0,s1
   11c58:	000780e7          	jalr	a5
   11c5c:	06054463          	bltz	a0,11cc4 <_fclose_r+0xe0>
   11c60:	00c45783          	lhu	a5,12(s0)
   11c64:	0807f793          	andi	a5,a5,128
   11c68:	06079663          	bnez	a5,11cd4 <_fclose_r+0xf0>
   11c6c:	03042583          	lw	a1,48(s0)
   11c70:	00058c63          	beqz	a1,11c88 <_fclose_r+0xa4>
   11c74:	04040793          	addi	a5,s0,64
   11c78:	00f58663          	beq	a1,a5,11c84 <_fclose_r+0xa0>
   11c7c:	00048513          	mv	a0,s1
   11c80:	bf8ff0ef          	jal	11078 <_free_r>
   11c84:	02042823          	sw	zero,48(s0)
   11c88:	04442583          	lw	a1,68(s0)
   11c8c:	00058863          	beqz	a1,11c9c <_fclose_r+0xb8>
   11c90:	00048513          	mv	a0,s1
   11c94:	be4ff0ef          	jal	11078 <_free_r>
   11c98:	04042223          	sw	zero,68(s0)
   11c9c:	b29fe0ef          	jal	107c4 <__sfp_lock_acquire>
   11ca0:	00041623          	sh	zero,12(s0)
   11ca4:	b25fe0ef          	jal	107c8 <__sfp_lock_release>
   11ca8:	00c12083          	lw	ra,12(sp)
   11cac:	00812403          	lw	s0,8(sp)
   11cb0:	00412483          	lw	s1,4(sp)
   11cb4:	00090513          	mv	a0,s2
   11cb8:	00012903          	lw	s2,0(sp)
   11cbc:	01010113          	addi	sp,sp,16
   11cc0:	00008067          	ret
   11cc4:	00c45783          	lhu	a5,12(s0)
   11cc8:	fff00913          	li	s2,-1
   11ccc:	0807f793          	andi	a5,a5,128
   11cd0:	f8078ee3          	beqz	a5,11c6c <_fclose_r+0x88>
   11cd4:	01042583          	lw	a1,16(s0)
   11cd8:	00048513          	mv	a0,s1
   11cdc:	b9cff0ef          	jal	11078 <_free_r>
   11ce0:	f8dff06f          	j	11c6c <_fclose_r+0x88>
   11ce4:	abdfe0ef          	jal	107a0 <__sinit>
   11ce8:	f29ff06f          	j	11c10 <_fclose_r+0x2c>

00011cec <fclose>:
   11cec:	00050593          	mv	a1,a0
   11cf0:	d5c1a503          	lw	a0,-676(gp) # 1397c <_impure_ptr>
   11cf4:	ef1ff06f          	j	11be4 <_fclose_r>

00011cf8 <__sflush_r>:
   11cf8:	00c59703          	lh	a4,12(a1)
   11cfc:	fe010113          	addi	sp,sp,-32
   11d00:	00812c23          	sw	s0,24(sp)
   11d04:	01312623          	sw	s3,12(sp)
   11d08:	00112e23          	sw	ra,28(sp)
   11d0c:	00877793          	andi	a5,a4,8
   11d10:	00058413          	mv	s0,a1
   11d14:	00050993          	mv	s3,a0
   11d18:	12079263          	bnez	a5,11e3c <__sflush_r+0x144>
   11d1c:	000017b7          	lui	a5,0x1
   11d20:	80078793          	addi	a5,a5,-2048 # 800 <exit-0xf8b4>
   11d24:	0045a683          	lw	a3,4(a1)
   11d28:	00f767b3          	or	a5,a4,a5
   11d2c:	00f59623          	sh	a5,12(a1)
   11d30:	18d05c63          	blez	a3,11ec8 <__sflush_r+0x1d0>
   11d34:	02842803          	lw	a6,40(s0)
   11d38:	0e080663          	beqz	a6,11e24 <__sflush_r+0x12c>
   11d3c:	00912a23          	sw	s1,20(sp)
   11d40:	01371693          	slli	a3,a4,0x13
   11d44:	0009a483          	lw	s1,0(s3)
   11d48:	0009a023          	sw	zero,0(s3)
   11d4c:	1806ca63          	bltz	a3,11ee0 <__sflush_r+0x1e8>
   11d50:	01c42583          	lw	a1,28(s0)
   11d54:	00000613          	li	a2,0
   11d58:	00100693          	li	a3,1
   11d5c:	00098513          	mv	a0,s3
   11d60:	000800e7          	jalr	a6
   11d64:	fff00793          	li	a5,-1
   11d68:	00050613          	mv	a2,a0
   11d6c:	1af50c63          	beq	a0,a5,11f24 <__sflush_r+0x22c>
   11d70:	00c41783          	lh	a5,12(s0)
   11d74:	02842803          	lw	a6,40(s0)
   11d78:	0047f793          	andi	a5,a5,4
   11d7c:	00078e63          	beqz	a5,11d98 <__sflush_r+0xa0>
   11d80:	00442703          	lw	a4,4(s0)
   11d84:	03042783          	lw	a5,48(s0)
   11d88:	40e60633          	sub	a2,a2,a4
   11d8c:	00078663          	beqz	a5,11d98 <__sflush_r+0xa0>
   11d90:	03c42783          	lw	a5,60(s0)
   11d94:	40f60633          	sub	a2,a2,a5
   11d98:	01c42583          	lw	a1,28(s0)
   11d9c:	00000693          	li	a3,0
   11da0:	00098513          	mv	a0,s3
   11da4:	000800e7          	jalr	a6
   11da8:	fff00713          	li	a4,-1
   11dac:	00c41783          	lh	a5,12(s0)
   11db0:	12e51c63          	bne	a0,a4,11ee8 <__sflush_r+0x1f0>
   11db4:	0009a683          	lw	a3,0(s3)
   11db8:	01d00713          	li	a4,29
   11dbc:	18d76263          	bltu	a4,a3,11f40 <__sflush_r+0x248>
   11dc0:	20400737          	lui	a4,0x20400
   11dc4:	00170713          	addi	a4,a4,1 # 20400001 <__BSS_END__+0x203ec351>
   11dc8:	00d75733          	srl	a4,a4,a3
   11dcc:	00177713          	andi	a4,a4,1
   11dd0:	16070863          	beqz	a4,11f40 <__sflush_r+0x248>
   11dd4:	01042683          	lw	a3,16(s0)
   11dd8:	fffff737          	lui	a4,0xfffff
   11ddc:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebb4f>
   11de0:	00e7f733          	and	a4,a5,a4
   11de4:	00e41623          	sh	a4,12(s0)
   11de8:	00042223          	sw	zero,4(s0)
   11dec:	00d42023          	sw	a3,0(s0)
   11df0:	01379713          	slli	a4,a5,0x13
   11df4:	00075663          	bgez	a4,11e00 <__sflush_r+0x108>
   11df8:	0009a783          	lw	a5,0(s3)
   11dfc:	10078863          	beqz	a5,11f0c <__sflush_r+0x214>
   11e00:	03042583          	lw	a1,48(s0)
   11e04:	0099a023          	sw	s1,0(s3)
   11e08:	10058a63          	beqz	a1,11f1c <__sflush_r+0x224>
   11e0c:	04040793          	addi	a5,s0,64
   11e10:	00f58663          	beq	a1,a5,11e1c <__sflush_r+0x124>
   11e14:	00098513          	mv	a0,s3
   11e18:	a60ff0ef          	jal	11078 <_free_r>
   11e1c:	01412483          	lw	s1,20(sp)
   11e20:	02042823          	sw	zero,48(s0)
   11e24:	01c12083          	lw	ra,28(sp)
   11e28:	01812403          	lw	s0,24(sp)
   11e2c:	00c12983          	lw	s3,12(sp)
   11e30:	00000513          	li	a0,0
   11e34:	02010113          	addi	sp,sp,32
   11e38:	00008067          	ret
   11e3c:	01212823          	sw	s2,16(sp)
   11e40:	0105a903          	lw	s2,16(a1)
   11e44:	08090a63          	beqz	s2,11ed8 <__sflush_r+0x1e0>
   11e48:	00912a23          	sw	s1,20(sp)
   11e4c:	0005a483          	lw	s1,0(a1)
   11e50:	00377713          	andi	a4,a4,3
   11e54:	0125a023          	sw	s2,0(a1)
   11e58:	412484b3          	sub	s1,s1,s2
   11e5c:	00000793          	li	a5,0
   11e60:	00071463          	bnez	a4,11e68 <__sflush_r+0x170>
   11e64:	0145a783          	lw	a5,20(a1)
   11e68:	00f42423          	sw	a5,8(s0)
   11e6c:	00904863          	bgtz	s1,11e7c <__sflush_r+0x184>
   11e70:	0640006f          	j	11ed4 <__sflush_r+0x1dc>
   11e74:	00a90933          	add	s2,s2,a0
   11e78:	04905e63          	blez	s1,11ed4 <__sflush_r+0x1dc>
   11e7c:	02442783          	lw	a5,36(s0)
   11e80:	01c42583          	lw	a1,28(s0)
   11e84:	00048693          	mv	a3,s1
   11e88:	00090613          	mv	a2,s2
   11e8c:	00098513          	mv	a0,s3
   11e90:	000780e7          	jalr	a5
   11e94:	40a484b3          	sub	s1,s1,a0
   11e98:	fca04ee3          	bgtz	a0,11e74 <__sflush_r+0x17c>
   11e9c:	00c45783          	lhu	a5,12(s0)
   11ea0:	01012903          	lw	s2,16(sp)
   11ea4:	0407e793          	ori	a5,a5,64
   11ea8:	01c12083          	lw	ra,28(sp)
   11eac:	00f41623          	sh	a5,12(s0)
   11eb0:	01812403          	lw	s0,24(sp)
   11eb4:	01412483          	lw	s1,20(sp)
   11eb8:	00c12983          	lw	s3,12(sp)
   11ebc:	fff00513          	li	a0,-1
   11ec0:	02010113          	addi	sp,sp,32
   11ec4:	00008067          	ret
   11ec8:	03c5a683          	lw	a3,60(a1)
   11ecc:	e6d044e3          	bgtz	a3,11d34 <__sflush_r+0x3c>
   11ed0:	f55ff06f          	j	11e24 <__sflush_r+0x12c>
   11ed4:	01412483          	lw	s1,20(sp)
   11ed8:	01012903          	lw	s2,16(sp)
   11edc:	f49ff06f          	j	11e24 <__sflush_r+0x12c>
   11ee0:	05042603          	lw	a2,80(s0)
   11ee4:	e95ff06f          	j	11d78 <__sflush_r+0x80>
   11ee8:	01042683          	lw	a3,16(s0)
   11eec:	fffff737          	lui	a4,0xfffff
   11ef0:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebb4f>
   11ef4:	00e7f733          	and	a4,a5,a4
   11ef8:	00e41623          	sh	a4,12(s0)
   11efc:	00042223          	sw	zero,4(s0)
   11f00:	00d42023          	sw	a3,0(s0)
   11f04:	01379713          	slli	a4,a5,0x13
   11f08:	ee075ce3          	bgez	a4,11e00 <__sflush_r+0x108>
   11f0c:	03042583          	lw	a1,48(s0)
   11f10:	04a42823          	sw	a0,80(s0)
   11f14:	0099a023          	sw	s1,0(s3)
   11f18:	ee059ae3          	bnez	a1,11e0c <__sflush_r+0x114>
   11f1c:	01412483          	lw	s1,20(sp)
   11f20:	f05ff06f          	j	11e24 <__sflush_r+0x12c>
   11f24:	0009a783          	lw	a5,0(s3)
   11f28:	e40784e3          	beqz	a5,11d70 <__sflush_r+0x78>
   11f2c:	fe378713          	addi	a4,a5,-29
   11f30:	00070c63          	beqz	a4,11f48 <__sflush_r+0x250>
   11f34:	fea78793          	addi	a5,a5,-22
   11f38:	00078863          	beqz	a5,11f48 <__sflush_r+0x250>
   11f3c:	00c45783          	lhu	a5,12(s0)
   11f40:	0407e793          	ori	a5,a5,64
   11f44:	f65ff06f          	j	11ea8 <__sflush_r+0x1b0>
   11f48:	0099a023          	sw	s1,0(s3)
   11f4c:	01412483          	lw	s1,20(sp)
   11f50:	ed5ff06f          	j	11e24 <__sflush_r+0x12c>

00011f54 <_fflush_r>:
   11f54:	00050793          	mv	a5,a0
   11f58:	00050663          	beqz	a0,11f64 <_fflush_r+0x10>
   11f5c:	03452703          	lw	a4,52(a0)
   11f60:	00070e63          	beqz	a4,11f7c <_fflush_r+0x28>
   11f64:	00c59703          	lh	a4,12(a1)
   11f68:	00071663          	bnez	a4,11f74 <_fflush_r+0x20>
   11f6c:	00000513          	li	a0,0
   11f70:	00008067          	ret
   11f74:	00078513          	mv	a0,a5
   11f78:	d81ff06f          	j	11cf8 <__sflush_r>
   11f7c:	fe010113          	addi	sp,sp,-32
   11f80:	00b12623          	sw	a1,12(sp)
   11f84:	00112e23          	sw	ra,28(sp)
   11f88:	00a12423          	sw	a0,8(sp)
   11f8c:	815fe0ef          	jal	107a0 <__sinit>
   11f90:	00c12583          	lw	a1,12(sp)
   11f94:	00812783          	lw	a5,8(sp)
   11f98:	00c59703          	lh	a4,12(a1)
   11f9c:	00070a63          	beqz	a4,11fb0 <_fflush_r+0x5c>
   11fa0:	01c12083          	lw	ra,28(sp)
   11fa4:	00078513          	mv	a0,a5
   11fa8:	02010113          	addi	sp,sp,32
   11fac:	d4dff06f          	j	11cf8 <__sflush_r>
   11fb0:	01c12083          	lw	ra,28(sp)
   11fb4:	00000513          	li	a0,0
   11fb8:	02010113          	addi	sp,sp,32
   11fbc:	00008067          	ret

00011fc0 <fflush>:
   11fc0:	06050063          	beqz	a0,12020 <fflush+0x60>
   11fc4:	00050593          	mv	a1,a0
   11fc8:	d5c1a503          	lw	a0,-676(gp) # 1397c <_impure_ptr>
   11fcc:	00050663          	beqz	a0,11fd8 <fflush+0x18>
   11fd0:	03452783          	lw	a5,52(a0)
   11fd4:	00078c63          	beqz	a5,11fec <fflush+0x2c>
   11fd8:	00c59783          	lh	a5,12(a1)
   11fdc:	00079663          	bnez	a5,11fe8 <fflush+0x28>
   11fe0:	00000513          	li	a0,0
   11fe4:	00008067          	ret
   11fe8:	d11ff06f          	j	11cf8 <__sflush_r>
   11fec:	fe010113          	addi	sp,sp,-32
   11ff0:	00b12623          	sw	a1,12(sp)
   11ff4:	00a12423          	sw	a0,8(sp)
   11ff8:	00112e23          	sw	ra,28(sp)
   11ffc:	fa4fe0ef          	jal	107a0 <__sinit>
   12000:	00c12583          	lw	a1,12(sp)
   12004:	00812503          	lw	a0,8(sp)
   12008:	00c59783          	lh	a5,12(a1)
   1200c:	02079863          	bnez	a5,1203c <fflush+0x7c>
   12010:	01c12083          	lw	ra,28(sp)
   12014:	00000513          	li	a0,0
   12018:	02010113          	addi	sp,sp,32
   1201c:	00008067          	ret
   12020:	00013637          	lui	a2,0x13
   12024:	000125b7          	lui	a1,0x12
   12028:	00013537          	lui	a0,0x13
   1202c:	42060613          	addi	a2,a2,1056 # 13420 <__sglue>
   12030:	f5458593          	addi	a1,a1,-172 # 11f54 <_fflush_r>
   12034:	43050513          	addi	a0,a0,1072 # 13430 <_impure_data>
   12038:	fc4fe06f          	j	107fc <_fwalk_sglue>
   1203c:	01c12083          	lw	ra,28(sp)
   12040:	02010113          	addi	sp,sp,32
   12044:	cb5ff06f          	j	11cf8 <__sflush_r>

00012048 <_sbrk_r>:
   12048:	ff010113          	addi	sp,sp,-16
   1204c:	00812423          	sw	s0,8(sp)
   12050:	00912223          	sw	s1,4(sp)
   12054:	00050493          	mv	s1,a0
   12058:	00058513          	mv	a0,a1
   1205c:	00112623          	sw	ra,12(sp)
   12060:	d601a623          	sw	zero,-660(gp) # 1398c <errno>
   12064:	220000ef          	jal	12284 <_sbrk>
   12068:	fff00793          	li	a5,-1
   1206c:	00f50c63          	beq	a0,a5,12084 <_sbrk_r+0x3c>
   12070:	00c12083          	lw	ra,12(sp)
   12074:	00812403          	lw	s0,8(sp)
   12078:	00412483          	lw	s1,4(sp)
   1207c:	01010113          	addi	sp,sp,16
   12080:	00008067          	ret
   12084:	d6c1a783          	lw	a5,-660(gp) # 1398c <errno>
   12088:	fe0784e3          	beqz	a5,12070 <_sbrk_r+0x28>
   1208c:	00c12083          	lw	ra,12(sp)
   12090:	00812403          	lw	s0,8(sp)
   12094:	00f4a023          	sw	a5,0(s1)
   12098:	00412483          	lw	s1,4(sp)
   1209c:	01010113          	addi	sp,sp,16
   120a0:	00008067          	ret

000120a4 <__libc_fini_array>:
   120a4:	ff010113          	addi	sp,sp,-16
   120a8:	00812423          	sw	s0,8(sp)
   120ac:	000137b7          	lui	a5,0x13
   120b0:	00013437          	lui	s0,0x13
   120b4:	42078793          	addi	a5,a5,1056 # 13420 <__sglue>
   120b8:	41c40413          	addi	s0,s0,1052 # 1341c <__do_global_dtors_aux_fini_array_entry>
   120bc:	408787b3          	sub	a5,a5,s0
   120c0:	00912223          	sw	s1,4(sp)
   120c4:	00112623          	sw	ra,12(sp)
   120c8:	4027d493          	srai	s1,a5,0x2
   120cc:	02048063          	beqz	s1,120ec <__libc_fini_array+0x48>
   120d0:	ffc40413          	addi	s0,s0,-4
   120d4:	00f40433          	add	s0,s0,a5
   120d8:	00042783          	lw	a5,0(s0)
   120dc:	fff48493          	addi	s1,s1,-1
   120e0:	ffc40413          	addi	s0,s0,-4
   120e4:	000780e7          	jalr	a5
   120e8:	fe0498e3          	bnez	s1,120d8 <__libc_fini_array+0x34>
   120ec:	00c12083          	lw	ra,12(sp)
   120f0:	00812403          	lw	s0,8(sp)
   120f4:	00412483          	lw	s1,4(sp)
   120f8:	01010113          	addi	sp,sp,16
   120fc:	00008067          	ret

00012100 <__register_exitproc>:
   12100:	d701a783          	lw	a5,-656(gp) # 13990 <__atexit>
   12104:	04078c63          	beqz	a5,1215c <__register_exitproc+0x5c>
   12108:	0047a703          	lw	a4,4(a5)
   1210c:	01f00813          	li	a6,31
   12110:	06e84e63          	blt	a6,a4,1218c <__register_exitproc+0x8c>
   12114:	00271813          	slli	a6,a4,0x2
   12118:	02050663          	beqz	a0,12144 <__register_exitproc+0x44>
   1211c:	01078333          	add	t1,a5,a6
   12120:	08c32423          	sw	a2,136(t1)
   12124:	1887a883          	lw	a7,392(a5)
   12128:	00100613          	li	a2,1
   1212c:	00e61633          	sll	a2,a2,a4
   12130:	00c8e8b3          	or	a7,a7,a2
   12134:	1917a423          	sw	a7,392(a5)
   12138:	10d32423          	sw	a3,264(t1)
   1213c:	00200693          	li	a3,2
   12140:	02d50463          	beq	a0,a3,12168 <__register_exitproc+0x68>
   12144:	00170713          	addi	a4,a4,1
   12148:	00e7a223          	sw	a4,4(a5)
   1214c:	010787b3          	add	a5,a5,a6
   12150:	00b7a423          	sw	a1,8(a5)
   12154:	00000513          	li	a0,0
   12158:	00008067          	ret
   1215c:	f0018793          	addi	a5,gp,-256 # 13b20 <__atexit0>
   12160:	d6f1a823          	sw	a5,-656(gp) # 13990 <__atexit>
   12164:	fa5ff06f          	j	12108 <__register_exitproc+0x8>
   12168:	18c7a683          	lw	a3,396(a5)
   1216c:	00170713          	addi	a4,a4,1
   12170:	00e7a223          	sw	a4,4(a5)
   12174:	00c6e6b3          	or	a3,a3,a2
   12178:	18d7a623          	sw	a3,396(a5)
   1217c:	010787b3          	add	a5,a5,a6
   12180:	00b7a423          	sw	a1,8(a5)
   12184:	00000513          	li	a0,0
   12188:	00008067          	ret
   1218c:	fff00513          	li	a0,-1
   12190:	00008067          	ret

00012194 <_close>:
   12194:	03900893          	li	a7,57
   12198:	00000073          	ecall
   1219c:	00054463          	bltz	a0,121a4 <_close+0x10>
   121a0:	00008067          	ret
   121a4:	fe010113          	addi	sp,sp,-32
   121a8:	00112e23          	sw	ra,28(sp)
   121ac:	00a12623          	sw	a0,12(sp)
   121b0:	18c000ef          	jal	1233c <__errno>
   121b4:	00c12783          	lw	a5,12(sp)
   121b8:	01c12083          	lw	ra,28(sp)
   121bc:	40f007b3          	neg	a5,a5
   121c0:	00f52023          	sw	a5,0(a0)
   121c4:	fff00793          	li	a5,-1
   121c8:	00078513          	mv	a0,a5
   121cc:	02010113          	addi	sp,sp,32
   121d0:	00008067          	ret

000121d4 <_exit>:
   121d4:	05d00893          	li	a7,93
   121d8:	00000073          	ecall
   121dc:	00054463          	bltz	a0,121e4 <_exit+0x10>
   121e0:	0000006f          	j	121e0 <_exit+0xc>
   121e4:	fe010113          	addi	sp,sp,-32
   121e8:	00112e23          	sw	ra,28(sp)
   121ec:	00a12623          	sw	a0,12(sp)
   121f0:	14c000ef          	jal	1233c <__errno>
   121f4:	00c12783          	lw	a5,12(sp)
   121f8:	40f007b3          	neg	a5,a5
   121fc:	00f52023          	sw	a5,0(a0)
   12200:	0000006f          	j	12200 <_exit+0x2c>

00012204 <_lseek>:
   12204:	03e00893          	li	a7,62
   12208:	00000073          	ecall
   1220c:	00054463          	bltz	a0,12214 <_lseek+0x10>
   12210:	00008067          	ret
   12214:	fe010113          	addi	sp,sp,-32
   12218:	00112e23          	sw	ra,28(sp)
   1221c:	00a12623          	sw	a0,12(sp)
   12220:	11c000ef          	jal	1233c <__errno>
   12224:	00c12783          	lw	a5,12(sp)
   12228:	01c12083          	lw	ra,28(sp)
   1222c:	40f007b3          	neg	a5,a5
   12230:	00f52023          	sw	a5,0(a0)
   12234:	fff00793          	li	a5,-1
   12238:	00078513          	mv	a0,a5
   1223c:	02010113          	addi	sp,sp,32
   12240:	00008067          	ret

00012244 <_read>:
   12244:	03f00893          	li	a7,63
   12248:	00000073          	ecall
   1224c:	00054463          	bltz	a0,12254 <_read+0x10>
   12250:	00008067          	ret
   12254:	fe010113          	addi	sp,sp,-32
   12258:	00112e23          	sw	ra,28(sp)
   1225c:	00a12623          	sw	a0,12(sp)
   12260:	0dc000ef          	jal	1233c <__errno>
   12264:	00c12783          	lw	a5,12(sp)
   12268:	01c12083          	lw	ra,28(sp)
   1226c:	40f007b3          	neg	a5,a5
   12270:	00f52023          	sw	a5,0(a0)
   12274:	fff00793          	li	a5,-1
   12278:	00078513          	mv	a0,a5
   1227c:	02010113          	addi	sp,sp,32
   12280:	00008067          	ret

00012284 <_sbrk>:
   12284:	d801a783          	lw	a5,-640(gp) # 139a0 <heap_end.0>
   12288:	ff010113          	addi	sp,sp,-16
   1228c:	00112623          	sw	ra,12(sp)
   12290:	00050713          	mv	a4,a0
   12294:	02079063          	bnez	a5,122b4 <_sbrk+0x30>
   12298:	0d600893          	li	a7,214
   1229c:	00000513          	li	a0,0
   122a0:	00000073          	ecall
   122a4:	fff00793          	li	a5,-1
   122a8:	02f50c63          	beq	a0,a5,122e0 <_sbrk+0x5c>
   122ac:	00050793          	mv	a5,a0
   122b0:	d8a1a023          	sw	a0,-640(gp) # 139a0 <heap_end.0>
   122b4:	00f70533          	add	a0,a4,a5
   122b8:	0d600893          	li	a7,214
   122bc:	00000073          	ecall
   122c0:	d801a783          	lw	a5,-640(gp) # 139a0 <heap_end.0>
   122c4:	00f70733          	add	a4,a4,a5
   122c8:	00e51c63          	bne	a0,a4,122e0 <_sbrk+0x5c>
   122cc:	00c12083          	lw	ra,12(sp)
   122d0:	d8a1a023          	sw	a0,-640(gp) # 139a0 <heap_end.0>
   122d4:	00078513          	mv	a0,a5
   122d8:	01010113          	addi	sp,sp,16
   122dc:	00008067          	ret
   122e0:	05c000ef          	jal	1233c <__errno>
   122e4:	00c12083          	lw	ra,12(sp)
   122e8:	00c00793          	li	a5,12
   122ec:	00f52023          	sw	a5,0(a0)
   122f0:	fff00513          	li	a0,-1
   122f4:	01010113          	addi	sp,sp,16
   122f8:	00008067          	ret

000122fc <_write>:
   122fc:	04000893          	li	a7,64
   12300:	00000073          	ecall
   12304:	00054463          	bltz	a0,1230c <_write+0x10>
   12308:	00008067          	ret
   1230c:	fe010113          	addi	sp,sp,-32
   12310:	00112e23          	sw	ra,28(sp)
   12314:	00a12623          	sw	a0,12(sp)
   12318:	024000ef          	jal	1233c <__errno>
   1231c:	00c12783          	lw	a5,12(sp)
   12320:	01c12083          	lw	ra,28(sp)
   12324:	40f007b3          	neg	a5,a5
   12328:	00f52023          	sw	a5,0(a0)
   1232c:	fff00793          	li	a5,-1
   12330:	00078513          	mv	a0,a5
   12334:	02010113          	addi	sp,sp,32
   12338:	00008067          	ret

0001233c <__errno>:
   1233c:	d5c1a503          	lw	a0,-676(gp) # 1397c <_impure_ptr>
   12340:	00008067          	ret
