
out/simple_uart_test:     file format elf32-littleriscv


Disassembly of section .text:

000100b4 <exit>:
   100b4:	ff010113          	addi	sp,sp,-16
   100b8:	00000593          	li	a1,0
   100bc:	00812423          	sw	s0,8(sp)
   100c0:	00112623          	sw	ra,12(sp)
   100c4:	00050413          	mv	s0,a0
   100c8:	2b5000ef          	jal	10b7c <__call_exitprocs>
   100cc:	d681a783          	lw	a5,-664(gp) # 13648 <__stdio_exit_handler>
   100d0:	00078463          	beqz	a5,100d8 <exit+0x24>
   100d4:	000780e7          	jalr	a5
   100d8:	00040513          	mv	a0,s0
   100dc:	685010ef          	jal	11f60 <_exit>

000100e0 <register_fini>:
   100e0:	00000793          	li	a5,0
   100e4:	00078863          	beqz	a5,100f4 <register_fini+0x14>
   100e8:	00012537          	lui	a0,0x12
   100ec:	e3050513          	addi	a0,a0,-464 # 11e30 <__libc_fini_array>
   100f0:	3dd0006f          	j	10ccc <atexit>
   100f4:	00008067          	ret

000100f8 <_start>:
   100f8:	00003197          	auipc	gp,0x3
   100fc:	7e818193          	addi	gp,gp,2024 # 138e0 <__global_pointer$>
   10100:	00000513          	li	a0,0
   10104:	00050463          	beqz	a0,1010c <_start+0x14>
   10108:	01751073          	csrw	jvt,a0
   1010c:	00003517          	auipc	a0,0x3
   10110:	53c50513          	addi	a0,a0,1340 # 13648 <__stdio_exit_handler>
   10114:	00004617          	auipc	a2,0x4
   10118:	85c60613          	addi	a2,a2,-1956 # 13970 <__BSS_END__>
   1011c:	40a60633          	sub	a2,a2,a0
   10120:	00000593          	li	a1,0
   10124:	17d000ef          	jal	10aa0 <memset>
   10128:	00001517          	auipc	a0,0x1
   1012c:	ba450513          	addi	a0,a0,-1116 # 10ccc <atexit>
   10130:	00050863          	beqz	a0,10140 <_start+0x48>
   10134:	00002517          	auipc	a0,0x2
   10138:	cfc50513          	addi	a0,a0,-772 # 11e30 <__libc_fini_array>
   1013c:	391000ef          	jal	10ccc <atexit>
   10140:	0cd000ef          	jal	10a0c <__libc_init_array>
   10144:	00012503          	lw	a0,0(sp)
   10148:	00410593          	addi	a1,sp,4
   1014c:	00251613          	slli	a2,a0,0x2
   10150:	00460613          	addi	a2,a2,4
   10154:	00b60633          	add	a2,a2,a1
   10158:	06c000ef          	jal	101c4 <main>
   1015c:	f59ff06f          	j	100b4 <exit>

00010160 <__do_global_dtors_aux>:
   10160:	ff010113          	addi	sp,sp,-16
   10164:	00812423          	sw	s0,8(sp)
   10168:	d841c783          	lbu	a5,-636(gp) # 13664 <completed.1>
   1016c:	00112623          	sw	ra,12(sp)
   10170:	02079263          	bnez	a5,10194 <__do_global_dtors_aux+0x34>
   10174:	00000793          	li	a5,0
   10178:	00078a63          	beqz	a5,1018c <__do_global_dtors_aux+0x2c>
   1017c:	00012537          	lui	a0,0x12
   10180:	0d050513          	addi	a0,a0,208 # 120d0 <__EH_FRAME_BEGIN__>
   10184:	00000097          	auipc	ra,0x0
   10188:	000000e7          	jalr	zero # 0 <exit-0x100b4>
   1018c:	00100793          	li	a5,1
   10190:	d8f18223          	sb	a5,-636(gp) # 13664 <completed.1>
   10194:	00c12083          	lw	ra,12(sp)
   10198:	00812403          	lw	s0,8(sp)
   1019c:	01010113          	addi	sp,sp,16
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	00000793          	li	a5,0
   101a8:	00078c63          	beqz	a5,101c0 <frame_dummy+0x1c>
   101ac:	00012537          	lui	a0,0x12
   101b0:	d8818593          	addi	a1,gp,-632 # 13668 <object.0>
   101b4:	0d050513          	addi	a0,a0,208 # 120d0 <__EH_FRAME_BEGIN__>
   101b8:	00000317          	auipc	t1,0x0
   101bc:	00000067          	jr	zero # 0 <exit-0x100b4>
   101c0:	00008067          	ret

000101c4 <main>:
   101c4:	fe010113          	addi	sp,sp,-32
   101c8:	00112e23          	sw	ra,28(sp)
   101cc:	00812c23          	sw	s0,24(sp)
   101d0:	02010413          	addi	s0,sp,32
   101d4:	100007b7          	lui	a5,0x10000
   101d8:	00878793          	addi	a5,a5,8 # 10000008 <__BSS_END__+0xffec698>
   101dc:	fef42623          	sw	a5,-20(s0)
   101e0:	100007b7          	lui	a5,0x10000
   101e4:	fef42423          	sw	a5,-24(s0)
   101e8:	fec42783          	lw	a5,-20(s0)
   101ec:	00100713          	li	a4,1
   101f0:	00e7a023          	sw	a4,0(a5) # 10000000 <__BSS_END__+0xffec690>
   101f4:	fe842783          	lw	a5,-24(s0)
   101f8:	04100713          	li	a4,65
   101fc:	00e7a023          	sw	a4,0(a5)
   10200:	fe842783          	lw	a5,-24(s0)
   10204:	04200713          	li	a4,66
   10208:	00e7a023          	sw	a4,0(a5)
   1020c:	fe842783          	lw	a5,-24(s0)
   10210:	00a00713          	li	a4,10
   10214:	00e7a023          	sw	a4,0(a5)
   10218:	0000006f          	j	10218 <main+0x54>

0001021c <__fp_lock>:
   1021c:	00000513          	li	a0,0
   10220:	00008067          	ret

00010224 <stdio_exit_handler>:
   10224:	00013637          	lui	a2,0x13
   10228:	000125b7          	lui	a1,0x12
   1022c:	00013537          	lui	a0,0x13
   10230:	0e060613          	addi	a2,a2,224 # 130e0 <__sglue>
   10234:	97058593          	addi	a1,a1,-1680 # 11970 <_fclose_r>
   10238:	0f050513          	addi	a0,a0,240 # 130f0 <_impure_data>
   1023c:	34c0006f          	j	10588 <_fwalk_sglue>

00010240 <cleanup_stdio>:
   10240:	00452583          	lw	a1,4(a0)
   10244:	ff010113          	addi	sp,sp,-16
   10248:	00812423          	sw	s0,8(sp)
   1024c:	00112623          	sw	ra,12(sp)
   10250:	da018793          	addi	a5,gp,-608 # 13680 <__sf>
   10254:	00050413          	mv	s0,a0
   10258:	00f58463          	beq	a1,a5,10260 <cleanup_stdio+0x20>
   1025c:	714010ef          	jal	11970 <_fclose_r>
   10260:	00842583          	lw	a1,8(s0)
   10264:	e0818793          	addi	a5,gp,-504 # 136e8 <__sf+0x68>
   10268:	00f58663          	beq	a1,a5,10274 <cleanup_stdio+0x34>
   1026c:	00040513          	mv	a0,s0
   10270:	700010ef          	jal	11970 <_fclose_r>
   10274:	00c42583          	lw	a1,12(s0)
   10278:	e7018793          	addi	a5,gp,-400 # 13750 <__sf+0xd0>
   1027c:	00f58c63          	beq	a1,a5,10294 <cleanup_stdio+0x54>
   10280:	00040513          	mv	a0,s0
   10284:	00812403          	lw	s0,8(sp)
   10288:	00c12083          	lw	ra,12(sp)
   1028c:	01010113          	addi	sp,sp,16
   10290:	6e00106f          	j	11970 <_fclose_r>
   10294:	00c12083          	lw	ra,12(sp)
   10298:	00812403          	lw	s0,8(sp)
   1029c:	01010113          	addi	sp,sp,16
   102a0:	00008067          	ret

000102a4 <__fp_unlock>:
   102a4:	00000513          	li	a0,0
   102a8:	00008067          	ret

000102ac <global_stdio_init.part.0>:
   102ac:	fe010113          	addi	sp,sp,-32
   102b0:	000107b7          	lui	a5,0x10
   102b4:	00812c23          	sw	s0,24(sp)
   102b8:	22478793          	addi	a5,a5,548 # 10224 <stdio_exit_handler>
   102bc:	da018413          	addi	s0,gp,-608 # 13680 <__sf>
   102c0:	00112e23          	sw	ra,28(sp)
   102c4:	00912a23          	sw	s1,20(sp)
   102c8:	01212823          	sw	s2,16(sp)
   102cc:	01312623          	sw	s3,12(sp)
   102d0:	01412423          	sw	s4,8(sp)
   102d4:	d6f1a423          	sw	a5,-664(gp) # 13648 <__stdio_exit_handler>
   102d8:	00800613          	li	a2,8
   102dc:	00400793          	li	a5,4
   102e0:	00000593          	li	a1,0
   102e4:	dfc18513          	addi	a0,gp,-516 # 136dc <__sf+0x5c>
   102e8:	00f42623          	sw	a5,12(s0)
   102ec:	00042023          	sw	zero,0(s0)
   102f0:	00042223          	sw	zero,4(s0)
   102f4:	00042423          	sw	zero,8(s0)
   102f8:	06042223          	sw	zero,100(s0)
   102fc:	00042823          	sw	zero,16(s0)
   10300:	00042a23          	sw	zero,20(s0)
   10304:	00042c23          	sw	zero,24(s0)
   10308:	798000ef          	jal	10aa0 <memset>
   1030c:	00010a37          	lui	s4,0x10
   10310:	000109b7          	lui	s3,0x10
   10314:	00010937          	lui	s2,0x10
   10318:	000104b7          	lui	s1,0x10
   1031c:	000107b7          	lui	a5,0x10
   10320:	63ca0a13          	addi	s4,s4,1596 # 1063c <__sread>
   10324:	6a098993          	addi	s3,s3,1696 # 106a0 <__swrite>
   10328:	72890913          	addi	s2,s2,1832 # 10728 <__sseek>
   1032c:	78c48493          	addi	s1,s1,1932 # 1078c <__sclose>
   10330:	00978793          	addi	a5,a5,9 # 10009 <exit-0xab>
   10334:	00800613          	li	a2,8
   10338:	00000593          	li	a1,0
   1033c:	e6418513          	addi	a0,gp,-412 # 13744 <__sf+0xc4>
   10340:	06f42a23          	sw	a5,116(s0)
   10344:	03442023          	sw	s4,32(s0)
   10348:	03342223          	sw	s3,36(s0)
   1034c:	03242423          	sw	s2,40(s0)
   10350:	02942623          	sw	s1,44(s0)
   10354:	00842e23          	sw	s0,28(s0)
   10358:	06042423          	sw	zero,104(s0)
   1035c:	06042623          	sw	zero,108(s0)
   10360:	06042823          	sw	zero,112(s0)
   10364:	0c042623          	sw	zero,204(s0)
   10368:	06042c23          	sw	zero,120(s0)
   1036c:	06042e23          	sw	zero,124(s0)
   10370:	08042023          	sw	zero,128(s0)
   10374:	72c000ef          	jal	10aa0 <memset>
   10378:	000207b7          	lui	a5,0x20
   1037c:	01278793          	addi	a5,a5,18 # 20012 <__BSS_END__+0xc6a2>
   10380:	e0818713          	addi	a4,gp,-504 # 136e8 <__sf+0x68>
   10384:	ecc18513          	addi	a0,gp,-308 # 137ac <__sf+0x12c>
   10388:	00800613          	li	a2,8
   1038c:	00000593          	li	a1,0
   10390:	09442423          	sw	s4,136(s0)
   10394:	09342623          	sw	s3,140(s0)
   10398:	09242823          	sw	s2,144(s0)
   1039c:	08942a23          	sw	s1,148(s0)
   103a0:	0cf42e23          	sw	a5,220(s0)
   103a4:	0c042823          	sw	zero,208(s0)
   103a8:	0c042a23          	sw	zero,212(s0)
   103ac:	0c042c23          	sw	zero,216(s0)
   103b0:	12042a23          	sw	zero,308(s0)
   103b4:	0e042023          	sw	zero,224(s0)
   103b8:	0e042223          	sw	zero,228(s0)
   103bc:	0e042423          	sw	zero,232(s0)
   103c0:	08e42223          	sw	a4,132(s0)
   103c4:	6dc000ef          	jal	10aa0 <memset>
   103c8:	e7018793          	addi	a5,gp,-400 # 13750 <__sf+0xd0>
   103cc:	0f442823          	sw	s4,240(s0)
   103d0:	0f342a23          	sw	s3,244(s0)
   103d4:	0f242c23          	sw	s2,248(s0)
   103d8:	0e942e23          	sw	s1,252(s0)
   103dc:	01c12083          	lw	ra,28(sp)
   103e0:	0ef42623          	sw	a5,236(s0)
   103e4:	01812403          	lw	s0,24(sp)
   103e8:	01412483          	lw	s1,20(sp)
   103ec:	01012903          	lw	s2,16(sp)
   103f0:	00c12983          	lw	s3,12(sp)
   103f4:	00812a03          	lw	s4,8(sp)
   103f8:	02010113          	addi	sp,sp,32
   103fc:	00008067          	ret

00010400 <__sfp>:
   10400:	d681a783          	lw	a5,-664(gp) # 13648 <__stdio_exit_handler>
   10404:	fe010113          	addi	sp,sp,-32
   10408:	00912a23          	sw	s1,20(sp)
   1040c:	00112e23          	sw	ra,28(sp)
   10410:	00812c23          	sw	s0,24(sp)
   10414:	00050493          	mv	s1,a0
   10418:	0e078e63          	beqz	a5,10514 <__sfp+0x114>
   1041c:	00013837          	lui	a6,0x13
   10420:	0e080813          	addi	a6,a6,224 # 130e0 <__sglue>
   10424:	fff00693          	li	a3,-1
   10428:	00482783          	lw	a5,4(a6)
   1042c:	fff78793          	addi	a5,a5,-1
   10430:	0807c063          	bltz	a5,104b0 <__sfp+0xb0>
   10434:	00882403          	lw	s0,8(a6)
   10438:	00c0006f          	j	10444 <__sfp+0x44>
   1043c:	06840413          	addi	s0,s0,104
   10440:	06d78863          	beq	a5,a3,104b0 <__sfp+0xb0>
   10444:	00c41703          	lh	a4,12(s0)
   10448:	fff78793          	addi	a5,a5,-1
   1044c:	fe0718e3          	bnez	a4,1043c <__sfp+0x3c>
   10450:	ffff07b7          	lui	a5,0xffff0
   10454:	00178793          	addi	a5,a5,1 # ffff0001 <__BSS_END__+0xfffdc691>
   10458:	00f42623          	sw	a5,12(s0)
   1045c:	06042223          	sw	zero,100(s0)
   10460:	00042023          	sw	zero,0(s0)
   10464:	00042423          	sw	zero,8(s0)
   10468:	00042223          	sw	zero,4(s0)
   1046c:	00042823          	sw	zero,16(s0)
   10470:	00042a23          	sw	zero,20(s0)
   10474:	00042c23          	sw	zero,24(s0)
   10478:	00800613          	li	a2,8
   1047c:	00000593          	li	a1,0
   10480:	05c40513          	addi	a0,s0,92
   10484:	61c000ef          	jal	10aa0 <memset>
   10488:	02042823          	sw	zero,48(s0)
   1048c:	02042a23          	sw	zero,52(s0)
   10490:	04042223          	sw	zero,68(s0)
   10494:	04042423          	sw	zero,72(s0)
   10498:	01c12083          	lw	ra,28(sp)
   1049c:	00040513          	mv	a0,s0
   104a0:	01812403          	lw	s0,24(sp)
   104a4:	01412483          	lw	s1,20(sp)
   104a8:	02010113          	addi	sp,sp,32
   104ac:	00008067          	ret
   104b0:	00082403          	lw	s0,0(a6)
   104b4:	00040663          	beqz	s0,104c0 <__sfp+0xc0>
   104b8:	00040813          	mv	a6,s0
   104bc:	f6dff06f          	j	10428 <__sfp+0x28>
   104c0:	1ac00593          	li	a1,428
   104c4:	00048513          	mv	a0,s1
   104c8:	01012623          	sw	a6,12(sp)
   104cc:	421000ef          	jal	110ec <_malloc_r>
   104d0:	00c12803          	lw	a6,12(sp)
   104d4:	00050413          	mv	s0,a0
   104d8:	04050263          	beqz	a0,1051c <__sfp+0x11c>
   104dc:	00400793          	li	a5,4
   104e0:	00f52223          	sw	a5,4(a0)
   104e4:	00c50513          	addi	a0,a0,12
   104e8:	00042023          	sw	zero,0(s0)
   104ec:	00a42423          	sw	a0,8(s0)
   104f0:	1a000613          	li	a2,416
   104f4:	00000593          	li	a1,0
   104f8:	01012623          	sw	a6,12(sp)
   104fc:	5a4000ef          	jal	10aa0 <memset>
   10500:	00c12803          	lw	a6,12(sp)
   10504:	fff00693          	li	a3,-1
   10508:	00882023          	sw	s0,0(a6)
   1050c:	00040813          	mv	a6,s0
   10510:	f19ff06f          	j	10428 <__sfp+0x28>
   10514:	d99ff0ef          	jal	102ac <global_stdio_init.part.0>
   10518:	f05ff06f          	j	1041c <__sfp+0x1c>
   1051c:	00082023          	sw	zero,0(a6)
   10520:	00c00793          	li	a5,12
   10524:	00f4a023          	sw	a5,0(s1)
   10528:	f71ff06f          	j	10498 <__sfp+0x98>

