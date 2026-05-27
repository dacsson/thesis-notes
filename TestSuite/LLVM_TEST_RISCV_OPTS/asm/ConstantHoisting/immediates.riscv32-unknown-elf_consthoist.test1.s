# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv32-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	srli	a2, a0, 31
	slli	a1, a1, 1
	or	a1, a1, a2
	slli	a2, a0, 1
	addi	a0, a2, 2
	sltu	a2, a0, a2
	add	a1, a1, a2
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	srli	a2, a0, 31
	slli	a1, a1, 1
	or	a1, a1, a2
	slli	a2, a0, 1
	addi	a0, a2, 2
	sltu	a2, a0, a2
	add	a1, a1, a2
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
                                        # -- End function
