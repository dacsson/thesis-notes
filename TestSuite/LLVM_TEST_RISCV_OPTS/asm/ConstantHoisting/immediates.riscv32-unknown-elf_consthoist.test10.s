# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test10
# src = pre-opt (test10), tgt = post-opt (test10)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	slli	a0, a0, 24
	srli	a0, a0, 16
	slli	a1, a1, 24
	srli	a1, a1, 16
	tail	__mulsi3
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	slli	a0, a0, 24
	srli	a0, a0, 16
	slli	a1, a1, 24
	srli	a1, a1, 16
	tail	__mulsi3
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
                                        # -- End function
