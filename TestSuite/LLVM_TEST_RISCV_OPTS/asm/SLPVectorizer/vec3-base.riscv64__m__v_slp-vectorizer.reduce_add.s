# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: reduce_add
# src = pre-opt (reduce_add), tgt = post-opt (reduce_add)
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
	addw	a0, a0, a2
	addw	a0, a0, a1
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
	mv	a1, a0
	lw	a0, 0(a1)
	lw	a2, 4(a1)
	lw	a1, 8(a1)
	addw	a0, a0, a2
	addw	a0, a0, a1
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
