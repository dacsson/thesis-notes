# Source: LoopStrengthReduce/lsr-cost-compare.loop-reduce_loop-term-fold.ll
# Function: test4
# src = pre-opt (test4), tgt = post-opt (test4)
# Triple: riscv64, Attrs: v
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
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 2
	add	a3, a3, a2
	flw	fa5, 0(a3)
	lui	a3, 260096
	fmv.w.x	fa4, a3
	fadd.s	fa5, fa5, fa4
	add	a1, a1, a2
	fsw	fa5, 0(a1)
	addi	a0, a0, 1
	lui	a1, 8
	addi	a1, a1, -768
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	call	use
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	call	use
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lui	a2, 31
	addi	a2, a2, 1024
	add	a2, a1, a2
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	flw	fa5, 0(a2)
	lui	a3, 260096
	fmv.w.x	fa4, a3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a0)
	addi	a0, a0, 4
	addi	a2, a2, 4
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	call	use
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	call	use
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
