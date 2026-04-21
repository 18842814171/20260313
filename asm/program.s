
out/program:     file format elf32-littleriscv


Disassembly of section .text:

000100b4 <exit>:
   100b4:	ff010113          	addi	sp,sp,-16
   100b8:	00000593          	li	a1,0
   100bc:	00812423          	sw	s0,8(sp)
   100c0:	00112623          	sw	ra,12(sp)
   100c4:	00050413          	mv	s0,a0
   100c8:	29d000ef          	jal	10b64 <__call_exitprocs>
   100cc:	d681a783          	lw	a5,-664(gp) # 13630 <__stdio_exit_handler>
   100d0:	00078463          	beqz	a5,100d8 <exit+0x24>
   100d4:	000780e7          	jalr	a5
   100d8:	00040513          	mv	a0,s0
   100dc:	66d010ef          	jal	11f48 <_exit>

000100e0 <register_fini>:
   100e0:	00000793          	li	a5,0
   100e4:	00078863          	beqz	a5,100f4 <register_fini+0x14>
   100e8:	00012537          	lui	a0,0x12
   100ec:	e1850513          	addi	a0,a0,-488 # 11e18 <__libc_fini_array>
   100f0:	3c50006f          	j	10cb4 <atexit>
   100f4:	00008067          	ret

000100f8 <_start>:
   100f8:	00003197          	auipc	gp,0x3
   100fc:	7d018193          	addi	gp,gp,2000 # 138c8 <__global_pointer$>
   10100:	00000513          	li	a0,0
   10104:	00050463          	beqz	a0,1010c <_start+0x14>
   10108:	01751073          	csrw	jvt,a0
   1010c:	00003517          	auipc	a0,0x3
   10110:	52450513          	addi	a0,a0,1316 # 13630 <__stdio_exit_handler>
   10114:	00004617          	auipc	a2,0x4
   10118:	84460613          	addi	a2,a2,-1980 # 13958 <__BSS_END__>
   1011c:	40a60633          	sub	a2,a2,a0
   10120:	00000593          	li	a1,0
   10124:	165000ef          	jal	10a88 <memset>
   10128:	00001517          	auipc	a0,0x1
   1012c:	b8c50513          	addi	a0,a0,-1140 # 10cb4 <atexit>
   10130:	00050863          	beqz	a0,10140 <_start+0x48>
   10134:	00002517          	auipc	a0,0x2
   10138:	ce450513          	addi	a0,a0,-796 # 11e18 <__libc_fini_array>
   1013c:	379000ef          	jal	10cb4 <atexit>
   10140:	0b5000ef          	jal	109f4 <__libc_init_array>
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
   10168:	d841c783          	lbu	a5,-636(gp) # 1364c <completed.1>
   1016c:	00112623          	sw	ra,12(sp)
   10170:	02079263          	bnez	a5,10194 <__do_global_dtors_aux+0x34>
   10174:	00000793          	li	a5,0
   10178:	00078a63          	beqz	a5,1018c <__do_global_dtors_aux+0x2c>
   1017c:	00012537          	lui	a0,0x12
   10180:	0b850513          	addi	a0,a0,184 # 120b8 <__EH_FRAME_BEGIN__>
   10184:	00000097          	auipc	ra,0x0
   10188:	000000e7          	jalr	zero # 0 <exit-0x100b4>
   1018c:	00100793          	li	a5,1
   10190:	d8f18223          	sb	a5,-636(gp) # 1364c <completed.1>
   10194:	00c12083          	lw	ra,12(sp)
   10198:	00812403          	lw	s0,8(sp)
   1019c:	01010113          	addi	sp,sp,16
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	00000793          	li	a5,0
   101a8:	00078c63          	beqz	a5,101c0 <frame_dummy+0x1c>
   101ac:	00012537          	lui	a0,0x12
   101b0:	d8818593          	addi	a1,gp,-632 # 13650 <object.0>
   101b4:	0b850513          	addi	a0,a0,184 # 120b8 <__EH_FRAME_BEGIN__>
   101b8:	00000317          	auipc	t1,0x0
   101bc:	00000067          	jr	zero # 0 <exit-0x100b4>
   101c0:	00008067          	ret

000101c4 <main>:
   101c4:	fe010113          	addi	sp,sp,-32
   101c8:	00112e23          	sw	ra,28(sp)
   101cc:	00812c23          	sw	s0,24(sp)
   101d0:	02010413          	addi	s0,sp,32
   101d4:	00500793          	li	a5,5
   101d8:	fef42623          	sw	a5,-20(s0)
   101dc:	00300793          	li	a5,3
   101e0:	fef42423          	sw	a5,-24(s0)
   101e4:	fec42703          	lw	a4,-20(s0)
   101e8:	fe842783          	lw	a5,-24(s0)
   101ec:	00f707b3          	add	a5,a4,a5
   101f0:	fef42223          	sw	a5,-28(s0)
   101f4:	05d00893          	li	a7,93
   101f8:	00800513          	li	a0,8
   101fc:	00000073          	ecall
   10200:	0000006f          	j	10200 <main+0x3c>

00010204 <__fp_lock>:
   10204:	00000513          	li	a0,0
   10208:	00008067          	ret

0001020c <stdio_exit_handler>:
   1020c:	00013637          	lui	a2,0x13
   10210:	000125b7          	lui	a1,0x12
   10214:	00013537          	lui	a0,0x13
   10218:	0c860613          	addi	a2,a2,200 # 130c8 <__sglue>
   1021c:	95858593          	addi	a1,a1,-1704 # 11958 <_fclose_r>
   10220:	0d850513          	addi	a0,a0,216 # 130d8 <_impure_data>
   10224:	34c0006f          	j	10570 <_fwalk_sglue>

00010228 <cleanup_stdio>:
   10228:	00452583          	lw	a1,4(a0)
   1022c:	ff010113          	addi	sp,sp,-16
   10230:	00812423          	sw	s0,8(sp)
   10234:	00112623          	sw	ra,12(sp)
   10238:	da018793          	addi	a5,gp,-608 # 13668 <__sf>
   1023c:	00050413          	mv	s0,a0
   10240:	00f58463          	beq	a1,a5,10248 <cleanup_stdio+0x20>
   10244:	714010ef          	jal	11958 <_fclose_r>
   10248:	00842583          	lw	a1,8(s0)
   1024c:	e0818793          	addi	a5,gp,-504 # 136d0 <__sf+0x68>
   10250:	00f58663          	beq	a1,a5,1025c <cleanup_stdio+0x34>
   10254:	00040513          	mv	a0,s0
   10258:	700010ef          	jal	11958 <_fclose_r>
   1025c:	00c42583          	lw	a1,12(s0)
   10260:	e7018793          	addi	a5,gp,-400 # 13738 <__sf+0xd0>
   10264:	00f58c63          	beq	a1,a5,1027c <cleanup_stdio+0x54>
   10268:	00040513          	mv	a0,s0
   1026c:	00812403          	lw	s0,8(sp)
   10270:	00c12083          	lw	ra,12(sp)
   10274:	01010113          	addi	sp,sp,16
   10278:	6e00106f          	j	11958 <_fclose_r>
   1027c:	00c12083          	lw	ra,12(sp)
   10280:	00812403          	lw	s0,8(sp)
   10284:	01010113          	addi	sp,sp,16
   10288:	00008067          	ret

0001028c <__fp_unlock>:
   1028c:	00000513          	li	a0,0
   10290:	00008067          	ret

00010294 <global_stdio_init.part.0>:
   10294:	fe010113          	addi	sp,sp,-32
   10298:	000107b7          	lui	a5,0x10
   1029c:	00812c23          	sw	s0,24(sp)
   102a0:	20c78793          	addi	a5,a5,524 # 1020c <stdio_exit_handler>
   102a4:	da018413          	addi	s0,gp,-608 # 13668 <__sf>
   102a8:	00112e23          	sw	ra,28(sp)
   102ac:	00912a23          	sw	s1,20(sp)
   102b0:	01212823          	sw	s2,16(sp)
   102b4:	01312623          	sw	s3,12(sp)
   102b8:	01412423          	sw	s4,8(sp)
   102bc:	d6f1a423          	sw	a5,-664(gp) # 13630 <__stdio_exit_handler>
   102c0:	00800613          	li	a2,8
   102c4:	00400793          	li	a5,4
   102c8:	00000593          	li	a1,0
   102cc:	dfc18513          	addi	a0,gp,-516 # 136c4 <__sf+0x5c>
   102d0:	00f42623          	sw	a5,12(s0)
   102d4:	00042023          	sw	zero,0(s0)
   102d8:	00042223          	sw	zero,4(s0)
   102dc:	00042423          	sw	zero,8(s0)
   102e0:	06042223          	sw	zero,100(s0)
   102e4:	00042823          	sw	zero,16(s0)
   102e8:	00042a23          	sw	zero,20(s0)
   102ec:	00042c23          	sw	zero,24(s0)
   102f0:	798000ef          	jal	10a88 <memset>
   102f4:	00010a37          	lui	s4,0x10
   102f8:	000109b7          	lui	s3,0x10
   102fc:	00010937          	lui	s2,0x10
   10300:	000104b7          	lui	s1,0x10
   10304:	000107b7          	lui	a5,0x10
   10308:	624a0a13          	addi	s4,s4,1572 # 10624 <__sread>
   1030c:	68898993          	addi	s3,s3,1672 # 10688 <__swrite>
   10310:	71090913          	addi	s2,s2,1808 # 10710 <__sseek>
   10314:	77448493          	addi	s1,s1,1908 # 10774 <__sclose>
   10318:	00978793          	addi	a5,a5,9 # 10009 <exit-0xab>
   1031c:	00800613          	li	a2,8
   10320:	00000593          	li	a1,0
   10324:	e6418513          	addi	a0,gp,-412 # 1372c <__sf+0xc4>
   10328:	06f42a23          	sw	a5,116(s0)
   1032c:	03442023          	sw	s4,32(s0)
   10330:	03342223          	sw	s3,36(s0)
   10334:	03242423          	sw	s2,40(s0)
   10338:	02942623          	sw	s1,44(s0)
   1033c:	00842e23          	sw	s0,28(s0)
   10340:	06042423          	sw	zero,104(s0)
   10344:	06042623          	sw	zero,108(s0)
   10348:	06042823          	sw	zero,112(s0)
   1034c:	0c042623          	sw	zero,204(s0)
   10350:	06042c23          	sw	zero,120(s0)
   10354:	06042e23          	sw	zero,124(s0)
   10358:	08042023          	sw	zero,128(s0)
   1035c:	72c000ef          	jal	10a88 <memset>
   10360:	000207b7          	lui	a5,0x20
   10364:	01278793          	addi	a5,a5,18 # 20012 <__BSS_END__+0xc6ba>
   10368:	e0818713          	addi	a4,gp,-504 # 136d0 <__sf+0x68>
   1036c:	ecc18513          	addi	a0,gp,-308 # 13794 <__sf+0x12c>
   10370:	00800613          	li	a2,8
   10374:	00000593          	li	a1,0
   10378:	09442423          	sw	s4,136(s0)
   1037c:	09342623          	sw	s3,140(s0)
   10380:	09242823          	sw	s2,144(s0)
   10384:	08942a23          	sw	s1,148(s0)
   10388:	0cf42e23          	sw	a5,220(s0)
   1038c:	0c042823          	sw	zero,208(s0)
   10390:	0c042a23          	sw	zero,212(s0)
   10394:	0c042c23          	sw	zero,216(s0)
   10398:	12042a23          	sw	zero,308(s0)
   1039c:	0e042023          	sw	zero,224(s0)
   103a0:	0e042223          	sw	zero,228(s0)
   103a4:	0e042423          	sw	zero,232(s0)
   103a8:	08e42223          	sw	a4,132(s0)
   103ac:	6dc000ef          	jal	10a88 <memset>
   103b0:	e7018793          	addi	a5,gp,-400 # 13738 <__sf+0xd0>
   103b4:	0f442823          	sw	s4,240(s0)
   103b8:	0f342a23          	sw	s3,244(s0)
   103bc:	0f242c23          	sw	s2,248(s0)
   103c0:	0e942e23          	sw	s1,252(s0)
   103c4:	01c12083          	lw	ra,28(sp)
   103c8:	0ef42623          	sw	a5,236(s0)
   103cc:	01812403          	lw	s0,24(sp)
   103d0:	01412483          	lw	s1,20(sp)
   103d4:	01012903          	lw	s2,16(sp)
   103d8:	00c12983          	lw	s3,12(sp)
   103dc:	00812a03          	lw	s4,8(sp)
   103e0:	02010113          	addi	sp,sp,32
   103e4:	00008067          	ret

000103e8 <__sfp>:
   103e8:	d681a783          	lw	a5,-664(gp) # 13630 <__stdio_exit_handler>
   103ec:	fe010113          	addi	sp,sp,-32
   103f0:	00912a23          	sw	s1,20(sp)
   103f4:	00112e23          	sw	ra,28(sp)
   103f8:	00812c23          	sw	s0,24(sp)
   103fc:	00050493          	mv	s1,a0
   10400:	0e078e63          	beqz	a5,104fc <__sfp+0x114>
   10404:	00013837          	lui	a6,0x13
   10408:	0c880813          	addi	a6,a6,200 # 130c8 <__sglue>
   1040c:	fff00693          	li	a3,-1
   10410:	00482783          	lw	a5,4(a6)
   10414:	fff78793          	addi	a5,a5,-1
   10418:	0807c063          	bltz	a5,10498 <__sfp+0xb0>
   1041c:	00882403          	lw	s0,8(a6)
   10420:	00c0006f          	j	1042c <__sfp+0x44>
   10424:	06840413          	addi	s0,s0,104
   10428:	06d78863          	beq	a5,a3,10498 <__sfp+0xb0>
   1042c:	00c41703          	lh	a4,12(s0)
   10430:	fff78793          	addi	a5,a5,-1
   10434:	fe0718e3          	bnez	a4,10424 <__sfp+0x3c>
   10438:	ffff07b7          	lui	a5,0xffff0
   1043c:	00178793          	addi	a5,a5,1 # ffff0001 <__BSS_END__+0xfffdc6a9>
   10440:	00f42623          	sw	a5,12(s0)
   10444:	06042223          	sw	zero,100(s0)
   10448:	00042023          	sw	zero,0(s0)
   1044c:	00042423          	sw	zero,8(s0)
   10450:	00042223          	sw	zero,4(s0)
   10454:	00042823          	sw	zero,16(s0)
   10458:	00042a23          	sw	zero,20(s0)
   1045c:	00042c23          	sw	zero,24(s0)
   10460:	00800613          	li	a2,8
   10464:	00000593          	li	a1,0
   10468:	05c40513          	addi	a0,s0,92
   1046c:	61c000ef          	jal	10a88 <memset>
   10470:	02042823          	sw	zero,48(s0)
   10474:	02042a23          	sw	zero,52(s0)
   10478:	04042223          	sw	zero,68(s0)
   1047c:	04042423          	sw	zero,72(s0)
   10480:	01c12083          	lw	ra,28(sp)
   10484:	00040513          	mv	a0,s0
   10488:	01812403          	lw	s0,24(sp)
   1048c:	01412483          	lw	s1,20(sp)
   10490:	02010113          	addi	sp,sp,32
   10494:	00008067          	ret
   10498:	00082403          	lw	s0,0(a6)
   1049c:	00040663          	beqz	s0,104a8 <__sfp+0xc0>
   104a0:	00040813          	mv	a6,s0
   104a4:	f6dff06f          	j	10410 <__sfp+0x28>
   104a8:	1ac00593          	li	a1,428
   104ac:	00048513          	mv	a0,s1
   104b0:	01012623          	sw	a6,12(sp)
   104b4:	421000ef          	jal	110d4 <_malloc_r>
   104b8:	00c12803          	lw	a6,12(sp)
   104bc:	00050413          	mv	s0,a0
   104c0:	04050263          	beqz	a0,10504 <__sfp+0x11c>
   104c4:	00400793          	li	a5,4
   104c8:	00f52223          	sw	a5,4(a0)
   104cc:	00c50513          	addi	a0,a0,12
   104d0:	00042023          	sw	zero,0(s0)
   104d4:	00a42423          	sw	a0,8(s0)
   104d8:	1a000613          	li	a2,416
   104dc:	00000593          	li	a1,0
   104e0:	01012623          	sw	a6,12(sp)
   104e4:	5a4000ef          	jal	10a88 <memset>
   104e8:	00c12803          	lw	a6,12(sp)
   104ec:	fff00693          	li	a3,-1
   104f0:	00882023          	sw	s0,0(a6)
   104f4:	00040813          	mv	a6,s0
   104f8:	f19ff06f          	j	10410 <__sfp+0x28>
   104fc:	d99ff0ef          	jal	10294 <global_stdio_init.part.0>
   10500:	f05ff06f          	j	10404 <__sfp+0x1c>
   10504:	00082023          	sw	zero,0(a6)
   10508:	00c00793          	li	a5,12
   1050c:	00f4a023          	sw	a5,0(s1)
   10510:	f71ff06f          	j	10480 <__sfp+0x98>

