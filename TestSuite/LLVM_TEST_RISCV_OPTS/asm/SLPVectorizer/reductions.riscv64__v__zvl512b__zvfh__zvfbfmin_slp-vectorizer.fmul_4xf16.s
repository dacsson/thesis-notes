# Source: SLPVectorizer/reductions.riscv64__v__zvl512b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: fmul_4xf16
# src = pre-opt (fmul_4xf16), tgt = post-opt (fmul_4xf16)
# Triple: riscv64, Attrs: +v,+zvl512b,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	flh	fa5, 0(a0)
	flh	fa2, 2(a0)
	flh	fa3, 4(a0)
	flh	fa4, 6(a0)
	fcvt.s.h	fa2, fa2
	fcvt.s.h	fa5, fa5
	fmul.s	fa5, fa5, fa2
	fcvt.s.h	fa3, fa3
	fmul.s	fa5, fa5, fa3
	fcvt.s.h	fa4, fa4
	fmul.s	fa5, fa5, fa4
	fcvt.h.s	fa0, fa5
	ret
.Lfunc_end24:
	.size	src, .Lfunc_end24-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	flh	fa5, 0(a0)
	flh	fa2, 2(a0)
	flh	fa3, 4(a0)
	flh	fa4, 6(a0)
	fcvt.s.h	fa2, fa2
	fcvt.s.h	fa5, fa5
	fmul.s	fa5, fa5, fa2
	fcvt.s.h	fa3, fa3
	fmul.s	fa5, fa5, fa3
	fcvt.s.h	fa4, fa4
	fmul.s	fa5, fa5, fa4
	fcvt.h.s	fa0, fa5
	ret
.Lfunc_end24:
	.size	tgt, .Lfunc_end24-tgt
	.cfi_endproc
                                        # -- End function
