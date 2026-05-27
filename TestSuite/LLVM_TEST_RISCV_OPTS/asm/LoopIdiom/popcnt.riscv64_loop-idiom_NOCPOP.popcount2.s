# Source: LoopIdiom/popcnt.riscv64_loop-idiom_NOCPOP.ll
# Function: popcount2
# src = pre-opt (popcount2), tgt = post-opt (popcount2)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	li	a3, 0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addiw	a0, a0, 1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	addi	a2, a3, -1
	and	a2, a2, a3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %while.end
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a2
	addw	a0, a0, a1
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
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
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	li	a3, 0
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB3_4
	j	.LBB3_1
.LBB3_1:                                # %while.body.preheader
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	li	a3, 0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addiw	a0, a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	addi	a2, a3, -1
	and	a2, a2, a3
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	mv	a4, a3
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	mv	a4, a1
	sd	a4, 64(sp)                      # 8-byte Folded Spill
	mv	a4, a2
	sd	a4, 72(sp)                      # 8-byte Folded Spill
	mv	a4, a0
	sd	a4, 80(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %while.end.loopexit
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	j	.LBB3_4
.LBB3_4:                                # %while.end
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	addw	a0, a0, a2
	addw	a0, a0, a1
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
