# Source: LoopVectorize/blend-any-of-reduction-cost.ll
# Function: any_of_reduction_used_in_blend_with_multiple_phis
# src = pre-opt (any_of_reduction_used_in_blend_with_multiple_phis), tgt = post-opt (any_of_reduction_used_in_blend_with_multiple_phis)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_2
.LBB1_2:                                # %else.1
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_3
.LBB1_3:                                # %else.2
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a0)
	li	a0, 0
	beq	a2, a0, .LBB1_8
# %bb.7:                                # %else.2
                                        #   in Loop: Header=BB1_1 Depth=1
	mv	a0, a1
.LBB1_8:                                # %else.2
                                        #   in Loop: Header=BB1_1 Depth=1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_4:                                # %x.1
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_5:                                # %loop.latch
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a2
	sd	a3, 80(sp)                      # 8-byte Folded Spill
	mv	a3, a0
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_6
.LBB1_6:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_2
.LBB1_2:                                # %else.1
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_3
.LBB1_3:                                # %else.2
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a0)
	li	a0, 0
	beq	a2, a0, .LBB1_8
# %bb.7:                                # %else.2
                                        #   in Loop: Header=BB1_1 Depth=1
	mv	a0, a1
.LBB1_8:                                # %else.2
                                        #   in Loop: Header=BB1_1 Depth=1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_4:                                # %x.1
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_5:                                # %loop.latch
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a2
	sd	a3, 80(sp)                      # 8-byte Folded Spill
	mv	a3, a0
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_6
.LBB1_6:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
