# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: one_uncountable_two_countable_exits
# src = pre-opt (one_uncountable_two_countable_exits), tgt = post-opt (one_uncountable_two_countable_exits)
# Triple: riscv64, Attrs: +v
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 3
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB18_1
.LBB18_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a1, 64
	beq	a0, a1, .LBB18_4
	j	.LBB18_2
.LBB18_2:                               # %update
                                        #   in Loop: Header=BB18_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	add	a3, a2, a1
	lbu	a2, 0(a3)
	addiw	a2, a2, 1
	sb	a2, 0(a3)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 37
	beq	a0, a1, .LBB18_4
	j	.LBB18_3
.LBB18_3:                               # %loop.inc
                                        #   in Loop: Header=BB18_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 128
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB18_1
	j	.LBB18_4
.LBB18_4:                               # %loop.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end18:
	.size	src, .Lfunc_end18-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 3
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB18_1
.LBB18_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a1, 64
	beq	a0, a1, .LBB18_4
	j	.LBB18_2
.LBB18_2:                               # %update
                                        #   in Loop: Header=BB18_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	add	a3, a2, a1
	lbu	a2, 0(a3)
	addiw	a2, a2, 1
	sb	a2, 0(a3)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 37
	beq	a0, a1, .LBB18_4
	j	.LBB18_3
.LBB18_3:                               # %loop.inc
                                        #   in Loop: Header=BB18_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 128
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB18_1
	j	.LBB18_4
.LBB18_4:                               # %loop.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end18:
	.size	tgt, .Lfunc_end18-tgt
	.cfi_endproc
                                        # -- End function