00010514 <__sinit>:
   10514:	03452783          	lw	a5,52(a0)
   10518:	00078463          	beqz	a5,10520 <__sinit+0xc>
   1051c:	00008067          	ret
   10520:	000107b7          	lui	a5,0x10
   10524:	d681a703          	lw	a4,-664(gp) # 13630 <__stdio_exit_handler>
   10528:	22878793          	addi	a5,a5,552 # 10228 <cleanup_stdio>
   1052c:	02f52a23          	sw	a5,52(a0)
   10530:	fe0716e3          	bnez	a4,1051c <__sinit+0x8>
   10534:	d61ff06f          	j	10294 <global_stdio_init.part.0>

00010538 <__sfp_lock_acquire>:
   10538:	00008067          	ret

0001053c <__sfp_lock_release>:
   1053c:	00008067          	ret

00010540 <__fp_lock_all>:
   10540:	00013637          	lui	a2,0x13
   10544:	000105b7          	lui	a1,0x10
   10548:	0c860613          	addi	a2,a2,200 # 130c8 <__sglue>
   1054c:	20458593          	addi	a1,a1,516 # 10204 <__fp_lock>
   10550:	00000513          	li	a0,0
   10554:	01c0006f          	j	10570 <_fwalk_sglue>

00010558 <__fp_unlock_all>:
   10558:	00013637          	lui	a2,0x13
   1055c:	000105b7          	lui	a1,0x10
   10560:	0c860613          	addi	a2,a2,200 # 130c8 <__sglue>
   10564:	28c58593          	addi	a1,a1,652 # 1028c <__fp_unlock>
   10568:	00000513          	li	a0,0
   1056c:	0040006f          	j	10570 <_fwalk_sglue>

00010570 <_fwalk_sglue>:
   10570:	fd010113          	addi	sp,sp,-48
   10574:	03212023          	sw	s2,32(sp)
   10578:	01312e23          	sw	s3,28(sp)
   1057c:	01412c23          	sw	s4,24(sp)
   10580:	01512a23          	sw	s5,20(sp)
   10584:	01612823          	sw	s6,16(sp)
   10588:	01712623          	sw	s7,12(sp)
   1058c:	02112623          	sw	ra,44(sp)
   10590:	02812423          	sw	s0,40(sp)
   10594:	02912223          	sw	s1,36(sp)
   10598:	00060a93          	mv	s5,a2
   1059c:	00050b13          	mv	s6,a0
   105a0:	00058b93          	mv	s7,a1
   105a4:	00000a13          	li	s4,0
   105a8:	00100993          	li	s3,1
   105ac:	fff00913          	li	s2,-1
   105b0:	004aa483          	lw	s1,4(s5)
   105b4:	fff48493          	addi	s1,s1,-1
   105b8:	0204ca63          	bltz	s1,105ec <_fwalk_sglue+0x7c>
   105bc:	008aa403          	lw	s0,8(s5)
   105c0:	00c45783          	lhu	a5,12(s0)
   105c4:	00f9fe63          	bgeu	s3,a5,105e0 <_fwalk_sglue+0x70>
   105c8:	00e41783          	lh	a5,14(s0)
   105cc:	00040593          	mv	a1,s0
   105d0:	000b0513          	mv	a0,s6
   105d4:	01278663          	beq	a5,s2,105e0 <_fwalk_sglue+0x70>
   105d8:	000b80e7          	jalr	s7
   105dc:	00aa6a33          	or	s4,s4,a0
   105e0:	fff48493          	addi	s1,s1,-1
   105e4:	06840413          	addi	s0,s0,104
   105e8:	fd249ce3          	bne	s1,s2,105c0 <_fwalk_sglue+0x50>
   105ec:	000aaa83          	lw	s5,0(s5)
   105f0:	fc0a90e3          	bnez	s5,105b0 <_fwalk_sglue+0x40>
   105f4:	02c12083          	lw	ra,44(sp)
   105f8:	02812403          	lw	s0,40(sp)
   105fc:	02412483          	lw	s1,36(sp)
   10600:	02012903          	lw	s2,32(sp)
   10604:	01c12983          	lw	s3,28(sp)
   10608:	01412a83          	lw	s5,20(sp)
   1060c:	01012b03          	lw	s6,16(sp)
   10610:	00c12b83          	lw	s7,12(sp)
   10614:	000a0513          	mv	a0,s4
   10618:	01812a03          	lw	s4,24(sp)
   1061c:	03010113          	addi	sp,sp,48
   10620:	00008067          	ret

00010624 <__sread>:
   10624:	ff010113          	addi	sp,sp,-16
   10628:	00812423          	sw	s0,8(sp)
   1062c:	00058413          	mv	s0,a1
   10630:	00e59583          	lh	a1,14(a1)
   10634:	00112623          	sw	ra,12(sp)
   10638:	2ec000ef          	jal	10924 <_read_r>
   1063c:	02054063          	bltz	a0,1065c <__sread+0x38>
   10640:	05042783          	lw	a5,80(s0)
   10644:	00c12083          	lw	ra,12(sp)
   10648:	00a787b3          	add	a5,a5,a0
   1064c:	04f42823          	sw	a5,80(s0)
   10650:	00812403          	lw	s0,8(sp)
   10654:	01010113          	addi	sp,sp,16
   10658:	00008067          	ret
   1065c:	00c45783          	lhu	a5,12(s0)
   10660:	fffff737          	lui	a4,0xfffff
   10664:	fff70713          	addi	a4,a4,-1 # ffffefff <__BSS_END__+0xfffeb6a7>
   10668:	00e7f7b3          	and	a5,a5,a4
   1066c:	00c12083          	lw	ra,12(sp)
   10670:	00f41623          	sh	a5,12(s0)
   10674:	00812403          	lw	s0,8(sp)
   10678:	01010113          	addi	sp,sp,16
   1067c:	00008067          	ret

00010680 <__seofread>:
   10680:	00000513          	li	a0,0
   10684:	00008067          	ret

00010688 <__swrite>:
   10688:	00c59783          	lh	a5,12(a1)
   1068c:	fe010113          	addi	sp,sp,-32
   10690:	00068313          	mv	t1,a3
   10694:	00112e23          	sw	ra,28(sp)
   10698:	1007f693          	andi	a3,a5,256
   1069c:	00058713          	mv	a4,a1
   106a0:	00060893          	mv	a7,a2
   106a4:	00050813          	mv	a6,a0
   106a8:	02069863          	bnez	a3,106d8 <__swrite+0x50>
   106ac:	fffff6b7          	lui	a3,0xfffff
   106b0:	fff68693          	addi	a3,a3,-1 # ffffefff <__BSS_END__+0xfffeb6a7>
   106b4:	01c12083          	lw	ra,28(sp)
   106b8:	00d7f7b3          	and	a5,a5,a3
   106bc:	00e71583          	lh	a1,14(a4)
   106c0:	00f71623          	sh	a5,12(a4)
   106c4:	00030693          	mv	a3,t1
   106c8:	00088613          	mv	a2,a7
   106cc:	00080513          	mv	a0,a6
   106d0:	02010113          	addi	sp,sp,32
   106d4:	2b80006f          	j	1098c <_write_r>
   106d8:	00e59583          	lh	a1,14(a1)
   106dc:	00c12423          	sw	a2,8(sp)
   106e0:	00200693          	li	a3,2
   106e4:	00000613          	li	a2,0
   106e8:	00612623          	sw	t1,12(sp)
   106ec:	00e12023          	sw	a4,0(sp)
   106f0:	00a12223          	sw	a0,4(sp)
   106f4:	1c8000ef          	jal	108bc <_lseek_r>
   106f8:	00012703          	lw	a4,0(sp)
   106fc:	00c12303          	lw	t1,12(sp)
   10700:	00812883          	lw	a7,8(sp)
   10704:	00c71783          	lh	a5,12(a4)
   10708:	00412803          	lw	a6,4(sp)
   1070c:	fa1ff06f          	j	106ac <__swrite+0x24>

00010710 <__sseek>:
   10710:	ff010113          	addi	sp,sp,-16
   10714:	00812423          	sw	s0,8(sp)
   10718:	00058413          	mv	s0,a1
   1071c:	00e59583          	lh	a1,14(a1)
   10720:	00112623          	sw	ra,12(sp)
   10724:	198000ef          	jal	108bc <_lseek_r>
   10728:	fff00713          	li	a4,-1
   1072c:	00c41783          	lh	a5,12(s0)
   10730:	02e50263          	beq	a0,a4,10754 <__sseek+0x44>
   10734:	00001737          	lui	a4,0x1
   10738:	00e7e7b3          	or	a5,a5,a4
   1073c:	00c12083          	lw	ra,12(sp)
   10740:	04a42823          	sw	a0,80(s0)
   10744:	00f41623          	sh	a5,12(s0)
   10748:	00812403          	lw	s0,8(sp)
   1074c:	01010113          	addi	sp,sp,16
   10750:	00008067          	ret
   10754:	80050713          	addi	a4,a0,-2048
   10758:	80070713          	addi	a4,a4,-2048 # 800 <exit-0xf8b4>
   1075c:	00e7f7b3          	and	a5,a5,a4
   10760:	00c12083          	lw	ra,12(sp)
   10764:	00f41623          	sh	a5,12(s0)
   10768:	00812403          	lw	s0,8(sp)
   1076c:	01010113          	addi	sp,sp,16
   10770:	00008067          	ret

00010774 <__sclose>:
   10774:	00e59583          	lh	a1,14(a1)
   10778:	0040006f          	j	1077c <_close_r>

0001077c <_close_r>:
   1077c:	ff010113          	addi	sp,sp,-16
   10780:	00812423          	sw	s0,8(sp)
   10784:	00912223          	sw	s1,4(sp)
   10788:	00050493          	mv	s1,a0
   1078c:	00058513          	mv	a0,a1
   10790:	00112623          	sw	ra,12(sp)
   10794:	d601a623          	sw	zero,-660(gp) # 13634 <errno>
   10798:	770010ef          	jal	11f08 <_close>
   1079c:	fff00793          	li	a5,-1
   107a0:	00f50c63          	beq	a0,a5,107b8 <_close_r+0x3c>
   107a4:	00c12083          	lw	ra,12(sp)
   107a8:	00812403          	lw	s0,8(sp)
   107ac:	00412483          	lw	s1,4(sp)
   107b0:	01010113          	addi	sp,sp,16
   107b4:	00008067          	ret
   107b8:	d6c1a783          	lw	a5,-660(gp) # 13634 <errno>
   107bc:	fe0784e3          	beqz	a5,107a4 <_close_r+0x28>
   107c0:	00c12083          	lw	ra,12(sp)
   107c4:	00812403          	lw	s0,8(sp)
   107c8:	00f4a023          	sw	a5,0(s1)
   107cc:	00412483          	lw	s1,4(sp)
   107d0:	01010113          	addi	sp,sp,16
   107d4:	00008067          	ret

000107d8 <_reclaim_reent>:
   107d8:	d5c1a783          	lw	a5,-676(gp) # 13624 <_impure_ptr>
   107dc:	0ca78e63          	beq	a5,a0,108b8 <_reclaim_reent+0xe0>
   107e0:	04452583          	lw	a1,68(a0)
   107e4:	fe010113          	addi	sp,sp,-32
   107e8:	00912a23          	sw	s1,20(sp)
   107ec:	00112e23          	sw	ra,28(sp)
   107f0:	00812c23          	sw	s0,24(sp)
   107f4:	00050493          	mv	s1,a0
   107f8:	04058863          	beqz	a1,10848 <_reclaim_reent+0x70>
   107fc:	01212823          	sw	s2,16(sp)
   10800:	01312623          	sw	s3,12(sp)
   10804:	00000913          	li	s2,0
   10808:	08000993          	li	s3,128
   1080c:	012587b3          	add	a5,a1,s2
   10810:	0007a403          	lw	s0,0(a5)
   10814:	00040e63          	beqz	s0,10830 <_reclaim_reent+0x58>
   10818:	00040593          	mv	a1,s0
   1081c:	00042403          	lw	s0,0(s0)
   10820:	00048513          	mv	a0,s1
   10824:	5c8000ef          	jal	10dec <_free_r>
   10828:	fe0418e3          	bnez	s0,10818 <_reclaim_reent+0x40>
   1082c:	0444a583          	lw	a1,68(s1)
   10830:	00490913          	addi	s2,s2,4
   10834:	fd391ce3          	bne	s2,s3,1080c <_reclaim_reent+0x34>
   10838:	00048513          	mv	a0,s1
   1083c:	5b0000ef          	jal	10dec <_free_r>
   10840:	01012903          	lw	s2,16(sp)
   10844:	00c12983          	lw	s3,12(sp)
   10848:	0384a583          	lw	a1,56(s1)
   1084c:	00058663          	beqz	a1,10858 <_reclaim_reent+0x80>
   10850:	00048513          	mv	a0,s1
   10854:	598000ef          	jal	10dec <_free_r>
   10858:	0404a403          	lw	s0,64(s1)
   1085c:	00040c63          	beqz	s0,10874 <_reclaim_reent+0x9c>
   10860:	00040593          	mv	a1,s0
   10864:	00042403          	lw	s0,0(s0)
   10868:	00048513          	mv	a0,s1
   1086c:	580000ef          	jal	10dec <_free_r>
   10870:	fe0418e3          	bnez	s0,10860 <_reclaim_reent+0x88>
   10874:	04c4a583          	lw	a1,76(s1)
   10878:	00058663          	beqz	a1,10884 <_reclaim_reent+0xac>
   1087c:	00048513          	mv	a0,s1
   10880:	56c000ef          	jal	10dec <_free_r>
   10884:	0344a783          	lw	a5,52(s1)
   10888:	00078e63          	beqz	a5,108a4 <_reclaim_reent+0xcc>
   1088c:	01812403          	lw	s0,24(sp)
   10890:	01c12083          	lw	ra,28(sp)
   10894:	00048513          	mv	a0,s1
   10898:	01412483          	lw	s1,20(sp)
   1089c:	02010113          	addi	sp,sp,32
   108a0:	00078067          	jr	a5
   108a4:	01c12083          	lw	ra,28(sp)
   108a8:	01812403          	lw	s0,24(sp)
   108ac:	01412483          	lw	s1,20(sp)
   108b0:	02010113          	addi	sp,sp,32
   108b4:	00008067          	ret
   108b8:	00008067          	ret

