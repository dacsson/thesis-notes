# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test15
# src = pre-opt (test15), tgt = post-opt (test15)
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
	slli	a0, a2, 16
	sltu	a3, a0, a2
	srli	a5, a2, 16
	slli	a1, a4, 16
	or	a1, a1, a5
	sub	a1, a1, a4
	sub	a1, a1, a3
	sub	a2, a0, a2
	slli	a0, a1, 16
	srli	a3, a2, 16
	or	a0, a0, a3
	sub	a1, a0, a1
	slli	a0, a2, 16
	sltu	a3, a0, a2
	sub	a1, a1, a3
	sub	a0, a0, a2
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
	mv	a4, a1
	mv	a2, a0
	slli	a0, a2, 16
	sltu	a3, a0, a2
	srli	a5, a2, 16
	slli	a1, a4, 16
	or	a1, a1, a5
	sub	a1, a1, a4
	sub	a1, a1, a3
	sub	a2, a0, a2
	slli	a0, a1, 16
	srli	a3, a2, 16
	or	a0, a0, a3
	sub	a1, a0, a1
	slli	a0, a2, 16
	sltu	a3, a0, a2
	sub	a1, a1, a3
	sub	a0, a0, a2
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
                                        # -- End function
