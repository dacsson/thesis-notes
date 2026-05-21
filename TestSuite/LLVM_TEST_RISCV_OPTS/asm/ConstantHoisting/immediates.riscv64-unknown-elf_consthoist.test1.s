# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	slli	a0, a0, 1
	addi	a0, a0, 2
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	slli	a0, a0, 1
	addi	a0, a0, 2
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
                                        # -- End function
