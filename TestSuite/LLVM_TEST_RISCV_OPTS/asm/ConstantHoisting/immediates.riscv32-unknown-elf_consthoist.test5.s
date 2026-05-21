# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test5
# src = pre-opt (test5), tgt = post-opt (test5)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	slli	a0, a0, 16
	srli	a0, a0, 16
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	slli	a0, a0, 16
	srli	a0, a0, 16
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
                                        # -- End function
