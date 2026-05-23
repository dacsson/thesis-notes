# Source: SimplifyCFG/switch-of-powers-of-two.riscv64_simplifycfg_switch-to-lookup_.ll
# Function: unable_to_generate_lookup_table
# src = pre-opt (unable_to_generate_lookup_table), tgt = post-opt (unable_to_generate_lookup_table)
# Triple: riscv64, Attrs: none
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
	.cfi_remember_state
	mv	a2, a1
	mv	a1, a0
	sext.w	a0, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a1, 1
	beq	a0, a1, .LBB4_5
	j	.LBB4_1
.LBB4_1:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 2
	beq	a0, a1, .LBB4_6
	j	.LBB4_2
.LBB4_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 8
	beq	a0, a1, .LBB4_7
	j	.LBB4_3
.LBB4_3:                                # %entry
	j	.LBB4_8
# %bb.4:                                # %default_case
.LBB4_5:                                # %bb2
	.cfi_restore_state
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 48
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	subw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_6:                                # %bb3
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 96
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_7:                                # %bb4
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_8:                                # %bb5
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 9
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_9:                                # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_remember_state
	mv	a2, a1
	mv	a1, a0
	sext.w	a0, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a1, 1
	beq	a0, a1, .LBB4_5
	j	.LBB4_1
.LBB4_1:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 2
	beq	a0, a1, .LBB4_6
	j	.LBB4_2
.LBB4_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 8
	beq	a0, a1, .LBB4_7
	j	.LBB4_3
.LBB4_3:                                # %entry
	j	.LBB4_8
# %bb.4:                                # %default_case
.LBB4_5:                                # %bb2
	.cfi_restore_state
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 48
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	subw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_6:                                # %bb3
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 96
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_7:                                # %bb4
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_8:                                # %bb5
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 9
	call	bar
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_9:                                # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
