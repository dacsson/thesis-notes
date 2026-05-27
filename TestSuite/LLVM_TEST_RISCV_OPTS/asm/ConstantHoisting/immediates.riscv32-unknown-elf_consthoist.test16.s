# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test16
# src = pre-opt (test16), tgt = post-opt (test16)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	mv	a3, a1
	mv	a1, a0
	slli	a2, a1, 16
	add	a0, a2, a1
	sltu	a2, a0, a2
	srli	a4, a1, 16
	slli	a1, a3, 16
	or	a1, a1, a4
	add	a1, a1, a3
	add	a2, a1, a2
	slli	a1, a2, 16
	srli	a3, a0, 16
	or	a1, a1, a3
	add	a1, a1, a2
	slli	a2, a0, 16
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
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
	mv	a3, a1
	mv	a1, a0
	slli	a2, a1, 16
	add	a0, a2, a1
	sltu	a2, a0, a2
	srli	a4, a1, 16
	slli	a1, a3, 16
	or	a1, a1, a4
	add	a1, a1, a3
	add	a2, a1, a2
	slli	a1, a2, 16
	srli	a3, a0, 16
	or	a1, a1, a3
	add	a1, a1, a2
	slli	a2, a0, 16
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
                                        # -- End function
