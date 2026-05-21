# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test11
# src = pre-opt (test11), tgt = post-opt (test11)
# Triple: riscv32-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	ori	a1, a1, 2
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	ori	a1, a1, 2
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
                                        # -- End function