000108bc <_lseek_r>:
   108bc:	ff010113          	addi	sp,sp,-16
   108c0:	00058793          	mv	a5,a1
   108c4:	00812423          	sw	s0,8(sp)
   108c8:	00912223          	sw	s1,4(sp)
   108cc:	00060593          	mv	a1,a2
   108d0:	00050493          	mv	s1,a0
   108d4:	00068613          	mv	a2,a3
   108d8:	00078513          	mv	a0,a5
   108dc:	00112623          	sw	ra,12(sp)
   108e0:	d601a623          	sw	zero,-660(gp) # 13634 <errno>
   108e4:	694010ef          	jal	11f78 <_lseek>
   108e8:	fff00793          	li	a5,-1
   108ec:	00f50c63          	beq	a0,a5,10904 <_lseek_r+0x48>
   108f0:	00c12083          	lw	ra,12(sp)
   108f4:	00812403          	lw	s0,8(sp)
   108f8:	00412483          	lw	s1,4(sp)
   108fc:	01010113          	addi	sp,sp,16
   10900:	00008067          	ret
   10904:	d6c1a783          	lw	a5,-660(gp) # 13634 <errno>
   10908:	fe0784e3          	beqz	a5,108f0 <_lseek_r+0x34>
   1090c:	00c12083          	lw	ra,12(sp)
   10910:	00812403          	lw	s0,8(sp)
   10914:	00f4a023          	sw	a5,0(s1)
   10918:	00412483          	lw	s1,4(sp)
   1091c:	01010113          	addi	sp,sp,16
   10920:	00008067          	ret

00010924 <_read_r>:
   10924:	ff010113          	addi	sp,sp,-16
   10928:	00058793          	mv	a5,a1
   1092c:	00812423          	sw	s0,8(sp)
   10930:	00912223          	sw	s1,4(sp)
   10934:	00060593          	mv	a1,a2
   10938:	00050493          	mv	s1,a0
   1093c:	00068613          	mv	a2,a3
   10940:	00078513          	mv	a0,a5
   10944:	00112623          	sw	ra,12(sp)
   10948:	d601a623          	sw	zero,-660(gp) # 13634 <errno>
   1094c:	66c010ef          	jal	11fb8 <_read>
   10950:	fff00793          	li	a5,-1
   10954:	00f50c63          	beq	a0,a5,1096c <_read_r+0x48>
   10958:	00c12083          	lw	ra,12(sp)
   1095c:	00812403          	lw	s0,8(sp)
   10960:	00412483          	lw	s1,4(sp)
   10964:	01010113          	addi	sp,sp,16
   10968:	00008067          	ret
   1096c:	d6c1a783          	lw	a5,-660(gp) # 13634 <errno>
   10970:	fe0784e3          	beqz	a5,10958 <_read_r+0x34>
   10974:	00c12083          	lw	ra,12(sp)
   10978:	00812403          	lw	s0,8(sp)
   1097c:	00f4a023          	sw	a5,0(s1)
   10980:	00412483          	lw	s1,4(sp)
   10984:	01010113          	addi	sp,sp,16
   10988:	00008067          	ret

0001098c <_write_r>:
   1098c:	ff010113          	addi	sp,sp,-16
   10990:	00058793          	mv	a5,a1
   10994:	00812423          	sw	s0,8(sp)
   10998:	00912223          	sw	s1,4(sp)
   1099c:	00060593          	mv	a1,a2
   109a0:	00050493          	mv	s1,a0
   109a4:	00068613          	mv	a2,a3
   109a8:	00078513          	mv	a0,a5
   109ac:	00112623          	sw	ra,12(sp)
   109b0:	d601a623          	sw	zero,-660(gp) # 13634 <errno>
   109b4:	6bc010ef          	jal	12070 <_write>
   109b8:	fff00793          	li	a5,-1
   109bc:	00f50c63          	beq	a0,a5,109d4 <_write_r+0x48>
   109c0:	00c12083          	lw	ra,12(sp)
   109c4:	00812403          	lw	s0,8(sp)
   109c8:	00412483          	lw	s1,4(sp)
   109cc:	01010113          	addi	sp,sp,16
   109d0:	00008067          	ret
   109d4:	d6c1a783          	lw	a5,-660(gp) # 13634 <errno>
   109d8:	fe0784e3          	beqz	a5,109c0 <_write_r+0x34>
   109dc:	00c12083          	lw	ra,12(sp)
   109e0:	00812403          	lw	s0,8(sp)
   109e4:	00f4a023          	sw	a5,0(s1)
   109e8:	00412483          	lw	s1,4(sp)
   109ec:	01010113          	addi	sp,sp,16
   109f0:	00008067          	ret

000109f4 <__libc_init_array>:
   109f4:	ff010113          	addi	sp,sp,-16
   109f8:	00812423          	sw	s0,8(sp)
   109fc:	01212023          	sw	s2,0(sp)
   10a00:	00013437          	lui	s0,0x13
   10a04:	00013937          	lui	s2,0x13
   10a08:	00112623          	sw	ra,12(sp)
   10a0c:	00912223          	sw	s1,4(sp)
   10a10:	0bc90913          	addi	s2,s2,188 # 130bc <__init_array_start>
   10a14:	0bc40413          	addi	s0,s0,188 # 130bc <__init_array_start>
   10a18:	02890263          	beq	s2,s0,10a3c <__libc_init_array+0x48>
   10a1c:	40890933          	sub	s2,s2,s0
   10a20:	40295913          	srai	s2,s2,0x2
   10a24:	00000493          	li	s1,0
   10a28:	00042783          	lw	a5,0(s0)
   10a2c:	00148493          	addi	s1,s1,1
   10a30:	00440413          	addi	s0,s0,4
   10a34:	000780e7          	jalr	a5
   10a38:	ff24e8e3          	bltu	s1,s2,10a28 <__libc_init_array+0x34>
   10a3c:	00013937          	lui	s2,0x13
   10a40:	00013437          	lui	s0,0x13
   10a44:	0c490913          	addi	s2,s2,196 # 130c4 <__do_global_dtors_aux_fini_array_entry>
   10a48:	0bc40413          	addi	s0,s0,188 # 130bc <__init_array_start>
   10a4c:	02890263          	beq	s2,s0,10a70 <__libc_init_array+0x7c>
   10a50:	40890933          	sub	s2,s2,s0
   10a54:	40295913          	srai	s2,s2,0x2
   10a58:	00000493          	li	s1,0
   10a5c:	00042783          	lw	a5,0(s0)
   10a60:	00148493          	addi	s1,s1,1
   10a64:	00440413          	addi	s0,s0,4
   10a68:	000780e7          	jalr	a5
   10a6c:	ff24e8e3          	bltu	s1,s2,10a5c <__libc_init_array+0x68>
   10a70:	00c12083          	lw	ra,12(sp)
   10a74:	00812403          	lw	s0,8(sp)
   10a78:	00412483          	lw	s1,4(sp)
   10a7c:	00012903          	lw	s2,0(sp)
   10a80:	01010113          	addi	sp,sp,16
   10a84:	00008067          	ret

00010a88 <memset>:
   10a88:	00f00313          	li	t1,15
   10a8c:	00050713          	mv	a4,a0
   10a90:	02c37e63          	bgeu	t1,a2,10acc <memset+0x44>
   10a94:	00f77793          	andi	a5,a4,15
   10a98:	0a079063          	bnez	a5,10b38 <memset+0xb0>
   10a9c:	08059263          	bnez	a1,10b20 <memset+0x98>
   10aa0:	ff067693          	andi	a3,a2,-16
   10aa4:	00f67613          	andi	a2,a2,15
   10aa8:	00e686b3          	add	a3,a3,a4
   10aac:	00b72023          	sw	a1,0(a4)
   10ab0:	00b72223          	sw	a1,4(a4)
   10ab4:	00b72423          	sw	a1,8(a4)
   10ab8:	00b72623          	sw	a1,12(a4)
   10abc:	01070713          	addi	a4,a4,16
   10ac0:	fed766e3          	bltu	a4,a3,10aac <memset+0x24>
   10ac4:	00061463          	bnez	a2,10acc <memset+0x44>
   10ac8:	00008067          	ret
   10acc:	40c306b3          	sub	a3,t1,a2
   10ad0:	00269693          	slli	a3,a3,0x2
   10ad4:	00000297          	auipc	t0,0x0
   10ad8:	005686b3          	add	a3,a3,t0
   10adc:	00c68067          	jr	12(a3)
   10ae0:	00b70723          	sb	a1,14(a4)
   10ae4:	00b706a3          	sb	a1,13(a4)
   10ae8:	00b70623          	sb	a1,12(a4)
   10aec:	00b705a3          	sb	a1,11(a4)
   10af0:	00b70523          	sb	a1,10(a4)
   10af4:	00b704a3          	sb	a1,9(a4)
   10af8:	00b70423          	sb	a1,8(a4)
   10afc:	00b703a3          	sb	a1,7(a4)
   10b00:	00b70323          	sb	a1,6(a4)
   10b04:	00b702a3          	sb	a1,5(a4)
   10b08:	00b70223          	sb	a1,4(a4)
   10b0c:	00b701a3          	sb	a1,3(a4)
   10b10:	00b70123          	sb	a1,2(a4)
   10b14:	00b700a3          	sb	a1,1(a4)
   10b18:	00b70023          	sb	a1,0(a4)
   10b1c:	00008067          	ret
   10b20:	0ff5f593          	zext.b	a1,a1
   10b24:	00859693          	slli	a3,a1,0x8
   10b28:	00d5e5b3          	or	a1,a1,a3
   10b2c:	01059693          	slli	a3,a1,0x10
   10b30:	00d5e5b3          	or	a1,a1,a3
   10b34:	f6dff06f          	j	10aa0 <memset+0x18>
   10b38:	00279693          	slli	a3,a5,0x2
   10b3c:	00000297          	auipc	t0,0x0
   10b40:	005686b3          	add	a3,a3,t0
   10b44:	00008293          	mv	t0,ra
   10b48:	fa0680e7          	jalr	-96(a3)
   10b4c:	00028093          	mv	ra,t0
   10b50:	ff078793          	addi	a5,a5,-16
   10b54:	40f70733          	sub	a4,a4,a5
   10b58:	00f60633          	add	a2,a2,a5
   10b5c:	f6c378e3          	bgeu	t1,a2,10acc <memset+0x44>
   10b60:	f3dff06f          	j	10a9c <memset+0x14>

00010b64 <__call_exitprocs>:
   10b64:	fd010113          	addi	sp,sp,-48
   10b68:	01412c23          	sw	s4,24(sp)
   10b6c:	03212023          	sw	s2,32(sp)
   10b70:	d701a903          	lw	s2,-656(gp) # 13638 <__atexit>
   10b74:	02112623          	sw	ra,44(sp)
   10b78:	0a090863          	beqz	s2,10c28 <__call_exitprocs+0xc4>
   10b7c:	01312e23          	sw	s3,28(sp)
   10b80:	01512a23          	sw	s5,20(sp)
   10b84:	01612823          	sw	s6,16(sp)
   10b88:	01712623          	sw	s7,12(sp)
   10b8c:	02812423          	sw	s0,40(sp)
   10b90:	02912223          	sw	s1,36(sp)
   10b94:	01812423          	sw	s8,8(sp)
   10b98:	00050b13          	mv	s6,a0
   10b9c:	00058b93          	mv	s7,a1
   10ba0:	fff00993          	li	s3,-1
   10ba4:	00100a93          	li	s5,1
   10ba8:	00492483          	lw	s1,4(s2)
   10bac:	fff48413          	addi	s0,s1,-1
   10bb0:	04044e63          	bltz	s0,10c0c <__call_exitprocs+0xa8>
   10bb4:	00249493          	slli	s1,s1,0x2
   10bb8:	009904b3          	add	s1,s2,s1
   10bbc:	080b9063          	bnez	s7,10c3c <__call_exitprocs+0xd8>
   10bc0:	00492783          	lw	a5,4(s2)
   10bc4:	0044a683          	lw	a3,4(s1)
   10bc8:	fff78793          	addi	a5,a5,-1
   10bcc:	0c878463          	beq	a5,s0,10c94 <__call_exitprocs+0x130>
   10bd0:	0004a223          	sw	zero,4(s1)
   10bd4:	02068663          	beqz	a3,10c00 <__call_exitprocs+0x9c>
   10bd8:	18892783          	lw	a5,392(s2)
   10bdc:	008a9733          	sll	a4,s5,s0
   10be0:	00492c03          	lw	s8,4(s2)
   10be4:	00f777b3          	and	a5,a4,a5
   10be8:	06079e63          	bnez	a5,10c64 <__call_exitprocs+0x100>
   10bec:	000680e7          	jalr	a3
   10bf0:	00492703          	lw	a4,4(s2)
   10bf4:	d701a783          	lw	a5,-656(gp) # 13638 <__atexit>
   10bf8:	09871863          	bne	a4,s8,10c88 <__call_exitprocs+0x124>
   10bfc:	09279663          	bne	a5,s2,10c88 <__call_exitprocs+0x124>
   10c00:	fff40413          	addi	s0,s0,-1
   10c04:	ffc48493          	addi	s1,s1,-4
   10c08:	fb341ae3          	bne	s0,s3,10bbc <__call_exitprocs+0x58>
   10c0c:	02812403          	lw	s0,40(sp)
   10c10:	02412483          	lw	s1,36(sp)
   10c14:	01c12983          	lw	s3,28(sp)
   10c18:	01412a83          	lw	s5,20(sp)
   10c1c:	01012b03          	lw	s6,16(sp)
   10c20:	00c12b83          	lw	s7,12(sp)
   10c24:	00812c03          	lw	s8,8(sp)
   10c28:	02c12083          	lw	ra,44(sp)
   10c2c:	02012903          	lw	s2,32(sp)
   10c30:	01812a03          	lw	s4,24(sp)
   10c34:	03010113          	addi	sp,sp,48
   10c38:	00008067          	ret
   10c3c:	1044a783          	lw	a5,260(s1)
   10c40:	fff40713          	addi	a4,s0,-1
   10c44:	f6fb8ee3          	beq	s7,a5,10bc0 <__call_exitprocs+0x5c>
   10c48:	ffe40413          	addi	s0,s0,-2
   10c4c:	fd3700e3          	beq	a4,s3,10c0c <__call_exitprocs+0xa8>
   10c50:	1004a783          	lw	a5,256(s1)
   10c54:	05778463          	beq	a5,s7,10c9c <__call_exitprocs+0x138>
   10c58:	ff848493          	addi	s1,s1,-8
   10c5c:	ff3410e3          	bne	s0,s3,10c3c <__call_exitprocs+0xd8>
   10c60:	fadff06f          	j	10c0c <__call_exitprocs+0xa8>
   10c64:	18c92783          	lw	a5,396(s2)
   10c68:	0844a583          	lw	a1,132(s1)
   10c6c:	00f77733          	and	a4,a4,a5
   10c70:	02071c63          	bnez	a4,10ca8 <__call_exitprocs+0x144>
   10c74:	000b0513          	mv	a0,s6
   10c78:	000680e7          	jalr	a3
   10c7c:	00492703          	lw	a4,4(s2)
   10c80:	d701a783          	lw	a5,-656(gp) # 13638 <__atexit>
   10c84:	f7870ce3          	beq	a4,s8,10bfc <__call_exitprocs+0x98>
   10c88:	f80782e3          	beqz	a5,10c0c <__call_exitprocs+0xa8>
   10c8c:	00078913          	mv	s2,a5
   10c90:	f19ff06f          	j	10ba8 <__call_exitprocs+0x44>
   10c94:	00892223          	sw	s0,4(s2)
   10c98:	f3dff06f          	j	10bd4 <__call_exitprocs+0x70>
   10c9c:	00070413          	mv	s0,a4
   10ca0:	ffc48493          	addi	s1,s1,-4
   10ca4:	f1dff06f          	j	10bc0 <__call_exitprocs+0x5c>
   10ca8:	00058513          	mv	a0,a1
   10cac:	000680e7          	jalr	a3
   10cb0:	f41ff06f          	j	10bf0 <__call_exitprocs+0x8c>

00010cb4 <atexit>:
   10cb4:	00050593          	mv	a1,a0
   10cb8:	00000693          	li	a3,0
   10cbc:	00000613          	li	a2,0
   10cc0:	00000513          	li	a0,0
   10cc4:	1b00106f          	j	11e74 <__register_exitproc>

