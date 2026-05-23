# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: constant_stride_widen_no_reordering
# src = pre-opt (constant_stride_widen_no_reordering), tgt = post-opt (constant_stride_widen_no_reordering)
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
	lbu	s1, 0(a0)
	lbu	s0, 1(a0)
	lbu	t6, 2(a0)
	lbu	t5, 3(a0)
	lbu	t4, 100(a0)
	lbu	t3, 101(a0)
	lbu	t2, 102(a0)
	lbu	t1, 103(a0)
	lbu	t0, 200(a0)
	lbu	a7, 201(a0)
	lbu	a6, 202(a0)
	lbu	a5, 203(a0)
	lbu	a4, 300(a0)
	lbu	a3, 301(a0)
	lbu	a1, 302(a0)
	lbu	a0, 303(a0)
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
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a1, 100
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vlse32.v	v8, (a0), a1
	vse32.v	v8, (a2)
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
