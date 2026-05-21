# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test15
# src = pre-opt (test15), tgt = post-opt (test15)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	mv	a1, a0
	slli	a0, a1, 16
	sub	a1, a0, a1
	slli	a0, a1, 16
	sub	a0, a0, a1
	ret
.Lfunc_end14:
	.size	src, .Lfunc_end14-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	mv	a1, a0
	slli	a0, a1, 16
	sub	a1, a0, a1
	slli	a0, a1, 16
	sub	a0, a0, a1
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
                                        # -- End function
