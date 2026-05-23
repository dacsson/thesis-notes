# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: rt_stride_1_no_reordering
# src = pre-opt (rt_stride_1_no_reordering), tgt = post-opt (rt_stride_1_no_reordering)
# Triple: riscv64, Attrs: +m,+v,+unaligned-vector-mem
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	sd	s1, 0(sp)                       # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	mv	s0, a1
	mv	s1, a0
	slli	t6, s0, 1
	add	t5, t6, s0
	slli	t4, s0, 2
	add	t3, t4, s0
	add	t2, t4, t6
	slli	t0, s0, 3
	sub	t1, t0, s0
	add	a7, t0, s0
	add	a6, t0, t6
	li	a0, 11
	mul	a5, s0, a0
	add	a4, t0, t4
	li	a0, 13
	mul	a3, s0, a0
	slli	a0, s0, 4
	sub	a1, a0, t6
	sub	a0, a0, s0
	add	s0, s1, s0
	add	t6, s1, t6
	add	t5, s1, t5
	add	t4, s1, t4
	add	t3, s1, t3
	add	t2, s1, t2
	add	t1, s1, t1
	add	t0, s1, t0
	add	a7, s1, a7
	add	a6, s1, a6
	add	a5, s1, a5
	add	a4, s1, a4
	add	a3, s1, a3
	add	a1, s1, a1
	add	a0, s1, a0
	lbu	s1, 0(s1)
	lbu	s0, 0(s0)
	lbu	t6, 0(t6)
	lbu	t5, 0(t5)
	lbu	t4, 0(t4)
	lbu	t3, 0(t3)
	lbu	t2, 0(t2)
	lbu	t1, 0(t1)
	lbu	t0, 0(t0)
	lbu	a7, 0(a7)
	lbu	a6, 0(a6)
	lbu	a5, 0(a5)
	lbu	a4, 0(a4)
	lbu	a3, 0(a3)
	lbu	a1, 0(a1)
	lbu	a0, 0(a0)
	sb	s1, 0(a2)
	sb	s0, 1(a2)
	sb	t6, 2(a2)
	sb	t5, 3(a2)
	sb	t4, 4(a2)
	sb	t3, 5(a2)
	sb	t2, 6(a2)
	sb	t1, 7(a2)
	sb	t0, 8(a2)
	sb	a7, 9(a2)
	sb	a6, 10(a2)
	sb	a5, 11(a2)
	sb	a4, 12(a2)
	sb	a3, 13(a2)
	sb	a1, 14(a2)
	sb	a0, 15(a2)
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	ld	s1, 0(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 16, e8, m1, tu, ma
	vlse8.v	v8, (a0), a1
	vse8.v	v8, (a2)
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
