# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test19
# src = pre-opt (test19), tgt = post-opt (test19)
# Triple: riscv64-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	sext.w	a0, a1
	bnez	a0, .LBB18_2
	j	.LBB18_1
.LBB18_1:                               # %if.true
	li	a0, 20
	sw	a0, 2044(zero)
	j	.LBB18_2
.LBB18_2:                               # %exit
	li	a0, 10
	sw	a0, 2044(zero)
	ret
.Lfunc_end18:
	.size	src, .Lfunc_end18-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:                                # %entry
	sext.w	a0, a1
	bnez	a0, .LBB18_2
	j	.LBB18_1
.LBB18_1:                               # %if.true
	li	a0, 20
	sw	a0, 2044(zero)
	j	.LBB18_2
.LBB18_2:                               # %exit
	li	a0, 10
	sw	a0, 2044(zero)
	ret
.Lfunc_end18:
	.size	tgt, .Lfunc_end18-tgt
                                        # -- End function