0001052c <__sinit>:
   1052c:	03452783          	lw	a5,52(a0)
   10530:	00078463          	beqz	a5,10538 <__sinit+0xc>
   10534:	00008067          	ret
   10538:	000107b7          	lui	a5,0x10
   1053c:	d681a703          	lw	a4,-664(gp) # 13648 <__stdio_exit_handler>
   10540:	24078793          	addi	a5,a5,576 # 10240 <cleanup_stdio>
   10544:	02f52a23          	sw	a5,52(a0)
   10548:	fe0716e3          	bnez	a4,10534 <__sinit+0x8>
   1054c:	d61ff06f          	j	102ac <global_stdio_init.part.0>

00010550 <__sfp_lock_acquire>:
   10550:	00008067          	ret

00010554 <__sfp_lock_release>:
   10554:	00008067          	ret

00010558 <__fp_lock_all>:
   10558:	00013637          	lui	a2,0x13
   1055c:	000105b7          	lui	a1,0x10
   10560:	0e060613          	addi	a2,a2,224 # 130e0 <__sglue>
   10564:	21c58593          	addi	a1,a1,540 # 1021c <__fp_lock>
   10568:	00000513          	li	a0,0
   1056c:	01c0006f          	j	10588 <_fwalk_sglue>

00010570 <__fp_unlock_all>:
   10570:	00013637          	lui	a2,0x13
   10574:	000105b7          	lui	a1,0x10
   10578:	0e060613          	addi	a2,a2,224 # 130e0 <__sglue>
   1057c:	2a458593          	addi	a1,a1,676 # 102a4 <__fp_unlock>
   10580:	00000513          	li	a0,0
   10584:	0040006f          	j	10588 <_fwalk_sglue>

00010588 <_fwalk_sglue>:
   10588:	fd010113          	addi	sp,sp,-48
   1058c:	03212023          	sw	s2,32(sp)
   10590:	01312e23          	sw	s3,28(sp)
   10594:	01412c23          	sw	s4,24(sp)
   10598:	01512a23          	sw	s5,20(sp)
   1059c:	01612823          	sw	s6,16(sp)
   105a0:	01712623          	sw	s7,12(sp)
   105a4:	02112623          	sw	ra,44(sp)
   105a8:	02812423          	sw	s0,40(sp)
   105ac:	02912223          	sw	s1,36(sp)
   105b0:	00060a93          	mv	s5,a2
   105b4:	00050b13          	mv	s6,a0
   105b8:	00058b93          	mv	s7,a1
   105bc:	00000a13          	li	s4,0
   105c0:	00100993          	li	s3,1
   105c4:	fff00913          	li	s2,-1
   105c8:	004aa483          	lw	s1,4(s5)
   105cc:	fff48493          	addi	s1,s1,-1
   105d0:	0204ca63          	bltz	s1,10604 <_fwalk_sglue+0x7c>
   105d4:	008aa403          	lw	s0,8(s5)
   105d8:	00c45783          	lhu	a5,12(s0)
   105dc:	00f9fe63          	bgeu	s3,a5,105f8 <_fwalk_sglue+0x70>
   105e0:	00e41783          	lh	a5,14(s0)
   105e4:	00040593          	mv	a1,s0
   105e8:	000b0513          	mv	a0,s6
   105ec:	01278663          	beq	a5,s2,105f8 <_fwalk_sglue+0x70>
   105f0:	000b80e7          	jalr	s7
   105f4:	00aa6a33          	or	s4,s4,a0
   105f8:	fff48493          	addi	s1,s1,-1
   105fc:	06840413          	addi	s0,s0,104
   10600:	fd249ce3          	bne	s1,s2,105d8 <_fwalk_sglue+0x50>
   10604:	000aaa83          	lw	s5,0(s5)
   10608:	fc0a90e3          	bnez	s5,105c8 <_fwalk_sglue+0x40>
   1060c:	02c12083          	lw	ra,44(sp)
   10610:	02812403          	lw	s0,40(sp)
   10614:	02412483          	lw	s1,36(sp)
   10618:	02012903          	lw	s2,32(sp)
   1061c:	01c12983          	lw	s3,28(sp)
   10620:	01412a83          	lw	s5,20(sp)
   10624:	01012b03          	lw	s6,16(sp)
   10628:	00c12b83          	lw	s7,12(sp)
   1062c:	000a0513          	mv	a0,s4
   10630:	01812a03          	lw	s4,24(sp)
   10634:	03010113          	addi	sp,sp,48
   10638:	00008067          	ret

0001063c <__sread>:
   1063c:	ff010113          	addi	sp,sp,-16
   10640:	00812423          	sw	s0,8(sp)
   10644:	00058413          	mv	s0,a1
   10648:	00e59583          	lh	a1,14(a1)
   1064c:	00112623          	sw	ra,12(sp)
   10650:	2ec000ef          	jal	1093c <_read_r>
   10654:	02054063          	bltz	a0,10674 <__sread+0x38>
   10658:	05042783          	lw	a5,80(s0)
   1065c:	00c12083          	lw	ra,12(sp)
   10660:	00a787b3          	add	a5,a5,a0
   10664:	04f42823          	sw	a5,80(s0)
   10668:	00812403          	lw	s0,8(sp)
   1066c:	01010113          	addi	sp,sp,16
   10670:	00008067          	ret
   10674:	00c45783          	lhu	a5,12(s0)
   10678:	fffff737          	lui	a4,0xfffff
   1067c:	fff70713          	addi	a4,a4,-1 # ffffefff <__BSS_END__+0xfffeb68f>
   10680:	00e7f7b3          	and	a5,a5,a4
   10684:	00c12083          	lw	ra,12(sp)
   10688:	00f41623          	sh	a5,12(s0)
   1068c:	00812403          	lw	s0,8(sp)
   10690:	01010113          	addi	sp,sp,16
   10694:	00008067          	ret

00010698 <__seofread>:
   10698:	00000513          	li	a0,0
   1069c:	00008067          	ret

000106a0 <__swrite>:
   106a0:	00c59783          	lh	a5,12(a1)
   106a4:	fe010113          	addi	sp,sp,-32
   106a8:	00068313          	mv	t1,a3
   106ac:	00112e23          	sw	ra,28(sp)
   106b0:	1007f693          	andi	a3,a5,256
   106b4:	00058713          	mv	a4,a1
   106b8:	00060893          	mv	a7,a2
   106bc:	00050813          	mv	a6,a0
   106c0:	02069863          	bnez	a3,106f0 <__swrite+0x50>
   106c4:	fffff6b7          	lui	a3,0xfffff
   106c8:	fff68693          	addi	a3,a3,-1 # ffffefff <__BSS_END__+0xfffeb68f>
   106cc:	01c12083          	lw	ra,28(sp)
   106d0:	00d7f7b3          	and	a5,a5,a3
   106d4:	00e71583          	lh	a1,14(a4)
   106d8:	00f71623          	sh	a5,12(a4)
   106dc:	00030693          	mv	a3,t1
   106e0:	00088613          	mv	a2,a7
   106e4:	00080513          	mv	a0,a6
   106e8:	02010113          	addi	sp,sp,32
   106ec:	2b80006f          	j	109a4 <_write_r>
   106f0:	00e59583          	lh	a1,14(a1)
   106f4:	00c12423          	sw	a2,8(sp)
   106f8:	00200693          	li	a3,2
   106fc:	00000613          	li	a2,0
   10700:	00612623          	sw	t1,12(sp)
   10704:	00e12023          	sw	a4,0(sp)
   10708:	00a12223          	sw	a0,4(sp)
   1070c:	1c8000ef          	jal	108d4 <_lseek_r>
   10710:	00012703          	lw	a4,0(sp)
   10714:	00c12303          	lw	t1,12(sp)
   10718:	00812883          	lw	a7,8(sp)
   1071c:	00c71783          	lh	a5,12(a4)
   10720:	00412803          	lw	a6,4(sp)
   10724:	fa1ff06f          	j	106c4 <__swrite+0x24>

00010728 <__sseek>:
   10728:	ff010113          	addi	sp,sp,-16
   1072c:	00812423          	sw	s0,8(sp)
   10730:	00058413          	mv	s0,a1
   10734:	00e59583          	lh	a1,14(a1)
   10738:	00112623          	sw	ra,12(sp)
   1073c:	198000ef          	jal	108d4 <_lseek_r>
   10740:	fff00713          	li	a4,-1
   10744:	00c41783          	lh	a5,12(s0)
   10748:	02e50263          	beq	a0,a4,1076c <__sseek+0x44>
   1074c:	00001737          	lui	a4,0x1
   10750:	00e7e7b3          	or	a5,a5,a4
   10754:	00c12083          	lw	ra,12(sp)
   10758:	04a42823          	sw	a0,80(s0)
   1075c:	00f41623          	sh	a5,12(s0)
   10760:	00812403          	lw	s0,8(sp)
   10764:	01010113          	addi	sp,sp,16
   10768:	00008067          	ret
   1076c:	80050713          	addi	a4,a0,-2048
   10770:	80070713          	addi	a4,a4,-2048 # 800 <exit-0xf8b4>
   10774:	00e7f7b3          	and	a5,a5,a4
   10778:	00c12083          	lw	ra,12(sp)
   1077c:	00f41623          	sh	a5,12(s0)
   10780:	00812403          	lw	s0,8(sp)
   10784:	01010113          	addi	sp,sp,16
   10788:	00008067          	ret

0001078c <__sclose>:
   1078c:	00e59583          	lh	a1,14(a1)
   10790:	0040006f          	j	10794 <_close_r>

00010794 <_close_r>:
   10794:	ff010113          	addi	sp,sp,-16
   10798:	00812423          	sw	s0,8(sp)
   1079c:	00912223          	sw	s1,4(sp)
   107a0:	00050493          	mv	s1,a0
   107a4:	00058513          	mv	a0,a1
   107a8:	00112623          	sw	ra,12(sp)
   107ac:	d601a623          	sw	zero,-660(gp) # 1364c <errno>
   107b0:	770010ef          	jal	11f20 <_close>
   107b4:	fff00793          	li	a5,-1
   107b8:	00f50c63          	beq	a0,a5,107d0 <_close_r+0x3c>
   107bc:	00c12083          	lw	ra,12(sp)
   107c0:	00812403          	lw	s0,8(sp)
   107c4:	00412483          	lw	s1,4(sp)
   107c8:	01010113          	addi	sp,sp,16
   107cc:	00008067          	ret
   107d0:	d6c1a783          	lw	a5,-660(gp) # 1364c <errno>
   107d4:	fe0784e3          	beqz	a5,107bc <_close_r+0x28>
   107d8:	00c12083          	lw	ra,12(sp)
   107dc:	00812403          	lw	s0,8(sp)
   107e0:	00f4a023          	sw	a5,0(s1)
   107e4:	00412483          	lw	s1,4(sp)
   107e8:	01010113          	addi	sp,sp,16
   107ec:	00008067          	ret

000107f0 <_reclaim_reent>:
   107f0:	d5c1a783          	lw	a5,-676(gp) # 1363c <_impure_ptr>
   107f4:	0ca78e63          	beq	a5,a0,108d0 <_reclaim_reent+0xe0>
   107f8:	04452583          	lw	a1,68(a0)
   107fc:	fe010113          	addi	sp,sp,-32
   10800:	00912a23          	sw	s1,20(sp)
   10804:	00112e23          	sw	ra,28(sp)
   10808:	00812c23          	sw	s0,24(sp)
   1080c:	00050493          	mv	s1,a0
   10810:	04058863          	beqz	a1,10860 <_reclaim_reent+0x70>
   10814:	01212823          	sw	s2,16(sp)
   10818:	01312623          	sw	s3,12(sp)
   1081c:	00000913          	li	s2,0
   10820:	08000993          	li	s3,128
   10824:	012587b3          	add	a5,a1,s2
   10828:	0007a403          	lw	s0,0(a5)
   1082c:	00040e63          	beqz	s0,10848 <_reclaim_reent+0x58>
   10830:	00040593          	mv	a1,s0
   10834:	00042403          	lw	s0,0(s0)
   10838:	00048513          	mv	a0,s1
   1083c:	5c8000ef          	jal	10e04 <_free_r>
   10840:	fe0418e3          	bnez	s0,10830 <_reclaim_reent+0x40>
   10844:	0444a583          	lw	a1,68(s1)
   10848:	00490913          	addi	s2,s2,4
   1084c:	fd391ce3          	bne	s2,s3,10824 <_reclaim_reent+0x34>
   10850:	00048513          	mv	a0,s1
   10854:	5b0000ef          	jal	10e04 <_free_r>
   10858:	01012903          	lw	s2,16(sp)
   1085c:	00c12983          	lw	s3,12(sp)
   10860:	0384a583          	lw	a1,56(s1)
   10864:	00058663          	beqz	a1,10870 <_reclaim_reent+0x80>
   10868:	00048513          	mv	a0,s1
   1086c:	598000ef          	jal	10e04 <_free_r>
   10870:	0404a403          	lw	s0,64(s1)
   10874:	00040c63          	beqz	s0,1088c <_reclaim_reent+0x9c>
   10878:	00040593          	mv	a1,s0
   1087c:	00042403          	lw	s0,0(s0)
   10880:	00048513          	mv	a0,s1
   10884:	580000ef          	jal	10e04 <_free_r>
   10888:	fe0418e3          	bnez	s0,10878 <_reclaim_reent+0x88>
   1088c:	04c4a583          	lw	a1,76(s1)
   10890:	00058663          	beqz	a1,1089c <_reclaim_reent+0xac>
   10894:	00048513          	mv	a0,s1
   10898:	56c000ef          	jal	10e04 <_free_r>
   1089c:	0344a783          	lw	a5,52(s1)
   108a0:	00078e63          	beqz	a5,108bc <_reclaim_reent+0xcc>
   108a4:	01812403          	lw	s0,24(sp)
   108a8:	01c12083          	lw	ra,28(sp)
   108ac:	00048513          	mv	a0,s1
   108b0:	01412483          	lw	s1,20(sp)
   108b4:	02010113          	addi	sp,sp,32
   108b8:	00078067          	jr	a5
   108bc:	01c12083          	lw	ra,28(sp)
   108c0:	01812403          	lw	s0,24(sp)
   108c4:	01412483          	lw	s1,20(sp)
   108c8:	02010113          	addi	sp,sp,32
   108cc:	00008067          	ret
   108d0:	00008067          	ret

