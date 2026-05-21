# Source: LoopStrengthReduce/lsr-cost-compare.loop-reduce_loop-term-fold.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
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
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	lui	a2, 31
	addi	a2, a2, 1024
	add	a2, a1, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	flw	fa5, 0(a2)
	lui	a3, 260096
	fmv.w.x	fa4, a3
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 0(a0)
	addi	a0, a0, 4
	addi	a2, a2, 4
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
