# Source: SLPVectorizer/remarks_cmp_sel_min_max.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: min_double
# src = pre-opt (min_double), tgt = post-opt (min_double)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	fld	fa5, 80(a1)
	fmv.d.x	fa4, zero
	fmin.d	fa5, fa5, fa4
	fsd	fa5, 0(a0)
	fld	fa5, 88(a1)
	fmin.d	fa5, fa5, fa4
	fsd	fa5, 8(a0)
                                        # implicit-def: $x10
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
	addi	a1, a1, 80
                                        # implicit-def: $v9
	vsetivli	zero, 2, e64, m1, tu, ma
	vle64.v	v9, (a1)
	fmv.d.x	fa5, zero
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vfmin.vf	v8, v9, fa5
	vse64.v	v8, (a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