000108d4 <_lseek_r>:
   108d4:	ff010113          	addi	sp,sp,-16
   108d8:	00058793          	mv	a5,a1
   108dc:	00812423          	sw	s0,8(sp)
   108e0:	00912223          	sw	s1,4(sp)
   108e4:	00060593          	mv	a1,a2
   108e8:	00050493          	mv	s1,a0
   108ec:	00068613          	mv	a2,a3
   108f0:	00078513          	mv	a0,a5
   108f4:	00112623          	sw	ra,12(sp)
   108f8:	d601a623          	sw	zero,-660(gp) # 1364c <errno>
   108fc:	694010ef          	jal	11f90 <_lseek>
   10900:	fff00793          	li	a5,-1
   10904:	00f50c63          	beq	a0,a5,1091c <_lseek_r+0x48>
   10908:	00c12083          	lw	ra,12(sp)
   1090c:	00812403          	lw	s0,8(sp)
   10910:	00412483          	lw	s1,4(sp)
   10914:	01010113          	addi	sp,sp,16
   10918:	00008067          	ret
   1091c:	d6c1a783          	lw	a5,-660(gp) # 1364c <errno>
   10920:	fe0784e3          	beqz	a5,10908 <_lseek_r+0x34>
   10924:	00c12083          	lw	ra,12(sp)
   10928:	00812403          	lw	s0,8(sp)
   1092c:	00f4a023          	sw	a5,0(s1)
   10930:	00412483          	lw	s1,4(sp)
   10934:	01010113          	addi	sp,sp,16
   10938:	00008067          	ret

0001093c <_read_r>:
   1093c:	ff010113          	addi	sp,sp,-16
   10940:	00058793          	mv	a5,a1
   10944:	00812423          	sw	s0,8(sp)
   10948:	00912223          	sw	s1,4(sp)
   1094c:	00060593          	mv	a1,a2
   10950:	00050493          	mv	s1,a0
   10954:	00068613          	mv	a2,a3
   10958:	00078513          	mv	a0,a5
   1095c:	00112623          	sw	ra,12(sp)
   10960:	d601a623          	sw	zero,-660(gp) # 1364c <errno>
   10964:	66c010ef          	jal	11fd0 <_read>
   10968:	fff00793          	li	a5,-1
   1096c:	00f50c63          	beq	a0,a5,10984 <_read_r+0x48>
   10970:	00c12083          	lw	ra,12(sp)
   10974:	00812403          	lw	s0,8(sp)
   10978:	00412483          	lw	s1,4(sp)
   1097c:	01010113          	addi	sp,sp,16
   10980:	00008067          	ret
   10984:	d6c1a783          	lw	a5,-660(gp) # 1364c <errno>
   10988:	fe0784e3          	beqz	a5,10970 <_read_r+0x34>
   1098c:	00c12083          	lw	ra,12(sp)
   10990:	00812403          	lw	s0,8(sp)
   10994:	00f4a023          	sw	a5,0(s1)
   10998:	00412483          	lw	s1,4(sp)
   1099c:	01010113          	addi	sp,sp,16
   109a0:	00008067          	ret

000109a4 <_write_r>:
   109a4:	ff010113          	addi	sp,sp,-16
   109a8:	00058793          	mv	a5,a1
   109ac:	00812423          	sw	s0,8(sp)
   109b0:	00912223          	sw	s1,4(sp)
   109b4:	00060593          	mv	a1,a2
   109b8:	00050493          	mv	s1,a0
   109bc:	00068613          	mv	a2,a3
   109c0:	00078513          	mv	a0,a5
   109c4:	00112623          	sw	ra,12(sp)
   109c8:	d601a623          	sw	zero,-660(gp) # 1364c <errno>
   109cc:	6bc010ef          	jal	12088 <_write>
   109d0:	fff00793          	li	a5,-1
   109d4:	00f50c63          	beq	a0,a5,109ec <_write_r+0x48>
   109d8:	00c12083          	lw	ra,12(sp)
   109dc:	00812403          	lw	s0,8(sp)
   109e0:	00412483          	lw	s1,4(sp)
   109e4:	01010113          	addi	sp,sp,16
   109e8:	00008067          	ret
   109ec:	d6c1a783          	lw	a5,-660(gp) # 1364c <errno>
   109f0:	fe0784e3          	beqz	a5,109d8 <_write_r+0x34>
   109f4:	00c12083          	lw	ra,12(sp)
   109f8:	00812403          	lw	s0,8(sp)
   109fc:	00f4a023          	sw	a5,0(s1)
   10a00:	00412483          	lw	s1,4(sp)
   10a04:	01010113          	addi	sp,sp,16
   10a08:	00008067          	ret

00010a0c <__libc_init_array>:
   10a0c:	ff010113          	addi	sp,sp,-16
   10a10:	00812423          	sw	s0,8(sp)
   10a14:	01212023          	sw	s2,0(sp)
   10a18:	00013437          	lui	s0,0x13
   10a1c:	00013937          	lui	s2,0x13
   10a20:	00112623          	sw	ra,12(sp)
   10a24:	00912223          	sw	s1,4(sp)
   10a28:	0d490913          	addi	s2,s2,212 # 130d4 <__init_array_start>
   10a2c:	0d440413          	addi	s0,s0,212 # 130d4 <__init_array_start>
   10a30:	02890263          	beq	s2,s0,10a54 <__libc_init_array+0x48>
   10a34:	40890933          	sub	s2,s2,s0
   10a38:	40295913          	srai	s2,s2,0x2
   10a3c:	00000493          	li	s1,0
   10a40:	00042783          	lw	a5,0(s0)
   10a44:	00148493          	addi	s1,s1,1
   10a48:	00440413          	addi	s0,s0,4
   10a4c:	000780e7          	jalr	a5
   10a50:	ff24e8e3          	bltu	s1,s2,10a40 <__libc_init_array+0x34>
   10a54:	00013937          	lui	s2,0x13
   10a58:	00013437          	lui	s0,0x13
   10a5c:	0dc90913          	addi	s2,s2,220 # 130dc <__do_global_dtors_aux_fini_array_entry>
   10a60:	0d440413          	addi	s0,s0,212 # 130d4 <__init_array_start>
   10a64:	02890263          	beq	s2,s0,10a88 <__libc_init_array+0x7c>
   10a68:	40890933          	sub	s2,s2,s0
   10a6c:	40295913          	srai	s2,s2,0x2
   10a70:	00000493          	li	s1,0
   10a74:	00042783          	lw	a5,0(s0)
   10a78:	00148493          	addi	s1,s1,1
   10a7c:	00440413          	addi	s0,s0,4
   10a80:	000780e7          	jalr	a5
   10a84:	ff24e8e3          	bltu	s1,s2,10a74 <__libc_init_array+0x68>
   10a88:	00c12083          	lw	ra,12(sp)
   10a8c:	00812403          	lw	s0,8(sp)
   10a90:	00412483          	lw	s1,4(sp)
   10a94:	00012903          	lw	s2,0(sp)
   10a98:	01010113          	addi	sp,sp,16
   10a9c:	00008067          	ret

00010aa0 <memset>:
   10aa0:	00f00313          	li	t1,15
   10aa4:	00050713          	mv	a4,a0
   10aa8:	02c37e63          	bgeu	t1,a2,10ae4 <memset+0x44>
   10aac:	00f77793          	andi	a5,a4,15
   10ab0:	0a079063          	bnez	a5,10b50 <memset+0xb0>
   10ab4:	08059263          	bnez	a1,10b38 <memset+0x98>
   10ab8:	ff067693          	andi	a3,a2,-16
   10abc:	00f67613          	andi	a2,a2,15
   10ac0:	00e686b3          	add	a3,a3,a4
   10ac4:	00b72023          	sw	a1,0(a4)
   10ac8:	00b72223          	sw	a1,4(a4)
   10acc:	00b72423          	sw	a1,8(a4)
   10ad0:	00b72623          	sw	a1,12(a4)
   10ad4:	01070713          	addi	a4,a4,16
   10ad8:	fed766e3          	bltu	a4,a3,10ac4 <memset+0x24>
   10adc:	00061463          	bnez	a2,10ae4 <memset+0x44>
   10ae0:	00008067          	ret
   10ae4:	40c306b3          	sub	a3,t1,a2
   10ae8:	00269693          	slli	a3,a3,0x2
   10aec:	00000297          	auipc	t0,0x0
   10af0:	005686b3          	add	a3,a3,t0
   10af4:	00c68067          	jr	12(a3)
   10af8:	00b70723          	sb	a1,14(a4)
   10afc:	00b706a3          	sb	a1,13(a4)
   10b00:	00b70623          	sb	a1,12(a4)
   10b04:	00b705a3          	sb	a1,11(a4)
   10b08:	00b70523          	sb	a1,10(a4)
   10b0c:	00b704a3          	sb	a1,9(a4)
   10b10:	00b70423          	sb	a1,8(a4)
   10b14:	00b703a3          	sb	a1,7(a4)
   10b18:	00b70323          	sb	a1,6(a4)
   10b1c:	00b702a3          	sb	a1,5(a4)
   10b20:	00b70223          	sb	a1,4(a4)
   10b24:	00b701a3          	sb	a1,3(a4)
   10b28:	00b70123          	sb	a1,2(a4)
   10b2c:	00b700a3          	sb	a1,1(a4)
   10b30:	00b70023          	sb	a1,0(a4)
   10b34:	00008067          	ret
   10b38:	0ff5f593          	zext.b	a1,a1
   10b3c:	00859693          	slli	a3,a1,0x8
   10b40:	00d5e5b3          	or	a1,a1,a3
   10b44:	01059693          	slli	a3,a1,0x10
   10b48:	00d5e5b3          	or	a1,a1,a3
   10b4c:	f6dff06f          	j	10ab8 <memset+0x18>
   10b50:	00279693          	slli	a3,a5,0x2
   10b54:	00000297          	auipc	t0,0x0
   10b58:	005686b3          	add	a3,a3,t0
   10b5c:	00008293          	mv	t0,ra
   10b60:	fa0680e7          	jalr	-96(a3)
   10b64:	00028093          	mv	ra,t0
   10b68:	ff078793          	addi	a5,a5,-16
   10b6c:	40f70733          	sub	a4,a4,a5
   10b70:	00f60633          	add	a2,a2,a5
   10b74:	f6c378e3          	bgeu	t1,a2,10ae4 <memset+0x44>
   10b78:	f3dff06f          	j	10ab4 <memset+0x14>

00010b7c <__call_exitprocs>:
   10b7c:	fd010113          	addi	sp,sp,-48
   10b80:	01412c23          	sw	s4,24(sp)
   10b84:	03212023          	sw	s2,32(sp)
   10b88:	d701a903          	lw	s2,-656(gp) # 13650 <__atexit>
   10b8c:	02112623          	sw	ra,44(sp)
   10b90:	0a090863          	beqz	s2,10c40 <__call_exitprocs+0xc4>
   10b94:	01312e23          	sw	s3,28(sp)
   10b98:	01512a23          	sw	s5,20(sp)
   10b9c:	01612823          	sw	s6,16(sp)
   10ba0:	01712623          	sw	s7,12(sp)
   10ba4:	02812423          	sw	s0,40(sp)
   10ba8:	02912223          	sw	s1,36(sp)
   10bac:	01812423          	sw	s8,8(sp)
   10bb0:	00050b13          	mv	s6,a0
   10bb4:	00058b93          	mv	s7,a1
   10bb8:	fff00993          	li	s3,-1
   10bbc:	00100a93          	li	s5,1
   10bc0:	00492483          	lw	s1,4(s2)
   10bc4:	fff48413          	addi	s0,s1,-1
   10bc8:	04044e63          	bltz	s0,10c24 <__call_exitprocs+0xa8>
   10bcc:	00249493          	slli	s1,s1,0x2
   10bd0:	009904b3          	add	s1,s2,s1
   10bd4:	080b9063          	bnez	s7,10c54 <__call_exitprocs+0xd8>
   10bd8:	00492783          	lw	a5,4(s2)
   10bdc:	0044a683          	lw	a3,4(s1)
   10be0:	fff78793          	addi	a5,a5,-1
   10be4:	0c878463          	beq	a5,s0,10cac <__call_exitprocs+0x130>
   10be8:	0004a223          	sw	zero,4(s1)
   10bec:	02068663          	beqz	a3,10c18 <__call_exitprocs+0x9c>
   10bf0:	18892783          	lw	a5,392(s2)
   10bf4:	008a9733          	sll	a4,s5,s0
   10bf8:	00492c03          	lw	s8,4(s2)
   10bfc:	00f777b3          	and	a5,a4,a5
   10c00:	06079e63          	bnez	a5,10c7c <__call_exitprocs+0x100>
   10c04:	000680e7          	jalr	a3
   10c08:	00492703          	lw	a4,4(s2)
   10c0c:	d701a783          	lw	a5,-656(gp) # 13650 <__atexit>
   10c10:	09871863          	bne	a4,s8,10ca0 <__call_exitprocs+0x124>
   10c14:	09279663          	bne	a5,s2,10ca0 <__call_exitprocs+0x124>
   10c18:	fff40413          	addi	s0,s0,-1
   10c1c:	ffc48493          	addi	s1,s1,-4
   10c20:	fb341ae3          	bne	s0,s3,10bd4 <__call_exitprocs+0x58>
   10c24:	02812403          	lw	s0,40(sp)
   10c28:	02412483          	lw	s1,36(sp)
   10c2c:	01c12983          	lw	s3,28(sp)
   10c30:	01412a83          	lw	s5,20(sp)
   10c34:	01012b03          	lw	s6,16(sp)
   10c38:	00c12b83          	lw	s7,12(sp)
   10c3c:	00812c03          	lw	s8,8(sp)
   10c40:	02c12083          	lw	ra,44(sp)
   10c44:	02012903          	lw	s2,32(sp)
   10c48:	01812a03          	lw	s4,24(sp)
   10c4c:	03010113          	addi	sp,sp,48
   10c50:	00008067          	ret
   10c54:	1044a783          	lw	a5,260(s1)
   10c58:	fff40713          	addi	a4,s0,-1
   10c5c:	f6fb8ee3          	beq	s7,a5,10bd8 <__call_exitprocs+0x5c>
   10c60:	ffe40413          	addi	s0,s0,-2
   10c64:	fd3700e3          	beq	a4,s3,10c24 <__call_exitprocs+0xa8>
   10c68:	1004a783          	lw	a5,256(s1)
   10c6c:	05778463          	beq	a5,s7,10cb4 <__call_exitprocs+0x138>
   10c70:	ff848493          	addi	s1,s1,-8
   10c74:	ff3410e3          	bne	s0,s3,10c54 <__call_exitprocs+0xd8>
   10c78:	fadff06f          	j	10c24 <__call_exitprocs+0xa8>
   10c7c:	18c92783          	lw	a5,396(s2)
   10c80:	0844a583          	lw	a1,132(s1)
   10c84:	00f77733          	and	a4,a4,a5
   10c88:	02071c63          	bnez	a4,10cc0 <__call_exitprocs+0x144>
   10c8c:	000b0513          	mv	a0,s6
   10c90:	000680e7          	jalr	a3
   10c94:	00492703          	lw	a4,4(s2)
   10c98:	d701a783          	lw	a5,-656(gp) # 13650 <__atexit>
   10c9c:	f7870ce3          	beq	a4,s8,10c14 <__call_exitprocs+0x98>
   10ca0:	f80782e3          	beqz	a5,10c24 <__call_exitprocs+0xa8>
   10ca4:	00078913          	mv	s2,a5
   10ca8:	f19ff06f          	j	10bc0 <__call_exitprocs+0x44>
   10cac:	00892223          	sw	s0,4(s2)
   10cb0:	f3dff06f          	j	10bec <__call_exitprocs+0x70>
   10cb4:	00070413          	mv	s0,a4
   10cb8:	ffc48493          	addi	s1,s1,-4
   10cbc:	f1dff06f          	j	10bd8 <__call_exitprocs+0x5c>
   10cc0:	00058513          	mv	a0,a1
   10cc4:	000680e7          	jalr	a3
   10cc8:	f41ff06f          	j	10c08 <__call_exitprocs+0x8c>

