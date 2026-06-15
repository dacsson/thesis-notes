# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer_1.ll
# Function: reduce_fadd
# src = pre-opt (reduce_fadd), tgt = post-opt (reduce_fadd)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	flw	fa5, 0(a0)
	flw	fa3, 4(a0)
	flw	fa4, 8(a0)
	fadd.s	fa5, fa5, fa3
	fadd.s	fa0, fa5, fa4
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	flw	fa5, 0(a0)
	flw	fa3, 4(a0)
	flw	fa4, 8(a0)
	fadd.s	fa5, fa5, fa3
	fadd.s	fa0, fa5, fa4
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
