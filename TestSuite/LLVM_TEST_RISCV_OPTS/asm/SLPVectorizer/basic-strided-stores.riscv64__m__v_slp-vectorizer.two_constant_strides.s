# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: two_constant_strides
# src = pre-opt (two_constant_strides), tgt = post-opt (two_constant_strides)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	lbu	t0, 0(a0)
	lbu	a7, 1(a0)
	lbu	a6, 2(a0)
	lbu	a5, 3(a0)
	lbu	a4, 4(a0)
	lbu	a3, 5(a0)
	lbu	a2, 6(a0)
	lbu	a0, 7(a0)
	sb	t0, 0(a1)
	sb	a7, 2(a1)
	sb	a6, 4(a1)
	sb	a5, 6(a1)
	sb	a4, 9(a1)
	sb	a3, 11(a1)
	sb	a2, 13(a1)
	sb	a0, 15(a1)
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a2, a1
	mv	a3, a0
	addi	a1, a3, 4
	addi	a0, a2, 9
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v9, (a3)
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
	li	a1, 2
	vsse8.v	v9, (a2), a1
	vsse8.v	v8, (a0), a1
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
