# Source: SimplifyCFG/switch-of-powers-of-two.riscv64_simplifycfg_switch-to-lookup_.ll
# Function: switch_with_long_condition
# src = pre-opt (switch_with_long_condition), tgt = post-opt (switch_with_long_condition)
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
	.cfi_remember_state
	mv	a2, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	xori	a0, a0, 1
	or	a0, a0, a1
	beqz	a0, .LBB5_5
	j	.LBB5_1
.LBB5_1:                                # %entry
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 2
	or	a0, a0, a1
	beqz	a0, .LBB5_6
	j	.LBB5_2
.LBB5_2:                                # %entry
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	xori	a0, a0, 4
	or	a0, a0, a1
	beqz	a0, .LBB5_7
	j	.LBB5_3
.LBB5_3:                                # %entry
	j	.LBB5_8
# %bb.4:                                # %default_case
.LBB5_5:                                # %bb2
	.cfi_restore_state
	li	a0, 0
	li	a1, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_9
.LBB5_6:                                # %bb3
	li	a0, 0
	li	a1, 1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_9
.LBB5_7:                                # %bb4
	li	a1, 0
	mv	a0, a1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_9
.LBB5_8:                                # %bb5
	li	a0, 0
	li	a1, 42
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_9
.LBB5_9:                                # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
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
	.cfi_remember_state
	mv	a3, a1
	li	a1, 0
	li	a2, 2
	mv	a4, a3
	sd	a4, 0(sp)                       # 8-byte Folded Spill
	mv	a4, a0
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	xori	a0, a0, 1
	or	a0, a0, a3
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB5_8
	j	.LBB5_1
.LBB5_1:                                # %entry
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	xori	a0, a0, 2
	or	a0, a0, a1
	beqz	a0, .LBB5_5
	j	.LBB5_2
.LBB5_2:                                # %entry
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	xori	a0, a0, 4
	or	a0, a0, a1
	beqz	a0, .LBB5_6
	j	.LBB5_3
.LBB5_3:                                # %entry
	j	.LBB5_7
# %bb.4:                                # %default_case
.LBB5_5:                                # %bb3
	.cfi_restore_state
	li	a0, 0
	li	a1, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_8
.LBB5_6:                                # %bb4
	li	a1, 0
	mv	a0, a1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_8
.LBB5_7:                                # %bb5
	li	a0, 0
	li	a1, 42
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_8
.LBB5_8:                                # %return
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
