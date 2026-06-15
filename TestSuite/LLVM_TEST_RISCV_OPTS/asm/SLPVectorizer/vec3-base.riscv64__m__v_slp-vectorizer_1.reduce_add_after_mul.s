# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer_1.ll
# Function: reduce_add_after_mul
# src = pre-opt (reduce_add_after_mul), tgt = post-opt (reduce_add_after_mul)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	lw	a1, 8(a1)
	slliw	a3, a0, 1
	slliw	a0, a0, 3
	addw	a0, a0, a3
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	slliw	a3, a1, 1
	slliw	a1, a1, 3
	addw	a1, a1, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	lw	a1, 8(a1)
	slliw	a3, a0, 1
	slliw	a0, a0, 3
	addw	a0, a0, a3
	slliw	a3, a2, 1
	slliw	a2, a2, 3
	addw	a2, a2, a3
	slliw	a3, a1, 1
	slliw	a1, a1, 3
	addw	a1, a1, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