00010cc8 <_malloc_trim_r>:
   10cc8:	fe010113          	addi	sp,sp,-32
   10ccc:	01212823          	sw	s2,16(sp)
   10cd0:	00013937          	lui	s2,0x13
   10cd4:	00812c23          	sw	s0,24(sp)
   10cd8:	00912a23          	sw	s1,20(sp)
   10cdc:	01312623          	sw	s3,12(sp)
   10ce0:	00058413          	mv	s0,a1
   10ce4:	00112e23          	sw	ra,28(sp)
   10ce8:	00050993          	mv	s3,a0
   10cec:	21890913          	addi	s2,s2,536 # 13218 <__malloc_av_>
   10cf0:	461000ef          	jal	11950 <__malloc_lock>
   10cf4:	00892783          	lw	a5,8(s2)
   10cf8:	00001737          	lui	a4,0x1
   10cfc:	0047a483          	lw	s1,4(a5)
   10d00:	ffc4f493          	andi	s1,s1,-4
   10d04:	7ff48793          	addi	a5,s1,2047
   10d08:	7f078793          	addi	a5,a5,2032
   10d0c:	40878433          	sub	s0,a5,s0
   10d10:	00c45413          	srli	s0,s0,0xc
   10d14:	fff40413          	addi	s0,s0,-1
   10d18:	00c41413          	slli	s0,s0,0xc
   10d1c:	00e44e63          	blt	s0,a4,10d38 <_malloc_trim_r+0x70>
   10d20:	00000593          	li	a1,0
   10d24:	00098513          	mv	a0,s3
   10d28:	094010ef          	jal	11dbc <_sbrk_r>
   10d2c:	00892783          	lw	a5,8(s2)
   10d30:	009787b3          	add	a5,a5,s1
   10d34:	02f50663          	beq	a0,a5,10d60 <_malloc_trim_r+0x98>
   10d38:	00098513          	mv	a0,s3
   10d3c:	419000ef          	jal	11954 <__malloc_unlock>
   10d40:	01c12083          	lw	ra,28(sp)
   10d44:	01812403          	lw	s0,24(sp)
   10d48:	01412483          	lw	s1,20(sp)
   10d4c:	01012903          	lw	s2,16(sp)
   10d50:	00c12983          	lw	s3,12(sp)
   10d54:	00000513          	li	a0,0
   10d58:	02010113          	addi	sp,sp,32
   10d5c:	00008067          	ret
   10d60:	408005b3          	neg	a1,s0
   10d64:	00098513          	mv	a0,s3
   10d68:	054010ef          	jal	11dbc <_sbrk_r>
   10d6c:	fff00793          	li	a5,-1
   10d70:	04f50463          	beq	a0,a5,10db8 <_malloc_trim_r+0xf0>
   10d74:	00892683          	lw	a3,8(s2)
   10d78:	ed81a783          	lw	a5,-296(gp) # 137a0 <__malloc_current_mallinfo>
   10d7c:	408484b3          	sub	s1,s1,s0
   10d80:	0014e493          	ori	s1,s1,1
   10d84:	00098513          	mv	a0,s3
   10d88:	408787b3          	sub	a5,a5,s0
   10d8c:	0096a223          	sw	s1,4(a3)
   10d90:	ecf1ac23          	sw	a5,-296(gp) # 137a0 <__malloc_current_mallinfo>
   10d94:	3c1000ef          	jal	11954 <__malloc_unlock>
   10d98:	01c12083          	lw	ra,28(sp)
   10d9c:	01812403          	lw	s0,24(sp)
   10da0:	01412483          	lw	s1,20(sp)
   10da4:	01012903          	lw	s2,16(sp)
   10da8:	00c12983          	lw	s3,12(sp)
   10dac:	00100513          	li	a0,1
   10db0:	02010113          	addi	sp,sp,32
   10db4:	00008067          	ret
   10db8:	00000593          	li	a1,0
   10dbc:	00098513          	mv	a0,s3
   10dc0:	7fd000ef          	jal	11dbc <_sbrk_r>
   10dc4:	00892703          	lw	a4,8(s2)
   10dc8:	00f00693          	li	a3,15
   10dcc:	40e507b3          	sub	a5,a0,a4
   10dd0:	f6f6d4e3          	bge	a3,a5,10d38 <_malloc_trim_r+0x70>
   10dd4:	d601a603          	lw	a2,-672(gp) # 13628 <__malloc_sbrk_base>
   10dd8:	0017e793          	ori	a5,a5,1
   10ddc:	40c50533          	sub	a0,a0,a2
   10de0:	00f72223          	sw	a5,4(a4) # 1004 <exit-0xf0b0>
   10de4:	eca1ac23          	sw	a0,-296(gp) # 137a0 <__malloc_current_mallinfo>
   10de8:	f51ff06f          	j	10d38 <_malloc_trim_r+0x70>

00010dec <_free_r>:
   10dec:	12058463          	beqz	a1,10f14 <_free_r+0x128>
   10df0:	fe010113          	addi	sp,sp,-32
   10df4:	00812c23          	sw	s0,24(sp)
   10df8:	00b12623          	sw	a1,12(sp)
   10dfc:	00050413          	mv	s0,a0
   10e00:	00112e23          	sw	ra,28(sp)
   10e04:	34d000ef          	jal	11950 <__malloc_lock>
   10e08:	00c12583          	lw	a1,12(sp)
   10e0c:	00013837          	lui	a6,0x13
   10e10:	21880813          	addi	a6,a6,536 # 13218 <__malloc_av_>
   10e14:	ffc5a503          	lw	a0,-4(a1)
   10e18:	ff858713          	addi	a4,a1,-8
   10e1c:	00882883          	lw	a7,8(a6)
   10e20:	ffe57793          	andi	a5,a0,-2
   10e24:	00f70633          	add	a2,a4,a5
   10e28:	00462683          	lw	a3,4(a2)
   10e2c:	00157313          	andi	t1,a0,1
   10e30:	ffc6f693          	andi	a3,a3,-4
   10e34:	18c88863          	beq	a7,a2,10fc4 <_free_r+0x1d8>
   10e38:	00d62223          	sw	a3,4(a2)
   10e3c:	00d608b3          	add	a7,a2,a3
   10e40:	0048a883          	lw	a7,4(a7)
   10e44:	0018f893          	andi	a7,a7,1
   10e48:	08031a63          	bnez	t1,10edc <_free_r+0xf0>
   10e4c:	ff85a303          	lw	t1,-8(a1)
   10e50:	000135b7          	lui	a1,0x13
   10e54:	22058593          	addi	a1,a1,544 # 13220 <__malloc_av_+0x8>
   10e58:	40670733          	sub	a4,a4,t1
   10e5c:	00872503          	lw	a0,8(a4)
   10e60:	006787b3          	add	a5,a5,t1
   10e64:	12b50a63          	beq	a0,a1,10f98 <_free_r+0x1ac>
   10e68:	00c72303          	lw	t1,12(a4)
   10e6c:	00652623          	sw	t1,12(a0)
   10e70:	00a32423          	sw	a0,8(t1) # 101c0 <frame_dummy+0x1c>
   10e74:	18088c63          	beqz	a7,1100c <_free_r+0x220>
   10e78:	0017e693          	ori	a3,a5,1
   10e7c:	00d72223          	sw	a3,4(a4)
   10e80:	00f62023          	sw	a5,0(a2)
   10e84:	1ff00693          	li	a3,511
   10e88:	0af6e263          	bltu	a3,a5,10f2c <_free_r+0x140>
   10e8c:	ff87f693          	andi	a3,a5,-8
   10e90:	00868693          	addi	a3,a3,8
   10e94:	00482583          	lw	a1,4(a6)
   10e98:	00d806b3          	add	a3,a6,a3
   10e9c:	0006a603          	lw	a2,0(a3)
   10ea0:	0057d513          	srli	a0,a5,0x5
   10ea4:	00100793          	li	a5,1
   10ea8:	00a797b3          	sll	a5,a5,a0
   10eac:	00b7e7b3          	or	a5,a5,a1
   10eb0:	ff868593          	addi	a1,a3,-8
   10eb4:	00c72423          	sw	a2,8(a4)
   10eb8:	00b72623          	sw	a1,12(a4)
   10ebc:	00f82223          	sw	a5,4(a6)
   10ec0:	00e6a023          	sw	a4,0(a3)
   10ec4:	00e62623          	sw	a4,12(a2)
   10ec8:	00040513          	mv	a0,s0
   10ecc:	01812403          	lw	s0,24(sp)
   10ed0:	01c12083          	lw	ra,28(sp)
   10ed4:	02010113          	addi	sp,sp,32
   10ed8:	27d0006f          	j	11954 <__malloc_unlock>
   10edc:	02089e63          	bnez	a7,10f18 <_free_r+0x12c>
   10ee0:	000135b7          	lui	a1,0x13
   10ee4:	00d787b3          	add	a5,a5,a3
   10ee8:	22058593          	addi	a1,a1,544 # 13220 <__malloc_av_+0x8>
   10eec:	00862683          	lw	a3,8(a2)
   10ef0:	0017e893          	ori	a7,a5,1
   10ef4:	00f70533          	add	a0,a4,a5
   10ef8:	16b68063          	beq	a3,a1,11058 <_free_r+0x26c>
   10efc:	00c62603          	lw	a2,12(a2)
   10f00:	00c6a623          	sw	a2,12(a3)
   10f04:	00d62423          	sw	a3,8(a2)
   10f08:	01172223          	sw	a7,4(a4)
   10f0c:	00f52023          	sw	a5,0(a0)
   10f10:	f75ff06f          	j	10e84 <_free_r+0x98>
   10f14:	00008067          	ret
   10f18:	00156513          	ori	a0,a0,1
   10f1c:	fea5ae23          	sw	a0,-4(a1)
   10f20:	00f62023          	sw	a5,0(a2)
   10f24:	1ff00693          	li	a3,511
   10f28:	f6f6f2e3          	bgeu	a3,a5,10e8c <_free_r+0xa0>
   10f2c:	0097d693          	srli	a3,a5,0x9
   10f30:	00400613          	li	a2,4
   10f34:	0ed66063          	bltu	a2,a3,11014 <_free_r+0x228>
   10f38:	0067d693          	srli	a3,a5,0x6
   10f3c:	03968593          	addi	a1,a3,57
   10f40:	00359593          	slli	a1,a1,0x3
   10f44:	03868613          	addi	a2,a3,56
   10f48:	00b805b3          	add	a1,a6,a1
   10f4c:	0005a683          	lw	a3,0(a1)
   10f50:	ff858593          	addi	a1,a1,-8
   10f54:	00d59863          	bne	a1,a3,10f64 <_free_r+0x178>
   10f58:	11c0006f          	j	11074 <_free_r+0x288>
   10f5c:	0086a683          	lw	a3,8(a3)
   10f60:	00d58863          	beq	a1,a3,10f70 <_free_r+0x184>
   10f64:	0046a603          	lw	a2,4(a3)
   10f68:	ffc67613          	andi	a2,a2,-4
   10f6c:	fec7e8e3          	bltu	a5,a2,10f5c <_free_r+0x170>
   10f70:	00c6a583          	lw	a1,12(a3)
   10f74:	00b72623          	sw	a1,12(a4)
   10f78:	00d72423          	sw	a3,8(a4)
   10f7c:	00040513          	mv	a0,s0
   10f80:	01812403          	lw	s0,24(sp)
   10f84:	01c12083          	lw	ra,28(sp)
   10f88:	00e5a423          	sw	a4,8(a1)
   10f8c:	00e6a623          	sw	a4,12(a3)
   10f90:	02010113          	addi	sp,sp,32
   10f94:	1c10006f          	j	11954 <__malloc_unlock>
   10f98:	0a089063          	bnez	a7,11038 <_free_r+0x24c>
   10f9c:	00c62583          	lw	a1,12(a2)
   10fa0:	00862603          	lw	a2,8(a2)
   10fa4:	00f686b3          	add	a3,a3,a5
   10fa8:	0016e793          	ori	a5,a3,1
   10fac:	00b62623          	sw	a1,12(a2)
   10fb0:	00c5a423          	sw	a2,8(a1)
   10fb4:	00f72223          	sw	a5,4(a4)
   10fb8:	00d70733          	add	a4,a4,a3
   10fbc:	00d72023          	sw	a3,0(a4)
   10fc0:	f09ff06f          	j	10ec8 <_free_r+0xdc>
   10fc4:	00d786b3          	add	a3,a5,a3
   10fc8:	02031063          	bnez	t1,10fe8 <_free_r+0x1fc>
   10fcc:	ff85a783          	lw	a5,-8(a1)
   10fd0:	40f70733          	sub	a4,a4,a5
   10fd4:	00872603          	lw	a2,8(a4)
   10fd8:	00f686b3          	add	a3,a3,a5
   10fdc:	00c72783          	lw	a5,12(a4)
   10fe0:	00f62623          	sw	a5,12(a2)
   10fe4:	00c7a423          	sw	a2,8(a5)
   10fe8:	0016e613          	ori	a2,a3,1
   10fec:	d641a783          	lw	a5,-668(gp) # 1362c <__malloc_trim_threshold>
   10ff0:	00c72223          	sw	a2,4(a4)
   10ff4:	00e82423          	sw	a4,8(a6)
   10ff8:	ecf6e8e3          	bltu	a3,a5,10ec8 <_free_r+0xdc>
   10ffc:	d7c1a583          	lw	a1,-644(gp) # 13644 <__malloc_top_pad>
   11000:	00040513          	mv	a0,s0
   11004:	cc5ff0ef          	jal	10cc8 <_malloc_trim_r>
   11008:	ec1ff06f          	j	10ec8 <_free_r+0xdc>
   1100c:	00d787b3          	add	a5,a5,a3
   11010:	eddff06f          	j	10eec <_free_r+0x100>
   11014:	01400613          	li	a2,20
   11018:	02d67863          	bgeu	a2,a3,11048 <_free_r+0x25c>
   1101c:	05400613          	li	a2,84
   11020:	06d66863          	bltu	a2,a3,11090 <_free_r+0x2a4>
   11024:	00c7d693          	srli	a3,a5,0xc
   11028:	06f68593          	addi	a1,a3,111
   1102c:	00359593          	slli	a1,a1,0x3
   11030:	06e68613          	addi	a2,a3,110
   11034:	f15ff06f          	j	10f48 <_free_r+0x15c>
   11038:	0017e693          	ori	a3,a5,1
   1103c:	00d72223          	sw	a3,4(a4)
   11040:	00f62023          	sw	a5,0(a2)
   11044:	e85ff06f          	j	10ec8 <_free_r+0xdc>
   11048:	05c68593          	addi	a1,a3,92
   1104c:	00359593          	slli	a1,a1,0x3
   11050:	05b68613          	addi	a2,a3,91
   11054:	ef5ff06f          	j	10f48 <_free_r+0x15c>
   11058:	00e82a23          	sw	a4,20(a6)
   1105c:	00e82823          	sw	a4,16(a6)
   11060:	00b72623          	sw	a1,12(a4)
   11064:	00b72423          	sw	a1,8(a4)
   11068:	01172223          	sw	a7,4(a4)
   1106c:	00f52023          	sw	a5,0(a0)
   11070:	e59ff06f          	j	10ec8 <_free_r+0xdc>
   11074:	00482503          	lw	a0,4(a6)
   11078:	40265613          	srai	a2,a2,0x2
   1107c:	00100793          	li	a5,1
   11080:	00c797b3          	sll	a5,a5,a2
   11084:	00a7e7b3          	or	a5,a5,a0
   11088:	00f82223          	sw	a5,4(a6)
   1108c:	ee9ff06f          	j	10f74 <_free_r+0x188>
   11090:	15400613          	li	a2,340
   11094:	00d66c63          	bltu	a2,a3,110ac <_free_r+0x2c0>
   11098:	00f7d693          	srli	a3,a5,0xf
   1109c:	07868593          	addi	a1,a3,120
   110a0:	00359593          	slli	a1,a1,0x3
   110a4:	07768613          	addi	a2,a3,119
   110a8:	ea1ff06f          	j	10f48 <_free_r+0x15c>
   110ac:	55400613          	li	a2,1364
   110b0:	00d66c63          	bltu	a2,a3,110c8 <_free_r+0x2dc>
   110b4:	0127d693          	srli	a3,a5,0x12
   110b8:	07d68593          	addi	a1,a3,125
   110bc:	00359593          	slli	a1,a1,0x3
   110c0:	07c68613          	addi	a2,a3,124
   110c4:	e85ff06f          	j	10f48 <_free_r+0x15c>
   110c8:	3f800593          	li	a1,1016
   110cc:	07e00613          	li	a2,126
   110d0:	e79ff06f          	j	10f48 <_free_r+0x15c>

