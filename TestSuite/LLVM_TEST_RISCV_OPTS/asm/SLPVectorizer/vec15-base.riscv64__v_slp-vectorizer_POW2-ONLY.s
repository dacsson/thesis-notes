# Source: SLPVectorizer/vec15-base.riscv64__v_slp-vectorizer_POW2-ONLY.ll
# Function: v15_load_i8_mul_by_constant_store
# src = pre-opt (v15_load_i8_mul_by_constant_store), tgt = post-opt (v15_load_i8_mul_by_constant_store)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lbu	a2, 0(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 0(a1)
	lbu	a2, 1(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 1(a1)
	lbu	a2, 2(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 2(a1)
	lbu	a2, 3(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 3(a1)
	lbu	a2, 4(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 4(a1)
	lbu	a2, 5(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 5(a1)
	lbu	a2, 6(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 6(a1)
	lbu	a2, 7(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 7(a1)
	lbu	a2, 8(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 8(a1)
	lbu	a2, 9(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 9(a1)
	lbu	a2, 10(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 10(a1)
	lbu	a2, 11(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 11(a1)
	lbu	a2, 12(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 12(a1)
	lbu	a2, 13(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	sb	a2, 13(a1)
	lbu	a0, 14(a0)
	slliw	a2, a0, 1
	slliw	a0, a0, 3
	addw	a0, a0, a2
	sb	a0, 14(a1)
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v9, (a0)
	li	a3, 10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmul.vx	v8, v9, a3
	vse8.v	v8, (a1)
	addi	a4, a0, 8
	addi	a2, a1, 8
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v9, (a4)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vmul.vx	v8, v9, a3
	vse8.v	v8, (a2)
	addi	a4, a0, 12
	addi	a2, a1, 12
                                        # implicit-def: $v9
	vsetivli	zero, 2, e8, mf8, tu, ma
	vle8.v	v9, (a4)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf8, ta, ma
	vmul.vx	v8, v9, a3
	vse8.v	v8, (a2)
	lbu	a0, 14(a0)
	slliw	a2, a0, 1
	slliw	a0, a0, 3
	addw	a0, a0, a2
	sb	a0, 14(a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
