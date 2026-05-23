# Source: SLPVectorizer/rvv-min-vector-size.riscv64__v_slp-vectorizer_1.ll
# Function: foo
# src = pre-opt (foo), tgt = post-opt (foo)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	li	a0, 0
	sd	a0, 0(a1)
	sd	a0, 8(a1)
	sd	a0, 16(a1)
	sd	a0, 24(a1)
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
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.i	v8, 0
	vse64.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
