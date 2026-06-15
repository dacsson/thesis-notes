# Source: SLPVectorizer/revec-strided-store.riscv64_slp-vectorizer.ll
# Function: too_wide
# src = pre-opt (too_wide), tgt = post-opt (too_wide)
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
	sh	a0, 14(a1)
	sh	a0, 12(a1)
	sh	a0, 10(a1)
	sh	a0, 8(a1)
	sh	a0, 6(a1)
	sh	a0, 4(a1)
	sh	a0, 2(a1)
	sh	a0, 0(a1)
	sh	a0, 30(a1)
	sh	a0, 28(a1)
	sh	a0, 26(a1)
	sh	a0, 24(a1)
	sh	a0, 22(a1)
	sh	a0, 20(a1)
	sh	a0, 18(a1)
	sh	a0, 16(a1)
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
# %bb.0:                                # %entry
                                        # implicit-def: $v8m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vmv.v.i	v8, 0
	vse16.v	v8, (a0)
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