00010ccc <atexit>:
   10ccc:	00050593          	mv	a1,a0
   10cd0:	00000693          	li	a3,0
   10cd4:	00000613          	li	a2,0
   10cd8:	00000513          	li	a0,0
   10cdc:	1b00106f          	j	11e8c <__register_exitproc>

00010ce0 <_malloc_trim_r>:
   10ce0:	fe010113          	addi	sp,sp,-32
   10ce4:	01212823          	sw	s2,16(sp)
   10ce8:	00013937          	lui	s2,0x13
   10cec:	00812c23          	sw	s0,24(sp)
   10cf0:	00912a23          	sw	s1,20(sp)
   10cf4:	01312623          	sw	s3,12(sp)
   10cf8:	00058413          	mv	s0,a1
   10cfc:	00112e23          	sw	ra,28(sp)
   10d00:	00050993          	mv	s3,a0
   10d04:	23090913          	addi	s2,s2,560 # 13230 <__malloc_av_>
   10d08:	461000ef          	jal	11968 <__malloc_lock>
   10d0c:	00892783          	lw	a5,8(s2)
   10d10:	00001737          	lui	a4,0x1
   10d14:	0047a483          	lw	s1,4(a5)
   10d18:	ffc4f493          	andi	s1,s1,-4
   10d1c:	7ff48793          	addi	a5,s1,2047
   10d20:	7f078793          	addi	a5,a5,2032
   10d24:	40878433          	sub	s0,a5,s0
   10d28:	00c45413          	srli	s0,s0,0xc
   10d2c:	fff40413          	addi	s0,s0,-1
   10d30:	00c41413          	slli	s0,s0,0xc
   10d34:	00e44e63          	blt	s0,a4,10d50 <_malloc_trim_r+0x70>
   10d38:	00000593          	li	a1,0
   10d3c:	00098513          	mv	a0,s3
   10d40:	094010ef          	jal	11dd4 <_sbrk_r>
   10d44:	00892783          	lw	a5,8(s2)
   10d48:	009787b3          	add	a5,a5,s1
   10d4c:	02f50663          	beq	a0,a5,10d78 <_malloc_trim_r+0x98>
   10d50:	00098513          	mv	a0,s3
   10d54:	419000ef          	jal	1196c <__malloc_unlock>
   10d58:	01c12083          	lw	ra,28(sp)
   10d5c:	01812403          	lw	s0,24(sp)
   10d60:	01412483          	lw	s1,20(sp)
   10d64:	01012903          	lw	s2,16(sp)
   10d68:	00c12983          	lw	s3,12(sp)
   10d6c:	00000513          	li	a0,0
   10d70:	02010113          	addi	sp,sp,32
   10d74:	00008067          	ret
   10d78:	408005b3          	neg	a1,s0
   10d7c:	00098513          	mv	a0,s3
   10d80:	054010ef          	jal	11dd4 <_sbrk_r>
   10d84:	fff00793          	li	a5,-1
   10d88:	04f50463          	beq	a0,a5,10dd0 <_malloc_trim_r+0xf0>
   10d8c:	00892683          	lw	a3,8(s2)
   10d90:	ed81a783          	lw	a5,-296(gp) # 137b8 <__malloc_current_mallinfo>
   10d94:	408484b3          	sub	s1,s1,s0
   10d98:	0014e493          	ori	s1,s1,1
   10d9c:	00098513          	mv	a0,s3
   10da0:	408787b3          	sub	a5,a5,s0
   10da4:	0096a223          	sw	s1,4(a3)
   10da8:	ecf1ac23          	sw	a5,-296(gp) # 137b8 <__malloc_current_mallinfo>
   10dac:	3c1000ef          	jal	1196c <__malloc_unlock>
   10db0:	01c12083          	lw	ra,28(sp)
   10db4:	01812403          	lw	s0,24(sp)
   10db8:	01412483          	lw	s1,20(sp)
   10dbc:	01012903          	lw	s2,16(sp)
   10dc0:	00c12983          	lw	s3,12(sp)
   10dc4:	00100513          	li	a0,1
   10dc8:	02010113          	addi	sp,sp,32
   10dcc:	00008067          	ret
   10dd0:	00000593          	li	a1,0
   10dd4:	00098513          	mv	a0,s3
   10dd8:	7fd000ef          	jal	11dd4 <_sbrk_r>
   10ddc:	00892703          	lw	a4,8(s2)
   10de0:	00f00693          	li	a3,15
   10de4:	40e507b3          	sub	a5,a0,a4
   10de8:	f6f6d4e3          	bge	a3,a5,10d50 <_malloc_trim_r+0x70>
   10dec:	d601a603          	lw	a2,-672(gp) # 13640 <__malloc_sbrk_base>
   10df0:	0017e793          	ori	a5,a5,1
   10df4:	40c50533          	sub	a0,a0,a2
   10df8:	00f72223          	sw	a5,4(a4) # 1004 <exit-0xf0b0>
   10dfc:	eca1ac23          	sw	a0,-296(gp) # 137b8 <__malloc_current_mallinfo>
   10e00:	f51ff06f          	j	10d50 <_malloc_trim_r+0x70>

00010e04 <_free_r>:
   10e04:	12058463          	beqz	a1,10f2c <_free_r+0x128>
   10e08:	fe010113          	addi	sp,sp,-32
   10e0c:	00812c23          	sw	s0,24(sp)
   10e10:	00b12623          	sw	a1,12(sp)
   10e14:	00050413          	mv	s0,a0
   10e18:	00112e23          	sw	ra,28(sp)
   10e1c:	34d000ef          	jal	11968 <__malloc_lock>
   10e20:	00c12583          	lw	a1,12(sp)
   10e24:	00013837          	lui	a6,0x13
   10e28:	23080813          	addi	a6,a6,560 # 13230 <__malloc_av_>
   10e2c:	ffc5a503          	lw	a0,-4(a1)
   10e30:	ff858713          	addi	a4,a1,-8
   10e34:	00882883          	lw	a7,8(a6)
   10e38:	ffe57793          	andi	a5,a0,-2
   10e3c:	00f70633          	add	a2,a4,a5
   10e40:	00462683          	lw	a3,4(a2)
   10e44:	00157313          	andi	t1,a0,1
   10e48:	ffc6f693          	andi	a3,a3,-4
   10e4c:	18c88863          	beq	a7,a2,10fdc <_free_r+0x1d8>
   10e50:	00d62223          	sw	a3,4(a2)
   10e54:	00d608b3          	add	a7,a2,a3
   10e58:	0048a883          	lw	a7,4(a7)
   10e5c:	0018f893          	andi	a7,a7,1
   10e60:	08031a63          	bnez	t1,10ef4 <_free_r+0xf0>
   10e64:	ff85a303          	lw	t1,-8(a1)
   10e68:	000135b7          	lui	a1,0x13
   10e6c:	23858593          	addi	a1,a1,568 # 13238 <__malloc_av_+0x8>
   10e70:	40670733          	sub	a4,a4,t1
   10e74:	00872503          	lw	a0,8(a4)
   10e78:	006787b3          	add	a5,a5,t1
   10e7c:	12b50a63          	beq	a0,a1,10fb0 <_free_r+0x1ac>
   10e80:	00c72303          	lw	t1,12(a4)
   10e84:	00652623          	sw	t1,12(a0)
   10e88:	00a32423          	sw	a0,8(t1) # 101c0 <frame_dummy+0x1c>
   10e8c:	18088c63          	beqz	a7,11024 <_free_r+0x220>
   10e90:	0017e693          	ori	a3,a5,1
   10e94:	00d72223          	sw	a3,4(a4)
   10e98:	00f62023          	sw	a5,0(a2)
   10e9c:	1ff00693          	li	a3,511
   10ea0:	0af6e263          	bltu	a3,a5,10f44 <_free_r+0x140>
   10ea4:	ff87f693          	andi	a3,a5,-8
   10ea8:	00868693          	addi	a3,a3,8
   10eac:	00482583          	lw	a1,4(a6)
   10eb0:	00d806b3          	add	a3,a6,a3
   10eb4:	0006a603          	lw	a2,0(a3)
   10eb8:	0057d513          	srli	a0,a5,0x5
   10ebc:	00100793          	li	a5,1
   10ec0:	00a797b3          	sll	a5,a5,a0
   10ec4:	00b7e7b3          	or	a5,a5,a1
   10ec8:	ff868593          	addi	a1,a3,-8
   10ecc:	00c72423          	sw	a2,8(a4)
   10ed0:	00b72623          	sw	a1,12(a4)
   10ed4:	00f82223          	sw	a5,4(a6)
   10ed8:	00e6a023          	sw	a4,0(a3)
   10edc:	00e62623          	sw	a4,12(a2)
   10ee0:	00040513          	mv	a0,s0
   10ee4:	01812403          	lw	s0,24(sp)
   10ee8:	01c12083          	lw	ra,28(sp)
   10eec:	02010113          	addi	sp,sp,32
   10ef0:	27d0006f          	j	1196c <__malloc_unlock>
   10ef4:	02089e63          	bnez	a7,10f30 <_free_r+0x12c>
   10ef8:	000135b7          	lui	a1,0x13
   10efc:	00d787b3          	add	a5,a5,a3
   10f00:	23858593          	addi	a1,a1,568 # 13238 <__malloc_av_+0x8>
   10f04:	00862683          	lw	a3,8(a2)
   10f08:	0017e893          	ori	a7,a5,1
   10f0c:	00f70533          	add	a0,a4,a5
   10f10:	16b68063          	beq	a3,a1,11070 <_free_r+0x26c>
   10f14:	00c62603          	lw	a2,12(a2)
   10f18:	00c6a623          	sw	a2,12(a3)
   10f1c:	00d62423          	sw	a3,8(a2)
   10f20:	01172223          	sw	a7,4(a4)
   10f24:	00f52023          	sw	a5,0(a0)
   10f28:	f75ff06f          	j	10e9c <_free_r+0x98>
   10f2c:	00008067          	ret
   10f30:	00156513          	ori	a0,a0,1
   10f34:	fea5ae23          	sw	a0,-4(a1)
   10f38:	00f62023          	sw	a5,0(a2)
   10f3c:	1ff00693          	li	a3,511
   10f40:	f6f6f2e3          	bgeu	a3,a5,10ea4 <_free_r+0xa0>
   10f44:	0097d693          	srli	a3,a5,0x9
   10f48:	00400613          	li	a2,4
   10f4c:	0ed66063          	bltu	a2,a3,1102c <_free_r+0x228>
   10f50:	0067d693          	srli	a3,a5,0x6
   10f54:	03968593          	addi	a1,a3,57
   10f58:	00359593          	slli	a1,a1,0x3
   10f5c:	03868613          	addi	a2,a3,56
   10f60:	00b805b3          	add	a1,a6,a1
   10f64:	0005a683          	lw	a3,0(a1)
   10f68:	ff858593          	addi	a1,a1,-8
   10f6c:	00d59863          	bne	a1,a3,10f7c <_free_r+0x178>
   10f70:	11c0006f          	j	1108c <_free_r+0x288>
   10f74:	0086a683          	lw	a3,8(a3)
   10f78:	00d58863          	beq	a1,a3,10f88 <_free_r+0x184>
   10f7c:	0046a603          	lw	a2,4(a3)
   10f80:	ffc67613          	andi	a2,a2,-4
   10f84:	fec7e8e3          	bltu	a5,a2,10f74 <_free_r+0x170>
   10f88:	00c6a583          	lw	a1,12(a3)
   10f8c:	00b72623          	sw	a1,12(a4)
   10f90:	00d72423          	sw	a3,8(a4)
   10f94:	00040513          	mv	a0,s0
   10f98:	01812403          	lw	s0,24(sp)
   10f9c:	01c12083          	lw	ra,28(sp)
   10fa0:	00e5a423          	sw	a4,8(a1)
   10fa4:	00e6a623          	sw	a4,12(a3)
   10fa8:	02010113          	addi	sp,sp,32
   10fac:	1c10006f          	j	1196c <__malloc_unlock>
   10fb0:	0a089063          	bnez	a7,11050 <_free_r+0x24c>
   10fb4:	00c62583          	lw	a1,12(a2)
   10fb8:	00862603          	lw	a2,8(a2)
   10fbc:	00f686b3          	add	a3,a3,a5
   10fc0:	0016e793          	ori	a5,a3,1
   10fc4:	00b62623          	sw	a1,12(a2)
   10fc8:	00c5a423          	sw	a2,8(a1)
   10fcc:	00f72223          	sw	a5,4(a4)
   10fd0:	00d70733          	add	a4,a4,a3
   10fd4:	00d72023          	sw	a3,0(a4)
   10fd8:	f09ff06f          	j	10ee0 <_free_r+0xdc>
   10fdc:	00d786b3          	add	a3,a5,a3
   10fe0:	02031063          	bnez	t1,11000 <_free_r+0x1fc>
   10fe4:	ff85a783          	lw	a5,-8(a1)
   10fe8:	40f70733          	sub	a4,a4,a5
   10fec:	00872603          	lw	a2,8(a4)
   10ff0:	00f686b3          	add	a3,a3,a5
   10ff4:	00c72783          	lw	a5,12(a4)
   10ff8:	00f62623          	sw	a5,12(a2)
   10ffc:	00c7a423          	sw	a2,8(a5)
   11000:	0016e613          	ori	a2,a3,1
   11004:	d641a783          	lw	a5,-668(gp) # 13644 <__malloc_trim_threshold>
   11008:	00c72223          	sw	a2,4(a4)
   1100c:	00e82423          	sw	a4,8(a6)
   11010:	ecf6e8e3          	bltu	a3,a5,10ee0 <_free_r+0xdc>
   11014:	d7c1a583          	lw	a1,-644(gp) # 1365c <__malloc_top_pad>
   11018:	00040513          	mv	a0,s0
   1101c:	cc5ff0ef          	jal	10ce0 <_malloc_trim_r>
   11020:	ec1ff06f          	j	10ee0 <_free_r+0xdc>
   11024:	00d787b3          	add	a5,a5,a3
   11028:	eddff06f          	j	10f04 <_free_r+0x100>
   1102c:	01400613          	li	a2,20
   11030:	02d67863          	bgeu	a2,a3,11060 <_free_r+0x25c>
   11034:	05400613          	li	a2,84
   11038:	06d66863          	bltu	a2,a3,110a8 <_free_r+0x2a4>
   1103c:	00c7d693          	srli	a3,a5,0xc
   11040:	06f68593          	addi	a1,a3,111
   11044:	00359593          	slli	a1,a1,0x3
   11048:	06e68613          	addi	a2,a3,110
   1104c:	f15ff06f          	j	10f60 <_free_r+0x15c>
   11050:	0017e693          	ori	a3,a5,1
   11054:	00d72223          	sw	a3,4(a4)
   11058:	00f62023          	sw	a5,0(a2)
   1105c:	e85ff06f          	j	10ee0 <_free_r+0xdc>
   11060:	05c68593          	addi	a1,a3,92
   11064:	00359593          	slli	a1,a1,0x3
   11068:	05b68613          	addi	a2,a3,91
   1106c:	ef5ff06f          	j	10f60 <_free_r+0x15c>
   11070:	00e82a23          	sw	a4,20(a6)
   11074:	00e82823          	sw	a4,16(a6)
   11078:	00b72623          	sw	a1,12(a4)
   1107c:	00b72423          	sw	a1,8(a4)
   11080:	01172223          	sw	a7,4(a4)
   11084:	00f52023          	sw	a5,0(a0)
   11088:	e59ff06f          	j	10ee0 <_free_r+0xdc>
   1108c:	00482503          	lw	a0,4(a6)
   11090:	40265613          	srai	a2,a2,0x2
   11094:	00100793          	li	a5,1
   11098:	00c797b3          	sll	a5,a5,a2
   1109c:	00a7e7b3          	or	a5,a5,a0
   110a0:	00f82223          	sw	a5,4(a6)
   110a4:	ee9ff06f          	j	10f8c <_free_r+0x188>
   110a8:	15400613          	li	a2,340
   110ac:	00d66c63          	bltu	a2,a3,110c4 <_free_r+0x2c0>
   110b0:	00f7d693          	srli	a3,a5,0xf
   110b4:	07868593          	addi	a1,a3,120
   110b8:	00359593          	slli	a1,a1,0x3
   110bc:	07768613          	addi	a2,a3,119
   110c0:	ea1ff06f          	j	10f60 <_free_r+0x15c>
   110c4:	55400613          	li	a2,1364
   110c8:	00d66c63          	bltu	a2,a3,110e0 <_free_r+0x2dc>
   110cc:	0127d693          	srli	a3,a5,0x12
   110d0:	07d68593          	addi	a1,a3,125
   110d4:	00359593          	slli	a1,a1,0x3
   110d8:	07c68613          	addi	a2,a3,124
   110dc:	e85ff06f          	j	10f60 <_free_r+0x15c>
   110e0:	3f800593          	li	a1,1016
   110e4:	07e00613          	li	a2,126
   110e8:	e79ff06f          	j	10f60 <_free_r+0x15c>

