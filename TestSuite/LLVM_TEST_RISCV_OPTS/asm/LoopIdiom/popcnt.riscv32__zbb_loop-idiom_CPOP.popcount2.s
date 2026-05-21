# Source: LoopIdiom/popcnt.riscv32__zbb_loop-idiom_CPOP.ll
# Function: popcount2
# src = pre-opt (popcount2), tgt = post-opt (popcount2)
# Triple: riscv32, Attrs: +zbb
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	mv	a4, a3
	mv	a3, a2
	mv	a5, a1
	mv	a1, a5
	mv	a2, a0
	or	a0, a0, a5
	li	a5, 0
	sw	a5, 24(sp)                      # 4-byte Folded Spill
	sw	a4, 28(sp)                      # 4-byte Folded Spill
	sw	a3, 32(sp)                      # 4-byte Folded Spill
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a5, 40(sp)                      # 4-byte Folded Reload
	lw	a3, 36(sp)                      # 4-byte Folded Reload
	lw	a1, 32(sp)                      # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a2, 4(sp)                       # 4-byte Folded Spill
	addi	a0, a0, 1
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	seqz	a2, a3
	sub	a4, a5, a2
	addi	a2, a3, -1
	and	a4, a4, a5
	sw	a4, 20(sp)                      # 4-byte Folded Spill
	and	a2, a2, a3
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	call	__mulsi3
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	call	__mulsi3
	lw	a5, 8(sp)                       # 4-byte Folded Reload
	lw	a3, 12(sp)                      # 4-byte Folded Reload
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	mv	a4, a0
	or	a0, a2, a1
	sw	a5, 24(sp)                      # 4-byte Folded Spill
	sw	a4, 28(sp)                      # 4-byte Folded Spill
	sw	a3, 32(sp)                      # 4-byte Folded Spill
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %while.end
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 32(sp)                      # 4-byte Folded Reload
	add	a0, a0, a2
	add	a0, a0, a1
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sw	a3, 60(sp)                      # 4-byte Folded Spill
	sw	a2, 64(sp)                      # 4-byte Folded Spill
	mv	a4, a1
	sw	a4, 68(sp)                      # 4-byte Folded Spill
	mv	a4, a0
	sw	a4, 72(sp)                      # 4-byte Folded Spill
	cpop	a1, a1
	cpop	a0, a0
	add	a0, a0, a1
	sw	a0, 76(sp)                      # 4-byte Folded Spill
	li	a1, 0
	sw	a1, 80(sp)                      # 4-byte Folded Spill
	sw	a3, 84(sp)                      # 4-byte Folded Spill
	sw	a2, 88(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB3_4
	j	.LBB3_1
.LBB3_1:                                # %while.body.preheader
	lw	a0, 68(sp)                      # 4-byte Folded Reload
	lw	a1, 72(sp)                      # 4-byte Folded Reload
	lw	a2, 64(sp)                      # 4-byte Folded Reload
	lw	a3, 60(sp)                      # 4-byte Folded Reload
	lw	a5, 76(sp)                      # 4-byte Folded Reload
	li	a4, 0
	sw	a5, 36(sp)                      # 4-byte Folded Spill
	sw	a4, 40(sp)                      # 4-byte Folded Spill
	sw	a3, 44(sp)                      # 4-byte Folded Spill
	sw	a2, 48(sp)                      # 4-byte Folded Spill
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a5, 56(sp)                      # 4-byte Folded Reload
	lw	a3, 52(sp)                      # 4-byte Folded Reload
	lw	a1, 48(sp)                      # 4-byte Folded Reload
	lw	a4, 44(sp)                      # 4-byte Folded Reload
	lw	a0, 40(sp)                      # 4-byte Folded Reload
	lw	a2, 36(sp)                      # 4-byte Folded Reload
	sw	a4, 0(sp)                       # 4-byte Folded Spill
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	addi	a0, a0, 1
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	seqz	a2, a3
	sub	a4, a5, a2
	addi	a2, a3, -1
	and	a4, a4, a5
	sw	a4, 12(sp)                      # 4-byte Folded Spill
	and	a2, a2, a3
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	call	__mulsi3
	lw	a1, 0(sp)                       # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	call	__mulsi3
	lw	a7, 4(sp)                       # 4-byte Folded Reload
	lw	a6, 8(sp)                       # 4-byte Folded Reload
	lw	a5, 12(sp)                      # 4-byte Folded Reload
	lw	a4, 76(sp)                      # 4-byte Folded Reload
	lw	a3, 16(sp)                      # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	addi	a1, a0, -1
	li	a0, 0
	mv	t0, a1
	sw	t0, 36(sp)                      # 4-byte Folded Spill
	sw	a7, 40(sp)                      # 4-byte Folded Spill
	mv	a7, a2
	sw	a7, 44(sp)                      # 4-byte Folded Spill
	mv	a7, a3
	sw	a7, 48(sp)                      # 4-byte Folded Spill
	sw	a6, 52(sp)                      # 4-byte Folded Spill
	sw	a5, 56(sp)                      # 4-byte Folded Spill
	sw	a4, 24(sp)                      # 4-byte Folded Spill
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	sw	a2, 32(sp)                      # 4-byte Folded Spill
	blt	a0, a1, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %while.end.loopexit
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	lw	a1, 32(sp)                      # 4-byte Folded Reload
	sw	a2, 80(sp)                      # 4-byte Folded Spill
	sw	a1, 84(sp)                      # 4-byte Folded Spill
	sw	a0, 88(sp)                      # 4-byte Folded Spill
	j	.LBB3_4
.LBB3_4:                                # %while.end
	lw	a1, 80(sp)                      # 4-byte Folded Reload
	lw	a0, 84(sp)                      # 4-byte Folded Reload
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	add	a0, a0, a2
	add	a0, a0, a1
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