000110d4 <_malloc_r>:
   110d4:	fc010113          	addi	sp,sp,-64
   110d8:	02812c23          	sw	s0,56(sp)
   110dc:	02112e23          	sw	ra,60(sp)
   110e0:	00b58793          	addi	a5,a1,11
   110e4:	01600713          	li	a4,22
   110e8:	00050413          	mv	s0,a0
   110ec:	08f76e63          	bltu	a4,a5,11188 <_malloc_r+0xb4>
   110f0:	01000693          	li	a3,16
   110f4:	06b6ec63          	bltu	a3,a1,1116c <_malloc_r+0x98>
   110f8:	059000ef          	jal	11950 <__malloc_lock>
   110fc:	01000693          	li	a3,16
   11100:	01800713          	li	a4,24
   11104:	00200893          	li	a7,2
   11108:	00013837          	lui	a6,0x13
   1110c:	21880813          	addi	a6,a6,536 # 13218 <__malloc_av_>
   11110:	00e80733          	add	a4,a6,a4
   11114:	00472783          	lw	a5,4(a4)
   11118:	ff870613          	addi	a2,a4,-8
   1111c:	44c78c63          	beq	a5,a2,11574 <_malloc_r+0x4a0>
   11120:	0047a703          	lw	a4,4(a5)
   11124:	00c7a603          	lw	a2,12(a5)
   11128:	0087a583          	lw	a1,8(a5)
   1112c:	ffc77713          	andi	a4,a4,-4
   11130:	00e78733          	add	a4,a5,a4
   11134:	00472683          	lw	a3,4(a4)
   11138:	00c5a623          	sw	a2,12(a1)
   1113c:	00f12623          	sw	a5,12(sp)
   11140:	00b62423          	sw	a1,8(a2)
   11144:	0016e693          	ori	a3,a3,1
   11148:	00040513          	mv	a0,s0
   1114c:	00d72223          	sw	a3,4(a4)
   11150:	005000ef          	jal	11954 <__malloc_unlock>
   11154:	00c12783          	lw	a5,12(sp)
   11158:	03c12083          	lw	ra,60(sp)
   1115c:	03812403          	lw	s0,56(sp)
   11160:	00878513          	addi	a0,a5,8
   11164:	04010113          	addi	sp,sp,64
   11168:	00008067          	ret
   1116c:	00c00793          	li	a5,12
   11170:	00f42023          	sw	a5,0(s0)
   11174:	00000513          	li	a0,0
   11178:	03c12083          	lw	ra,60(sp)
   1117c:	03812403          	lw	s0,56(sp)
   11180:	04010113          	addi	sp,sp,64
   11184:	00008067          	ret
   11188:	ff87f693          	andi	a3,a5,-8
   1118c:	fe07c0e3          	bltz	a5,1116c <_malloc_r+0x98>
   11190:	fcb6eee3          	bltu	a3,a1,1116c <_malloc_r+0x98>
   11194:	00d12623          	sw	a3,12(sp)
   11198:	7b8000ef          	jal	11950 <__malloc_lock>
   1119c:	00c12683          	lw	a3,12(sp)
   111a0:	1f700793          	li	a5,503
   111a4:	4cd7f663          	bgeu	a5,a3,11670 <_malloc_r+0x59c>
   111a8:	0096d793          	srli	a5,a3,0x9
   111ac:	16078e63          	beqz	a5,11328 <_malloc_r+0x254>
   111b0:	00400713          	li	a4,4
   111b4:	42f76863          	bltu	a4,a5,115e4 <_malloc_r+0x510>
   111b8:	0066d793          	srli	a5,a3,0x6
   111bc:	03978893          	addi	a7,a5,57
   111c0:	03878e13          	addi	t3,a5,56
   111c4:	00389513          	slli	a0,a7,0x3
   111c8:	00013837          	lui	a6,0x13
   111cc:	21880813          	addi	a6,a6,536 # 13218 <__malloc_av_>
   111d0:	00a80533          	add	a0,a6,a0
   111d4:	00452783          	lw	a5,4(a0)
   111d8:	ff850513          	addi	a0,a0,-8
   111dc:	02f50863          	beq	a0,a5,1120c <_malloc_r+0x138>
   111e0:	00f00313          	li	t1,15
   111e4:	0140006f          	j	111f8 <_malloc_r+0x124>
   111e8:	00c7a583          	lw	a1,12(a5)
   111ec:	34065463          	bgez	a2,11534 <_malloc_r+0x460>
   111f0:	00b50e63          	beq	a0,a1,1120c <_malloc_r+0x138>
   111f4:	00058793          	mv	a5,a1
   111f8:	0047a703          	lw	a4,4(a5)
   111fc:	ffc77713          	andi	a4,a4,-4
   11200:	40d70633          	sub	a2,a4,a3
   11204:	fec352e3          	bge	t1,a2,111e8 <_malloc_r+0x114>
   11208:	000e0893          	mv	a7,t3
   1120c:	01082783          	lw	a5,16(a6)
   11210:	00013e37          	lui	t3,0x13
   11214:	220e0e13          	addi	t3,t3,544 # 13220 <__malloc_av_+0x8>
   11218:	2dc78c63          	beq	a5,t3,114f0 <_malloc_r+0x41c>
   1121c:	0047a703          	lw	a4,4(a5)
   11220:	00f00593          	li	a1,15
   11224:	ffc77713          	andi	a4,a4,-4
   11228:	40d70633          	sub	a2,a4,a3
   1122c:	46c5cc63          	blt	a1,a2,116a4 <_malloc_r+0x5d0>
   11230:	01c82a23          	sw	t3,20(a6)
   11234:	01c82823          	sw	t3,16(a6)
   11238:	44065263          	bgez	a2,1167c <_malloc_r+0x5a8>
   1123c:	1ff00613          	li	a2,511
   11240:	00482303          	lw	t1,4(a6)
   11244:	34e66063          	bltu	a2,a4,11584 <_malloc_r+0x4b0>
   11248:	ff877613          	andi	a2,a4,-8
   1124c:	00860613          	addi	a2,a2,8
   11250:	00c80633          	add	a2,a6,a2
   11254:	00062583          	lw	a1,0(a2)
   11258:	00575513          	srli	a0,a4,0x5
   1125c:	00100713          	li	a4,1
   11260:	00a71733          	sll	a4,a4,a0
   11264:	00e36333          	or	t1,t1,a4
   11268:	ff860713          	addi	a4,a2,-8
   1126c:	00b7a423          	sw	a1,8(a5)
   11270:	00e7a623          	sw	a4,12(a5)
   11274:	00682223          	sw	t1,4(a6)
   11278:	00f62023          	sw	a5,0(a2)
   1127c:	00f5a623          	sw	a5,12(a1)
   11280:	4028d793          	srai	a5,a7,0x2
   11284:	00100513          	li	a0,1
   11288:	00f51533          	sll	a0,a0,a5
   1128c:	0aa36663          	bltu	t1,a0,11338 <_malloc_r+0x264>
   11290:	006577b3          	and	a5,a0,t1
   11294:	02079463          	bnez	a5,112bc <_malloc_r+0x1e8>
   11298:	00151513          	slli	a0,a0,0x1
   1129c:	ffc8f893          	andi	a7,a7,-4
   112a0:	006577b3          	and	a5,a0,t1
   112a4:	00488893          	addi	a7,a7,4
   112a8:	00079a63          	bnez	a5,112bc <_malloc_r+0x1e8>
   112ac:	00151513          	slli	a0,a0,0x1
   112b0:	006577b3          	and	a5,a0,t1
   112b4:	00488893          	addi	a7,a7,4
   112b8:	fe078ae3          	beqz	a5,112ac <_malloc_r+0x1d8>
   112bc:	00f00e93          	li	t4,15
   112c0:	00389f13          	slli	t5,a7,0x3
   112c4:	01e80f33          	add	t5,a6,t5
   112c8:	000f0313          	mv	t1,t5
   112cc:	00c32703          	lw	a4,12(t1)
   112d0:	00088f93          	mv	t6,a7
   112d4:	32e30a63          	beq	t1,a4,11608 <_malloc_r+0x534>
   112d8:	00472603          	lw	a2,4(a4)
   112dc:	00070793          	mv	a5,a4
   112e0:	00c72703          	lw	a4,12(a4)
   112e4:	ffc67613          	andi	a2,a2,-4
   112e8:	40d605b3          	sub	a1,a2,a3
   112ec:	32beca63          	blt	t4,a1,11620 <_malloc_r+0x54c>
   112f0:	fe05c2e3          	bltz	a1,112d4 <_malloc_r+0x200>
   112f4:	00c78633          	add	a2,a5,a2
   112f8:	00462683          	lw	a3,4(a2)
   112fc:	0087a583          	lw	a1,8(a5)
   11300:	00040513          	mv	a0,s0
   11304:	0016e693          	ori	a3,a3,1
   11308:	00d62223          	sw	a3,4(a2)
   1130c:	00e5a623          	sw	a4,12(a1)
   11310:	00b72423          	sw	a1,8(a4)
   11314:	00f12623          	sw	a5,12(sp)
   11318:	63c000ef          	jal	11954 <__malloc_unlock>
   1131c:	00c12783          	lw	a5,12(sp)
   11320:	00878513          	addi	a0,a5,8
   11324:	e55ff06f          	j	11178 <_malloc_r+0xa4>
   11328:	20000513          	li	a0,512
   1132c:	04000893          	li	a7,64
   11330:	03f00e13          	li	t3,63
   11334:	e95ff06f          	j	111c8 <_malloc_r+0xf4>
   11338:	00882783          	lw	a5,8(a6)
   1133c:	0047a703          	lw	a4,4(a5)
   11340:	ffc77313          	andi	t1,a4,-4
   11344:	40d30633          	sub	a2,t1,a3
   11348:	00d36663          	bltu	t1,a3,11354 <_malloc_r+0x280>
   1134c:	01062713          	slti	a4,a2,16
   11350:	1a070463          	beqz	a4,114f8 <_malloc_r+0x424>
   11354:	d7c1a583          	lw	a1,-644(gp) # 13644 <__malloc_top_pad>
   11358:	d601a603          	lw	a2,-672(gp) # 13628 <__malloc_sbrk_base>
   1135c:	fff00713          	li	a4,-1
   11360:	00b685b3          	add	a1,a3,a1
   11364:	42e60463          	beq	a2,a4,1178c <_malloc_r+0x6b8>
   11368:	00001737          	lui	a4,0x1
   1136c:	00f70713          	addi	a4,a4,15 # 100f <exit-0xf0a5>
   11370:	00e585b3          	add	a1,a1,a4
   11374:	fffff737          	lui	a4,0xfffff
   11378:	00e5f5b3          	and	a1,a1,a4
   1137c:	00040513          	mv	a0,s0
   11380:	01012e23          	sw	a6,28(sp)
   11384:	00f12c23          	sw	a5,24(sp)
   11388:	00d12a23          	sw	a3,20(sp)
   1138c:	00612823          	sw	t1,16(sp)
   11390:	00b12623          	sw	a1,12(sp)
   11394:	229000ef          	jal	11dbc <_sbrk_r>
   11398:	fff00713          	li	a4,-1
   1139c:	00c12583          	lw	a1,12(sp)
   113a0:	01012303          	lw	t1,16(sp)
   113a4:	01412683          	lw	a3,20(sp)
   113a8:	01812783          	lw	a5,24(sp)
   113ac:	01c12803          	lw	a6,28(sp)
   113b0:	00050e13          	mv	t3,a0
   113b4:	34e50663          	beq	a0,a4,11700 <_malloc_r+0x62c>
   113b8:	00678733          	add	a4,a5,t1
   113bc:	34e56063          	bltu	a0,a4,116fc <_malloc_r+0x628>
   113c0:	ed818e93          	addi	t4,gp,-296 # 137a0 <__malloc_current_mallinfo>
   113c4:	000ea603          	lw	a2,0(t4)
   113c8:	00c58633          	add	a2,a1,a2
   113cc:	00cea023          	sw	a2,0(t4)
   113d0:	48a70a63          	beq	a4,a0,11864 <_malloc_r+0x790>
   113d4:	d601af03          	lw	t5,-672(gp) # 13628 <__malloc_sbrk_base>
   113d8:	fff00513          	li	a0,-1
   113dc:	4aaf0263          	beq	t5,a0,11880 <_malloc_r+0x7ac>
   113e0:	40ee0733          	sub	a4,t3,a4
   113e4:	00c70733          	add	a4,a4,a2
   113e8:	00eea023          	sw	a4,0(t4)
   113ec:	007e7f13          	andi	t5,t3,7
   113f0:	3a0f0e63          	beqz	t5,117ac <_malloc_r+0x6d8>
   113f4:	ff8e7e13          	andi	t3,t3,-8
   113f8:	000018b7          	lui	a7,0x1
   113fc:	008e0e13          	addi	t3,t3,8
   11400:	00888893          	addi	a7,a7,8 # 1008 <exit-0xf0ac>
   11404:	00be0633          	add	a2,t3,a1
   11408:	41e885b3          	sub	a1,a7,t5
   1140c:	40c585b3          	sub	a1,a1,a2
   11410:	01459593          	slli	a1,a1,0x14
   11414:	0145d593          	srli	a1,a1,0x14
   11418:	00040513          	mv	a0,s0
   1141c:	03012623          	sw	a6,44(sp)
   11420:	03d12423          	sw	t4,40(sp)
   11424:	02f12223          	sw	a5,36(sp)
   11428:	02d12023          	sw	a3,32(sp)
   1142c:	00612e23          	sw	t1,28(sp)
   11430:	01c12c23          	sw	t3,24(sp)
   11434:	01e12a23          	sw	t5,20(sp)
   11438:	00c12823          	sw	a2,16(sp)
   1143c:	00b12623          	sw	a1,12(sp)
   11440:	17d000ef          	jal	11dbc <_sbrk_r>
   11444:	00050713          	mv	a4,a0
   11448:	fff00513          	li	a0,-1
   1144c:	00c12583          	lw	a1,12(sp)
   11450:	01012603          	lw	a2,16(sp)
   11454:	01412f03          	lw	t5,20(sp)
   11458:	01812e03          	lw	t3,24(sp)
   1145c:	01c12303          	lw	t1,28(sp)
   11460:	02012683          	lw	a3,32(sp)
   11464:	02412783          	lw	a5,36(sp)
   11468:	02812e83          	lw	t4,40(sp)
   1146c:	02c12803          	lw	a6,44(sp)
   11470:	44a70e63          	beq	a4,a0,118cc <_malloc_r+0x7f8>
   11474:	000ea603          	lw	a2,0(t4)
   11478:	41c70733          	sub	a4,a4,t3
   1147c:	00b70733          	add	a4,a4,a1
   11480:	00176713          	ori	a4,a4,1
   11484:	01c82423          	sw	t3,8(a6)
   11488:	00c58633          	add	a2,a1,a2
   1148c:	00ee2223          	sw	a4,4(t3)
   11490:	00cea023          	sw	a2,0(t4)
   11494:	03078e63          	beq	a5,a6,114d0 <_malloc_r+0x3fc>
   11498:	00f00513          	li	a0,15
   1149c:	3e657663          	bgeu	a0,t1,11888 <_malloc_r+0x7b4>
   114a0:	0047a583          	lw	a1,4(a5)
   114a4:	ff430713          	addi	a4,t1,-12
   114a8:	ff877713          	andi	a4,a4,-8
   114ac:	0015f593          	andi	a1,a1,1
   114b0:	00e5e5b3          	or	a1,a1,a4
   114b4:	00b7a223          	sw	a1,4(a5)
   114b8:	00500893          	li	a7,5
   114bc:	00e785b3          	add	a1,a5,a4
   114c0:	0115a223          	sw	a7,4(a1)
   114c4:	0115a423          	sw	a7,8(a1)
   114c8:	40e56a63          	bltu	a0,a4,118dc <_malloc_r+0x808>
   114cc:	004e2703          	lw	a4,4(t3)
   114d0:	d781a583          	lw	a1,-648(gp) # 13640 <__malloc_max_sbrked_mem>
   114d4:	00c5f463          	bgeu	a1,a2,114dc <_malloc_r+0x408>
   114d8:	d6c1ac23          	sw	a2,-648(gp) # 13640 <__malloc_max_sbrked_mem>
   114dc:	d741a583          	lw	a1,-652(gp) # 1363c <__malloc_max_total_mem>
   114e0:	00c5f463          	bgeu	a1,a2,114e8 <_malloc_r+0x414>
   114e4:	d6c1aa23          	sw	a2,-652(gp) # 1363c <__malloc_max_total_mem>
   114e8:	000e0793          	mv	a5,t3
   114ec:	21c0006f          	j	11708 <_malloc_r+0x634>
   114f0:	00482303          	lw	t1,4(a6)
   114f4:	d8dff06f          	j	11280 <_malloc_r+0x1ac>
   114f8:	0016e713          	ori	a4,a3,1
   114fc:	00e7a223          	sw	a4,4(a5)
   11500:	00d786b3          	add	a3,a5,a3
   11504:	00166613          	ori	a2,a2,1
   11508:	00d82423          	sw	a3,8(a6)
   1150c:	00040513          	mv	a0,s0
   11510:	00c6a223          	sw	a2,4(a3)
   11514:	00f12623          	sw	a5,12(sp)
   11518:	43c000ef          	jal	11954 <__malloc_unlock>
   1151c:	00c12783          	lw	a5,12(sp)
   11520:	03c12083          	lw	ra,60(sp)
   11524:	03812403          	lw	s0,56(sp)
   11528:	00878513          	addi	a0,a5,8
   1152c:	04010113          	addi	sp,sp,64
   11530:	00008067          	ret
   11534:	0087a603          	lw	a2,8(a5)
   11538:	00e78733          	add	a4,a5,a4
   1153c:	00472683          	lw	a3,4(a4) # fffff004 <__BSS_END__+0xfffeb6ac>
   11540:	00b62623          	sw	a1,12(a2)
   11544:	00f12623          	sw	a5,12(sp)
   11548:	0016e693          	ori	a3,a3,1
   1154c:	00c5a423          	sw	a2,8(a1)
   11550:	00040513          	mv	a0,s0
   11554:	00d72223          	sw	a3,4(a4)
   11558:	3fc000ef          	jal	11954 <__malloc_unlock>
   1155c:	00c12783          	lw	a5,12(sp)
   11560:	03c12083          	lw	ra,60(sp)
   11564:	03812403          	lw	s0,56(sp)
   11568:	00878513          	addi	a0,a5,8
   1156c:	04010113          	addi	sp,sp,64
   11570:	00008067          	ret
   11574:	00c72783          	lw	a5,12(a4)
   11578:	00288893          	addi	a7,a7,2
   1157c:	c8f708e3          	beq	a4,a5,1120c <_malloc_r+0x138>
   11580:	ba1ff06f          	j	11120 <_malloc_r+0x4c>
   11584:	00975613          	srli	a2,a4,0x9
   11588:	00400593          	li	a1,4
   1158c:	14c5fe63          	bgeu	a1,a2,116e8 <_malloc_r+0x614>
   11590:	01400593          	li	a1,20
   11594:	28c5e263          	bltu	a1,a2,11818 <_malloc_r+0x744>
   11598:	05c60513          	addi	a0,a2,92
   1159c:	00351513          	slli	a0,a0,0x3
   115a0:	05b60593          	addi	a1,a2,91
   115a4:	00a80533          	add	a0,a6,a0
   115a8:	00052603          	lw	a2,0(a0)
   115ac:	ff850513          	addi	a0,a0,-8
   115b0:	00c51863          	bne	a0,a2,115c0 <_malloc_r+0x4ec>
   115b4:	1e00006f          	j	11794 <_malloc_r+0x6c0>
   115b8:	00862603          	lw	a2,8(a2)
   115bc:	00c50863          	beq	a0,a2,115cc <_malloc_r+0x4f8>
   115c0:	00462583          	lw	a1,4(a2)
   115c4:	ffc5f593          	andi	a1,a1,-4
   115c8:	feb768e3          	bltu	a4,a1,115b8 <_malloc_r+0x4e4>
   115cc:	00c62503          	lw	a0,12(a2)
   115d0:	00a7a623          	sw	a0,12(a5)
   115d4:	00c7a423          	sw	a2,8(a5)
   115d8:	00f52423          	sw	a5,8(a0)
   115dc:	00f62623          	sw	a5,12(a2)
   115e0:	ca1ff06f          	j	11280 <_malloc_r+0x1ac>
   115e4:	01400713          	li	a4,20
   115e8:	14f77063          	bgeu	a4,a5,11728 <_malloc_r+0x654>
   115ec:	05400713          	li	a4,84
   115f0:	24f76263          	bltu	a4,a5,11834 <_malloc_r+0x760>
   115f4:	00c6d793          	srli	a5,a3,0xc
   115f8:	06f78893          	addi	a7,a5,111
   115fc:	06e78e13          	addi	t3,a5,110
   11600:	00389513          	slli	a0,a7,0x3
   11604:	bc5ff06f          	j	111c8 <_malloc_r+0xf4>
   11608:	001f8f93          	addi	t6,t6,1
   1160c:	003ff793          	andi	a5,t6,3
   11610:	00830313          	addi	t1,t1,8
   11614:	12078863          	beqz	a5,11744 <_malloc_r+0x670>
   11618:	00c32703          	lw	a4,12(t1)
   1161c:	cb9ff06f          	j	112d4 <_malloc_r+0x200>
   11620:	0087a503          	lw	a0,8(a5)
   11624:	0016e893          	ori	a7,a3,1
   11628:	0117a223          	sw	a7,4(a5)
   1162c:	00e52623          	sw	a4,12(a0)
   11630:	00a72423          	sw	a0,8(a4)
   11634:	00d786b3          	add	a3,a5,a3
   11638:	00d82a23          	sw	a3,20(a6)
   1163c:	00d82823          	sw	a3,16(a6)
   11640:	0015e713          	ori	a4,a1,1
   11644:	00c78633          	add	a2,a5,a2
   11648:	01c6a623          	sw	t3,12(a3)
   1164c:	01c6a423          	sw	t3,8(a3)
   11650:	00e6a223          	sw	a4,4(a3)
   11654:	00040513          	mv	a0,s0
   11658:	00b62023          	sw	a1,0(a2)
   1165c:	00f12623          	sw	a5,12(sp)
   11660:	2f4000ef          	jal	11954 <__malloc_unlock>
   11664:	00c12783          	lw	a5,12(sp)
   11668:	00878513          	addi	a0,a5,8
   1166c:	b0dff06f          	j	11178 <_malloc_r+0xa4>
   11670:	0036d893          	srli	a7,a3,0x3
   11674:	00868713          	addi	a4,a3,8
   11678:	a91ff06f          	j	11108 <_malloc_r+0x34>
   1167c:	00e78733          	add	a4,a5,a4
   11680:	00472683          	lw	a3,4(a4)
   11684:	00f12623          	sw	a5,12(sp)
   11688:	00040513          	mv	a0,s0
   1168c:	0016e693          	ori	a3,a3,1
   11690:	00d72223          	sw	a3,4(a4)
   11694:	2c0000ef          	jal	11954 <__malloc_unlock>
   11698:	00c12783          	lw	a5,12(sp)
   1169c:	00878513          	addi	a0,a5,8
   116a0:	ad9ff06f          	j	11178 <_malloc_r+0xa4>
   116a4:	0016e593          	ori	a1,a3,1
   116a8:	00b7a223          	sw	a1,4(a5)
   116ac:	00d786b3          	add	a3,a5,a3
   116b0:	00d82a23          	sw	a3,20(a6)
   116b4:	00d82823          	sw	a3,16(a6)
   116b8:	00166593          	ori	a1,a2,1
   116bc:	00e78733          	add	a4,a5,a4
   116c0:	01c6a623          	sw	t3,12(a3)
   116c4:	01c6a423          	sw	t3,8(a3)
   116c8:	00b6a223          	sw	a1,4(a3)
   116cc:	00040513          	mv	a0,s0
   116d0:	00c72023          	sw	a2,0(a4)
   116d4:	00f12623          	sw	a5,12(sp)
   116d8:	27c000ef          	jal	11954 <__malloc_unlock>
   116dc:	00c12783          	lw	a5,12(sp)
   116e0:	00878513          	addi	a0,a5,8
   116e4:	a95ff06f          	j	11178 <_malloc_r+0xa4>
   116e8:	00675613          	srli	a2,a4,0x6
   116ec:	03960513          	addi	a0,a2,57
   116f0:	00351513          	slli	a0,a0,0x3
   116f4:	03860593          	addi	a1,a2,56
   116f8:	eadff06f          	j	115a4 <_malloc_r+0x4d0>
   116fc:	15078a63          	beq	a5,a6,11850 <_malloc_r+0x77c>
   11700:	00882783          	lw	a5,8(a6)
   11704:	0047a703          	lw	a4,4(a5)
   11708:	ffc77713          	andi	a4,a4,-4
   1170c:	40d70633          	sub	a2,a4,a3
   11710:	00d76663          	bltu	a4,a3,1171c <_malloc_r+0x648>
   11714:	01062713          	slti	a4,a2,16
   11718:	de0700e3          	beqz	a4,114f8 <_malloc_r+0x424>
   1171c:	00040513          	mv	a0,s0
   11720:	234000ef          	jal	11954 <__malloc_unlock>
   11724:	a51ff06f          	j	11174 <_malloc_r+0xa0>
   11728:	05c78893          	addi	a7,a5,92
   1172c:	05b78e13          	addi	t3,a5,91
   11730:	00389513          	slli	a0,a7,0x3
   11734:	a95ff06f          	j	111c8 <_malloc_r+0xf4>
   11738:	008f2783          	lw	a5,8(t5)
   1173c:	fff88893          	addi	a7,a7,-1
   11740:	21e79463          	bne	a5,t5,11948 <_malloc_r+0x874>
   11744:	0038f793          	andi	a5,a7,3
   11748:	ff8f0f13          	addi	t5,t5,-8
   1174c:	fe0796e3          	bnez	a5,11738 <_malloc_r+0x664>
   11750:	00482703          	lw	a4,4(a6)
   11754:	fff54793          	not	a5,a0
   11758:	00e7f7b3          	and	a5,a5,a4
   1175c:	00f82223          	sw	a5,4(a6)
   11760:	00151513          	slli	a0,a0,0x1
   11764:	fff50713          	addi	a4,a0,-1
   11768:	bcf778e3          	bgeu	a4,a5,11338 <_malloc_r+0x264>
   1176c:	00f57733          	and	a4,a0,a5
   11770:	00071a63          	bnez	a4,11784 <_malloc_r+0x6b0>
   11774:	00151513          	slli	a0,a0,0x1
   11778:	00f57733          	and	a4,a0,a5
   1177c:	004f8f93          	addi	t6,t6,4
   11780:	fe070ae3          	beqz	a4,11774 <_malloc_r+0x6a0>
   11784:	000f8893          	mv	a7,t6
   11788:	b39ff06f          	j	112c0 <_malloc_r+0x1ec>
   1178c:	01058593          	addi	a1,a1,16
   11790:	bedff06f          	j	1137c <_malloc_r+0x2a8>
   11794:	4025d593          	srai	a1,a1,0x2
   11798:	00100713          	li	a4,1
   1179c:	00b71733          	sll	a4,a4,a1
   117a0:	00e36333          	or	t1,t1,a4
   117a4:	00682223          	sw	t1,4(a6)
   117a8:	e29ff06f          	j	115d0 <_malloc_r+0x4fc>
   117ac:	00be0633          	add	a2,t3,a1
   117b0:	40c005b3          	neg	a1,a2
   117b4:	01459593          	slli	a1,a1,0x14
   117b8:	0145d593          	srli	a1,a1,0x14
   117bc:	00040513          	mv	a0,s0
   117c0:	03012423          	sw	a6,40(sp)
   117c4:	03d12223          	sw	t4,36(sp)
   117c8:	02f12023          	sw	a5,32(sp)
   117cc:	00d12e23          	sw	a3,28(sp)
   117d0:	00612c23          	sw	t1,24(sp)
   117d4:	01c12a23          	sw	t3,20(sp)
   117d8:	00b12623          	sw	a1,12(sp)
   117dc:	00c12823          	sw	a2,16(sp)
   117e0:	5dc000ef          	jal	11dbc <_sbrk_r>
   117e4:	00050713          	mv	a4,a0
   117e8:	fff00513          	li	a0,-1
   117ec:	00c12583          	lw	a1,12(sp)
   117f0:	01412e03          	lw	t3,20(sp)
   117f4:	01812303          	lw	t1,24(sp)
   117f8:	01c12683          	lw	a3,28(sp)
   117fc:	02012783          	lw	a5,32(sp)
   11800:	02412e83          	lw	t4,36(sp)
   11804:	02812803          	lw	a6,40(sp)
   11808:	c6a716e3          	bne	a4,a0,11474 <_malloc_r+0x3a0>
   1180c:	01012703          	lw	a4,16(sp)
   11810:	00000593          	li	a1,0
   11814:	c61ff06f          	j	11474 <_malloc_r+0x3a0>
   11818:	05400593          	li	a1,84
   1181c:	06c5ec63          	bltu	a1,a2,11894 <_malloc_r+0x7c0>
   11820:	00c75613          	srli	a2,a4,0xc
   11824:	06f60513          	addi	a0,a2,111
   11828:	00351513          	slli	a0,a0,0x3
   1182c:	06e60593          	addi	a1,a2,110
   11830:	d75ff06f          	j	115a4 <_malloc_r+0x4d0>
   11834:	15400713          	li	a4,340
   11838:	06f76c63          	bltu	a4,a5,118b0 <_malloc_r+0x7dc>
   1183c:	00f6d793          	srli	a5,a3,0xf
   11840:	07878893          	addi	a7,a5,120
   11844:	07778e13          	addi	t3,a5,119
   11848:	00389513          	slli	a0,a7,0x3
   1184c:	97dff06f          	j	111c8 <_malloc_r+0xf4>
   11850:	ed818e93          	addi	t4,gp,-296 # 137a0 <__malloc_current_mallinfo>
   11854:	000ea603          	lw	a2,0(t4)
   11858:	00c58633          	add	a2,a1,a2
   1185c:	00cea023          	sw	a2,0(t4)
   11860:	b75ff06f          	j	113d4 <_malloc_r+0x300>
   11864:	01451513          	slli	a0,a0,0x14
   11868:	b60516e3          	bnez	a0,113d4 <_malloc_r+0x300>
   1186c:	00882e03          	lw	t3,8(a6)
   11870:	00b305b3          	add	a1,t1,a1
   11874:	0015e713          	ori	a4,a1,1
   11878:	00ee2223          	sw	a4,4(t3)
   1187c:	c55ff06f          	j	114d0 <_malloc_r+0x3fc>
   11880:	d7c1a023          	sw	t3,-672(gp) # 13628 <__malloc_sbrk_base>
   11884:	b69ff06f          	j	113ec <_malloc_r+0x318>
   11888:	00100793          	li	a5,1
   1188c:	00fe2223          	sw	a5,4(t3)
   11890:	e8dff06f          	j	1171c <_malloc_r+0x648>
   11894:	15400593          	li	a1,340
   11898:	06c5ec63          	bltu	a1,a2,11910 <_malloc_r+0x83c>
   1189c:	00f75613          	srli	a2,a4,0xf
   118a0:	07860513          	addi	a0,a2,120
   118a4:	00351513          	slli	a0,a0,0x3
   118a8:	07760593          	addi	a1,a2,119
   118ac:	cf9ff06f          	j	115a4 <_malloc_r+0x4d0>
   118b0:	55400713          	li	a4,1364
   118b4:	06f76c63          	bltu	a4,a5,1192c <_malloc_r+0x858>
   118b8:	0126d793          	srli	a5,a3,0x12
   118bc:	07d78893          	addi	a7,a5,125
   118c0:	07c78e13          	addi	t3,a5,124
   118c4:	00389513          	slli	a0,a7,0x3
   118c8:	901ff06f          	j	111c8 <_malloc_r+0xf4>
   118cc:	ff8f0f13          	addi	t5,t5,-8
   118d0:	01e60733          	add	a4,a2,t5
   118d4:	00000593          	li	a1,0
   118d8:	b9dff06f          	j	11474 <_malloc_r+0x3a0>
   118dc:	00878593          	addi	a1,a5,8
   118e0:	00040513          	mv	a0,s0
   118e4:	01012a23          	sw	a6,20(sp)
   118e8:	01d12823          	sw	t4,16(sp)
   118ec:	00d12623          	sw	a3,12(sp)
   118f0:	cfcff0ef          	jal	10dec <_free_r>
   118f4:	01412803          	lw	a6,20(sp)
   118f8:	01012e83          	lw	t4,16(sp)
   118fc:	00c12683          	lw	a3,12(sp)
   11900:	00882e03          	lw	t3,8(a6)
   11904:	000ea603          	lw	a2,0(t4)
   11908:	004e2703          	lw	a4,4(t3)
   1190c:	bc5ff06f          	j	114d0 <_malloc_r+0x3fc>
   11910:	55400593          	li	a1,1364
   11914:	02c5e463          	bltu	a1,a2,1193c <_malloc_r+0x868>
   11918:	01275613          	srli	a2,a4,0x12
   1191c:	07d60513          	addi	a0,a2,125
   11920:	00351513          	slli	a0,a0,0x3
   11924:	07c60593          	addi	a1,a2,124
   11928:	c7dff06f          	j	115a4 <_malloc_r+0x4d0>
   1192c:	3f800513          	li	a0,1016
   11930:	07f00893          	li	a7,127
   11934:	07e00e13          	li	t3,126
   11938:	891ff06f          	j	111c8 <_malloc_r+0xf4>
   1193c:	3f800513          	li	a0,1016
   11940:	07e00593          	li	a1,126
   11944:	c61ff06f          	j	115a4 <_malloc_r+0x4d0>
   11948:	00482783          	lw	a5,4(a6)
   1194c:	e15ff06f          	j	11760 <_malloc_r+0x68c>

