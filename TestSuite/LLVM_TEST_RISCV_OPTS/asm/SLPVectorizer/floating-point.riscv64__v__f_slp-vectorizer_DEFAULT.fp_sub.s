# Source: SLPVectorizer/floating-point.riscv64__v__f_slp-vectorizer_DEFAULT.ll
# Function: fp_sub
# src = pre-opt (fp_sub), tgt = post-opt (fp_sub)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	flw	fa2, 0(a1)
	flw	fa3, 4(a1)
	flw	fa4, 8(a1)
	flw	fa5, 12(a1)
	lui	a1, 263168
	fmv.w.x	fa1, a1
	fsub.s	fa2, fa2, fa1
	fsub.s	fa3, fa3, fa1
	fsub.s	fa4, fa4, fa1
	fsub.s	fa5, fa5, fa1
	fsw	fa2, 0(a0)
	fsw	fa3, 4(a0)
	fsw	fa4, 8(a0)
	fsw	fa5, 12(a0)
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a1)
	lui	a1, 787456
	fmv.w.x	fa5, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vfadd.vf	v8, v9, fa5
	vse32.v	v8, (a0)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
