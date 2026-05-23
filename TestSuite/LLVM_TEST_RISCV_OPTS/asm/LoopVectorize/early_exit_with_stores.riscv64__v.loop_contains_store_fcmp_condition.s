# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: loop_contains_store_fcmp_condition
# src = pre-opt (loop_contains_store_fcmp_condition), tgt = post-opt (loop_contains_store_fcmp_condition)
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
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a3, a2, a1
	lh	a2, 0(a3)
	addiw	a2, a2, 1
	sh	a2, 0(a3)
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	lui	a0, 278432
	fmv.w.x	fa5, a0
	fle.s	a0, fa0, fa5
	beqz	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.inc
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_3
.LBB2_3:                                # %exit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a3, a2, a1
	lh	a2, 0(a3)
	addiw	a2, a2, 1
	sh	a2, 0(a3)
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	lui	a0, 278432
	fmv.w.x	fa5, a0
	fle.s	a0, fa0, fa5
	beqz	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.inc
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_3
.LBB2_3:                                # %exit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