000110ec <_malloc_r>:
   110ec:	fc010113          	addi	sp,sp,-64
   110f0:	02812c23          	sw	s0,56(sp)
   110f4:	02112e23          	sw	ra,60(sp)
   110f8:	00b58793          	addi	a5,a1,11
   110fc:	01600713          	li	a4,22
   11100:	00050413          	mv	s0,a0
   11104:	08f76e63          	bltu	a4,a5,111a0 <_malloc_r+0xb4>
   11108:	01000693          	li	a3,16
   1110c:	06b6ec63          	bltu	a3,a1,11184 <_malloc_r+0x98>
   11110:	059000ef          	jal	11968 <__malloc_lock>
   11114:	01000693          	li	a3,16
   11118:	01800713          	li	a4,24
   1111c:	00200893          	li	a7,2
   11120:	00013837          	lui	a6,0x13
   11124:	23080813          	addi	a6,a6,560 # 13230 <__malloc_av_>
   11128:	00e80733          	add	a4,a6,a4
   1112c:	00472783          	lw	a5,4(a4)
   11130:	ff870613          	addi	a2,a4,-8
   11134:	44c78c63          	beq	a5,a2,1158c <_malloc_r+0x4a0>
   11138:	0047a703          	lw	a4,4(a5)
   1113c:	00c7a603          	lw	a2,12(a5)
   11140:	0087a583          	lw	a1,8(a5)
   11144:	ffc77713          	andi	a4,a4,-4
   11148:	00e78733          	add	a4,a5,a4
   1114c:	00472683          	lw	a3,4(a4)
   11150:	00c5a623          	sw	a2,12(a1)
   11154:	00f12623          	sw	a5,12(sp)
   11158:	00b62423          	sw	a1,8(a2)
   1115c:	0016e693          	ori	a3,a3,1
   11160:	00040513          	mv	a0,s0
   11164:	00d72223          	sw	a3,4(a4)
   11168:	005000ef          	jal	1196c <__malloc_unlock>
   1116c:	00c12783          	lw	a5,12(sp)
   11170:	03c12083          	lw	ra,60(sp)
   11174:	03812403          	lw	s0,56(sp)
   11178:	00878513          	addi	a0,a5,8
   1117c:	04010113          	addi	sp,sp,64
   11180:	00008067          	ret
   11184:	00c00793          	li	a5,12
   11188:	00f42023          	sw	a5,0(s0)
   1118c:	00000513          	li	a0,0
   11190:	03c12083          	lw	ra,60(sp)
   11194:	03812403          	lw	s0,56(sp)
   11198:	04010113          	addi	sp,sp,64
   1119c:	00008067          	ret
   111a0:	ff87f693          	andi	a3,a5,-8
   111a4:	fe07c0e3          	bltz	a5,11184 <_malloc_r+0x98>
   111a8:	fcb6eee3          	bltu	a3,a1,11184 <_malloc_r+0x98>
   111ac:	00d12623          	sw	a3,12(sp)
   111b0:	7b8000ef          	jal	11968 <__malloc_lock>
   111b4:	00c12683          	lw	a3,12(sp)
   111b8:	1f700793          	li	a5,503
   111bc:	4cd7f663          	bgeu	a5,a3,11688 <_malloc_r+0x59c>
   111c0:	0096d793          	srli	a5,a3,0x9
   111c4:	16078e63          	beqz	a5,11340 <_malloc_r+0x254>
   111c8:	00400713          	li	a4,4
   111cc:	42f76863          	bltu	a4,a5,115fc <_malloc_r+0x510>
   111d0:	0066d793          	srli	a5,a3,0x6
   111d4:	03978893          	addi	a7,a5,57
   111d8:	03878e13          	addi	t3,a5,56
   111dc:	00389513          	slli	a0,a7,0x3
   111e0:	00013837          	lui	a6,0x13
   111e4:	23080813          	addi	a6,a6,560 # 13230 <__malloc_av_>
   111e8:	00a80533          	add	a0,a6,a0
   111ec:	00452783          	lw	a5,4(a0)
   111f0:	ff850513          	addi	a0,a0,-8
   111f4:	02f50863          	beq	a0,a5,11224 <_malloc_r+0x138>
   111f8:	00f00313          	li	t1,15
   111fc:	0140006f          	j	11210 <_malloc_r+0x124>
   11200:	00c7a583          	lw	a1,12(a5)
   11204:	34065463          	bgez	a2,1154c <_malloc_r+0x460>
   11208:	00b50e63          	beq	a0,a1,11224 <_malloc_r+0x138>
   1120c:	00058793          	mv	a5,a1
   11210:	0047a703          	lw	a4,4(a5)
   11214:	ffc77713          	andi	a4,a4,-4
   11218:	40d70633          	sub	a2,a4,a3
   1121c:	fec352e3          	bge	t1,a2,11200 <_malloc_r+0x114>
   11220:	000e0893          	mv	a7,t3
   11224:	01082783          	lw	a5,16(a6)
   11228:	00013e37          	lui	t3,0x13
   1122c:	238e0e13          	addi	t3,t3,568 # 13238 <__malloc_av_+0x8>
   11230:	2dc78c63          	beq	a5,t3,11508 <_malloc_r+0x41c>
   11234:	0047a703          	lw	a4,4(a5)
   11238:	00f00593          	li	a1,15
   1123c:	ffc77713          	andi	a4,a4,-4
   11240:	40d70633          	sub	a2,a4,a3
   11244:	46c5cc63          	blt	a1,a2,116bc <_malloc_r+0x5d0>
   11248:	01c82a23          	sw	t3,20(a6)
   1124c:	01c82823          	sw	t3,16(a6)
   11250:	44065263          	bgez	a2,11694 <_malloc_r+0x5a8>
   11254:	1ff00613          	li	a2,511
   11258:	00482303          	lw	t1,4(a6)
   1125c:	34e66063          	bltu	a2,a4,1159c <_malloc_r+0x4b0>
   11260:	ff877613          	andi	a2,a4,-8
   11264:	00860613          	addi	a2,a2,8
   11268:	00c80633          	add	a2,a6,a2
   1126c:	00062583          	lw	a1,0(a2)
   11270:	00575513          	srli	a0,a4,0x5
   11274:	00100713          	li	a4,1
   11278:	00a71733          	sll	a4,a4,a0
   1127c:	00e36333          	or	t1,t1,a4
   11280:	ff860713          	addi	a4,a2,-8
   11284:	00b7a423          	sw	a1,8(a5)
   11288:	00e7a623          	sw	a4,12(a5)
   1128c:	00682223          	sw	t1,4(a6)
   11290:	00f62023          	sw	a5,0(a2)
   11294:	00f5a623          	sw	a5,12(a1)
   11298:	4028d793          	srai	a5,a7,0x2
   1129c:	00100513          	li	a0,1
   112a0:	00f51533          	sll	a0,a0,a5
   112a4:	0aa36663          	bltu	t1,a0,11350 <_malloc_r+0x264>
   112a8:	006577b3          	and	a5,a0,t1
   112ac:	02079463          	bnez	a5,112d4 <_malloc_r+0x1e8>
   112b0:	00151513          	slli	a0,a0,0x1
   112b4:	ffc8f893          	andi	a7,a7,-4
   112b8:	006577b3          	and	a5,a0,t1
   112bc:	00488893          	addi	a7,a7,4
   112c0:	00079a63          	bnez	a5,112d4 <_malloc_r+0x1e8>
   112c4:	00151513          	slli	a0,a0,0x1
   112c8:	006577b3          	and	a5,a0,t1
   112cc:	00488893          	addi	a7,a7,4
   112d0:	fe078ae3          	beqz	a5,112c4 <_malloc_r+0x1d8>
   112d4:	00f00e93          	li	t4,15
   112d8:	00389f13          	slli	t5,a7,0x3
   112dc:	01e80f33          	add	t5,a6,t5
   112e0:	000f0313          	mv	t1,t5
   112e4:	00c32703          	lw	a4,12(t1)
   112e8:	00088f93          	mv	t6,a7
   112ec:	32e30a63          	beq	t1,a4,11620 <_malloc_r+0x534>
   112f0:	00472603          	lw	a2,4(a4)
   112f4:	00070793          	mv	a5,a4
   112f8:	00c72703          	lw	a4,12(a4)
   112fc:	ffc67613          	andi	a2,a2,-4
   11300:	40d605b3          	sub	a1,a2,a3
   11304:	32beca63          	blt	t4,a1,11638 <_malloc_r+0x54c>
   11308:	fe05c2e3          	bltz	a1,112ec <_malloc_r+0x200>
   1130c:	00c78633          	add	a2,a5,a2
   11310:	00462683          	lw	a3,4(a2)
   11314:	0087a583          	lw	a1,8(a5)
   11318:	00040513          	mv	a0,s0
   1131c:	0016e693          	ori	a3,a3,1
   11320:	00d62223          	sw	a3,4(a2)
   11324:	00e5a623          	sw	a4,12(a1)
   11328:	00b72423          	sw	a1,8(a4)
   1132c:	00f12623          	sw	a5,12(sp)
   11330:	63c000ef          	jal	1196c <__malloc_unlock>
   11334:	00c12783          	lw	a5,12(sp)
   11338:	00878513          	addi	a0,a5,8
   1133c:	e55ff06f          	j	11190 <_malloc_r+0xa4>
   11340:	20000513          	li	a0,512
   11344:	04000893          	li	a7,64
   11348:	03f00e13          	li	t3,63
   1134c:	e95ff06f          	j	111e0 <_malloc_r+0xf4>
   11350:	00882783          	lw	a5,8(a6)
   11354:	0047a703          	lw	a4,4(a5)
   11358:	ffc77313          	andi	t1,a4,-4
   1135c:	40d30633          	sub	a2,t1,a3
   11360:	00d36663          	bltu	t1,a3,1136c <_malloc_r+0x280>
   11364:	01062713          	slti	a4,a2,16
   11368:	1a070463          	beqz	a4,11510 <_malloc_r+0x424>
   1136c:	d7c1a583          	lw	a1,-644(gp) # 1365c <__malloc_top_pad>
   11370:	d601a603          	lw	a2,-672(gp) # 13640 <__malloc_sbrk_base>
   11374:	fff00713          	li	a4,-1
   11378:	00b685b3          	add	a1,a3,a1
   1137c:	42e60463          	beq	a2,a4,117a4 <_malloc_r+0x6b8>
   11380:	00001737          	lui	a4,0x1
   11384:	00f70713          	addi	a4,a4,15 # 100f <exit-0xf0a5>
   11388:	00e585b3          	add	a1,a1,a4
   1138c:	fffff737          	lui	a4,0xfffff
   11390:	00e5f5b3          	and	a1,a1,a4
   11394:	00040513          	mv	a0,s0
   11398:	01012e23          	sw	a6,28(sp)
   1139c:	00f12c23          	sw	a5,24(sp)
   113a0:	00d12a23          	sw	a3,20(sp)
   113a4:	00612823          	sw	t1,16(sp)
   113a8:	00b12623          	sw	a1,12(sp)
   113ac:	229000ef          	jal	11dd4 <_sbrk_r>
   113b0:	fff00713          	li	a4,-1
   113b4:	00c12583          	lw	a1,12(sp)
   113b8:	01012303          	lw	t1,16(sp)
   113bc:	01412683          	lw	a3,20(sp)
   113c0:	01812783          	lw	a5,24(sp)
   113c4:	01c12803          	lw	a6,28(sp)
   113c8:	00050e13          	mv	t3,a0
   113cc:	34e50663          	beq	a0,a4,11718 <_malloc_r+0x62c>
   113d0:	00678733          	add	a4,a5,t1
   113d4:	34e56063          	bltu	a0,a4,11714 <_malloc_r+0x628>
   113d8:	ed818e93          	addi	t4,gp,-296 # 137b8 <__malloc_current_mallinfo>
   113dc:	000ea603          	lw	a2,0(t4)
   113e0:	00c58633          	add	a2,a1,a2
   113e4:	00cea023          	sw	a2,0(t4)
   113e8:	48a70a63          	beq	a4,a0,1187c <_malloc_r+0x790>
   113ec:	d601af03          	lw	t5,-672(gp) # 13640 <__malloc_sbrk_base>
   113f0:	fff00513          	li	a0,-1
   113f4:	4aaf0263          	beq	t5,a0,11898 <_malloc_r+0x7ac>
   113f8:	40ee0733          	sub	a4,t3,a4
   113fc:	00c70733          	add	a4,a4,a2
   11400:	00eea023          	sw	a4,0(t4)
   11404:	007e7f13          	andi	t5,t3,7
   11408:	3a0f0e63          	beqz	t5,117c4 <_malloc_r+0x6d8>
   1140c:	ff8e7e13          	andi	t3,t3,-8
   11410:	000018b7          	lui	a7,0x1
   11414:	008e0e13          	addi	t3,t3,8
   11418:	00888893          	addi	a7,a7,8 # 1008 <exit-0xf0ac>
   1141c:	00be0633          	add	a2,t3,a1
   11420:	41e885b3          	sub	a1,a7,t5
   11424:	40c585b3          	sub	a1,a1,a2
   11428:	01459593          	slli	a1,a1,0x14
   1142c:	0145d593          	srli	a1,a1,0x14
   11430:	00040513          	mv	a0,s0
   11434:	03012623          	sw	a6,44(sp)
   11438:	03d12423          	sw	t4,40(sp)
   1143c:	02f12223          	sw	a5,36(sp)
   11440:	02d12023          	sw	a3,32(sp)
   11444:	00612e23          	sw	t1,28(sp)
   11448:	01c12c23          	sw	t3,24(sp)
   1144c:	01e12a23          	sw	t5,20(sp)
   11450:	00c12823          	sw	a2,16(sp)
   11454:	00b12623          	sw	a1,12(sp)
   11458:	17d000ef          	jal	11dd4 <_sbrk_r>
   1145c:	00050713          	mv	a4,a0
   11460:	fff00513          	li	a0,-1
   11464:	00c12583          	lw	a1,12(sp)
   11468:	01012603          	lw	a2,16(sp)
   1146c:	01412f03          	lw	t5,20(sp)
   11470:	01812e03          	lw	t3,24(sp)
   11474:	01c12303          	lw	t1,28(sp)
   11478:	02012683          	lw	a3,32(sp)
   1147c:	02412783          	lw	a5,36(sp)
   11480:	02812e83          	lw	t4,40(sp)
   11484:	02c12803          	lw	a6,44(sp)
   11488:	44a70e63          	beq	a4,a0,118e4 <_malloc_r+0x7f8>
   1148c:	000ea603          	lw	a2,0(t4)
   11490:	41c70733          	sub	a4,a4,t3
   11494:	00b70733          	add	a4,a4,a1
   11498:	00176713          	ori	a4,a4,1
   1149c:	01c82423          	sw	t3,8(a6)
   114a0:	00c58633          	add	a2,a1,a2
   114a4:	00ee2223          	sw	a4,4(t3)
   114a8:	00cea023          	sw	a2,0(t4)
   114ac:	03078e63          	beq	a5,a6,114e8 <_malloc_r+0x3fc>
   114b0:	00f00513          	li	a0,15
   114b4:	3e657663          	bgeu	a0,t1,118a0 <_malloc_r+0x7b4>
   114b8:	0047a583          	lw	a1,4(a5)
   114bc:	ff430713          	addi	a4,t1,-12
   114c0:	ff877713          	andi	a4,a4,-8
   114c4:	0015f593          	andi	a1,a1,1
   114c8:	00e5e5b3          	or	a1,a1,a4
   114cc:	00b7a223          	sw	a1,4(a5)
   114d0:	00500893          	li	a7,5
   114d4:	00e785b3          	add	a1,a5,a4
   114d8:	0115a223          	sw	a7,4(a1)
   114dc:	0115a423          	sw	a7,8(a1)
   114e0:	40e56a63          	bltu	a0,a4,118f4 <_malloc_r+0x808>
   114e4:	004e2703          	lw	a4,4(t3)
   114e8:	d781a583          	lw	a1,-648(gp) # 13658 <__malloc_max_sbrked_mem>
   114ec:	00c5f463          	bgeu	a1,a2,114f4 <_malloc_r+0x408>
   114f0:	d6c1ac23          	sw	a2,-648(gp) # 13658 <__malloc_max_sbrked_mem>
   114f4:	d741a583          	lw	a1,-652(gp) # 13654 <__malloc_max_total_mem>
   114f8:	00c5f463          	bgeu	a1,a2,11500 <_malloc_r+0x414>
   114fc:	d6c1aa23          	sw	a2,-652(gp) # 13654 <__malloc_max_total_mem>
   11500:	000e0793          	mv	a5,t3
   11504:	21c0006f          	j	11720 <_malloc_r+0x634>
   11508:	00482303          	lw	t1,4(a6)
   1150c:	d8dff06f          	j	11298 <_malloc_r+0x1ac>
   11510:	0016e713          	ori	a4,a3,1
   11514:	00e7a223          	sw	a4,4(a5)
   11518:	00d786b3          	add	a3,a5,a3
   1151c:	00166613          	ori	a2,a2,1
   11520:	00d82423          	sw	a3,8(a6)
   11524:	00040513          	mv	a0,s0
   11528:	00c6a223          	sw	a2,4(a3)
   1152c:	00f12623          	sw	a5,12(sp)
   11530:	43c000ef          	jal	1196c <__malloc_unlock>
   11534:	00c12783          	lw	a5,12(sp)
   11538:	03c12083          	lw	ra,60(sp)
   1153c:	03812403          	lw	s0,56(sp)
   11540:	00878513          	addi	a0,a5,8
   11544:	04010113          	addi	sp,sp,64
   11548:	00008067          	ret
   1154c:	0087a603          	lw	a2,8(a5)
   11550:	00e78733          	add	a4,a5,a4
   11554:	00472683          	lw	a3,4(a4) # fffff004 <__BSS_END__+0xfffeb694>
   11558:	00b62623          	sw	a1,12(a2)
   1155c:	00f12623          	sw	a5,12(sp)
   11560:	0016e693          	ori	a3,a3,1
   11564:	00c5a423          	sw	a2,8(a1)
   11568:	00040513          	mv	a0,s0
   1156c:	00d72223          	sw	a3,4(a4)
   11570:	3fc000ef          	jal	1196c <__malloc_unlock>
   11574:	00c12783          	lw	a5,12(sp)
   11578:	03c12083          	lw	ra,60(sp)
   1157c:	03812403          	lw	s0,56(sp)
   11580:	00878513          	addi	a0,a5,8
   11584:	04010113          	addi	sp,sp,64
   11588:	00008067          	ret
   1158c:	00c72783          	lw	a5,12(a4)
   11590:	00288893          	addi	a7,a7,2
   11594:	c8f708e3          	beq	a4,a5,11224 <_malloc_r+0x138>
   11598:	ba1ff06f          	j	11138 <_malloc_r+0x4c>
   1159c:	00975613          	srli	a2,a4,0x9
   115a0:	00400593          	li	a1,4
   115a4:	14c5fe63          	bgeu	a1,a2,11700 <_malloc_r+0x614>
   115a8:	01400593          	li	a1,20
   115ac:	28c5e263          	bltu	a1,a2,11830 <_malloc_r+0x744>
   115b0:	05c60513          	addi	a0,a2,92
   115b4:	00351513          	slli	a0,a0,0x3
   115b8:	05b60593          	addi	a1,a2,91
   115bc:	00a80533          	add	a0,a6,a0
   115c0:	00052603          	lw	a2,0(a0)
   115c4:	ff850513          	addi	a0,a0,-8
   115c8:	00c51863          	bne	a0,a2,115d8 <_malloc_r+0x4ec>
   115cc:	1e00006f          	j	117ac <_malloc_r+0x6c0>
   115d0:	00862603          	lw	a2,8(a2)
   115d4:	00c50863          	beq	a0,a2,115e4 <_malloc_r+0x4f8>
   115d8:	00462583          	lw	a1,4(a2)
   115dc:	ffc5f593          	andi	a1,a1,-4
   115e0:	feb768e3          	bltu	a4,a1,115d0 <_malloc_r+0x4e4>
   115e4:	00c62503          	lw	a0,12(a2)
   115e8:	00a7a623          	sw	a0,12(a5)
   115ec:	00c7a423          	sw	a2,8(a5)
   115f0:	00f52423          	sw	a5,8(a0)
   115f4:	00f62623          	sw	a5,12(a2)
   115f8:	ca1ff06f          	j	11298 <_malloc_r+0x1ac>
   115fc:	01400713          	li	a4,20
   11600:	14f77063          	bgeu	a4,a5,11740 <_malloc_r+0x654>
   11604:	05400713          	li	a4,84
   11608:	24f76263          	bltu	a4,a5,1184c <_malloc_r+0x760>
   1160c:	00c6d793          	srli	a5,a3,0xc
   11610:	06f78893          	addi	a7,a5,111
   11614:	06e78e13          	addi	t3,a5,110
   11618:	00389513          	slli	a0,a7,0x3
   1161c:	bc5ff06f          	j	111e0 <_malloc_r+0xf4>
   11620:	001f8f93          	addi	t6,t6,1
   11624:	003ff793          	andi	a5,t6,3
   11628:	00830313          	addi	t1,t1,8
   1162c:	12078863          	beqz	a5,1175c <_malloc_r+0x670>
   11630:	00c32703          	lw	a4,12(t1)
   11634:	cb9ff06f          	j	112ec <_malloc_r+0x200>
   11638:	0087a503          	lw	a0,8(a5)
   1163c:	0016e893          	ori	a7,a3,1
   11640:	0117a223          	sw	a7,4(a5)
   11644:	00e52623          	sw	a4,12(a0)
   11648:	00a72423          	sw	a0,8(a4)
   1164c:	00d786b3          	add	a3,a5,a3
   11650:	00d82a23          	sw	a3,20(a6)
   11654:	00d82823          	sw	a3,16(a6)
   11658:	0015e713          	ori	a4,a1,1
   1165c:	00c78633          	add	a2,a5,a2
   11660:	01c6a623          	sw	t3,12(a3)
   11664:	01c6a423          	sw	t3,8(a3)
   11668:	00e6a223          	sw	a4,4(a3)
   1166c:	00040513          	mv	a0,s0
   11670:	00b62023          	sw	a1,0(a2)
   11674:	00f12623          	sw	a5,12(sp)
   11678:	2f4000ef          	jal	1196c <__malloc_unlock>
   1167c:	00c12783          	lw	a5,12(sp)
   11680:	00878513          	addi	a0,a5,8
   11684:	b0dff06f          	j	11190 <_malloc_r+0xa4>
   11688:	0036d893          	srli	a7,a3,0x3
   1168c:	00868713          	addi	a4,a3,8
   11690:	a91ff06f          	j	11120 <_malloc_r+0x34>
   11694:	00e78733          	add	a4,a5,a4
   11698:	00472683          	lw	a3,4(a4)
   1169c:	00f12623          	sw	a5,12(sp)
   116a0:	00040513          	mv	a0,s0
   116a4:	0016e693          	ori	a3,a3,1
   116a8:	00d72223          	sw	a3,4(a4)
   116ac:	2c0000ef          	jal	1196c <__malloc_unlock>
   116b0:	00c12783          	lw	a5,12(sp)
   116b4:	00878513          	addi	a0,a5,8
   116b8:	ad9ff06f          	j	11190 <_malloc_r+0xa4>
   116bc:	0016e593          	ori	a1,a3,1
   116c0:	00b7a223          	sw	a1,4(a5)
   116c4:	00d786b3          	add	a3,a5,a3
   116c8:	00d82a23          	sw	a3,20(a6)
   116cc:	00d82823          	sw	a3,16(a6)
   116d0:	00166593          	ori	a1,a2,1
   116d4:	00e78733          	add	a4,a5,a4
   116d8:	01c6a623          	sw	t3,12(a3)
   116dc:	01c6a423          	sw	t3,8(a3)
   116e0:	00b6a223          	sw	a1,4(a3)
   116e4:	00040513          	mv	a0,s0
   116e8:	00c72023          	sw	a2,0(a4)
   116ec:	00f12623          	sw	a5,12(sp)
   116f0:	27c000ef          	jal	1196c <__malloc_unlock>
   116f4:	00c12783          	lw	a5,12(sp)
   116f8:	00878513          	addi	a0,a5,8
   116fc:	a95ff06f          	j	11190 <_malloc_r+0xa4>
   11700:	00675613          	srli	a2,a4,0x6
   11704:	03960513          	addi	a0,a2,57
   11708:	00351513          	slli	a0,a0,0x3
   1170c:	03860593          	addi	a1,a2,56
   11710:	eadff06f          	j	115bc <_malloc_r+0x4d0>
   11714:	15078a63          	beq	a5,a6,11868 <_malloc_r+0x77c>
   11718:	00882783          	lw	a5,8(a6)
   1171c:	0047a703          	lw	a4,4(a5)
   11720:	ffc77713          	andi	a4,a4,-4
   11724:	40d70633          	sub	a2,a4,a3
   11728:	00d76663          	bltu	a4,a3,11734 <_malloc_r+0x648>
   1172c:	01062713          	slti	a4,a2,16
   11730:	de0700e3          	beqz	a4,11510 <_malloc_r+0x424>
   11734:	00040513          	mv	a0,s0
   11738:	234000ef          	jal	1196c <__malloc_unlock>
   1173c:	a51ff06f          	j	1118c <_malloc_r+0xa0>
   11740:	05c78893          	addi	a7,a5,92
   11744:	05b78e13          	addi	t3,a5,91
   11748:	00389513          	slli	a0,a7,0x3
   1174c:	a95ff06f          	j	111e0 <_malloc_r+0xf4>
   11750:	008f2783          	lw	a5,8(t5)
   11754:	fff88893          	addi	a7,a7,-1
   11758:	21e79463          	bne	a5,t5,11960 <_malloc_r+0x874>
   1175c:	0038f793          	andi	a5,a7,3
   11760:	ff8f0f13          	addi	t5,t5,-8
   11764:	fe0796e3          	bnez	a5,11750 <_malloc_r+0x664>
   11768:	00482703          	lw	a4,4(a6)
   1176c:	fff54793          	not	a5,a0
   11770:	00e7f7b3          	and	a5,a5,a4
   11774:	00f82223          	sw	a5,4(a6)
   11778:	00151513          	slli	a0,a0,0x1
   1177c:	fff50713          	addi	a4,a0,-1
   11780:	bcf778e3          	bgeu	a4,a5,11350 <_malloc_r+0x264>
   11784:	00f57733          	and	a4,a0,a5
   11788:	00071a63          	bnez	a4,1179c <_malloc_r+0x6b0>
   1178c:	00151513          	slli	a0,a0,0x1
   11790:	00f57733          	and	a4,a0,a5
   11794:	004f8f93          	addi	t6,t6,4
   11798:	fe070ae3          	beqz	a4,1178c <_malloc_r+0x6a0>
   1179c:	000f8893          	mv	a7,t6
   117a0:	b39ff06f          	j	112d8 <_malloc_r+0x1ec>
   117a4:	01058593          	addi	a1,a1,16
   117a8:	bedff06f          	j	11394 <_malloc_r+0x2a8>
   117ac:	4025d593          	srai	a1,a1,0x2
   117b0:	00100713          	li	a4,1
   117b4:	00b71733          	sll	a4,a4,a1
   117b8:	00e36333          	or	t1,t1,a4
   117bc:	00682223          	sw	t1,4(a6)
   117c0:	e29ff06f          	j	115e8 <_malloc_r+0x4fc>
   117c4:	00be0633          	add	a2,t3,a1
   117c8:	40c005b3          	neg	a1,a2
   117cc:	01459593          	slli	a1,a1,0x14
   117d0:	0145d593          	srli	a1,a1,0x14
   117d4:	00040513          	mv	a0,s0
   117d8:	03012423          	sw	a6,40(sp)
   117dc:	03d12223          	sw	t4,36(sp)
   117e0:	02f12023          	sw	a5,32(sp)
   117e4:	00d12e23          	sw	a3,28(sp)
   117e8:	00612c23          	sw	t1,24(sp)
   117ec:	01c12a23          	sw	t3,20(sp)
   117f0:	00b12623          	sw	a1,12(sp)
   117f4:	00c12823          	sw	a2,16(sp)
   117f8:	5dc000ef          	jal	11dd4 <_sbrk_r>
   117fc:	00050713          	mv	a4,a0
   11800:	fff00513          	li	a0,-1
   11804:	00c12583          	lw	a1,12(sp)
   11808:	01412e03          	lw	t3,20(sp)
   1180c:	01812303          	lw	t1,24(sp)
   11810:	01c12683          	lw	a3,28(sp)
   11814:	02012783          	lw	a5,32(sp)
   11818:	02412e83          	lw	t4,36(sp)
   1181c:	02812803          	lw	a6,40(sp)
   11820:	c6a716e3          	bne	a4,a0,1148c <_malloc_r+0x3a0>
   11824:	01012703          	lw	a4,16(sp)
   11828:	00000593          	li	a1,0
   1182c:	c61ff06f          	j	1148c <_malloc_r+0x3a0>
   11830:	05400593          	li	a1,84
   11834:	06c5ec63          	bltu	a1,a2,118ac <_malloc_r+0x7c0>
   11838:	00c75613          	srli	a2,a4,0xc
   1183c:	06f60513          	addi	a0,a2,111
   11840:	00351513          	slli	a0,a0,0x3
   11844:	06e60593          	addi	a1,a2,110
   11848:	d75ff06f          	j	115bc <_malloc_r+0x4d0>
   1184c:	15400713          	li	a4,340
   11850:	06f76c63          	bltu	a4,a5,118c8 <_malloc_r+0x7dc>
   11854:	00f6d793          	srli	a5,a3,0xf
   11858:	07878893          	addi	a7,a5,120
   1185c:	07778e13          	addi	t3,a5,119
   11860:	00389513          	slli	a0,a7,0x3
   11864:	97dff06f          	j	111e0 <_malloc_r+0xf4>
   11868:	ed818e93          	addi	t4,gp,-296 # 137b8 <__malloc_current_mallinfo>
   1186c:	000ea603          	lw	a2,0(t4)
   11870:	00c58633          	add	a2,a1,a2
   11874:	00cea023          	sw	a2,0(t4)
   11878:	b75ff06f          	j	113ec <_malloc_r+0x300>
   1187c:	01451513          	slli	a0,a0,0x14
   11880:	b60516e3          	bnez	a0,113ec <_malloc_r+0x300>
   11884:	00882e03          	lw	t3,8(a6)
   11888:	00b305b3          	add	a1,t1,a1
   1188c:	0015e713          	ori	a4,a1,1
   11890:	00ee2223          	sw	a4,4(t3)
   11894:	c55ff06f          	j	114e8 <_malloc_r+0x3fc>
   11898:	d7c1a023          	sw	t3,-672(gp) # 13640 <__malloc_sbrk_base>
   1189c:	b69ff06f          	j	11404 <_malloc_r+0x318>
   118a0:	00100793          	li	a5,1
   118a4:	00fe2223          	sw	a5,4(t3)
   118a8:	e8dff06f          	j	11734 <_malloc_r+0x648>
   118ac:	15400593          	li	a1,340
   118b0:	06c5ec63          	bltu	a1,a2,11928 <_malloc_r+0x83c>
   118b4:	00f75613          	srli	a2,a4,0xf
   118b8:	07860513          	addi	a0,a2,120
   118bc:	00351513          	slli	a0,a0,0x3
   118c0:	07760593          	addi	a1,a2,119
   118c4:	cf9ff06f          	j	115bc <_malloc_r+0x4d0>
   118c8:	55400713          	li	a4,1364
   118cc:	06f76c63          	bltu	a4,a5,11944 <_malloc_r+0x858>
   118d0:	0126d793          	srli	a5,a3,0x12
   118d4:	07d78893          	addi	a7,a5,125
   118d8:	07c78e13          	addi	t3,a5,124
   118dc:	00389513          	slli	a0,a7,0x3
   118e0:	901ff06f          	j	111e0 <_malloc_r+0xf4>
   118e4:	ff8f0f13          	addi	t5,t5,-8
   118e8:	01e60733          	add	a4,a2,t5
   118ec:	00000593          	li	a1,0
   118f0:	b9dff06f          	j	1148c <_malloc_r+0x3a0>
   118f4:	00878593          	addi	a1,a5,8
   118f8:	00040513          	mv	a0,s0
   118fc:	01012a23          	sw	a6,20(sp)
   11900:	01d12823          	sw	t4,16(sp)
   11904:	00d12623          	sw	a3,12(sp)
   11908:	cfcff0ef          	jal	10e04 <_free_r>
   1190c:	01412803          	lw	a6,20(sp)
   11910:	01012e83          	lw	t4,16(sp)
   11914:	00c12683          	lw	a3,12(sp)
   11918:	00882e03          	lw	t3,8(a6)
   1191c:	000ea603          	lw	a2,0(t4)
   11920:	004e2703          	lw	a4,4(t3)
   11924:	bc5ff06f          	j	114e8 <_malloc_r+0x3fc>
   11928:	55400593          	li	a1,1364
   1192c:	02c5e463          	bltu	a1,a2,11954 <_malloc_r+0x868>
   11930:	01275613          	srli	a2,a4,0x12
   11934:	07d60513          	addi	a0,a2,125
   11938:	00351513          	slli	a0,a0,0x3
   1193c:	07c60593          	addi	a1,a2,124
   11940:	c7dff06f          	j	115bc <_malloc_r+0x4d0>
   11944:	3f800513          	li	a0,1016
   11948:	07f00893          	li	a7,127
   1194c:	07e00e13          	li	t3,126
   11950:	891ff06f          	j	111e0 <_malloc_r+0xf4>
   11954:	3f800513          	li	a0,1016
   11958:	07e00593          	li	a1,126
   1195c:	c61ff06f          	j	115bc <_malloc_r+0x4d0>
   11960:	00482783          	lw	a5,4(a6)
   11964:	e15ff06f          	j	11778 <_malloc_r+0x68c>

