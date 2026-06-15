# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: no_root_reshuffle
# src = pre-opt (no_root_reshuffle), tgt = post-opt (no_root_reshuffle)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	fld	fa5, 0(a0)
	fmul.d	fa3, fa5, fa5
	fld	fa4, 8(a0)
	fld	fa5, 16(a0)
	fmul.d	fa5, fa5, fa5
	fmadd.d	fa0, fa5, fa4, fa3
	ret
.Lfunc_end17:
	.size	src, .Lfunc_end17-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	fld	fa5, 0(a0)
	fmul.d	fa3, fa5, fa5
	fld	fa4, 8(a0)
	fld	fa5, 16(a0)
	fmul.d	fa5, fa5, fa5
	fmadd.d	fa0, fa5, fa4, fa3
	ret
.Lfunc_end17:
	.size	tgt, .Lfunc_end17-tgt
	.cfi_endproc
                                        # -- End function
