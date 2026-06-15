# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	slli	a1, a0, 1
	slli	a0, a0, 15
	sub	a0, a0, a1
	lui	a1, 8
	addi	a1, a1, -2
	add	a0, a0, a1
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	slli	a1, a0, 1
	slli	a0, a0, 15
	sub	a0, a0, a1
	lui	a1, 8
	addi	a1, a1, -2
	add	a0, a0, a1
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
                                        # -- End function