00011968 <__malloc_lock>:
   11968:	00008067          	ret

0001196c <__malloc_unlock>:
   1196c:	00008067          	ret

00011970 <_fclose_r>:
   11970:	ff010113          	addi	sp,sp,-16
   11974:	00112623          	sw	ra,12(sp)
   11978:	01212023          	sw	s2,0(sp)
   1197c:	02058863          	beqz	a1,119ac <_fclose_r+0x3c>
   11980:	00812423          	sw	s0,8(sp)
   11984:	00912223          	sw	s1,4(sp)
   11988:	00058413          	mv	s0,a1
   1198c:	00050493          	mv	s1,a0
   11990:	00050663          	beqz	a0,1199c <_fclose_r+0x2c>
   11994:	03452783          	lw	a5,52(a0)
   11998:	0c078c63          	beqz	a5,11a70 <_fclose_r+0x100>
   1199c:	00c41783          	lh	a5,12(s0)
   119a0:	02079263          	bnez	a5,119c4 <_fclose_r+0x54>
   119a4:	00812403          	lw	s0,8(sp)
   119a8:	00412483          	lw	s1,4(sp)
   119ac:	00c12083          	lw	ra,12(sp)
   119b0:	00000913          	li	s2,0
   119b4:	00090513          	mv	a0,s2
   119b8:	00012903          	lw	s2,0(sp)
   119bc:	01010113          	addi	sp,sp,16
   119c0:	00008067          	ret
   119c4:	00040593          	mv	a1,s0
   119c8:	00048513          	mv	a0,s1
   119cc:	0b8000ef          	jal	11a84 <__sflush_r>
   119d0:	02c42783          	lw	a5,44(s0)
   119d4:	00050913          	mv	s2,a0
   119d8:	00078a63          	beqz	a5,119ec <_fclose_r+0x7c>
   119dc:	01c42583          	lw	a1,28(s0)
   119e0:	00048513          	mv	a0,s1
   119e4:	000780e7          	jalr	a5
   119e8:	06054463          	bltz	a0,11a50 <_fclose_r+0xe0>
   119ec:	00c45783          	lhu	a5,12(s0)
   119f0:	0807f793          	andi	a5,a5,128
   119f4:	06079663          	bnez	a5,11a60 <_fclose_r+0xf0>
   119f8:	03042583          	lw	a1,48(s0)
   119fc:	00058c63          	beqz	a1,11a14 <_fclose_r+0xa4>
   11a00:	04040793          	addi	a5,s0,64
   11a04:	00f58663          	beq	a1,a5,11a10 <_fclose_r+0xa0>
   11a08:	00048513          	mv	a0,s1
   11a0c:	bf8ff0ef          	jal	10e04 <_free_r>
   11a10:	02042823          	sw	zero,48(s0)
   11a14:	04442583          	lw	a1,68(s0)
   11a18:	00058863          	beqz	a1,11a28 <_fclose_r+0xb8>
   11a1c:	00048513          	mv	a0,s1
   11a20:	be4ff0ef          	jal	10e04 <_free_r>
   11a24:	04042223          	sw	zero,68(s0)
   11a28:	b29fe0ef          	jal	10550 <__sfp_lock_acquire>
   11a2c:	00041623          	sh	zero,12(s0)
   11a30:	b25fe0ef          	jal	10554 <__sfp_lock_release>
   11a34:	00c12083          	lw	ra,12(sp)
   11a38:	00812403          	lw	s0,8(sp)
   11a3c:	00412483          	lw	s1,4(sp)
   11a40:	00090513          	mv	a0,s2
   11a44:	00012903          	lw	s2,0(sp)
   11a48:	01010113          	addi	sp,sp,16
   11a4c:	00008067          	ret
   11a50:	00c45783          	lhu	a5,12(s0)
   11a54:	fff00913          	li	s2,-1
   11a58:	0807f793          	andi	a5,a5,128
   11a5c:	f8078ee3          	beqz	a5,119f8 <_fclose_r+0x88>
   11a60:	01042583          	lw	a1,16(s0)
   11a64:	00048513          	mv	a0,s1
   11a68:	b9cff0ef          	jal	10e04 <_free_r>
   11a6c:	f8dff06f          	j	119f8 <_fclose_r+0x88>
   11a70:	abdfe0ef          	jal	1052c <__sinit>
   11a74:	f29ff06f          	j	1199c <_fclose_r+0x2c>

