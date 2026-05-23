# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer_1.ll
# Function: dot_product_fp32_reorder
# src = pre-opt (dot_product_fp32_reorder), tgt = post-opt (dot_product_fp32_reorder)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	flw	fa1, 0(a0)
	flw	fa3, 4(a0)
	flw	fa5, 8(a0)
	flw	fa0, 0(a1)
	flw	fa2, 4(a1)
	flw	fa4, 8(a1)
	fmul.s	fa1, fa1, fa0
	fmadd.s	fa3, fa3, fa2, fa1
	fmadd.s	fa0, fa5, fa4, fa3
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	flw	fa1, 0(a0)
	flw	fa3, 4(a0)
	flw	fa5, 8(a0)
	flw	fa0, 0(a1)
	flw	fa2, 4(a1)
	flw	fa4, 8(a1)
	fmul.s	fa1, fa1, fa0
	fmadd.s	fa3, fa3, fa2, fa1
	fmadd.s	fa0, fa5, fa4, fa3
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
