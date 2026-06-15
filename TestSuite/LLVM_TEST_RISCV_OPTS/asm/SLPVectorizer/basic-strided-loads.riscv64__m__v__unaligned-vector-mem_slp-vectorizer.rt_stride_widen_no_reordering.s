# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: rt_stride_widen_no_reordering
# src = pre-opt (rt_stride_widen_no_reordering), tgt = post-opt (rt_stride_widen_no_reordering)
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
	mv	a3, a1
	mv	a4, a0
	slli	a1, a3, 1
	add	a0, a1, a3
	add	a3, a4, a3
	add	a1, a4, a1
	add	a0, a4, a0
	lbu	s1, 0(a4)
	lbu	s0, 1(a4)
	lbu	t6, 2(a4)
	lbu	t5, 3(a4)
	lbu	t4, 0(a3)
	lbu	t3, 1(a3)
	lbu	t2, 2(a3)
	lbu	t1, 3(a3)
	lbu	t0, 0(a1)
	lbu	a7, 1(a1)
	lbu	a6, 2(a1)
	lbu	a5, 3(a1)
	lbu	a4, 0(a0)
	lbu	a3, 1(a0)
	lbu	a1, 2(a0)
	lbu	a0, 3(a0)
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
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
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
	vsetivli	zero, 4, e32, m1, tu, ma
	vlse32.v	v8, (a0), a1
	vse32.v	v8, (a2)
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
