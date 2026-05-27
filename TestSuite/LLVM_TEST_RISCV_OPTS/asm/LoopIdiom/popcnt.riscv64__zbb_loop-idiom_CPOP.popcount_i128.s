# Source: LoopIdiom/popcnt.riscv64__zbb_loop-idiom_CPOP.ll
# Function: popcount_i128
# src = pre-opt (popcount_i128), tgt = post-opt (popcount_i128)
# Triple: riscv64, Attrs: +zbb
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
	mv	a3, a1
	mv	a1, a3
	mv	a2, a0
	or	a0, a0, a3
	li	a3, 0
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addiw	a3, a0, 1
	seqz	a0, a4
	sub	a0, a1, a0
	addi	a2, a4, -1
	and	a2, a2, a4
	and	a1, a0, a1
	or	a0, a2, a1
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %while.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	mv	a2, a1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	cpop	a1, a1
	cpop	a0, a0
	add	a0, a0, a1
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB2_4
	j	.LBB2_1
.LBB2_1:                                # %while.body.preheader
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a6, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a5, a1, 1
	seqz	a1, a6
	sub	a1, a3, a1
	addi	a4, a6, -1
	and	a4, a4, a6
	and	a3, a1, a3
	addiw	a1, a0, -1
	li	a0, 0
	mv	a6, a1
	sd	a6, 16(sp)                      # 8-byte Folded Spill
	sd	a5, 24(sp)                      # 8-byte Folded Spill
	sd	a4, 32(sp)                      # 8-byte Folded Spill
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %while.end.loopexit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB2_4
.LBB2_4:                                # %while.end
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
