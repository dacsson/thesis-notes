# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: uncountable_exit_with_reduction
# src = pre-opt (uncountable_exit_with_reduction), tgt = post-opt (uncountable_exit_with_reduction)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB19_1
.LBB19_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a4, a3, a1
	lhu	a3, 0(a4)
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	addiw	a3, a3, 1
	sh	a3, 0(a4)
	add	a0, a0, a1
	lh	a1, 0(a0)
	li	a0, 500
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB19_3
	j	.LBB19_2
.LBB19_2:                               # %for.inc
                                        #   in Loop: Header=BB19_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 20
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB19_1
	j	.LBB19_3
.LBB19_3:                               # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end19:
	.size	src, .Lfunc_end19-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB19_1
.LBB19_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a4, a3, a1
	lhu	a3, 0(a4)
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	addiw	a3, a3, 1
	sh	a3, 0(a4)
	add	a0, a0, a1
	lh	a1, 0(a0)
	li	a0, 500
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB19_3
	j	.LBB19_2
.LBB19_2:                               # %for.inc
                                        #   in Loop: Header=BB19_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 20
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB19_1
	j	.LBB19_3
.LBB19_3:                               # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end19:
	.size	tgt, .Lfunc_end19-tgt
	.cfi_endproc
                                        # -- End function
