# Source: DivRemPairs/div-rem-pairs.riscv64-unknown-unknown_div-rem-pairs.ll
# Function: no_domination
# src = pre-opt (no_domination), tgt = post-opt (no_domination)
# Triple: riscv64-unknown-unknown, Attrs: none
#

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
	mv	a3, a2
	mv	a2, a1
	mv	a1, a0
	andi	a0, a1, 1
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %if
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	sext.w	a1, a1
	call	__divdi3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_2:                                # %else
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	sext.w	a1, a1
	call	__moddi3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
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
	mv	a3, a2
	mv	a2, a1
	mv	a1, a0
	andi	a0, a1, 1
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %if
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	sext.w	a1, a1
	call	__divdi3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_2:                                # %else
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	sext.w	a1, a1
	call	__moddi3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
