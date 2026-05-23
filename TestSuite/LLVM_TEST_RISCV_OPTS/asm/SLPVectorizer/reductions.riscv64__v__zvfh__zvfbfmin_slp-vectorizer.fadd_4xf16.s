# Source: SLPVectorizer/reductions.riscv64__v__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: fadd_4xf16
# src = pre-opt (fadd_4xf16), tgt = post-opt (fadd_4xf16)
# Triple: riscv64, Attrs: +v,+zvfh,+zvfbfmin
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
	fadd.s	fa5, fa5, fa2
	fcvt.s.h	fa3, fa3
	fadd.s	fa5, fa5, fa3
	fcvt.s.h	fa4, fa4
	fadd.s	fa5, fa5, fa4
	fcvt.h.s	fa0, fa5
	ret
.Lfunc_end23:
	.size	src, .Lfunc_end23-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vle16.v	v9, (a0)
                                        # implicit-def: $v10
	vmv.s.x	v10, zero
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vfredusum.vs	v8, v9, v10
	vfmv.f.s	fa0, v8
	ret
.Lfunc_end23:
	.size	tgt, .Lfunc_end23-tgt
	.cfi_endproc
                                        # -- End function
