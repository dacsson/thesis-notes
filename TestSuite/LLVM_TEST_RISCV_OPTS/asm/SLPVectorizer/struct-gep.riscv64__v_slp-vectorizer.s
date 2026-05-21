# Source: SLPVectorizer/struct-gep.riscv64__v_slp-vectorizer.ll
# Function: splat_store_v2i32
# src = pre-opt (splat_store_v2i32), tgt = post-opt (splat_store_v2i32)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	slli	a1, a1, 3
	add	a1, a0, a1
	li	a0, 1
	sw	a0, 0(a1)
	sw	a0, 4(a1)
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
	slli	a1, a1, 3
	add	a1, a0, a1
	li	a0, 1
	sw	a0, 0(a1)
	sw	a0, 4(a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
