# Source: LoopIdiom/popcnt.riscv64__zbb_loop-idiom_CPOP.ll
# Function: popcount_i32
# src = pre-opt (popcount_i32), tgt = post-opt (popcount_i32)
# Triple: riscv64, Attrs: +zbb
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
	mv	a1, a0
	sext.w	a0, a1
	li	a2, 0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a2, a0, 1
	addiw	a0, a1, -1
	and	a1, a0, a1
	sext.w	a0, a1
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %while.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	cpopw	a0, a0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB1_4
	j	.LBB1_1
.LBB1_1:                                # %while.body.preheader
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a4, a1, 1
	addiw	a1, a3, -1
	and	a3, a1, a3
	addiw	a1, a0, -1
	li	a0, 0
	mv	a5, a1
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	sd	a4, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %while.end.loopexit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %while.end
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