00011950 <__malloc_lock>:
   11950:	00008067          	ret

00011954 <__malloc_unlock>:
   11954:	00008067          	ret

00011958 <_fclose_r>:
   11958:	ff010113          	addi	sp,sp,-16
   1195c:	00112623          	sw	ra,12(sp)
   11960:	01212023          	sw	s2,0(sp)
   11964:	02058863          	beqz	a1,11994 <_fclose_r+0x3c>
   11968:	00812423          	sw	s0,8(sp)
   1196c:	00912223          	sw	s1,4(sp)
   11970:	00058413          	mv	s0,a1
   11974:	00050493          	mv	s1,a0
   11978:	00050663          	beqz	a0,11984 <_fclose_r+0x2c>
   1197c:	03452783          	lw	a5,52(a0)
   11980:	0c078c63          	beqz	a5,11a58 <_fclose_r+0x100>
   11984:	00c41783          	lh	a5,12(s0)
   11988:	02079263          	bnez	a5,119ac <_fclose_r+0x54>
   1198c:	00812403          	lw	s0,8(sp)
   11990:	00412483          	lw	s1,4(sp)
   11994:	00c12083          	lw	ra,12(sp)
   11998:	00000913          	li	s2,0
   1199c:	00090513          	mv	a0,s2
   119a0:	00012903          	lw	s2,0(sp)
   119a4:	01010113          	addi	sp,sp,16
   119a8:	00008067          	ret
   119ac:	00040593          	mv	a1,s0
   119b0:	00048513          	mv	a0,s1
   119b4:	0b8000ef          	jal	11a6c <__sflush_r>
   119b8:	02c42783          	lw	a5,44(s0)
   119bc:	00050913          	mv	s2,a0
   119c0:	00078a63          	beqz	a5,119d4 <_fclose_r+0x7c>
   119c4:	01c42583          	lw	a1,28(s0)
   119c8:	00048513          	mv	a0,s1
   119cc:	000780e7          	jalr	a5
   119d0:	06054463          	bltz	a0,11a38 <_fclose_r+0xe0>
   119d4:	00c45783          	lhu	a5,12(s0)
   119d8:	0807f793          	andi	a5,a5,128
   119dc:	06079663          	bnez	a5,11a48 <_fclose_r+0xf0>
   119e0:	03042583          	lw	a1,48(s0)
   119e4:	00058c63          	beqz	a1,119fc <_fclose_r+0xa4>
   119e8:	04040793          	addi	a5,s0,64
   119ec:	00f58663          	beq	a1,a5,119f8 <_fclose_r+0xa0>
   119f0:	00048513          	mv	a0,s1
   119f4:	bf8ff0ef          	jal	10dec <_free_r>
   119f8:	02042823          	sw	zero,48(s0)
   119fc:	04442583          	lw	a1,68(s0)
   11a00:	00058863          	beqz	a1,11a10 <_fclose_r+0xb8>
   11a04:	00048513          	mv	a0,s1
   11a08:	be4ff0ef          	jal	10dec <_free_r>
   11a0c:	04042223          	sw	zero,68(s0)
   11a10:	b29fe0ef          	jal	10538 <__sfp_lock_acquire>
   11a14:	00041623          	sh	zero,12(s0)
   11a18:	b25fe0ef          	jal	1053c <__sfp_lock_release>
   11a1c:	00c12083          	lw	ra,12(sp)
   11a20:	00812403          	lw	s0,8(sp)
   11a24:	00412483          	lw	s1,4(sp)
   11a28:	00090513          	mv	a0,s2
   11a2c:	00012903          	lw	s2,0(sp)
   11a30:	01010113          	addi	sp,sp,16
   11a34:	00008067          	ret
   11a38:	00c45783          	lhu	a5,12(s0)
   11a3c:	fff00913          	li	s2,-1
   11a40:	0807f793          	andi	a5,a5,128
   11a44:	f8078ee3          	beqz	a5,119e0 <_fclose_r+0x88>
   11a48:	01042583          	lw	a1,16(s0)
   11a4c:	00048513          	mv	a0,s1
   11a50:	b9cff0ef          	jal	10dec <_free_r>
   11a54:	f8dff06f          	j	119e0 <_fclose_r+0x88>
   11a58:	abdfe0ef          	jal	10514 <__sinit>
   11a5c:	f29ff06f          	j	11984 <_fclose_r+0x2c>

