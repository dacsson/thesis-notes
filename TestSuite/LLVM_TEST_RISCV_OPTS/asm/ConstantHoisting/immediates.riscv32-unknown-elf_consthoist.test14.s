# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test14
# src = pre-opt (test14), tgt = post-opt (test14)
# Triple: riscv32-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	srli	a2, a0, 10
	slli	a1, a1, 22
	or	a1, a1, a2
	slli	a0, a0, 22
	ret
.Lfunc_end13:
	.size	src, .Lfunc_end13-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	srli	a2, a0, 10
	slli	a1, a1, 22
	or	a1, a1, a2
	slli	a0, a0, 22
	ret
.Lfunc_end13:
	.size	tgt, .Lfunc_end13-tgt
                                        # -- End function
