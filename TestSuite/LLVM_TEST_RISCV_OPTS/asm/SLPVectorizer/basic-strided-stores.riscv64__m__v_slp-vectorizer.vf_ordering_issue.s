# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: vf_ordering_issue
# src = pre-opt (vf_ordering_issue), tgt = post-opt (vf_ordering_issue)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	s0, 72(sp)                      # 8-byte Folded Spill
	sd	s1, 64(sp)                      # 8-byte Folded Spill
	sd	s2, 56(sp)                      # 8-byte Folded Spill
	sd	s3, 48(sp)                      # 8-byte Folded Spill
	sd	s4, 40(sp)                      # 8-byte Folded Spill
	sd	s5, 32(sp)                      # 8-byte Folded Spill
	sd	s6, 24(sp)                      # 8-byte Folded Spill
	sd	s7, 16(sp)                      # 8-byte Folded Spill
	sd	s8, 8(sp)                       # 8-byte Folded Spill
	sd	s9, 0(sp)                       # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	.cfi_offset s2, -24
	.cfi_offset s3, -32
	.cfi_offset s4, -40
	.cfi_offset s5, -48
	.cfi_offset s6, -56
	.cfi_offset s7, -64
	.cfi_offset s8, -72
	.cfi_offset s9, -80
	lbu	s9, 0(a0)
	lbu	s8, 38(a0)
	lbu	s7, 92(a0)
	lbu	s6, 33(a0)
	lbu	s5, 4(a0)
	lbu	s4, 5(a0)
	lbu	s3, 6(a0)
	lbu	s2, 7(a0)
	lbu	s1, 8(a0)
	lbu	s0, 9(a0)
	lbu	t6, 10(a0)
	lbu	t5, 11(a0)
	lbu	t4, 13(a0)
	lbu	t3, 83(a0)
	lbu	t2, 32(a0)
	lbu	t1, 15(a0)
	lbu	t0, 16(a0)
	lbu	a7, 17(a0)
	lbu	a6, 18(a0)
	lbu	a5, 19(a0)
	lbu	a4, 20(a0)
	lbu	a3, 21(a0)
	lbu	a2, 22(a0)
	lbu	a0, 23(a0)
	addiw	s5, s5, 1
	addiw	s4, s4, 1
	addiw	s3, s3, 1
	addiw	s2, s2, 1
	addiw	s1, s1, 1
	addiw	s0, s0, 1
	addiw	t6, t6, 1
	addiw	t5, t5, 1
	sb	s9, 0(a1)
	sb	s8, 2(a1)
	sb	s7, 4(a1)
	sb	s6, 6(a1)
	sb	s5, 8(a1)
	sb	s4, 9(a1)
	sb	s3, 10(a1)
	sb	s2, 11(a1)
	sb	s1, 12(a1)
	sb	s0, 13(a1)
	sb	t6, 14(a1)
	sb	t5, 15(a1)
	sb	t4, 16(a1)
	sb	t3, 18(a1)
	sb	t2, 20(a1)
	sb	t1, 22(a1)
	sb	t0, 24(a1)
	sb	a7, 26(a1)
	sb	a6, 28(a1)
	sb	a5, 30(a1)
	sb	a4, 32(a1)
	sb	a3, 34(a1)
	sb	a2, 36(a1)
	sb	a0, 38(a1)
	ld	s0, 72(sp)                      # 8-byte Folded Reload
	ld	s1, 64(sp)                      # 8-byte Folded Reload
	ld	s2, 56(sp)                      # 8-byte Folded Reload
	ld	s3, 48(sp)                      # 8-byte Folded Reload
	ld	s4, 40(sp)                      # 8-byte Folded Reload
	ld	s5, 32(sp)                      # 8-byte Folded Reload
	ld	s6, 24(sp)                      # 8-byte Folded Reload
	ld	s7, 16(sp)                      # 8-byte Folded Reload
	ld	s8, 8(sp)                       # 8-byte Folded Reload
	ld	s9, 0(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	t4, a0, 4
	addi	t3, a0, 15
	lbu	t2, 0(a0)
	lbu	t1, 38(a0)
	lbu	t0, 92(a0)
	lbu	a7, 33(a0)
	lbu	a5, 13(a0)
	lbu	a4, 83(a0)
	lbu	a3, 32(a0)
	lbu	a0, 23(a0)
	addi	a6, a1, 8
	addi	a2, a1, 22
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v8, (t4)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vadd.vi	v9, v8, 1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vle8.v	v8, (t3)
	sb	t2, 0(a1)
	sb	t1, 2(a1)
	sb	t0, 4(a1)
	sb	a7, 6(a1)
	vse8.v	v9, (a6)
	sb	a5, 16(a1)
	sb	a4, 18(a1)
	sb	a3, 20(a1)
	li	a3, 2
	vsse8.v	v8, (a2), a3
	sb	a0, 38(a1)
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
