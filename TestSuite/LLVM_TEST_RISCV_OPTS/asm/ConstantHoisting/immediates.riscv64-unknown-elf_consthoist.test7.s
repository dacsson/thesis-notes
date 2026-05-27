# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test7
# src = pre-opt (test7), tgt = post-opt (test7)
# Triple: riscv64-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	slli	a0, a0, 32
	srli	a0, a0, 32
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	slli	a0, a0, 32
	srli	a0, a0, 32
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
                                        # -- End function
