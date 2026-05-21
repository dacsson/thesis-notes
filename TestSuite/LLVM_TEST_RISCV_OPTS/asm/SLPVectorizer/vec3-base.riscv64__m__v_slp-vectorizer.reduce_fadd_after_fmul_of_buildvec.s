# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: reduce_fadd_after_fmul_of_buildvec
# src = pre-opt (reduce_fadd_after_fmul_of_buildvec), tgt = post-opt (reduce_fadd_after_fmul_of_buildvec)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	lui	a0, 266752
	fmv.w.x	fa5, a0
	fmul.s	fa4, fa1, fa5
	fmadd.s	fa4, fa0, fa5, fa4
	fmadd.s	fa0, fa2, fa5, fa4
	ret
.Lfunc_end18:
	.size	src, .Lfunc_end18-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 266752
	fmv.w.x	fa5, a0
	fmul.s	fa4, fa1, fa5
	fmadd.s	fa4, fa0, fa5, fa4
	fmadd.s	fa0, fa2, fa5, fa4
	ret
.Lfunc_end18:
	.size	tgt, .Lfunc_end18-tgt
	.cfi_endproc
                                        # -- End function
