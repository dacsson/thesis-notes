# Source: LoopIdiom/popcnt.riscv64_loop-idiom_NOCPOP.ll
# Function: popcount_i64
# src = pre-opt (popcount_i64), tgt = post-opt (popcount_i64)
# Triple: riscv64, Attrs: none
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %while.body.preheader
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a1, a0, 1
	addi	a0, a2, -1
	and	a0, a0, a2
	mv	a2, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %while.end.loopexit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %while.end
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
