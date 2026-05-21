# Source: LoopIdiom/popcnt.riscv64__zbb_loop-idiom_CPOP.ll
# Function: popcount_i64
# src = pre-opt (popcount_i64), tgt = post-opt (popcount_i64)
# Triple: riscv64, Attrs: +zbb
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a1, a0, 1
	addi	a0, a2, -1
	and	a0, a0, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %while.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	cpop	a0, a0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %while.body.preheader
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a4, a1, 1
	addi	a1, a3, -1
	and	a3, a1, a3
	addiw	a1, a0, -1
	li	a0, 0
	mv	a5, a1
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	sd	a4, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %while.end.loopexit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %while.end
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
