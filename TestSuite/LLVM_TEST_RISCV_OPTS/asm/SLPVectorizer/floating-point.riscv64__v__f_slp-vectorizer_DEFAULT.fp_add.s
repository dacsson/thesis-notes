# Source: SLPVectorizer/floating-point.riscv64__v__f_slp-vectorizer_DEFAULT.ll
# Function: fp_add
# src = pre-opt (fp_add), tgt = post-opt (fp_add)
# Triple: riscv64, Attrs: +v,+f
#

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
	flw	ft1, 0(a2)
	flw	ft0, 4(a2)
	flw	fa0, 8(a2)
	flw	fa1, 12(a2)
	fadd.s	fa2, fa2, ft1
	fadd.s	fa3, fa3, ft0
	fadd.s	fa4, fa4, fa0
	fadd.s	fa5, fa5, fa1
	fsw	fa2, 0(a0)
	fsw	fa3, 4(a0)
	fsw	fa4, 8(a0)
	fsw	fa5, 12(a0)
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
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a1)
                                        # implicit-def: $v10
	vle32.v	v10, (a2)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vfadd.vv	v8, v9, v10
	vse32.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
