# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: v3_load_i32_mul_by_constant_store
# src = pre-opt (v3_load_i32_mul_by_constant_store), tgt = post-opt (v3_load_i32_mul_by_constant_store)
# Triple: riscv64, Attrs: +m,+v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lw	a2, 0(a0)
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a3, a2, a3
	lw	a2, 4(a0)
	slliw	a4, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a4
	lw	a0, 8(a0)
	slliw	a4, a0, 1
	slliw	a0, a0, 3
	addw	a0, a0, a4
	sw	a3, 0(a1)
	sw	a2, 4(a1)
	sw	a0, 8(a1)
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
	vsetivli	zero, 3, e32, m1, tu, ma
	vle32.v	v9, (a0)
	li	a0, 10
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, ta, ma
	vmul.vx	v8, v9, a0
	vsetivli	zero, 3, e32, m1, ta, ma
	vse32.v	v8, (a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
