# Source: SLPVectorizer/load-store.riscv64__v_slp-vectorizer.ll
# Function: splat_store_i64
# src = pre-opt (splat_store_i64), tgt = post-opt (splat_store_i64)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a1
	mv	a1, a0
	lwu	a0, 0(a2)
	lwu	a2, 4(a2)
	sw	a2, 4(a1)
	sw	a0, 0(a1)
	srli	a3, a2, 16
	sh	a3, 14(a1)
	sh	a2, 12(a1)
	srli	a2, a0, 16
	sh	a2, 10(a1)
	sh	a0, 8(a1)
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a2, a1
	mv	a1, a0
	lwu	a0, 0(a2)
	lwu	a2, 4(a2)
	sw	a2, 4(a1)
	sw	a0, 0(a1)
	srli	a3, a2, 16
	sh	a3, 14(a1)
	sh	a2, 12(a1)
	srli	a2, a0, 16
	sh	a2, 10(a1)
	sh	a0, 8(a1)
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
