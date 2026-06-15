# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test9
# src = pre-opt (test9), tgt = post-opt (test9)
# Triple: riscv32-unknown-elf, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	li	a1, 0
	mv	a0, a1
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	li	a1, 0
	mv	a0, a1
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
                                        # -- End function