00011a60 <fclose>:
   11a60:	00050593          	mv	a1,a0
   11a64:	d5c1a503          	lw	a0,-676(gp) # 13624 <_impure_ptr>
   11a68:	ef1ff06f          	j	11958 <_fclose_r>

00011a6c <__sflush_r>:
   11a6c:	00c59703          	lh	a4,12(a1)
   11a70:	fe010113          	addi	sp,sp,-32
   11a74:	00812c23          	sw	s0,24(sp)
   11a78:	01312623          	sw	s3,12(sp)
   11a7c:	00112e23          	sw	ra,28(sp)
   11a80:	00877793          	andi	a5,a4,8
   11a84:	00058413          	mv	s0,a1
   11a88:	00050993          	mv	s3,a0
   11a8c:	12079263          	bnez	a5,11bb0 <__sflush_r+0x144>
   11a90:	000017b7          	lui	a5,0x1
   11a94:	80078793          	addi	a5,a5,-2048 # 800 <exit-0xf8b4>
   11a98:	0045a683          	lw	a3,4(a1)
   11a9c:	00f767b3          	or	a5,a4,a5
   11aa0:	00f59623          	sh	a5,12(a1)
   11aa4:	18d05c63          	blez	a3,11c3c <__sflush_r+0x1d0>
   11aa8:	02842803          	lw	a6,40(s0)
   11aac:	0e080663          	beqz	a6,11b98 <__sflush_r+0x12c>
   11ab0:	00912a23          	sw	s1,20(sp)
   11ab4:	01371693          	slli	a3,a4,0x13
   11ab8:	0009a483          	lw	s1,0(s3)
   11abc:	0009a023          	sw	zero,0(s3)
   11ac0:	1806ca63          	bltz	a3,11c54 <__sflush_r+0x1e8>
   11ac4:	01c42583          	lw	a1,28(s0)
   11ac8:	00000613          	li	a2,0
   11acc:	00100693          	li	a3,1
   11ad0:	00098513          	mv	a0,s3
   11ad4:	000800e7          	jalr	a6
   11ad8:	fff00793          	li	a5,-1
   11adc:	00050613          	mv	a2,a0
   11ae0:	1af50c63          	beq	a0,a5,11c98 <__sflush_r+0x22c>
   11ae4:	00c41783          	lh	a5,12(s0)
   11ae8:	02842803          	lw	a6,40(s0)
   11aec:	0047f793          	andi	a5,a5,4
   11af0:	00078e63          	beqz	a5,11b0c <__sflush_r+0xa0>
   11af4:	00442703          	lw	a4,4(s0)
   11af8:	03042783          	lw	a5,48(s0)
   11afc:	40e60633          	sub	a2,a2,a4
   11b00:	00078663          	beqz	a5,11b0c <__sflush_r+0xa0>
   11b04:	03c42783          	lw	a5,60(s0)
   11b08:	40f60633          	sub	a2,a2,a5
   11b0c:	01c42583          	lw	a1,28(s0)
   11b10:	00000693          	li	a3,0
   11b14:	00098513          	mv	a0,s3
   11b18:	000800e7          	jalr	a6
   11b1c:	fff00713          	li	a4,-1
   11b20:	00c41783          	lh	a5,12(s0)
   11b24:	12e51c63          	bne	a0,a4,11c5c <__sflush_r+0x1f0>
   11b28:	0009a683          	lw	a3,0(s3)
   11b2c:	01d00713          	li	a4,29
   11b30:	18d76263          	bltu	a4,a3,11cb4 <__sflush_r+0x248>
   11b34:	20400737          	lui	a4,0x20400
   11b38:	00170713          	addi	a4,a4,1 # 20400001 <__BSS_END__+0x203ec6a9>
   11b3c:	00d75733          	srl	a4,a4,a3
   11b40:	00177713          	andi	a4,a4,1
   11b44:	16070863          	beqz	a4,11cb4 <__sflush_r+0x248>
   11b48:	01042683          	lw	a3,16(s0)
   11b4c:	fffff737          	lui	a4,0xfffff
   11b50:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebea7>
   11b54:	00e7f733          	and	a4,a5,a4
   11b58:	00e41623          	sh	a4,12(s0)
   11b5c:	00042223          	sw	zero,4(s0)
   11b60:	00d42023          	sw	a3,0(s0)
   11b64:	01379713          	slli	a4,a5,0x13
   11b68:	00075663          	bgez	a4,11b74 <__sflush_r+0x108>
   11b6c:	0009a783          	lw	a5,0(s3)
   11b70:	10078863          	beqz	a5,11c80 <__sflush_r+0x214>
   11b74:	03042583          	lw	a1,48(s0)
   11b78:	0099a023          	sw	s1,0(s3)
   11b7c:	10058a63          	beqz	a1,11c90 <__sflush_r+0x224>
   11b80:	04040793          	addi	a5,s0,64
   11b84:	00f58663          	beq	a1,a5,11b90 <__sflush_r+0x124>
   11b88:	00098513          	mv	a0,s3
   11b8c:	a60ff0ef          	jal	10dec <_free_r>
   11b90:	01412483          	lw	s1,20(sp)
   11b94:	02042823          	sw	zero,48(s0)
   11b98:	01c12083          	lw	ra,28(sp)
   11b9c:	01812403          	lw	s0,24(sp)
   11ba0:	00c12983          	lw	s3,12(sp)
   11ba4:	00000513          	li	a0,0
   11ba8:	02010113          	addi	sp,sp,32
   11bac:	00008067          	ret
   11bb0:	01212823          	sw	s2,16(sp)
   11bb4:	0105a903          	lw	s2,16(a1)
   11bb8:	08090a63          	beqz	s2,11c4c <__sflush_r+0x1e0>
   11bbc:	00912a23          	sw	s1,20(sp)
   11bc0:	0005a483          	lw	s1,0(a1)
   11bc4:	00377713          	andi	a4,a4,3
   11bc8:	0125a023          	sw	s2,0(a1)
   11bcc:	412484b3          	sub	s1,s1,s2
   11bd0:	00000793          	li	a5,0
   11bd4:	00071463          	bnez	a4,11bdc <__sflush_r+0x170>
   11bd8:	0145a783          	lw	a5,20(a1)
   11bdc:	00f42423          	sw	a5,8(s0)
   11be0:	00904863          	bgtz	s1,11bf0 <__sflush_r+0x184>
   11be4:	0640006f          	j	11c48 <__sflush_r+0x1dc>
   11be8:	00a90933          	add	s2,s2,a0
   11bec:	04905e63          	blez	s1,11c48 <__sflush_r+0x1dc>
   11bf0:	02442783          	lw	a5,36(s0)
   11bf4:	01c42583          	lw	a1,28(s0)
   11bf8:	00048693          	mv	a3,s1
   11bfc:	00090613          	mv	a2,s2
   11c00:	00098513          	mv	a0,s3
   11c04:	000780e7          	jalr	a5
   11c08:	40a484b3          	sub	s1,s1,a0
   11c0c:	fca04ee3          	bgtz	a0,11be8 <__sflush_r+0x17c>
   11c10:	00c45783          	lhu	a5,12(s0)
   11c14:	01012903          	lw	s2,16(sp)
   11c18:	0407e793          	ori	a5,a5,64
   11c1c:	01c12083          	lw	ra,28(sp)
   11c20:	00f41623          	sh	a5,12(s0)
   11c24:	01812403          	lw	s0,24(sp)
   11c28:	01412483          	lw	s1,20(sp)
   11c2c:	00c12983          	lw	s3,12(sp)
   11c30:	fff00513          	li	a0,-1
   11c34:	02010113          	addi	sp,sp,32
   11c38:	00008067          	ret
   11c3c:	03c5a683          	lw	a3,60(a1)
   11c40:	e6d044e3          	bgtz	a3,11aa8 <__sflush_r+0x3c>
   11c44:	f55ff06f          	j	11b98 <__sflush_r+0x12c>
   11c48:	01412483          	lw	s1,20(sp)
   11c4c:	01012903          	lw	s2,16(sp)
   11c50:	f49ff06f          	j	11b98 <__sflush_r+0x12c>
   11c54:	05042603          	lw	a2,80(s0)
   11c58:	e95ff06f          	j	11aec <__sflush_r+0x80>
   11c5c:	01042683          	lw	a3,16(s0)
   11c60:	fffff737          	lui	a4,0xfffff
   11c64:	7ff70713          	addi	a4,a4,2047 # fffff7ff <__BSS_END__+0xfffebea7>
   11c68:	00e7f733          	and	a4,a5,a4
   11c6c:	00e41623          	sh	a4,12(s0)
   11c70:	00042223          	sw	zero,4(s0)
   11c74:	00d42023          	sw	a3,0(s0)
   11c78:	01379713          	slli	a4,a5,0x13
   11c7c:	ee075ce3          	bgez	a4,11b74 <__sflush_r+0x108>
   11c80:	03042583          	lw	a1,48(s0)
   11c84:	04a42823          	sw	a0,80(s0)
   11c88:	0099a023          	sw	s1,0(s3)
   11c8c:	ee059ae3          	bnez	a1,11b80 <__sflush_r+0x114>
   11c90:	01412483          	lw	s1,20(sp)
   11c94:	f05ff06f          	j	11b98 <__sflush_r+0x12c>
   11c98:	0009a783          	lw	a5,0(s3)
   11c9c:	e40784e3          	beqz	a5,11ae4 <__sflush_r+0x78>
   11ca0:	fe378713          	addi	a4,a5,-29
   11ca4:	00070c63          	beqz	a4,11cbc <__sflush_r+0x250>
   11ca8:	fea78793          	addi	a5,a5,-22
   11cac:	00078863          	beqz	a5,11cbc <__sflush_r+0x250>
   11cb0:	00c45783          	lhu	a5,12(s0)
   11cb4:	0407e793          	ori	a5,a5,64
   11cb8:	f65ff06f          	j	11c1c <__sflush_r+0x1b0>
   11cbc:	0099a023          	sw	s1,0(s3)
   11cc0:	01412483          	lw	s1,20(sp)
   11cc4:	ed5ff06f          	j	11b98 <__sflush_r+0x12c>

