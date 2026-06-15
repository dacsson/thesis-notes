# Source: LoopIdiom/popcnt.riscv32_loop-idiom_NOCPOP.ll
# Function: popcount_i128
# src = pre-opt (popcount_i128), tgt = post-opt (popcount_i128)
# Triple: riscv32, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	lw	a2, 8(a0)
	lw	a4, 0(a0)
	lw	a1, 12(a0)
	lw	a3, 4(a0)
	or	a5, a3, a1
	or	a0, a4, a2
	or	a0, a0, a5
	li	a5, 0
	sw	a5, 12(sp)                      # 4-byte Folded Spill
	sw	a4, 16(sp)                      # 4-byte Folded Spill
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a7, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	t0, 20(sp)                      # 4-byte Folded Reload
	lw	a6, 16(sp)                      # 4-byte Folded Reload
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	addi	a5, a0, 1
	or	a0, a6, t0
	seqz	a1, a0
	sub	a0, a2, a1
	sltu	a1, a2, a1
	sub	a1, a7, a1
	seqz	a3, a6
	sub	a3, t0, a3
	addi	a4, a6, -1
	and	a3, a3, t0
	and	a1, a1, a7
	and	a4, a4, a6
	and	a2, a0, a2
	or	a0, a4, a2
	or	a6, a3, a1
	or	a0, a0, a6
	sw	a5, 12(sp)                      # 4-byte Folded Spill
	sw	a4, 16(sp)                      # 4-byte Folded Spill
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %while.end
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	mv	a1, a0
	lw	a2, 8(a1)
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	lw	a0, 0(a1)
	sw	a0, 32(sp)                      # 4-byte Folded Spill
	lw	a3, 12(a1)
	sw	a3, 36(sp)                      # 4-byte Folded Spill
	lw	a1, 4(a1)
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	or	a1, a1, a3
	or	a0, a0, a2
	or	a0, a0, a1
	li	a1, 0
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB2_4
	j	.LBB2_1
.LBB2_1:                                # %while.body.preheader
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 40(sp)                      # 4-byte Folded Reload
	lw	a3, 32(sp)                      # 4-byte Folded Reload
	li	a4, 0
	sw	a4, 8(sp)                       # 4-byte Folded Spill
	sw	a3, 12(sp)                      # 4-byte Folded Spill
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a7, 24(sp)                      # 4-byte Folded Reload
	lw	a3, 20(sp)                      # 4-byte Folded Reload
	lw	t0, 16(sp)                      # 4-byte Folded Reload
	lw	a6, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	addi	a1, a0, 1
	or	a0, a6, t0
	seqz	a2, a0
	sub	a0, a3, a2
	sltu	a2, a3, a2
	sub	a2, a7, a2
	seqz	a4, a6
	sub	a4, t0, a4
	addi	a5, a6, -1
	and	a4, a4, t0
	and	a2, a2, a7
	and	a5, a5, a6
	and	a3, a0, a3
	or	a0, a5, a3
	or	a6, a4, a2
	or	a0, a0, a6
	mv	a6, a1
	sw	a6, 8(sp)                       # 4-byte Folded Spill
	sw	a5, 12(sp)                      # 4-byte Folded Spill
	sw	a4, 16(sp)                      # 4-byte Folded Spill
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %while.end.loopexit
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
	j	.LBB2_4
.LBB2_4:                                # %while.end
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
