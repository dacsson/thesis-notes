# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test8
# src = pre-opt (test8), tgt = post-opt (test8)
# Triple: riscv32-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	li	a1, 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	li	a1, 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
                                        # -- End function
