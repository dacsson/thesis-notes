# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: constant_stride_7
# src = pre-opt (constant_stride_7), tgt = post-opt (constant_stride_7)
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
	sb	a7, 7(a1)
	sb	a6, 14(a1)
	sb	a5, 21(a1)
	sb	a4, 28(a1)
	sb	a3, 35(a1)
	sb	a2, 42(a1)
	sb	a0, 49(a1)
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v8, (a0)
	li	a0, 7
	vsse8.v	v8, (a1), a0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
