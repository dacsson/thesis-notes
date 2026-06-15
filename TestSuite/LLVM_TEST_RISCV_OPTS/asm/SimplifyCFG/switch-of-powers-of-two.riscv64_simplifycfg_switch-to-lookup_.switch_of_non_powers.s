# Source: SimplifyCFG/switch-of-powers-of-two.riscv64_simplifycfg_switch-to-lookup_.ll
# Function: switch_of_non_powers
# src = pre-opt (switch_of_non_powers), tgt = post-opt (switch_of_non_powers)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	.cfi_remember_state
	mv	a1, a0
	sext.w	a0, a1
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB2_6
	j	.LBB2_1
.LBB2_1:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 1
	beq	a0, a1, .LBB2_7
	j	.LBB2_2
.LBB2_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 16
	beq	a0, a1, .LBB2_8
	j	.LBB2_3
.LBB2_3:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 32
	beq	a0, a1, .LBB2_9
	j	.LBB2_4
.LBB2_4:                                # %entry
	j	.LBB2_10
# %bb.5:                                # %default_case
.LBB2_6:                                # %bb1
	.cfi_restore_state
	li	a0, 3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_7:                                # %bb2
	li	a0, 2
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_8:                                # %bb3
	li	a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_9:                                # %bb4
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_10:                               # %bb5
	li	a0, 42
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_11:                               # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
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
	.cfi_remember_state
	mv	a2, a0
	sext.w	a0, a2
	li	a1, 3
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB2_10
	j	.LBB2_1
.LBB2_1:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 1
	beq	a0, a1, .LBB2_6
	j	.LBB2_2
.LBB2_2:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 16
	beq	a0, a1, .LBB2_7
	j	.LBB2_3
.LBB2_3:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 32
	beq	a0, a1, .LBB2_8
	j	.LBB2_4
.LBB2_4:                                # %entry
	j	.LBB2_9
# %bb.5:                                # %default_case
.LBB2_6:                                # %bb2
	.cfi_restore_state
	li	a0, 2
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_10
.LBB2_7:                                # %bb3
	li	a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_10
.LBB2_8:                                # %bb4
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_10
.LBB2_9:                                # %bb5
	li	a0, 42
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_10
.LBB2_10:                               # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
