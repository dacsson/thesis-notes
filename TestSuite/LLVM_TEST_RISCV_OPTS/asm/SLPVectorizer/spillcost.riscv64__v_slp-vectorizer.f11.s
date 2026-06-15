# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f11
# src = pre-opt (f11), tgt = post-opt (f11)
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %foo
	li	a0, 1
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_2:                                # %bar
	call	g
	call	g
	call	g
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_3:                                # %baz
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %foo
	li	a0, 1
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_2:                                # %bar
	call	g
	call	g
	call	g
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_3:                                # %baz
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
