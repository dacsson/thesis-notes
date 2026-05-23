# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test17
# src = pre-opt (test17), tgt = post-opt (test17)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	bnez	a1, .LBB16_2
	j	.LBB16_1
.LBB16_1:                               # %if.true
	lui	a1, 786432
	li	a0, 20
	sw	a0, 32(a1)
	j	.LBB16_2
.LBB16_2:                               # %exit
	lui	a1, 786432
	li	a0, 10
	sw	a0, 32(a1)
	ret
.Lfunc_end16:
	.size	src, .Lfunc_end16-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:                                # %entry
	addi	sp, sp, -16
	lui	a0, 786432
	addi	a0, a0, 32
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	bnez	a1, .LBB16_2
	j	.LBB16_1
.LBB16_1:                               # %if.true
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	li	a0, 20
	sw	a0, 0(a1)
	j	.LBB16_2
.LBB16_2:                               # %exit
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	li	a0, 10
	sw	a0, 0(a1)
	addi	sp, sp, 16
	ret
.Lfunc_end16:
	.size	tgt, .Lfunc_end16-tgt
                                        # -- End function
