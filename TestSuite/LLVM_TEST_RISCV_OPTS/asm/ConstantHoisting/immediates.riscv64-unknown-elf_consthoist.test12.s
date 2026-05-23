# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test12
# src = pre-opt (test12), tgt = post-opt (test12)
# Triple: riscv64-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
                                        # -- End function