00011cc8 <_fflush_r>:
   11cc8:	00050793          	mv	a5,a0
   11ccc:	00050663          	beqz	a0,11cd8 <_fflush_r+0x10>
   11cd0:	03452703          	lw	a4,52(a0)
   11cd4:	00070e63          	beqz	a4,11cf0 <_fflush_r+0x28>
   11cd8:	00c59703          	lh	a4,12(a1)
   11cdc:	00071663          	bnez	a4,11ce8 <_fflush_r+0x20>
   11ce0:	00000513          	li	a0,0
   11ce4:	00008067          	ret
   11ce8:	00078513          	mv	a0,a5
   11cec:	d81ff06f          	j	11a6c <__sflush_r>
   11cf0:	fe010113          	addi	sp,sp,-32
   11cf4:	00b12623          	sw	a1,12(sp)
   11cf8:	00112e23          	sw	ra,28(sp)
   11cfc:	00a12423          	sw	a0,8(sp)
   11d00:	815fe0ef          	jal	10514 <__sinit>
   11d04:	00c12583          	lw	a1,12(sp)
   11d08:	00812783          	lw	a5,8(sp)
   11d0c:	00c59703          	lh	a4,12(a1)
   11d10:	00070a63          	beqz	a4,11d24 <_fflush_r+0x5c>
   11d14:	01c12083          	lw	ra,28(sp)
   11d18:	00078513          	mv	a0,a5
   11d1c:	02010113          	addi	sp,sp,32
   11d20:	d4dff06f          	j	11a6c <__sflush_r>
   11d24:	01c12083          	lw	ra,28(sp)
   11d28:	00000513          	li	a0,0
   11d2c:	02010113          	addi	sp,sp,32
   11d30:	00008067          	ret

00011d34 <fflush>:
   11d34:	06050063          	beqz	a0,11d94 <fflush+0x60>
   11d38:	00050593          	mv	a1,a0
   11d3c:	d5c1a503          	lw	a0,-676(gp) # 13624 <_impure_ptr>
   11d40:	00050663          	beqz	a0,11d4c <fflush+0x18>
   11d44:	03452783          	lw	a5,52(a0)
   11d48:	00078c63          	beqz	a5,11d60 <fflush+0x2c>
   11d4c:	00c59783          	lh	a5,12(a1)
   11d50:	00079663          	bnez	a5,11d5c <fflush+0x28>
   11d54:	00000513          	li	a0,0
   11d58:	00008067          	ret
   11d5c:	d11ff06f          	j	11a6c <__sflush_r>
   11d60:	fe010113          	addi	sp,sp,-32
   11d64:	00b12623          	sw	a1,12(sp)
   11d68:	00a12423          	sw	a0,8(sp)
   11d6c:	00112e23          	sw	ra,28(sp)
   11d70:	fa4fe0ef          	jal	10514 <__sinit>
   11d74:	00c12583          	lw	a1,12(sp)
   11d78:	00812503          	lw	a0,8(sp)
   11d7c:	00c59783          	lh	a5,12(a1)
   11d80:	02079863          	bnez	a5,11db0 <fflush+0x7c>
   11d84:	01c12083          	lw	ra,28(sp)
   11d88:	00000513          	li	a0,0
   11d8c:	02010113          	addi	sp,sp,32
   11d90:	00008067          	ret
   11d94:	00013637          	lui	a2,0x13
   11d98:	000125b7          	lui	a1,0x12
   11d9c:	00013537          	lui	a0,0x13
   11da0:	0c860613          	addi	a2,a2,200 # 130c8 <__sglue>
   11da4:	cc858593          	addi	a1,a1,-824 # 11cc8 <_fflush_r>
   11da8:	0d850513          	addi	a0,a0,216 # 130d8 <_impure_data>
   11dac:	fc4fe06f          	j	10570 <_fwalk_sglue>
   11db0:	01c12083          	lw	ra,28(sp)
   11db4:	02010113          	addi	sp,sp,32
   11db8:	cb5ff06f          	j	11a6c <__sflush_r>

00011dbc <_sbrk_r>:
   11dbc:	ff010113          	addi	sp,sp,-16
   11dc0:	00812423          	sw	s0,8(sp)
   11dc4:	00912223          	sw	s1,4(sp)
   11dc8:	00050493          	mv	s1,a0
   11dcc:	00058513          	mv	a0,a1
   11dd0:	00112623          	sw	ra,12(sp)
   11dd4:	d601a623          	sw	zero,-660(gp) # 13634 <errno>
   11dd8:	220000ef          	jal	11ff8 <_sbrk>
   11ddc:	fff00793          	li	a5,-1
   11de0:	00f50c63          	beq	a0,a5,11df8 <_sbrk_r+0x3c>
   11de4:	00c12083          	lw	ra,12(sp)
   11de8:	00812403          	lw	s0,8(sp)
   11dec:	00412483          	lw	s1,4(sp)
   11df0:	01010113          	addi	sp,sp,16
   11df4:	00008067          	ret
   11df8:	d6c1a783          	lw	a5,-660(gp) # 13634 <errno>
   11dfc:	fe0784e3          	beqz	a5,11de4 <_sbrk_r+0x28>
   11e00:	00c12083          	lw	ra,12(sp)
   11e04:	00812403          	lw	s0,8(sp)
   11e08:	00f4a023          	sw	a5,0(s1)
   11e0c:	00412483          	lw	s1,4(sp)
   11e10:	01010113          	addi	sp,sp,16
   11e14:	00008067          	ret

00011e18 <__libc_fini_array>:
   11e18:	ff010113          	addi	sp,sp,-16
   11e1c:	00812423          	sw	s0,8(sp)
   11e20:	000137b7          	lui	a5,0x13
   11e24:	00013437          	lui	s0,0x13
   11e28:	0c878793          	addi	a5,a5,200 # 130c8 <__sglue>
   11e2c:	0c440413          	addi	s0,s0,196 # 130c4 <__do_global_dtors_aux_fini_array_entry>
   11e30:	408787b3          	sub	a5,a5,s0
   11e34:	00912223          	sw	s1,4(sp)
   11e38:	00112623          	sw	ra,12(sp)
   11e3c:	4027d493          	srai	s1,a5,0x2
   11e40:	02048063          	beqz	s1,11e60 <__libc_fini_array+0x48>
   11e44:	ffc40413          	addi	s0,s0,-4
   11e48:	00f40433          	add	s0,s0,a5
   11e4c:	00042783          	lw	a5,0(s0)
   11e50:	fff48493          	addi	s1,s1,-1
   11e54:	ffc40413          	addi	s0,s0,-4
   11e58:	000780e7          	jalr	a5
   11e5c:	fe0498e3          	bnez	s1,11e4c <__libc_fini_array+0x34>
   11e60:	00c12083          	lw	ra,12(sp)
   11e64:	00812403          	lw	s0,8(sp)
   11e68:	00412483          	lw	s1,4(sp)
   11e6c:	01010113          	addi	sp,sp,16
   11e70:	00008067          	ret

00011e74 <__register_exitproc>:
   11e74:	d701a783          	lw	a5,-656(gp) # 13638 <__atexit>
   11e78:	04078c63          	beqz	a5,11ed0 <__register_exitproc+0x5c>
   11e7c:	0047a703          	lw	a4,4(a5)
   11e80:	01f00813          	li	a6,31
   11e84:	06e84e63          	blt	a6,a4,11f00 <__register_exitproc+0x8c>
   11e88:	00271813          	slli	a6,a4,0x2
   11e8c:	02050663          	beqz	a0,11eb8 <__register_exitproc+0x44>
   11e90:	01078333          	add	t1,a5,a6
   11e94:	08c32423          	sw	a2,136(t1)
   11e98:	1887a883          	lw	a7,392(a5)
   11e9c:	00100613          	li	a2,1
   11ea0:	00e61633          	sll	a2,a2,a4
   11ea4:	00c8e8b3          	or	a7,a7,a2
   11ea8:	1917a423          	sw	a7,392(a5)
   11eac:	10d32423          	sw	a3,264(t1)
   11eb0:	00200693          	li	a3,2
   11eb4:	02d50463          	beq	a0,a3,11edc <__register_exitproc+0x68>
   11eb8:	00170713          	addi	a4,a4,1
   11ebc:	00e7a223          	sw	a4,4(a5)
   11ec0:	010787b3          	add	a5,a5,a6
   11ec4:	00b7a423          	sw	a1,8(a5)
   11ec8:	00000513          	li	a0,0
   11ecc:	00008067          	ret
   11ed0:	f0018793          	addi	a5,gp,-256 # 137c8 <__atexit0>
   11ed4:	d6f1a823          	sw	a5,-656(gp) # 13638 <__atexit>
   11ed8:	fa5ff06f          	j	11e7c <__register_exitproc+0x8>
   11edc:	18c7a683          	lw	a3,396(a5)
   11ee0:	00170713          	addi	a4,a4,1
   11ee4:	00e7a223          	sw	a4,4(a5)
   11ee8:	00c6e6b3          	or	a3,a3,a2
   11eec:	18d7a623          	sw	a3,396(a5)
   11ef0:	010787b3          	add	a5,a5,a6
   11ef4:	00b7a423          	sw	a1,8(a5)
   11ef8:	00000513          	li	a0,0
   11efc:	00008067          	ret
   11f00:	fff00513          	li	a0,-1
   11f04:	00008067          	ret

00011f08 <_close>:
   11f08:	03900893          	li	a7,57
   11f0c:	00000073          	ecall
   11f10:	00054463          	bltz	a0,11f18 <_close+0x10>
   11f14:	00008067          	ret
   11f18:	fe010113          	addi	sp,sp,-32
   11f1c:	00112e23          	sw	ra,28(sp)
   11f20:	00a12623          	sw	a0,12(sp)
   11f24:	18c000ef          	jal	120b0 <__errno>
   11f28:	00c12783          	lw	a5,12(sp)
   11f2c:	01c12083          	lw	ra,28(sp)
   11f30:	40f007b3          	neg	a5,a5
   11f34:	00f52023          	sw	a5,0(a0)
   11f38:	fff00793          	li	a5,-1
   11f3c:	00078513          	mv	a0,a5
   11f40:	02010113          	addi	sp,sp,32
   11f44:	00008067          	ret

00011f48 <_exit>:
   11f48:	05d00893          	li	a7,93
   11f4c:	00000073          	ecall
   11f50:	00054463          	bltz	a0,11f58 <_exit+0x10>
   11f54:	0000006f          	j	11f54 <_exit+0xc>
   11f58:	fe010113          	addi	sp,sp,-32
   11f5c:	00112e23          	sw	ra,28(sp)
   11f60:	00a12623          	sw	a0,12(sp)
   11f64:	14c000ef          	jal	120b0 <__errno>
   11f68:	00c12783          	lw	a5,12(sp)
   11f6c:	40f007b3          	neg	a5,a5
   11f70:	00f52023          	sw	a5,0(a0)
   11f74:	0000006f          	j	11f74 <_exit+0x2c>

00011f78 <_lseek>:
   11f78:	03e00893          	li	a7,62
   11f7c:	00000073          	ecall
   11f80:	00054463          	bltz	a0,11f88 <_lseek+0x10>
   11f84:	00008067          	ret
   11f88:	fe010113          	addi	sp,sp,-32
   11f8c:	00112e23          	sw	ra,28(sp)
   11f90:	00a12623          	sw	a0,12(sp)
   11f94:	11c000ef          	jal	120b0 <__errno>
   11f98:	00c12783          	lw	a5,12(sp)
   11f9c:	01c12083          	lw	ra,28(sp)
   11fa0:	40f007b3          	neg	a5,a5
   11fa4:	00f52023          	sw	a5,0(a0)
   11fa8:	fff00793          	li	a5,-1
   11fac:	00078513          	mv	a0,a5
   11fb0:	02010113          	addi	sp,sp,32
   11fb4:	00008067          	ret

00011fb8 <_read>:
   11fb8:	03f00893          	li	a7,63
   11fbc:	00000073          	ecall
   11fc0:	00054463          	bltz	a0,11fc8 <_read+0x10>
   11fc4:	00008067          	ret
   11fc8:	fe010113          	addi	sp,sp,-32
   11fcc:	00112e23          	sw	ra,28(sp)
   11fd0:	00a12623          	sw	a0,12(sp)
   11fd4:	0dc000ef          	jal	120b0 <__errno>
   11fd8:	00c12783          	lw	a5,12(sp)
   11fdc:	01c12083          	lw	ra,28(sp)
   11fe0:	40f007b3          	neg	a5,a5
   11fe4:	00f52023          	sw	a5,0(a0)
   11fe8:	fff00793          	li	a5,-1
   11fec:	00078513          	mv	a0,a5
   11ff0:	02010113          	addi	sp,sp,32
   11ff4:	00008067          	ret

00011ff8 <_sbrk>:
   11ff8:	d801a783          	lw	a5,-640(gp) # 13648 <heap_end.0>
   11ffc:	ff010113          	addi	sp,sp,-16
   12000:	00112623          	sw	ra,12(sp)
   12004:	00050713          	mv	a4,a0
   12008:	02079063          	bnez	a5,12028 <_sbrk+0x30>
   1200c:	0d600893          	li	a7,214
   12010:	00000513          	li	a0,0
   12014:	00000073          	ecall
   12018:	fff00793          	li	a5,-1
   1201c:	02f50c63          	beq	a0,a5,12054 <_sbrk+0x5c>
   12020:	00050793          	mv	a5,a0
   12024:	d8a1a023          	sw	a0,-640(gp) # 13648 <heap_end.0>
   12028:	00f70533          	add	a0,a4,a5
   1202c:	0d600893          	li	a7,214
   12030:	00000073          	ecall
   12034:	d801a783          	lw	a5,-640(gp) # 13648 <heap_end.0>
   12038:	00f70733          	add	a4,a4,a5
   1203c:	00e51c63          	bne	a0,a4,12054 <_sbrk+0x5c>
   12040:	00c12083          	lw	ra,12(sp)
   12044:	d8a1a023          	sw	a0,-640(gp) # 13648 <heap_end.0>
   12048:	00078513          	mv	a0,a5
   1204c:	01010113          	addi	sp,sp,16
   12050:	00008067          	ret
   12054:	05c000ef          	jal	120b0 <__errno>
   12058:	00c12083          	lw	ra,12(sp)
   1205c:	00c00793          	li	a5,12
   12060:	00f52023          	sw	a5,0(a0)
   12064:	fff00513          	li	a0,-1
   12068:	01010113          	addi	sp,sp,16
   1206c:	00008067          	ret

00012070 <_write>:
   12070:	04000893          	li	a7,64
   12074:	00000073          	ecall
   12078:	00054463          	bltz	a0,12080 <_write+0x10>
   1207c:	00008067          	ret
   12080:	fe010113          	addi	sp,sp,-32
   12084:	00112e23          	sw	ra,28(sp)
   12088:	00a12623          	sw	a0,12(sp)
   1208c:	024000ef          	jal	120b0 <__errno>
   12090:	00c12783          	lw	a5,12(sp)
   12094:	01c12083          	lw	ra,28(sp)
   12098:	40f007b3          	neg	a5,a5
   1209c:	00f52023          	sw	a5,0(a0)
   120a0:	fff00793          	li	a5,-1
   120a4:	00078513          	mv	a0,a5
   120a8:	02010113          	addi	sp,sp,32
   120ac:	00008067          	ret

000120b0 <__errno>:
   120b0:	d5c1a503          	lw	a0,-676(gp) # 13624 <_impure_ptr>
   120b4:	00008067          	ret
