# Source: SLPVectorizer/revec-strided-store.riscv64_slp-vectorizer.ll
# Function: non_aligned_stride_scalar
# src = pre-opt (non_aligned_stride_scalar), tgt = post-opt (non_aligned_stride_scalar)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	li	a0, 0
	sb	a0, 0(a1)
	sb	a0, 1(a1)
	sb	a0, 3(a1)
	sb	a0, 4(a1)
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	addi	a0, a1, 3
                                        # implicit-def: $v8
	vsetivli	zero, 2, e8, mf8, tu, ma
	vmv.v.i	v8, 0
	vse8.v	v8, (a1)
	vse8.v	v8, (a0)
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
