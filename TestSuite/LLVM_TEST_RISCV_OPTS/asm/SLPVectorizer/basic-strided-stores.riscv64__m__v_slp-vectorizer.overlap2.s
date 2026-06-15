# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: overlap2
# src = pre-opt (overlap2), tgt = post-opt (overlap2)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	lbu	a7, 0(a0)
	lbu	a6, 1(a0)
	lbu	a5, 2(a0)
	lbu	a4, 3(a0)
	lbu	a3, 4(a0)
	lbu	a2, 5(a0)
	lbu	a0, 6(a0)
	sb	a7, 0(a1)
	sb	a6, 2(a1)
	sb	a5, 4(a1)
	sb	a4, 6(a1)
	sb	a3, 7(a1)
	sb	a2, 8(a1)
	sb	a0, 9(a1)
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
	mv	a2, a1
	mv	a3, a0
	addi	a4, a3, 3
	lbu	a1, 2(a3)
	addi	a0, a2, 6
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v8, (a4)
                                        # implicit-def: $v9
	vsetivli	zero, 2, e8, mf8, tu, ma
	vle8.v	v9, (a3)
	li	a3, 2
	vsse8.v	v9, (a2), a3
	sb	a1, 4(a2)
	vsetivli	zero, 4, e8, mf4, ta, ma
	vse8.v	v8, (a0)
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
