# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test13
# src = pre-opt (test13), tgt = post-opt (test13)
# Triple: riscv32-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	bclri	a1, a1, 16
	ret
.Lfunc_end12:
	.size	src, .Lfunc_end12-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	bclri	a1, a1, 16
	ret
.Lfunc_end12:
	.size	tgt, .Lfunc_end12-tgt
                                        # -- End function
