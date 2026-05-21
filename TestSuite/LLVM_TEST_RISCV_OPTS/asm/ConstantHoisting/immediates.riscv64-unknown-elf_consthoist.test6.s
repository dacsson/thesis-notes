# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test6
# src = pre-opt (test6), tgt = post-opt (test6)
# Triple: riscv64-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	zext.h	a0, a0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	zext.h	a0, a0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
                                        # -- End function
