# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test18
# src = pre-opt (test18), tgt = post-opt (test18)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	addi	sp, sp, -16
	bnez	a1, .LBB17_2
	j	.LBB17_1
.LBB17_1:                               # %if.true
	lui	a0, 786432
	lw	a0, 32(a0)
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB17_3
.LBB17_2:                               # %if.false
	lui	a0, 786432
	lw	a0, 32(a0)
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB17_3
.LBB17_3:                               # %return
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end17:
	.size	src, .Lfunc_end17-src
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
	bnez	a1, .LBB17_2
	j	.LBB17_1
.LBB17_1:                               # %if.true
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 0(a0)
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	j	.LBB17_3
.LBB17_2:                               # %if.false
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 0(a0)
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	j	.LBB17_3
.LBB17_3:                               # %return
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end17:
	.size	tgt, .Lfunc_end17-tgt
                                        # -- End function
