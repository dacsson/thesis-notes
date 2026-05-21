# Source: SLPVectorizer/interleave-greater-than-slice.riscv64-unknown-linux__v__zvl128b_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux, Attrs: +v,+zvl128b
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	ld	a1, 0(a0)
	flw	fa5, 84(a1)
	fmv.w.x	fa3, zero
	fmadd.s	fa4, fa5, fa3, fa3
	flw	fa5, 28(a1)
	fmadd.s	fa4, fa5, fa3, fa4
	flw	fa5, 8(a1)
	fmadd.s	fa2, fa5, fa3, fa3
	flw	fa5, 68(a1)
	fmadd.s	fa5, fa5, fa3, fa4
	flw	fa4, 88(a1)
	fmadd.s	fa2, fa4, fa3, fa2
	flw	fa4, 92(a1)
	fmadd.s	fa4, fa4, fa3, fa2
	fmadd.s	fa2, fa0, fa3, fa5
	flw	fa5, 96(a1)
	fmadd.s	fa4, fa5, fa3, fa4
	flw	fa5, 80(a1)
	fmadd.s	fa5, fa0, fa5, fa4
	flw	fa4, 100(a1)
	fmadd.s	fa4, fa4, fa3, fa2
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a0)
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
	ld	a1, 0(a0)
	flw	fa5, 84(a1)
	fmv.w.x	fa3, zero
	fmadd.s	fa4, fa5, fa3, fa3
	flw	fa5, 28(a1)
	fmadd.s	fa4, fa5, fa3, fa4
	flw	fa5, 8(a1)
	fmadd.s	fa2, fa5, fa3, fa3
	flw	fa5, 68(a1)
	fmadd.s	fa5, fa5, fa3, fa4
	flw	fa4, 88(a1)
	fmadd.s	fa2, fa4, fa3, fa2
	flw	fa4, 92(a1)
	fmadd.s	fa4, fa4, fa3, fa2
	fmadd.s	fa2, fa0, fa3, fa5
	flw	fa5, 96(a1)
	fmadd.s	fa4, fa5, fa3, fa4
	flw	fa5, 80(a1)
	fmadd.s	fa5, fa0, fa5, fa4
	flw	fa4, 100(a1)
	fmadd.s	fa4, fa4, fa3, fa2
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
