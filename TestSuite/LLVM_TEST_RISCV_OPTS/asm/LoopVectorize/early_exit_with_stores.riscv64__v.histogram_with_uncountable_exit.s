# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: histogram_with_uncountable_exit
# src = pre-opt (histogram_with_uncountable_exit), tgt = post-opt (histogram_with_uncountable_exit)
# Triple: riscv64, Attrs: +v
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB15_1
.LBB15_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a4, a1, 2
	add	a3, a3, a4
	lwu	a3, 0(a3)
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	addiw	a2, a2, 1
	sw	a2, 0(a3)
	slli	a1, a1, 1
	add	a0, a0, a1
	lh	a1, 0(a0)
	li	a0, 500
	blt	a0, a1, .LBB15_3
	j	.LBB15_2
.LBB15_2:                               # %for.inc
                                        #   in Loop: Header=BB15_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB15_1
	j	.LBB15_3
.LBB15_3:                               # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB15_1
.LBB15_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a4, a1, 2
	add	a3, a3, a4
	lwu	a3, 0(a3)
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	addiw	a2, a2, 1
	sw	a2, 0(a3)
	slli	a1, a1, 1
	add	a0, a0, a1
	lh	a1, 0(a0)
	li	a0, 500
	blt	a0, a1, .LBB15_3
	j	.LBB15_2
.LBB15_2:                               # %for.inc
                                        #   in Loop: Header=BB15_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB15_1
	j	.LBB15_3
.LBB15_3:                               # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
