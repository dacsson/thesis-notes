# Source: LoopIdiom/popcnt.riscv32__zbb_loop-idiom_CPOP.ll
# Function: popcount_i64
# src = pre-opt (popcount_i64), tgt = post-opt (popcount_i64)
# Triple: riscv32, Attrs: +zbb
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	mv	a3, a1
	mv	a1, a3
	mv	a2, a0
	or	a0, a0, a3
	li	a3, 0
	sw	a3, 4(sp)                       # 4-byte Folded Spill
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	lw	a4, 8(sp)                       # 4-byte Folded Reload
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	addi	a3, a0, 1
	seqz	a0, a4
	sub	a0, a1, a0
	addi	a2, a4, -1
	and	a2, a2, a4
	and	a1, a0, a1
	or	a0, a2, a1
	sw	a3, 4(sp)                       # 4-byte Folded Spill
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %while.end
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	mv	a2, a1
	sw	a2, 32(sp)                      # 4-byte Folded Spill
	mv	a2, a0
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	cpop	a1, a1
	cpop	a0, a0
	add	a0, a0, a1
	sw	a0, 40(sp)                      # 4-byte Folded Spill
	li	a1, 0
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %while.body.preheader
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	lw	a1, 36(sp)                      # 4-byte Folded Reload
	lw	a3, 40(sp)                      # 4-byte Folded Reload
	li	a2, 0
	sw	a3, 16(sp)                      # 4-byte Folded Spill
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a2, 40(sp)                      # 4-byte Folded Reload
	lw	a3, 28(sp)                      # 4-byte Folded Reload
	lw	a6, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	addi	a5, a1, 1
	seqz	a1, a6
	sub	a1, a3, a1
	addi	a4, a6, -1
	and	a4, a4, a6
	and	a3, a1, a3
	addi	a1, a0, -1
	li	a0, 0
	mv	a6, a1
	sw	a6, 16(sp)                      # 4-byte Folded Spill
	sw	a5, 20(sp)                      # 4-byte Folded Spill
	sw	a4, 24(sp)                      # 4-byte Folded Spill
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	blt	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %while.end.loopexit
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %while.end
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
