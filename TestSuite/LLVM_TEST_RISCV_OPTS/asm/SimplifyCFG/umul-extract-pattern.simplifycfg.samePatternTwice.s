# Source: SimplifyCFG/umul-extract-pattern.simplifycfg.ll
# Function: samePatternTwice
# src = pre-opt (samePatternTwice), tgt = post-opt (samePatternTwice)
# Triple: riscv64, Attrs: v
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	beqz	a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %land.rhs
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	li	a3, 0
	mv	a1, a3
	call	__multi3
	snez	a0, a1
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %land.end
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	andi	a1, a1, 1
	add	a0, a0, a1
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	snez	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a3, 0
	mv	a1, a3
	call	__multi3
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	snez	a1, a1
	and	a0, a0, a1
	add	a0, a0, a0
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
