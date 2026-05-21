# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: rt_stride_widen_no_reordering_i16
# src = pre-opt (rt_stride_widen_no_reordering_i16), tgt = post-opt (rt_stride_widen_no_reordering_i16)
# Triple: riscv64, Attrs: +m,+v,+unaligned-vector-mem
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	sd	s0, 144(sp)                     # 8-byte Folded Spill
	sd	s1, 136(sp)                     # 8-byte Folded Spill
	sd	s2, 128(sp)                     # 8-byte Folded Spill
	sd	s3, 120(sp)                     # 8-byte Folded Spill
	sd	s4, 112(sp)                     # 8-byte Folded Spill
	sd	s5, 104(sp)                     # 8-byte Folded Spill
	sd	s6, 96(sp)                      # 8-byte Folded Spill
	sd	s7, 88(sp)                      # 8-byte Folded Spill
	sd	s8, 80(sp)                      # 8-byte Folded Spill
	sd	s9, 72(sp)                      # 8-byte Folded Spill
	sd	s10, 64(sp)                     # 8-byte Folded Spill
	sd	s11, 56(sp)                     # 8-byte Folded Spill
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
	mv	a4, a0
	slli	a5, a1, 1
	add	a3, a4, a5
	slli	a1, a1, 2
	add	a0, a4, a1
	add	a1, a1, a5
	add	a1, a4, a1
	lbu	a5, 0(a4)
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	lbu	a5, 1(a4)
	sd	a5, 8(sp)                       # 8-byte Folded Spill
	lbu	a5, 2(a4)
	sd	a5, 32(sp)                      # 8-byte Folded Spill
	lbu	a5, 3(a4)
	sd	a5, 24(sp)                      # 8-byte Folded Spill
	lbu	ra, 4(a4)
	lbu	a5, 5(a4)
	sd	a5, 40(sp)                      # 8-byte Folded Spill
	lbu	s10, 6(a4)
	lbu	s11, 7(a4)
	lbu	s8, 0(a3)
	lbu	s9, 1(a3)
	lbu	s6, 2(a3)
	lbu	s7, 3(a3)
	lbu	s4, 4(a3)
	lbu	s5, 5(a3)
	lbu	s2, 6(a3)
	lbu	s3, 7(a3)
	lbu	s0, 0(a0)
	lbu	s1, 1(a0)
	lbu	t5, 2(a0)
	lbu	t6, 3(a0)
	lbu	t3, 4(a0)
	lbu	t4, 5(a0)
	lbu	t1, 6(a0)
	lbu	t2, 7(a0)
	lbu	a7, 0(a1)
	lbu	t0, 1(a1)
	lbu	a5, 2(a1)
	lbu	a6, 3(a1)
	lbu	a3, 4(a1)
	lbu	a4, 5(a1)
	lbu	a0, 6(a1)
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lbu	a1, 7(a1)
	sb	a0, 1(a2)
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sb	a0, 0(a2)
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sb	a0, 3(a2)
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sb	a0, 2(a2)
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sb	a0, 5(a2)
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sb	ra, 4(a2)
	sb	s11, 7(a2)
	sb	s10, 6(a2)
	sb	s9, 9(a2)
	sb	s8, 8(a2)
	sb	s7, 11(a2)
	sb	s6, 10(a2)
	sb	s5, 13(a2)
	sb	s4, 12(a2)
	sb	s3, 15(a2)
	sb	s2, 14(a2)
	sb	s1, 17(a2)
	sb	s0, 16(a2)
	sb	t6, 19(a2)
	sb	t5, 18(a2)
	sb	t4, 21(a2)
	sb	t3, 20(a2)
	sb	t2, 23(a2)
	sb	t1, 22(a2)
	sb	t0, 25(a2)
	sb	a7, 24(a2)
	sb	a6, 27(a2)
	sb	a5, 26(a2)
	sb	a4, 29(a2)
	sb	a3, 28(a2)
	sb	a1, 31(a2)
	sb	a0, 30(a2)
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	ld	s0, 144(sp)                     # 8-byte Folded Reload
	ld	s1, 136(sp)                     # 8-byte Folded Reload
	ld	s2, 128(sp)                     # 8-byte Folded Reload
	ld	s3, 120(sp)                     # 8-byte Folded Reload
	ld	s4, 112(sp)                     # 8-byte Folded Reload
	ld	s5, 104(sp)                     # 8-byte Folded Reload
	ld	s6, 96(sp)                      # 8-byte Folded Reload
	ld	s7, 88(sp)                      # 8-byte Folded Reload
	ld	s8, 80(sp)                      # 8-byte Folded Reload
	ld	s9, 72(sp)                      # 8-byte Folded Reload
	ld	s10, 64(sp)                     # 8-byte Folded Reload
	ld	s11, 56(sp)                     # 8-byte Folded Reload
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
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	slli	a1, a1, 1
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vlse64.v	v8, (a0), a1
	vse64.v	v8, (a2)
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
