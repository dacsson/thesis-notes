# Source: LoopVectorize/blend-any-of-reduction-cost.ll
# Function: any_of_reduction_used_in_blend
# src = pre-opt (any_of_reduction_used_in_blend), tgt = post-opt (any_of_reduction_used_in_blend)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_2
.LBB0_2:                                # %else.1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_3
.LBB0_3:                                # %else.2
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a0)
	li	a0, 0
	beq	a2, a0, .LBB0_7
# %bb.6:                                # %else.2
                                        #   in Loop: Header=BB0_1 Depth=1
	mv	a0, a1
.LBB0_7:                                # %else.2
                                        #   in Loop: Header=BB0_1 Depth=1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %loop.latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a2
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	mv	a3, a0
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_5
.LBB0_5:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_2
.LBB0_2:                                # %else.1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_3
.LBB0_3:                                # %else.2
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a0)
	li	a0, 0
	beq	a2, a0, .LBB0_7
# %bb.6:                                # %else.2
                                        #   in Loop: Header=BB0_1 Depth=1
	mv	a0, a1
.LBB0_7:                                # %else.2
                                        #   in Loop: Header=BB0_1 Depth=1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %loop.latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a2
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	mv	a3, a0
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_5
.LBB0_5:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
