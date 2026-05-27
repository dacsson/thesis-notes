# Source: LoopIdiom/popcnt.riscv32_loop-idiom_NOCPOP.ll
# Function: popcount_i32
# src = pre-opt (popcount_i32), tgt = post-opt (popcount_i32)
# Triple: riscv32, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a1, 0
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	mv	a1, a0
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	addi	a1, a0, 1
	addi	a0, a2, -1
	and	a0, a0, a2
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	mv	a1, a0
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %while.end
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	li	a1, 0
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_4
	j	.LBB1_1
.LBB1_1:                                # %while.body.preheader
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	li	a1, 0
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	addi	a1, a0, 1
	addi	a0, a2, -1
	and	a0, a0, a2
	mv	a2, a1
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	mv	a2, a0
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %while.end.loopexit
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %while.end
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
