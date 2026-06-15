# Source: SimplifyCFG/umul-extract-pattern.simplifycfg.ll
# Function: stillHoistNotTooExpensive
# src = pre-opt (stillHoistNotTooExpensive), tgt = post-opt (stillHoistNotTooExpensive)
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
	beqz	a1, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %land.rhs
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	add	a0, a0, a2
	li	a3, 0
	mv	a1, a3
	call	__multi3
	snez	a0, a1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %land.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	mv	a2, a0
	snez	a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	add	a0, a1, a2
	li	a3, 0
	mv	a1, a3
	call	__multi3
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	snez	a1, a1
	and	a0, a0, a1
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
