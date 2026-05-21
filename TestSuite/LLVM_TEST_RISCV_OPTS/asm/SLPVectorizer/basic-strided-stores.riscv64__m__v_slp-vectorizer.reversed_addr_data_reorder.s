# Source: SLPVectorizer/basic-strided-stores.riscv64__m__v_slp-vectorizer.ll
# Function: reversed_addr_data_reorder
# src = pre-opt (reversed_addr_data_reorder), tgt = post-opt (reversed_addr_data_reorder)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a3, a0
	lbu	t0, 0(a3)
	lbu	a6, 1(a3)
	lbu	a4, 2(a3)
	lbu	a7, 3(a3)
	lbu	a0, 4(a3)
	lbu	a2, 5(a3)
	lbu	a5, 6(a3)
	lbu	a3, 7(a3)
	sb	t0, 14(a1)
	sb	a7, 12(a1)
	sb	a6, 10(a1)
	sb	a5, 8(a1)
	sb	a4, 6(a1)
	sb	a3, 4(a1)
	sb	a2, 2(a1)
	sb	a0, 0(a1)
	ret
.Lfunc_end13:
	.size	src, .Lfunc_end13-src
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
	lui	a0, %hi(.LCPI13_0)
	addi	a0, a0, %lo(.LCPI13_0)
                                        # implicit-def: $v10
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vrgather.vv	v8, v9, v10
	li	a0, 2
	vsse8.v	v8, (a1), a0
	ret
.Lfunc_end13:
	.size	tgt, .Lfunc_end13-tgt
	.cfi_endproc
                                        # -- End function
