# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test16
# src = pre-opt (test16), tgt = post-opt (test16)
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
	add	a1, a0, a1
	slli	a0, a1, 16
	add	a0, a0, a1
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	mv	a1, a0
	slli	a0, a1, 16
	add	a1, a0, a1
	slli	a0, a1, 16
	add	a0, a0, a1
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
                                        # -- End function
