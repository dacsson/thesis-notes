# Source: SLPVectorizer/revec-strided-store.riscv64_slp-vectorizer.ll
# Function: widened_strided_store
# src = pre-opt (widened_strided_store), tgt = post-opt (widened_strided_store)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 0
	sh	a0, 38(zero)
	sh	a0, 36(zero)
	sh	a0, 34(zero)
	sh	a0, 32(zero)
	sh	a0, 6(zero)
	sh	a0, 4(zero)
	sh	a0, 2(zero)
	sh	a0, 0(zero)
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv.v.i	v8, 0
	li	a0, 32
	vse16.v	v8, (a0)
	li	a0, 0
	vse16.v	v8, (a0)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