00011a78 <fclose>:
   11a78:	00050593          	mv	a1,a0
   11a7c:	d5c1a503          	lw	a0,-676(gp) # 1363c <_impure_ptr>
   11a80:	ef1ff06f          	j	11970 <_fclose_r>

00011a84 <__sflush_r>:
   11a84:	00c59703          	lh	a4,12(a1)
   11a88:	fe010113          	addi	sp,sp,-32
   11a8c:	00812c23          	sw	s0,24(sp)
   11a90:	01312623          	sw	s3,12(sp)
   11a94:	00112e23          	sw	ra,28(sp)
   11a98:	00877793          	andi	a5,a4,8
   11a9c:	00058413          	mv	s0,a1
   11aa0:	00050993          	mv	s3,a0
   11aa4:	12079263          	bnez	a5,11bc8 <__sflush_r+0x144>
   11aa8:	000017b7          	lui	a5,0x1
   11aac:	80078793          	addi	a5,a5,-2048 # 800 <exit-0xf8b4>
   11ab0:	0045a683          	lw	a3,4(a1)
   11ab4:	00f767b3          	or	a5,a4,a5
   11ab8:	00f59623          	sh	a5,12(a1)
   11abc:	18d05c63          	blez	a3,11c54 <__sflush_r+0x1d0>
   11ac0:	02842803          	lw	a6,40(s0)
   11ac4:	0e080663          	beqz	a6,11bb0 <__sflush_r+0x12c>
   11ac8:	00912a23          	sw	s1,20(sp)
   11acc:	01371693          	slli	a3,a4,0x13
   11ad0:	0009a483          	lw	s1,0(s3)
   11ad4:	0009a023          	sw	zero,0(s3)
   11ad8:	1806ca63          	bltz	a3,11c6c <__sflush_r+0x1e8>
   11adc:	01c42583          	lw	a1,28(s0)
   11ae0:	00000613          	li	a2,0
   11ae4:	00100693          	li	a3,1
   11ae8:	00098513          	mv	a0,s3
   11aec:	000800e7          	jalr	a6
   11af0:	fff00793          	li	a5,-1
   11af4:	00050613          	mv	a2,a0
   11af8:	1af50c63          	beq	a0,a5,11cb0 <__sflush_r+0x22c>
   11afc:	00c41783          	lh	a5,12(s0)
   11b00:	02842803          	lw	a6,40(s0)
   11b04:	0047f793          	andi	a5,a5,4
   11b08:	00078e63          	beqz	a5,11b24 <__sflush_r+0xa0>
   11b0c:	00442703          	lw	a4,4(s0)
   11b10:	03042783          	lw	a5,48(s0)
   11b14:	40e60633          	sub	a2,a2,a4
   11b18:	00078663          	beqz	a5,11b24 <__sflush_r+0xa0>
   11b1c:	03c42783          	lw	a5,60(s0)
   11b20:	40f60633          	sub	a2,a2,a5
   11b24:	01c42583          	lw	a1,28(s0)
   11b28:	00000693          	li	a3,0
   11b2c:	00098513          	mv	a0,s3
   11b30:	000800e7          	jalr	a6
   11b34:	fff00713          	li	a4,-1
   11b38:	00c41783          	lh	a5,12(s0)
   11b3c:	12e51c63          	bne	a0,a4,11c74 <__sflush_r+0x1f0>
   11b40:	0009a683          	lw	a3,0(s3)
   11b44:	01d00713          	li	a4,29
   11b48:	18d76263          	bltu	a4,a3,11ccc <__sflush_r+0x248>
   11b4c:	20400737          	lui	a4,0x20400
   11b50:	00170713          	addi	a4,a4,1 # 20400001 <__BSS_END__+0x203ec691>
   11b54:	00d75733          	srl	a4,a4,a3
   11b58:	00177713          	andi	a4,a4,1
   11b5c:	16070863          	beqz	a4,11ccc <__sflush_r+0x248>
   11b60:	01042683          	lw	a3,16(s0)
   11b64:	fffff737          	lui	a4,0xfffff
   11b68:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebe8f>
   11b6c:	00e7f733          	and	a4,a5,a4
   11b70:	00e41623          	sh	a4,12(s0)
   11b74:	00042223          	sw	zero,4(s0)
   11b78:	00d42023          	sw	a3,0(s0)
   11b7c:	01379713          	slli	a4,a5,0x13
   11b80:	00075663          	bgez	a4,11b8c <__sflush_r+0x108>
   11b84:	0009a783          	lw	a5,0(s3)
   11b88:	10078863          	beqz	a5,11c98 <__sflush_r+0x214>
   11b8c:	03042583          	lw	a1,48(s0)
   11b90:	0099a023          	sw	s1,0(s3)
   11b94:	10058a63          	beqz	a1,11ca8 <__sflush_r+0x224>
   11b98:	04040793          	addi	a5,s0,64
   11b9c:	00f58663          	beq	a1,a5,11ba8 <__sflush_r+0x124>
   11ba0:	00098513          	mv	a0,s3
   11ba4:	a60ff0ef          	jal	10e04 <_free_r>
   11ba8:	01412483          	lw	s1,20(sp)
   11bac:	02042823          	sw	zero,48(s0)
   11bb0:	01c12083          	lw	ra,28(sp)
   11bb4:	01812403          	lw	s0,24(sp)
   11bb8:	00c12983          	lw	s3,12(sp)
   11bbc:	00000513          	li	a0,0
   11bc0:	02010113          	addi	sp,sp,32
   11bc4:	00008067          	ret
   11bc8:	01212823          	sw	s2,16(sp)
   11bcc:	0105a903          	lw	s2,16(a1)
   11bd0:	08090a63          	beqz	s2,11c64 <__sflush_r+0x1e0>
   11bd4:	00912a23          	sw	s1,20(sp)
   11bd8:	0005a483          	lw	s1,0(a1)
   11bdc:	00377713          	andi	a4,a4,3
   11be0:	0125a023          	sw	s2,0(a1)
   11be4:	412484b3          	sub	s1,s1,s2
   11be8:	00000793          	li	a5,0
   11bec:	00071463          	bnez	a4,11bf4 <__sflush_r+0x170>
   11bf0:	0145a783          	lw	a5,20(a1)
   11bf4:	00f42423          	sw	a5,8(s0)
   11bf8:	00904863          	bgtz	s1,11c08 <__sflush_r+0x184>
   11bfc:	0640006f          	j	11c60 <__sflush_r+0x1dc>
   11c00:	00a90933          	add	s2,s2,a0
   11c04:	04905e63          	blez	s1,11c60 <__sflush_r+0x1dc>
   11c08:	02442783          	lw	a5,36(s0)
   11c0c:	01c42583          	lw	a1,28(s0)
   11c10:	00048693          	mv	a3,s1
   11c14:	00090613          	mv	a2,s2
   11c18:	00098513          	mv	a0,s3
   11c1c:	000780e7          	jalr	a5
   11c20:	40a484b3          	sub	s1,s1,a0
   11c24:	fca04ee3          	bgtz	a0,11c00 <__sflush_r+0x17c>
   11c28:	00c45783          	lhu	a5,12(s0)
   11c2c:	01012903          	lw	s2,16(sp)
   11c30:	0407e793          	ori	a5,a5,64
   11c34:	01c12083          	lw	ra,28(sp)
   11c38:	00f41623          	sh	a5,12(s0)
   11c3c:	01812403          	lw	s0,24(sp)
   11c40:	01412483          	lw	s1,20(sp)
   11c44:	00c12983          	lw	s3,12(sp)
   11c48:	fff00513          	li	a0,-1
   11c4c:	02010113          	addi	sp,sp,32
   11c50:	00008067          	ret
   11c54:	03c5a683          	lw	a3,60(a1)
   11c58:	e6d044e3          	bgtz	a3,11ac0 <__sflush_r+0x3c>
   11c5c:	f55ff06f          	j	11bb0 <__sflush_r+0x12c>
   11c60:	01412483          	lw	s1,20(sp)
   11c64:	01012903          	lw	s2,16(sp)
   11c68:	f49ff06f          	j	11bb0 <__sflush_r+0x12c>
   11c6c:	05042603          	lw	a2,80(s0)
   11c70:	e95ff06f          	j	11b04 <__sflush_r+0x80>
   11c74:	01042683          	lw	a3,16(s0)
   11c78:	fffff737          	lui	a4,0xfffff
   11c7c:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebe8f>
   11c80:	00e7f733          	and	a4,a5,a4
   11c84:	00e41623          	sh	a4,12(s0)
   11c88:	00042223          	sw	zero,4(s0)
   11c8c:	00d42023          	sw	a3,0(s0)
   11c90:	01379713          	slli	a4,a5,0x13
   11c94:	ee075ce3          	bgez	a4,11b8c <__sflush_r+0x108>
   11c98:	03042583          	lw	a1,48(s0)
   11c9c:	04a42823          	sw	a0,80(s0)
   11ca0:	0099a023          	sw	s1,0(s3)
   11ca4:	ee059ae3          	bnez	a1,11b98 <__sflush_r+0x114>
   11ca8:	01412483          	lw	s1,20(sp)
   11cac:	f05ff06f          	j	11bb0 <__sflush_r+0x12c>
   11cb0:	0009a783          	lw	a5,0(s3)
   11cb4:	e40784e3          	beqz	a5,11afc <__sflush_r+0x78>
   11cb8:	fe378713          	addi	a4,a5,-29
   11cbc:	00070c63          	beqz	a4,11cd4 <__sflush_r+0x250>
   11cc0:	fea78793          	addi	a5,a5,-22
   11cc4:	00078863          	beqz	a5,11cd4 <__sflush_r+0x250>
   11cc8:	00c45783          	lhu	a5,12(s0)
   11ccc:	0407e793          	ori	a5,a5,64
   11cd0:	f65ff06f          	j	11c34 <__sflush_r+0x1b0>
   11cd4:	0099a023          	sw	s1,0(s3)
   11cd8:	01412483          	lw	s1,20(sp)
   11cdc:	ed5ff06f          	j	11bb0 <__sflush_r+0x12c>

