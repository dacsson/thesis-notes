# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: constant_stride_reorder_geps
# src = pre-opt (constant_stride_reorder_geps), tgt = post-opt (constant_stride_reorder_geps)
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
	sb	a7, 4(a1)
	sb	a6, 2(a1)
	sb	a5, 14(a1)
	sb	a4, 6(a1)
	sb	a3, 10(a1)
	sb	a2, 12(a1)
	sb	a0, 8(a1)
	ret
.Lfunc_end12:
	.size	src, .Lfunc_end12-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v9
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v9, (a0)
	lui	a0, %hi(.LCPI12_0)
	addi	a0, a0, %lo(.LCPI12_0)
                                        # implicit-def: $v10
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vrgather.vv	v8, v9, v10
	li	a0, 2
	vsse8.v	v8, (a1), a0
	ret
.Lfunc_end12:
	.size	tgt, .Lfunc_end12-tgt
	.cfi_endproc
                                        # -- End function
