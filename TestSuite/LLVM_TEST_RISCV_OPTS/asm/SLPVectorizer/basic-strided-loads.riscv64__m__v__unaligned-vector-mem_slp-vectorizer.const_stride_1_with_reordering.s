# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: const_stride_1_with_reordering
# src = pre-opt (const_stride_1_with_reordering), tgt = post-opt (const_stride_1_with_reordering)
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
	lbu	s0, 0(a0)
	lbu	s1, 1(a0)
	lbu	t6, 2(a0)
	lbu	t5, 3(a0)
	lbu	t4, 4(a0)
	lbu	t3, 5(a0)
	lbu	t2, 6(a0)
	lbu	t1, 7(a0)
	lbu	t0, 8(a0)
	lbu	a7, 9(a0)
	lbu	a6, 10(a0)
	lbu	a5, 11(a0)
	lbu	a4, 12(a0)
	lbu	a3, 13(a0)
	lbu	a2, 14(a0)
	lbu	a0, 15(a0)
	sb	s1, 0(a1)
	sb	s0, 1(a1)
	sb	t6, 2(a1)
	sb	t5, 3(a1)
	sb	t4, 4(a1)
	sb	t3, 5(a1)
	sb	t2, 6(a1)
	sb	t1, 7(a1)
	sb	t0, 8(a1)
	sb	a7, 9(a1)
	sb	a6, 10(a1)
	sb	a5, 11(a1)
	sb	a4, 12(a1)
	sb	a3, 13(a1)
	sb	a2, 14(a1)
	sb	a0, 15(a1)
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	ld	s1, 0(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v9
	vsetivli	zero, 16, e8, m1, tu, ma
	vle8.v	v9, (a0)
	lui	a0, %hi(.LCPI1_0)
	addi	a0, a0, %lo(.LCPI1_0)
                                        # implicit-def: $v10
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, ta, ma
	vrgather.vv	v8, v9, v10
	vse8.v	v8, (a1)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