00011ce0 <_fflush_r>:
   11ce0:	00050793          	mv	a5,a0
   11ce4:	00050663          	beqz	a0,11cf0 <_fflush_r+0x10>
   11ce8:	03452703          	lw	a4,52(a0)
   11cec:	00070e63          	beqz	a4,11d08 <_fflush_r+0x28>
   11cf0:	00c59703          	lh	a4,12(a1)
   11cf4:	00071663          	bnez	a4,11d00 <_fflush_r+0x20>
   11cf8:	00000513          	li	a0,0
   11cfc:	00008067          	ret
   11d00:	00078513          	mv	a0,a5
   11d04:	d81ff06f          	j	11a84 <__sflush_r>
   11d08:	fe010113          	addi	sp,sp,-32
   11d0c:	00b12623          	sw	a1,12(sp)
   11d10:	00112e23          	sw	ra,28(sp)
   11d14:	00a12423          	sw	a0,8(sp)
   11d18:	815fe0ef          	jal	1052c <__sinit>
   11d1c:	00c12583          	lw	a1,12(sp)
   11d20:	00812783          	lw	a5,8(sp)
   11d24:	00c59703          	lh	a4,12(a1)
   11d28:	00070a63          	beqz	a4,11d3c <_fflush_r+0x5c>
   11d2c:	01c12083          	lw	ra,28(sp)
   11d30:	00078513          	mv	a0,a5
   11d34:	02010113          	addi	sp,sp,32
   11d38:	d4dff06f          	j	11a84 <__sflush_r>
   11d3c:	01c12083          	lw	ra,28(sp)
   11d40:	00000513          	li	a0,0
   11d44:	02010113          	addi	sp,sp,32
   11d48:	00008067          	ret

00011d4c <fflush>:
   11d4c:	06050063          	beqz	a0,11dac <fflush+0x60>
   11d50:	00050593          	mv	a1,a0
   11d54:	d5c1a503          	lw	a0,-676(gp) # 1363c <_impure_ptr>
   11d58:	00050663          	beqz	a0,11d64 <fflush+0x18>
   11d5c:	03452783          	lw	a5,52(a0)
   11d60:	00078c63          	beqz	a5,11d78 <fflush+0x2c>
   11d64:	00c59783          	lh	a5,12(a1)
   11d68:	00079663          	bnez	a5,11d74 <fflush+0x28>
   11d6c:	00000513          	li	a0,0
   11d70:	00008067          	ret
   11d74:	d11ff06f          	j	11a84 <__sflush_r>
   11d78:	fe010113          	addi	sp,sp,-32
   11d7c:	00b12623          	sw	a1,12(sp)
   11d80:	00a12423          	sw	a0,8(sp)
   11d84:	00112e23          	sw	ra,28(sp)
   11d88:	fa4fe0ef          	jal	1052c <__sinit>
   11d8c:	00c12583          	lw	a1,12(sp)
   11d90:	00812503          	lw	a0,8(sp)
   11d94:	00c59783          	lh	a5,12(a1)
   11d98:	02079863          	bnez	a5,11dc8 <fflush+0x7c>
   11d9c:	01c12083          	lw	ra,28(sp)
   11da0:	00000513          	li	a0,0
   11da4:	02010113          	addi	sp,sp,32
   11da8:	00008067          	ret
   11dac:	00013637          	lui	a2,0x13
   11db0:	000125b7          	lui	a1,0x12
   11db4:	00013537          	lui	a0,0x13
   11db8:	0e060613          	addi	a2,a2,224 # 130e0 <__sglue>
   11dbc:	ce058593          	addi	a1,a1,-800 # 11ce0 <_fflush_r>
   11dc0:	0f050513          	addi	a0,a0,240 # 130f0 <_impure_data>
   11dc4:	fc4fe06f          	j	10588 <_fwalk_sglue>
   11dc8:	01c12083          	lw	ra,28(sp)
   11dcc:	02010113          	addi	sp,sp,32
   11dd0:	cb5ff06f          	j	11a84 <__sflush_r>

00011dd4 <_sbrk_r>:
   11dd4:	ff010113          	addi	sp,sp,-16
   11dd8:	00812423          	sw	s0,8(sp)
   11ddc:	00912223          	sw	s1,4(sp)
   11de0:	00050493          	mv	s1,a0
   11de4:	00058513          	mv	a0,a1
   11de8:	00112623          	sw	ra,12(sp)
   11dec:	d601a623          	sw	zero,-660(gp) # 1364c <errno>
   11df0:	220000ef          	jal	12010 <_sbrk>
   11df4:	fff00793          	li	a5,-1
   11df8:	00f50c63          	beq	a0,a5,11e10 <_sbrk_r+0x3c>
   11dfc:	00c12083          	lw	ra,12(sp)
   11e00:	00812403          	lw	s0,8(sp)
   11e04:	00412483          	lw	s1,4(sp)
   11e08:	01010113          	addi	sp,sp,16
   11e0c:	00008067          	ret
   11e10:	d6c1a783          	lw	a5,-660(gp) # 1364c <errno>
   11e14:	fe0784e3          	beqz	a5,11dfc <_sbrk_r+0x28>
   11e18:	00c12083          	lw	ra,12(sp)
   11e1c:	00812403          	lw	s0,8(sp)
   11e20:	00f4a023          	sw	a5,0(s1)
   11e24:	00412483          	lw	s1,4(sp)
   11e28:	01010113          	addi	sp,sp,16
   11e2c:	00008067          	ret

00011e30 <__libc_fini_array>:
   11e30:	ff010113          	addi	sp,sp,-16
   11e34:	00812423          	sw	s0,8(sp)
   11e38:	000137b7          	lui	a5,0x13
   11e3c:	00013437          	lui	s0,0x13
   11e40:	0e078793          	addi	a5,a5,224 # 130e0 <__sglue>
   11e44:	0dc40413          	addi	s0,s0,220 # 130dc <__do_global_dtors_aux_fini_array_entry>
   11e48:	408787b3          	sub	a5,a5,s0
   11e4c:	00912223          	sw	s1,4(sp)
   11e50:	00112623          	sw	ra,12(sp)
   11e54:	4027d493          	srai	s1,a5,0x2
   11e58:	02048063          	beqz	s1,11e78 <__libc_fini_array+0x48>
   11e5c:	ffc40413          	addi	s0,s0,-4
   11e60:	00f40433          	add	s0,s0,a5
   11e64:	00042783          	lw	a5,0(s0)
   11e68:	fff48493          	addi	s1,s1,-1
   11e6c:	ffc40413          	addi	s0,s0,-4
   11e70:	000780e7          	jalr	a5
   11e74:	fe0498e3          	bnez	s1,11e64 <__libc_fini_array+0x34>
   11e78:	00c12083          	lw	ra,12(sp)
   11e7c:	00812403          	lw	s0,8(sp)
   11e80:	00412483          	lw	s1,4(sp)
   11e84:	01010113          	addi	sp,sp,16
   11e88:	00008067          	ret

00011e8c <__register_exitproc>:
   11e8c:	d701a783          	lw	a5,-656(gp) # 13650 <__atexit>
   11e90:	04078c63          	beqz	a5,11ee8 <__register_exitproc+0x5c>
   11e94:	0047a703          	lw	a4,4(a5)
   11e98:	01f00813          	li	a6,31
   11e9c:	06e84e63          	blt	a6,a4,11f18 <__register_exitproc+0x8c>
   11ea0:	00271813          	slli	a6,a4,0x2
   11ea4:	02050663          	beqz	a0,11ed0 <__register_exitproc+0x44>
   11ea8:	01078333          	add	t1,a5,a6
   11eac:	08c32423          	sw	a2,136(t1)
   11eb0:	1887a883          	lw	a7,392(a5)
   11eb4:	00100613          	li	a2,1
   11eb8:	00e61633          	sll	a2,a2,a4
   11ebc:	00c8e8b3          	or	a7,a7,a2
   11ec0:	1917a423          	sw	a7,392(a5)
   11ec4:	10d32423          	sw	a3,264(t1)
   11ec8:	00200693          	li	a3,2
   11ecc:	02d50463          	beq	a0,a3,11ef4 <__register_exitproc+0x68>
   11ed0:	00170713          	addi	a4,a4,1
   11ed4:	00e7a223          	sw	a4,4(a5)
   11ed8:	010787b3          	add	a5,a5,a6
   11edc:	00b7a423          	sw	a1,8(a5)
   11ee0:	00000513          	li	a0,0
   11ee4:	00008067          	ret
   11ee8:	f0018793          	addi	a5,gp,-256 # 137e0 <__atexit0>
   11eec:	d6f1a823          	sw	a5,-656(gp) # 13650 <__atexit>
   11ef0:	fa5ff06f          	j	11e94 <__register_exitproc+0x8>
   11ef4:	18c7a683          	lw	a3,396(a5)
   11ef8:	00170713          	addi	a4,a4,1
   11efc:	00e7a223          	sw	a4,4(a5)
   11f00:	00c6e6b3          	or	a3,a3,a2
   11f04:	18d7a623          	sw	a3,396(a5)
   11f08:	010787b3          	add	a5,a5,a6
   11f0c:	00b7a423          	sw	a1,8(a5)
   11f10:	00000513          	li	a0,0
   11f14:	00008067          	ret
   11f18:	fff00513          	li	a0,-1
   11f1c:	00008067          	ret

00011f20 <_close>:
   11f20:	03900893          	li	a7,57
   11f24:	00000073          	ecall
   11f28:	00054463          	bltz	a0,11f30 <_close+0x10>
   11f2c:	00008067          	ret
   11f30:	fe010113          	addi	sp,sp,-32
   11f34:	00112e23          	sw	ra,28(sp)
   11f38:	00a12623          	sw	a0,12(sp)
   11f3c:	18c000ef          	jal	120c8 <__errno>
   11f40:	00c12783          	lw	a5,12(sp)
   11f44:	01c12083          	lw	ra,28(sp)
   11f48:	40f007b3          	neg	a5,a5
   11f4c:	00f52023          	sw	a5,0(a0)
   11f50:	fff00793          	li	a5,-1
   11f54:	00078513          	mv	a0,a5
   11f58:	02010113          	addi	sp,sp,32
   11f5c:	00008067          	ret

00011f60 <_exit>:
   11f60:	05d00893          	li	a7,93
   11f64:	00000073          	ecall
   11f68:	00054463          	bltz	a0,11f70 <_exit+0x10>
   11f6c:	0000006f          	j	11f6c <_exit+0xc>
   11f70:	fe010113          	addi	sp,sp,-32
   11f74:	00112e23          	sw	ra,28(sp)
   11f78:	00a12623          	sw	a0,12(sp)
   11f7c:	14c000ef          	jal	120c8 <__errno>
   11f80:	00c12783          	lw	a5,12(sp)
   11f84:	40f007b3          	neg	a5,a5
   11f88:	00f52023          	sw	a5,0(a0)
   11f8c:	0000006f          	j	11f8c <_exit+0x2c>

00011f90 <_lseek>:
   11f90:	03e00893          	li	a7,62
   11f94:	00000073          	ecall
   11f98:	00054463          	bltz	a0,11fa0 <_lseek+0x10>
   11f9c:	00008067          	ret
   11fa0:	fe010113          	addi	sp,sp,-32
   11fa4:	00112e23          	sw	ra,28(sp)
   11fa8:	00a12623          	sw	a0,12(sp)
   11fac:	11c000ef          	jal	120c8 <__errno>
   11fb0:	00c12783          	lw	a5,12(sp)
   11fb4:	01c12083          	lw	ra,28(sp)
   11fb8:	40f007b3          	neg	a5,a5
   11fbc:	00f52023          	sw	a5,0(a0)
   11fc0:	fff00793          	li	a5,-1
   11fc4:	00078513          	mv	a0,a5
   11fc8:	02010113          	addi	sp,sp,32
   11fcc:	00008067          	ret

00011fd0 <_read>:
   11fd0:	03f00893          	li	a7,63
   11fd4:	00000073          	ecall
   11fd8:	00054463          	bltz	a0,11fe0 <_read+0x10>
   11fdc:	00008067          	ret
   11fe0:	fe010113          	addi	sp,sp,-32
   11fe4:	00112e23          	sw	ra,28(sp)
   11fe8:	00a12623          	sw	a0,12(sp)
   11fec:	0dc000ef          	jal	120c8 <__errno>
   11ff0:	00c12783          	lw	a5,12(sp)
   11ff4:	01c12083          	lw	ra,28(sp)
   11ff8:	40f007b3          	neg	a5,a5
   11ffc:	00f52023          	sw	a5,0(a0)
   12000:	fff00793          	li	a5,-1
   12004:	00078513          	mv	a0,a5
   12008:	02010113          	addi	sp,sp,32
   1200c:	00008067          	ret

00012010 <_sbrk>:
   12010:	d801a783          	lw	a5,-640(gp) # 13660 <heap_end.0>
   12014:	ff010113          	addi	sp,sp,-16
   12018:	00112623          	sw	ra,12(sp)
   1201c:	00050713          	mv	a4,a0
   12020:	02079063          	bnez	a5,12040 <_sbrk+0x30>
   12024:	0d600893          	li	a7,214
   12028:	00000513          	li	a0,0
   1202c:	00000073          	ecall
   12030:	fff00793          	li	a5,-1
   12034:	02f50c63          	beq	a0,a5,1206c <_sbrk+0x5c>
   12038:	00050793          	mv	a5,a0
   1203c:	d8a1a023          	sw	a0,-640(gp) # 13660 <heap_end.0>
   12040:	00f70533          	add	a0,a4,a5
   12044:	0d600893          	li	a7,214
   12048:	00000073          	ecall
   1204c:	d801a783          	lw	a5,-640(gp) # 13660 <heap_end.0>
   12050:	00f70733          	add	a4,a4,a5
   12054:	00e51c63          	bne	a0,a4,1206c <_sbrk+0x5c>
   12058:	00c12083          	lw	ra,12(sp)
   1205c:	d8a1a023          	sw	a0,-640(gp) # 13660 <heap_end.0>
   12060:	00078513          	mv	a0,a5
   12064:	01010113          	addi	sp,sp,16
   12068:	00008067          	ret
   1206c:	05c000ef          	jal	120c8 <__errno>
   12070:	00c12083          	lw	ra,12(sp)
   12074:	00c00793          	li	a5,12
   12078:	00f52023          	sw	a5,0(a0)
   1207c:	fff00513          	li	a0,-1
   12080:	01010113          	addi	sp,sp,16
   12084:	00008067          	ret

00012088 <_write>:
   12088:	04000893          	li	a7,64
   1208c:	00000073          	ecall
   12090:	00054463          	bltz	a0,12098 <_write+0x10>
   12094:	00008067          	ret
   12098:	fe010113          	addi	sp,sp,-32
   1209c:	00112e23          	sw	ra,28(sp)
   120a0:	00a12623          	sw	a0,12(sp)
   120a4:	024000ef          	jal	120c8 <__errno>
   120a8:	00c12783          	lw	a5,12(sp)
   120ac:	01c12083          	lw	ra,28(sp)
   120b0:	40f007b3          	neg	a5,a5
   120b4:	00f52023          	sw	a5,0(a0)
   120b8:	fff00793          	li	a5,-1
   120bc:	00078513          	mv	a0,a5
   120c0:	02010113          	addi	sp,sp,32
   120c4:	00008067          	ret

000120c8 <__errno>:
   120c8:	d5c1a503          	lw	a0,-676(gp) # 1363c <_impure_ptr>
   120cc:	00008067          	ret
