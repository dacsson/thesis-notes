# Source: SLPVectorizer/gep.riscv64__v_slp-vectorizer.ll
# Function: copy_with_offset_v2i8
# src = pre-opt (copy_with_offset_v2i8), tgt = post-opt (copy_with_offset_v2i8)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lbu	a2, 8(a0)
	sb	a2, 16(a1)
	lbu	a0, 9(a0)
	sb	a0, 17(a1)
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
	lbu	a2, 8(a0)
	sb	a2, 16(a1)
	lbu	a0, 9(a0)
	sb	a0, 17(a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
