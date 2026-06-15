# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: constant_strides_variable_gap
# src = pre-opt (constant_strides_variable_gap), tgt = post-opt (constant_strides_variable_gap)
# Triple: riscv64, Attrs: +m,+v
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a6, a1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	lbu	t1, 0(a0)
	lbu	t0, 1(a0)
	lbu	a7, 2(a0)
	lbu	a5, 3(a0)
	lbu	a4, 4(a0)
	lbu	a3, 5(a0)
	lbu	a2, 6(a0)
	lbu	a0, 7(a0)
	add	a1, a6, a1
	sb	t1, 0(a6)
	sb	t0, 7(a6)
	sb	a7, 14(a6)
	sb	a5, 21(a6)
	sb	a4, 28(a1)
	sb	a3, 35(a1)
	sb	a2, 42(a1)
	sb	a0, 49(a1)
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a3, a1, 4
	add	a0, a2, a0
	addi	a0, a0, 28
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v8, (a3)
                                        # implicit-def: $v9
	vle8.v	v9, (a1)
	li	a1, 7
	vsse8.v	v9, (a2), a1
	vsse8.v	v8, (a0), a1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
