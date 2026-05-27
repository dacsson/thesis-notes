# Source: SLPVectorizer/revec.riscv64_slp-vectorizer_1.ll
# Function: test5
# src = pre-opt (test5), tgt = post-opt (test5)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a0, 4095
	slli	a1, a0, 39
	li	a0, 0
	j	.LBB4_1
.LBB4_1:                                # %for.end47
	li	a0, 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	j	.LBB4_1
.LBB4_1:                                # %for.end47
	li	a0, 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
