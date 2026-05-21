# Source: SLPVectorizer/partial-vec-invalid-cost.slp-vectorizer.ll
# Function: partial_vec_invalid_cost
# src = pre-opt (partial_vec_invalid_cost), tgt = post-opt (partial_vec_invalid_cost)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	li	a0, 0
	sw	a0, 8(zero)
	sd	a0, 0(zero)
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
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	slli	a0, a0, 32
	srli	a0, a0, 32
	li	a1, 0
	sw	a1, 8(zero)
	sd	a0, 0(zero)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
