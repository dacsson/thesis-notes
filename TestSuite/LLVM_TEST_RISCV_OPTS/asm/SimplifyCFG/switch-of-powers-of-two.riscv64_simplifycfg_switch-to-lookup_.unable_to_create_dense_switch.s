# Source: SimplifyCFG/switch-of-powers-of-two.riscv64_simplifycfg_switch-to-lookup_.ll
# Function: unable_to_create_dense_switch
# src = pre-opt (unable_to_create_dense_switch), tgt = post-opt (unable_to_create_dense_switch)
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
	li	a1, 1
	beq	a0, a1, .LBB3_5
	j	.LBB3_1
.LBB3_1:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 2
	beq	a0, a1, .LBB3_6
	j	.LBB3_2
.LBB3_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 4
	beq	a0, a1, .LBB3_7
	j	.LBB3_3
.LBB3_3:                                # %entry
	j	.LBB3_8
# %bb.4:                                # %default_case
.LBB3_5:                                # %bb2
	.cfi_restore_state
	li	a0, 2
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB3_9
.LBB3_6:                                # %bb3
	li	a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB3_9
.LBB3_7:                                # %bb4
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB3_9
.LBB3_8:                                # %bb5
	li	a0, 42
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB3_9
.LBB3_9:                                # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
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
	mv	a1, a0
	sext.w	a0, a1
	li	a2, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	li	a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB3_8
	j	.LBB3_1
.LBB3_1:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 2
	beq	a0, a1, .LBB3_5
	j	.LBB3_2
.LBB3_2:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 4
	beq	a0, a1, .LBB3_6
	j	.LBB3_3
.LBB3_3:                                # %entry
	j	.LBB3_7
# %bb.4:                                # %default_case
.LBB3_5:                                # %bb3
	.cfi_restore_state
	li	a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_6:                                # %bb4
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_7:                                # %bb5
	li	a0, 42
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_8
.LBB3_8:                                # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
