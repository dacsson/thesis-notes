# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: constant_stride_reorder_data
# src = pre-opt (constant_stride_reorder_data), tgt = post-opt (constant_stride_reorder_data)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a5, a0
	lbu	t0, 0(a5)
	lbu	a6, 1(a5)
	lbu	a7, 2(a5)
	lbu	a4, 3(a5)
	lbu	a0, 4(a5)
	lbu	a3, 5(a5)
	lbu	a2, 6(a5)
	lbu	a5, 7(a5)
	sb	t0, 0(a1)
	sb	a7, 2(a1)
	sb	a6, 4(a1)
	sb	a5, 6(a1)
	sb	a4, 8(a1)
	sb	a3, 10(a1)
	sb	a2, 12(a1)
	sb	a0, 14(a1)
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
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
	lui	a0, %hi(.LCPI11_0)
	addi	a0, a0, %lo(.LCPI11_0)
                                        # implicit-def: $v10
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vrgather.vv	v8, v9, v10
	li	a0, 2
	vsse8.v	v8, (a1), a0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
