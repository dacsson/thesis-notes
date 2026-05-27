# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f3
# src = pre-opt (f3), tgt = post-opt (f3)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	fsd	fa0, 72(sp)                     # 8-byte Folded Spill
	fsd	fa1, 80(sp)                     # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	fld	fa5, 72(sp)                     # 8-byte Folded Reload
	fld	fa4, 80(sp)                     # 8-byte Folded Reload
	fsd	fa4, 24(sp)                     # 8-byte Folded Spill
	fsd	fa5, 32(sp)                     # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	g
	call	g
	call	g
	j	.LBB4_2
.LBB4_2:                                # %latch
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fld	fa5, 24(sp)                     # 8-byte Folded Reload
	fld	fa4, 32(sp)                     # 8-byte Folded Reload
	li	a2, 1023
	slli	a2, a2, 52
	fmv.d.x	fa3, a2
	fadd.d	fa4, fa4, fa3
	fsd	fa4, 8(sp)                      # 8-byte Folded Spill
	fadd.d	fa5, fa5, fa3
	fsd	fa5, 16(sp)                     # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	fsd	fa4, 72(sp)                     # 8-byte Folded Spill
	fsd	fa5, 80(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_3
.LBB4_3:                                # %exit
	fld	fa5, 16(sp)                     # 8-byte Folded Reload
	fld	fa4, 8(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 3
	add	a0, a0, a1
	fsd	fa4, 0(a0)
	fsd	fa5, 8(a0)
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	fsd	fa0, 72(sp)                     # 8-byte Folded Spill
	fsd	fa1, 80(sp)                     # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	fld	fa5, 72(sp)                     # 8-byte Folded Reload
	fld	fa4, 80(sp)                     # 8-byte Folded Reload
	fsd	fa4, 24(sp)                     # 8-byte Folded Spill
	fsd	fa5, 32(sp)                     # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	g
	call	g
	call	g
	j	.LBB4_2
.LBB4_2:                                # %latch
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fld	fa5, 24(sp)                     # 8-byte Folded Reload
	fld	fa4, 32(sp)                     # 8-byte Folded Reload
	li	a2, 1023
	slli	a2, a2, 52
	fmv.d.x	fa3, a2
	fadd.d	fa4, fa4, fa3
	fsd	fa4, 8(sp)                      # 8-byte Folded Spill
	fadd.d	fa5, fa5, fa3
	fsd	fa5, 16(sp)                     # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	fsd	fa4, 72(sp)                     # 8-byte Folded Spill
	fsd	fa5, 80(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_3
.LBB4_3:                                # %exit
	fld	fa5, 16(sp)                     # 8-byte Folded Reload
	fld	fa4, 8(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 3
	add	a0, a0, a1
	fsd	fa4, 0(a0)
	fsd	fa5, 8(a0)
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
