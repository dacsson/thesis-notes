# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	mv	a1, a0
	slli	a0, a1, 11
	sub	a0, a0, a1
	addi	a0, a0, 2047
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	mv	a1, a0
	slli	a0, a1, 11
	sub	a0, a0, a1
	addi	a0, a0, 2047
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
                                        # -- End function
