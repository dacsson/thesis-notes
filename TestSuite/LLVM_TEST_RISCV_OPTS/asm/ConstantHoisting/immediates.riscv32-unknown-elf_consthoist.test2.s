# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	mv	a4, a1
	mv	a2, a0
	slli	a0, a2, 11
	sltu	a3, a0, a2
	srli	a5, a2, 21
	slli	a1, a4, 11
	or	a1, a1, a5
	sub	a1, a1, a4
	sub	a1, a1, a3
	sub	a2, a0, a2
	addi	a0, a2, 2047
	sltu	a2, a0, a2
	add	a1, a1, a2
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
	mv	a4, a1
	mv	a2, a0
	slli	a0, a2, 11
	sltu	a3, a0, a2
	srli	a5, a2, 21
	slli	a1, a4, 11
	or	a1, a1, a5
	sub	a1, a1, a4
	sub	a1, a1, a3
	sub	a2, a0, a2
	addi	a0, a2, 2047
	sltu	a2, a0, a2
	add	a1, a1, a2
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
                                        # -- End function
