# Source: SLPVectorizer/revec.riscv64_slp-vectorizer.ll
# Function: test4
# src = pre-opt (test4), tgt = post-opt (test4)
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
	j	.LBB3_1
.LBB3_1:
	j	.LBB3_2
.LBB3_2:
	li	a0, 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, mf2, tu, ma
	vmv.v.i	v8, 0
	j	.LBB3_1
.LBB3_1:
	j	.LBB3_2
.LBB3_2:
	li	a0, 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
