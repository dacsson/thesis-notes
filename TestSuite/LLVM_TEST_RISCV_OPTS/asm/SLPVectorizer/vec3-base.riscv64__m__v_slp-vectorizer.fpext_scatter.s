# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: fpext_scatter
# src = pre-opt (fpext_scatter), tgt = post-opt (fpext_scatter)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	fcvt.s.d	fa5, fa0
	fsw	fa5, 0(a0)
	fsw	fa5, 4(a0)
	fsw	fa5, 8(a0)
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	fcvt.s.d	fa5, fa0
	fsw	fa5, 0(a0)
	fsw	fa5, 4(a0)
	fsw	fa5, 8(a0)
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
