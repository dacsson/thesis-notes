# Source: SLPVectorizer/load-store.riscv64__v_slp-vectorizer_DEFAULT.ll
# Function: store_arbitrary_constant_i32
# src = pre-opt (store_arbitrary_constant_i32), tgt = post-opt (store_arbitrary_constant_i32)
# Triple: riscv64, Attrs: +v
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
	sw	a0, 0(a1)
	li	a2, -1
	sh	a2, 6(a1)
	li	a2, -33
	sh	a2, 4(a1)
	sh	a0, 10(a1)
	li	a2, 44
	sh	a2, 8(a1)
	sh	a0, 14(a1)
	li	a0, 77
	sh	a0, 12(a1)
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	li	a0, 0
	sw	a0, 0(a1)
	li	a2, -1
	sh	a2, 6(a1)
	li	a2, -33
	sh	a2, 4(a1)
	sh	a0, 10(a1)
	li	a2, 44
	sh	a2, 8(a1)
	sh	a0, 14(a1)
	li	a0, 77
	sh	a0, 12(a1)
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
