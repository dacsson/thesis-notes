# Source: SimplifyCFG/switch-of-powers-of-two.riscv64_simplifycfg_switch-to-lookup_.ll
# Function: switch_of_powers_reachable_default
# src = pre-opt (switch_of_powers_reachable_default), tgt = post-opt (switch_of_powers_reachable_default)
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
	mv	a1, a0
	sext.w	a0, a1
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	li	a1, 1
	beq	a0, a1, .LBB1_6
	j	.LBB1_1
.LBB1_1:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 8
	beq	a0, a1, .LBB1_7
	j	.LBB1_2
.LBB1_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 16
	beq	a0, a1, .LBB1_8
	j	.LBB1_3
.LBB1_3:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 32
	beq	a0, a1, .LBB1_9
	j	.LBB1_4
.LBB1_4:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 64
	beq	a0, a1, .LBB1_10
	j	.LBB1_5
.LBB1_5:                                # %default_case
	li	a0, -1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_6:                                # %bb1
	li	a0, 3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_7:                                # %bb2
	li	a0, 2
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_8:                                # %bb3
	li	a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_9:                                # %bb4
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_10:                               # %bb5
	li	a0, 42
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_11:                               # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
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
	mv	a1, a0
	sext.w	a0, a1
	li	a2, -1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a1, 1
	beq	a0, a1, .LBB1_5
	j	.LBB1_1
.LBB1_1:                                # %entry
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 8
	beq	a0, a1, .LBB1_6
	j	.LBB1_2
.LBB1_2:                                # %entry
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 16
	beq	a0, a1, .LBB1_7
	j	.LBB1_3
.LBB1_3:                                # %entry
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 32
	beq	a0, a1, .LBB1_8
	j	.LBB1_4
.LBB1_4:                                # %entry
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 64
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB1_9
	j	.LBB1_10
.LBB1_5:                                # %bb1
	li	a0, 3
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_6:                                # %bb2
	li	a0, 2
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_7:                                # %bb3
	li	a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_8:                                # %bb4
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_9:                                # %bb5
	li	a0, 42
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_10:                               # %return
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
