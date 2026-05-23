# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v32f16
# src = pre-opt (shuffle_v32f16), tgt = post-opt (shuffle_v32f16)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -752
	.cfi_def_cfa_offset 752
	sd	ra, 744(sp)                     # 8-byte Folded Spill
	sd	s0, 736(sp)                     # 8-byte Folded Spill
	sd	s1, 728(sp)                     # 8-byte Folded Spill
	sd	s2, 720(sp)                     # 8-byte Folded Spill
	sd	s3, 712(sp)                     # 8-byte Folded Spill
	sd	s4, 704(sp)                     # 8-byte Folded Spill
	sd	s5, 696(sp)                     # 8-byte Folded Spill
	sd	s6, 688(sp)                     # 8-byte Folded Spill
	sd	s7, 680(sp)                     # 8-byte Folded Spill
	sd	s8, 672(sp)                     # 8-byte Folded Spill
	sd	s9, 664(sp)                     # 8-byte Folded Spill
	sd	s10, 656(sp)                    # 8-byte Folded Spill
	sd	s11, 648(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	.cfi_offset s2, -32
	.cfi_offset s3, -40
	.cfi_offset s4, -48
	.cfi_offset s5, -56
	.cfi_offset s6, -64
	.cfi_offset s7, -72
	.cfi_offset s8, -80
	.cfi_offset s9, -88
	.cfi_offset s10, -96
	.cfi_offset s11, -104
	sd	a1, 616(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 616(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 624(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 632(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 640(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB28_2
	j	.LBB28_1
.LBB28_1:                               # %then
	ld	a0, 632(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 384(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 312(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 304(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 296(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 288(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 280(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 272(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 264(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 256(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 248(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 240(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 232(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 224(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 216(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 208(sp)                     # 8-byte Folded Spill
	mv	s0, a0
	mv	s1, a0
	mv	s2, a0
	mv	s3, a0
	mv	s4, a0
	mv	s5, a0
	mv	s6, a0
	mv	s7, a0
	mv	s8, a0
	mv	s9, a0
	mv	s10, a0
	mv	s11, a0
	mv	a1, a0
	sd	a1, 320(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 368(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 352(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 336(sp)                     # 8-byte Folded Spill
	sd	a0, 200(sp)                     # 8-byte Folded Spill
	call	func0
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	ld	t6, 208(sp)                     # 8-byte Folded Reload
	ld	t5, 216(sp)                     # 8-byte Folded Reload
	ld	t4, 224(sp)                     # 8-byte Folded Reload
	ld	t3, 232(sp)                     # 8-byte Folded Reload
	ld	t2, 240(sp)                     # 8-byte Folded Reload
	ld	t1, 248(sp)                     # 8-byte Folded Reload
	ld	t0, 256(sp)                     # 8-byte Folded Reload
	ld	a7, 264(sp)                     # 8-byte Folded Reload
	ld	a6, 272(sp)                     # 8-byte Folded Reload
	ld	a5, 280(sp)                     # 8-byte Folded Reload
	ld	a4, 288(sp)                     # 8-byte Folded Reload
	ld	a3, 296(sp)                     # 8-byte Folded Reload
	ld	a2, 304(sp)                     # 8-byte Folded Reload
	ld	a1, 312(sp)                     # 8-byte Folded Reload
	ld	ra, 320(sp)                     # 8-byte Folded Reload
	sd	a0, 328(sp)                     # 8-byte Folded Spill
	ld	a0, 336(sp)                     # 8-byte Folded Reload
	sd	a0, 344(sp)                     # 8-byte Folded Spill
	ld	a0, 352(sp)                     # 8-byte Folded Reload
	sd	a0, 360(sp)                     # 8-byte Folded Spill
	ld	a0, 368(sp)                     # 8-byte Folded Reload
	sd	a0, 376(sp)                     # 8-byte Folded Spill
	ld	a0, 384(sp)                     # 8-byte Folded Reload
	sd	ra, 392(sp)                     # 8-byte Folded Spill
	sd	s11, 400(sp)                    # 8-byte Folded Spill
	sd	s10, 408(sp)                    # 8-byte Folded Spill
	sd	s9, 416(sp)                     # 8-byte Folded Spill
	sd	s8, 424(sp)                     # 8-byte Folded Spill
	sd	s7, 432(sp)                     # 8-byte Folded Spill
	sd	s6, 440(sp)                     # 8-byte Folded Spill
	sd	s5, 448(sp)                     # 8-byte Folded Spill
	sd	s4, 456(sp)                     # 8-byte Folded Spill
	sd	s3, 464(sp)                     # 8-byte Folded Spill
	sd	s2, 472(sp)                     # 8-byte Folded Spill
	sd	s1, 480(sp)                     # 8-byte Folded Spill
	sd	s0, 488(sp)                     # 8-byte Folded Spill
	sd	t6, 496(sp)                     # 8-byte Folded Spill
	sd	t5, 504(sp)                     # 8-byte Folded Spill
	sd	t4, 512(sp)                     # 8-byte Folded Spill
	sd	t3, 520(sp)                     # 8-byte Folded Spill
	sd	t2, 528(sp)                     # 8-byte Folded Spill
	sd	t1, 536(sp)                     # 8-byte Folded Spill
	sd	t0, 544(sp)                     # 8-byte Folded Spill
	sd	a7, 552(sp)                     # 8-byte Folded Spill
	sd	a6, 560(sp)                     # 8-byte Folded Spill
	sd	a5, 568(sp)                     # 8-byte Folded Spill
	sd	a4, 576(sp)                     # 8-byte Folded Spill
	sd	a3, 584(sp)                     # 8-byte Folded Spill
	sd	a2, 592(sp)                     # 8-byte Folded Spill
	sd	a1, 600(sp)                     # 8-byte Folded Spill
	sd	a0, 608(sp)                     # 8-byte Folded Spill
	j	.LBB28_3
.LBB28_2:                               # %else
	ld	a0, 624(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	s0, a0
	mv	s1, a0
	mv	s2, a0
	mv	s3, a0
	mv	s4, a0
	mv	s5, a0
	mv	s6, a0
	mv	s7, a0
	mv	s8, a0
	mv	s9, a0
	mv	s10, a0
	mv	s11, a0
	mv	a1, a0
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 176(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	func1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	t6, 48(sp)                      # 8-byte Folded Reload
	ld	t5, 56(sp)                      # 8-byte Folded Reload
	ld	t4, 64(sp)                      # 8-byte Folded Reload
	ld	t3, 72(sp)                      # 8-byte Folded Reload
	ld	t2, 80(sp)                      # 8-byte Folded Reload
	ld	t1, 88(sp)                      # 8-byte Folded Reload
	ld	t0, 96(sp)                      # 8-byte Folded Reload
	ld	a7, 104(sp)                     # 8-byte Folded Reload
	ld	a6, 112(sp)                     # 8-byte Folded Reload
	ld	a5, 120(sp)                     # 8-byte Folded Reload
	ld	a4, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	ra, 160(sp)                     # 8-byte Folded Reload
	sd	a0, 328(sp)                     # 8-byte Folded Spill
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	sd	a0, 344(sp)                     # 8-byte Folded Spill
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	sd	a0, 360(sp)                     # 8-byte Folded Spill
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	sd	a0, 376(sp)                     # 8-byte Folded Spill
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	sd	ra, 392(sp)                     # 8-byte Folded Spill
	sd	s11, 400(sp)                    # 8-byte Folded Spill
	sd	s10, 408(sp)                    # 8-byte Folded Spill
	sd	s9, 416(sp)                     # 8-byte Folded Spill
	sd	s8, 424(sp)                     # 8-byte Folded Spill
	sd	s7, 432(sp)                     # 8-byte Folded Spill
	sd	s6, 440(sp)                     # 8-byte Folded Spill
	sd	s5, 448(sp)                     # 8-byte Folded Spill
	sd	s4, 456(sp)                     # 8-byte Folded Spill
	sd	s3, 464(sp)                     # 8-byte Folded Spill
	sd	s2, 472(sp)                     # 8-byte Folded Spill
	sd	s1, 480(sp)                     # 8-byte Folded Spill
	sd	s0, 488(sp)                     # 8-byte Folded Spill
	sd	t6, 496(sp)                     # 8-byte Folded Spill
	sd	t5, 504(sp)                     # 8-byte Folded Spill
	sd	t4, 512(sp)                     # 8-byte Folded Spill
	sd	t3, 520(sp)                     # 8-byte Folded Spill
	sd	t2, 528(sp)                     # 8-byte Folded Spill
	sd	t1, 536(sp)                     # 8-byte Folded Spill
	sd	t0, 544(sp)                     # 8-byte Folded Spill
	sd	a7, 552(sp)                     # 8-byte Folded Spill
	sd	a6, 560(sp)                     # 8-byte Folded Spill
	sd	a5, 568(sp)                     # 8-byte Folded Spill
	sd	a4, 576(sp)                     # 8-byte Folded Spill
	sd	a3, 584(sp)                     # 8-byte Folded Spill
	sd	a2, 592(sp)                     # 8-byte Folded Spill
	sd	a1, 600(sp)                     # 8-byte Folded Spill
	sd	a0, 608(sp)                     # 8-byte Folded Spill
	j	.LBB28_3
.LBB28_3:                               # %finally
	ld	a1, 328(sp)                     # 8-byte Folded Reload
	ld	ra, 400(sp)                     # 8-byte Folded Reload
	ld	s11, 408(sp)                    # 8-byte Folded Reload
	ld	s10, 416(sp)                    # 8-byte Folded Reload
	ld	s9, 424(sp)                     # 8-byte Folded Reload
	ld	s8, 432(sp)                     # 8-byte Folded Reload
	ld	s7, 440(sp)                     # 8-byte Folded Reload
	ld	s6, 448(sp)                     # 8-byte Folded Reload
	ld	s5, 456(sp)                     # 8-byte Folded Reload
	ld	s4, 464(sp)                     # 8-byte Folded Reload
	ld	s3, 472(sp)                     # 8-byte Folded Reload
	ld	s2, 480(sp)                     # 8-byte Folded Reload
	ld	s1, 488(sp)                     # 8-byte Folded Reload
	ld	s0, 496(sp)                     # 8-byte Folded Reload
	ld	t6, 504(sp)                     # 8-byte Folded Reload
	ld	t5, 512(sp)                     # 8-byte Folded Reload
	ld	t4, 520(sp)                     # 8-byte Folded Reload
	ld	t3, 528(sp)                     # 8-byte Folded Reload
	ld	t2, 536(sp)                     # 8-byte Folded Reload
	ld	t1, 544(sp)                     # 8-byte Folded Reload
	ld	t0, 552(sp)                     # 8-byte Folded Reload
	ld	a7, 560(sp)                     # 8-byte Folded Reload
	ld	a6, 568(sp)                     # 8-byte Folded Reload
	ld	a5, 576(sp)                     # 8-byte Folded Reload
	ld	a4, 584(sp)                     # 8-byte Folded Reload
	ld	a3, 592(sp)                     # 8-byte Folded Reload
	ld	a2, 600(sp)                     # 8-byte Folded Reload
	ld	a0, 608(sp)                     # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	ld	a0, 392(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	ld	a0, 376(sp)                     # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	ld	a0, 360(sp)                     # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	ld	a0, 344(sp)                     # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	ld	a0, 640(sp)                     # 8-byte Folded Reload
	sh	a1, 0(a0)
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 640(sp)                     # 8-byte Folded Reload
	sh	a0, 2(a1)
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 640(sp)                     # 8-byte Folded Reload
	sh	a1, 4(a0)
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 640(sp)                     # 8-byte Folded Reload
	sh	a0, 6(a1)
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 640(sp)                     # 8-byte Folded Reload
	sh	a1, 8(a0)
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 640(sp)                     # 8-byte Folded Reload
	sh	ra, 10(a1)
	sh	s11, 12(a1)
	sh	s10, 14(a1)
	sh	s9, 16(a1)
	sh	s8, 18(a1)
	sh	s7, 20(a1)
	sh	s6, 22(a1)
	sh	s5, 24(a1)
	sh	s4, 26(a1)
	sh	s3, 28(a1)
	sh	s2, 30(a1)
	sh	s1, 32(a1)
	sh	s0, 34(a1)
	sh	t6, 36(a1)
	sh	t5, 38(a1)
	sh	t4, 40(a1)
	sh	t3, 42(a1)
	sh	t2, 44(a1)
	sh	t1, 46(a1)
	sh	t0, 48(a1)
	sh	a7, 50(a1)
	sh	a6, 52(a1)
	sh	a5, 54(a1)
	sh	a4, 56(a1)
	sh	a3, 58(a1)
	sh	a2, 60(a1)
	sh	a0, 62(a1)
	ld	ra, 744(sp)                     # 8-byte Folded Reload
	ld	s0, 736(sp)                     # 8-byte Folded Reload
	ld	s1, 728(sp)                     # 8-byte Folded Reload
	ld	s2, 720(sp)                     # 8-byte Folded Reload
	ld	s3, 712(sp)                     # 8-byte Folded Reload
	ld	s4, 704(sp)                     # 8-byte Folded Reload
	ld	s5, 696(sp)                     # 8-byte Folded Reload
	ld	s6, 688(sp)                     # 8-byte Folded Reload
	ld	s7, 680(sp)                     # 8-byte Folded Reload
	ld	s8, 672(sp)                     # 8-byte Folded Reload
	ld	s9, 664(sp)                     # 8-byte Folded Reload
	ld	s10, 656(sp)                    # 8-byte Folded Reload
	ld	s11, 648(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	.cfi_restore s11
	addi	sp, sp, 752
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end28:
	.size	src, .Lfunc_end28-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -752
	.cfi_def_cfa_offset 752
	sd	ra, 744(sp)                     # 8-byte Folded Spill
	sd	s0, 736(sp)                     # 8-byte Folded Spill
	sd	s1, 728(sp)                     # 8-byte Folded Spill
	sd	s2, 720(sp)                     # 8-byte Folded Spill
	sd	s3, 712(sp)                     # 8-byte Folded Spill
	sd	s4, 704(sp)                     # 8-byte Folded Spill
	sd	s5, 696(sp)                     # 8-byte Folded Spill
	sd	s6, 688(sp)                     # 8-byte Folded Spill
	sd	s7, 680(sp)                     # 8-byte Folded Spill
	sd	s8, 672(sp)                     # 8-byte Folded Spill
	sd	s9, 664(sp)                     # 8-byte Folded Spill
	sd	s10, 656(sp)                    # 8-byte Folded Spill
	sd	s11, 648(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	.cfi_offset s2, -32
	.cfi_offset s3, -40
	.cfi_offset s4, -48
	.cfi_offset s5, -56
	.cfi_offset s6, -64
	.cfi_offset s7, -72
	.cfi_offset s8, -80
	.cfi_offset s9, -88
	.cfi_offset s10, -96
	.cfi_offset s11, -104
	sd	a1, 616(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 616(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 624(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 632(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 640(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB28_2
	j	.LBB28_1
.LBB28_1:                               # %then
	ld	a0, 632(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 384(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 312(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 304(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 296(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 288(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 280(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 272(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 264(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 256(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 248(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 240(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 232(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 224(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 216(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 208(sp)                     # 8-byte Folded Spill
	mv	s0, a0
	mv	s1, a0
	mv	s2, a0
	mv	s3, a0
	mv	s4, a0
	mv	s5, a0
	mv	s6, a0
	mv	s7, a0
	mv	s8, a0
	mv	s9, a0
	mv	s10, a0
	mv	s11, a0
	mv	a1, a0
	sd	a1, 320(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 368(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 352(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 336(sp)                     # 8-byte Folded Spill
	sd	a0, 200(sp)                     # 8-byte Folded Spill
	call	func0
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	ld	t6, 208(sp)                     # 8-byte Folded Reload
	ld	t5, 216(sp)                     # 8-byte Folded Reload
	ld	t4, 224(sp)                     # 8-byte Folded Reload
	ld	t3, 232(sp)                     # 8-byte Folded Reload
	ld	t2, 240(sp)                     # 8-byte Folded Reload
	ld	t1, 248(sp)                     # 8-byte Folded Reload
	ld	t0, 256(sp)                     # 8-byte Folded Reload
	ld	a7, 264(sp)                     # 8-byte Folded Reload
	ld	a6, 272(sp)                     # 8-byte Folded Reload
	ld	a5, 280(sp)                     # 8-byte Folded Reload
	ld	a4, 288(sp)                     # 8-byte Folded Reload
	ld	a3, 296(sp)                     # 8-byte Folded Reload
	ld	a2, 304(sp)                     # 8-byte Folded Reload
	ld	a1, 312(sp)                     # 8-byte Folded Reload
	ld	ra, 320(sp)                     # 8-byte Folded Reload
	sd	a0, 328(sp)                     # 8-byte Folded Spill
	ld	a0, 336(sp)                     # 8-byte Folded Reload
	sd	a0, 344(sp)                     # 8-byte Folded Spill
	ld	a0, 352(sp)                     # 8-byte Folded Reload
	sd	a0, 360(sp)                     # 8-byte Folded Spill
	ld	a0, 368(sp)                     # 8-byte Folded Reload
	sd	a0, 376(sp)                     # 8-byte Folded Spill
	ld	a0, 384(sp)                     # 8-byte Folded Reload
	sd	ra, 392(sp)                     # 8-byte Folded Spill
	sd	s11, 400(sp)                    # 8-byte Folded Spill
	sd	s10, 408(sp)                    # 8-byte Folded Spill
	sd	s9, 416(sp)                     # 8-byte Folded Spill
	sd	s8, 424(sp)                     # 8-byte Folded Spill
	sd	s7, 432(sp)                     # 8-byte Folded Spill
	sd	s6, 440(sp)                     # 8-byte Folded Spill
	sd	s5, 448(sp)                     # 8-byte Folded Spill
	sd	s4, 456(sp)                     # 8-byte Folded Spill
	sd	s3, 464(sp)                     # 8-byte Folded Spill
	sd	s2, 472(sp)                     # 8-byte Folded Spill
	sd	s1, 480(sp)                     # 8-byte Folded Spill
	sd	s0, 488(sp)                     # 8-byte Folded Spill
	sd	t6, 496(sp)                     # 8-byte Folded Spill
	sd	t5, 504(sp)                     # 8-byte Folded Spill
	sd	t4, 512(sp)                     # 8-byte Folded Spill
	sd	t3, 520(sp)                     # 8-byte Folded Spill
	sd	t2, 528(sp)                     # 8-byte Folded Spill
	sd	t1, 536(sp)                     # 8-byte Folded Spill
	sd	t0, 544(sp)                     # 8-byte Folded Spill
	sd	a7, 552(sp)                     # 8-byte Folded Spill
	sd	a6, 560(sp)                     # 8-byte Folded Spill
	sd	a5, 568(sp)                     # 8-byte Folded Spill
	sd	a4, 576(sp)                     # 8-byte Folded Spill
	sd	a3, 584(sp)                     # 8-byte Folded Spill
	sd	a2, 592(sp)                     # 8-byte Folded Spill
	sd	a1, 600(sp)                     # 8-byte Folded Spill
	sd	a0, 608(sp)                     # 8-byte Folded Spill
	j	.LBB28_3
.LBB28_2:                               # %else
	ld	a0, 624(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	s0, a0
	mv	s1, a0
	mv	s2, a0
	mv	s3, a0
	mv	s4, a0
	mv	s5, a0
	mv	s6, a0
	mv	s7, a0
	mv	s8, a0
	mv	s9, a0
	mv	s10, a0
	mv	s11, a0
	mv	a1, a0
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 176(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	func1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	t6, 48(sp)                      # 8-byte Folded Reload
	ld	t5, 56(sp)                      # 8-byte Folded Reload
	ld	t4, 64(sp)                      # 8-byte Folded Reload
	ld	t3, 72(sp)                      # 8-byte Folded Reload
	ld	t2, 80(sp)                      # 8-byte Folded Reload
	ld	t1, 88(sp)                      # 8-byte Folded Reload
	ld	t0, 96(sp)                      # 8-byte Folded Reload
	ld	a7, 104(sp)                     # 8-byte Folded Reload
	ld	a6, 112(sp)                     # 8-byte Folded Reload
	ld	a5, 120(sp)                     # 8-byte Folded Reload
	ld	a4, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	ra, 160(sp)                     # 8-byte Folded Reload
	sd	a0, 328(sp)                     # 8-byte Folded Spill
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	sd	a0, 344(sp)                     # 8-byte Folded Spill
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	sd	a0, 360(sp)                     # 8-byte Folded Spill
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	sd	a0, 376(sp)                     # 8-byte Folded Spill
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	sd	ra, 392(sp)                     # 8-byte Folded Spill
	sd	s11, 400(sp)                    # 8-byte Folded Spill
	sd	s10, 408(sp)                    # 8-byte Folded Spill
	sd	s9, 416(sp)                     # 8-byte Folded Spill
	sd	s8, 424(sp)                     # 8-byte Folded Spill
	sd	s7, 432(sp)                     # 8-byte Folded Spill
	sd	s6, 440(sp)                     # 8-byte Folded Spill
	sd	s5, 448(sp)                     # 8-byte Folded Spill
	sd	s4, 456(sp)                     # 8-byte Folded Spill
	sd	s3, 464(sp)                     # 8-byte Folded Spill
	sd	s2, 472(sp)                     # 8-byte Folded Spill
	sd	s1, 480(sp)                     # 8-byte Folded Spill
	sd	s0, 488(sp)                     # 8-byte Folded Spill
	sd	t6, 496(sp)                     # 8-byte Folded Spill
	sd	t5, 504(sp)                     # 8-byte Folded Spill
	sd	t4, 512(sp)                     # 8-byte Folded Spill
	sd	t3, 520(sp)                     # 8-byte Folded Spill
	sd	t2, 528(sp)                     # 8-byte Folded Spill
	sd	t1, 536(sp)                     # 8-byte Folded Spill
	sd	t0, 544(sp)                     # 8-byte Folded Spill
	sd	a7, 552(sp)                     # 8-byte Folded Spill
	sd	a6, 560(sp)                     # 8-byte Folded Spill
	sd	a5, 568(sp)                     # 8-byte Folded Spill
	sd	a4, 576(sp)                     # 8-byte Folded Spill
	sd	a3, 584(sp)                     # 8-byte Folded Spill
	sd	a2, 592(sp)                     # 8-byte Folded Spill
	sd	a1, 600(sp)                     # 8-byte Folded Spill
	sd	a0, 608(sp)                     # 8-byte Folded Spill
	j	.LBB28_3
.LBB28_3:                               # %finally
	ld	a1, 328(sp)                     # 8-byte Folded Reload
	ld	ra, 400(sp)                     # 8-byte Folded Reload
	ld	s11, 408(sp)                    # 8-byte Folded Reload
	ld	s10, 416(sp)                    # 8-byte Folded Reload
	ld	s9, 424(sp)                     # 8-byte Folded Reload
	ld	s8, 432(sp)                     # 8-byte Folded Reload
	ld	s7, 440(sp)                     # 8-byte Folded Reload
	ld	s6, 448(sp)                     # 8-byte Folded Reload
	ld	s5, 456(sp)                     # 8-byte Folded Reload
	ld	s4, 464(sp)                     # 8-byte Folded Reload
	ld	s3, 472(sp)                     # 8-byte Folded Reload
	ld	s2, 480(sp)                     # 8-byte Folded Reload
	ld	s1, 488(sp)                     # 8-byte Folded Reload
	ld	s0, 496(sp)                     # 8-byte Folded Reload
	ld	t6, 504(sp)                     # 8-byte Folded Reload
	ld	t5, 512(sp)                     # 8-byte Folded Reload
	ld	t4, 520(sp)                     # 8-byte Folded Reload
	ld	t3, 528(sp)                     # 8-byte Folded Reload
	ld	t2, 536(sp)                     # 8-byte Folded Reload
	ld	t1, 544(sp)                     # 8-byte Folded Reload
	ld	t0, 552(sp)                     # 8-byte Folded Reload
	ld	a7, 560(sp)                     # 8-byte Folded Reload
	ld	a6, 568(sp)                     # 8-byte Folded Reload
	ld	a5, 576(sp)                     # 8-byte Folded Reload
	ld	a4, 584(sp)                     # 8-byte Folded Reload
	ld	a3, 592(sp)                     # 8-byte Folded Reload
	ld	a2, 600(sp)                     # 8-byte Folded Reload
	ld	a0, 608(sp)                     # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	ld	a0, 392(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	ld	a0, 376(sp)                     # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	ld	a0, 360(sp)                     # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	ld	a0, 344(sp)                     # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	ld	a0, 640(sp)                     # 8-byte Folded Reload
	sh	a1, 0(a0)
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 640(sp)                     # 8-byte Folded Reload
	sh	a0, 2(a1)
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 640(sp)                     # 8-byte Folded Reload
	sh	a1, 4(a0)
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 640(sp)                     # 8-byte Folded Reload
	sh	a0, 6(a1)
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 640(sp)                     # 8-byte Folded Reload
	sh	a1, 8(a0)
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 640(sp)                     # 8-byte Folded Reload
	sh	ra, 10(a1)
	sh	s11, 12(a1)
	sh	s10, 14(a1)
	sh	s9, 16(a1)
	sh	s8, 18(a1)
	sh	s7, 20(a1)
	sh	s6, 22(a1)
	sh	s5, 24(a1)
	sh	s4, 26(a1)
	sh	s3, 28(a1)
	sh	s2, 30(a1)
	sh	s1, 32(a1)
	sh	s0, 34(a1)
	sh	t6, 36(a1)
	sh	t5, 38(a1)
	sh	t4, 40(a1)
	sh	t3, 42(a1)
	sh	t2, 44(a1)
	sh	t1, 46(a1)
	sh	t0, 48(a1)
	sh	a7, 50(a1)
	sh	a6, 52(a1)
	sh	a5, 54(a1)
	sh	a4, 56(a1)
	sh	a3, 58(a1)
	sh	a2, 60(a1)
	sh	a0, 62(a1)
	ld	ra, 744(sp)                     # 8-byte Folded Reload
	ld	s0, 736(sp)                     # 8-byte Folded Reload
	ld	s1, 728(sp)                     # 8-byte Folded Reload
	ld	s2, 720(sp)                     # 8-byte Folded Reload
	ld	s3, 712(sp)                     # 8-byte Folded Reload
	ld	s4, 704(sp)                     # 8-byte Folded Reload
	ld	s5, 696(sp)                     # 8-byte Folded Reload
	ld	s6, 688(sp)                     # 8-byte Folded Reload
	ld	s7, 680(sp)                     # 8-byte Folded Reload
	ld	s8, 672(sp)                     # 8-byte Folded Reload
	ld	s9, 664(sp)                     # 8-byte Folded Reload
	ld	s10, 656(sp)                    # 8-byte Folded Reload
	ld	s11, 648(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	.cfi_restore s11
	addi	sp, sp, 752
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end28:
	.size	tgt, .Lfunc_end28-tgt
	.cfi_endproc
                                        # -- End function
