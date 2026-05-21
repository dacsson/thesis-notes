# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: overlap
# src = pre-opt (overlap), tgt = post-opt (overlap)
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
	sb	a7, 1(a1)
	sb	a6, 2(a1)
	sb	a5, 3(a1)
	sb	a4, 5(a1)
	sb	a3, 7(a1)
	sb	a2, 9(a1)
	sb	a0, 11(a1)
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
	mv	a3, a0
	addi	a2, a3, 4
	addi	a0, a1, 5
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v9, (a3)
                                        # implicit-def: $v8
	vle8.v	v8, (a2)
	vse8.v	v9, (a1)
	li	a1, 2
	vsse8.v	v8, (a0), a1
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
