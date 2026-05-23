# Source: SimplifyCFG/switch-of-powers-of-two.riscv64__zbb_simplifycfg_switch-to-lookup_.ll
# Function: switch_of_powers
# src = pre-opt (switch_of_powers), tgt = post-opt (switch_of_powers)
# Triple: riscv64, Attrs: +zbb
#

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
	beq	a0, a1, .LBB0_6
	j	.LBB0_1
.LBB0_1:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 8
	beq	a0, a1, .LBB0_7
	j	.LBB0_2
.LBB0_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 16
	beq	a0, a1, .LBB0_8
	j	.LBB0_3
.LBB0_3:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 32
	beq	a0, a1, .LBB0_9
	j	.LBB0_4
.LBB0_4:                                # %entry
	j	.LBB0_10
# %bb.5:                                # %default_case
.LBB0_6:                                # %bb1
	.cfi_restore_state
	li	a0, 3
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_7:                                # %bb2
	li	a0, 2
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_8:                                # %bb3
	li	a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_9:                                # %bb4
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_10:                               # %bb5
	li	a0, 42
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_11:                               # %return
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
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
	ctzw	a0, a0
	slli	a1, a0, 2
	lui	a0, %hi(.Lswitch.table.switch_of_powers)
	addi	a0, a0, %lo(.Lswitch.table.switch_of_powers)
	add	a0, a0, a1
	lw	a0, 0(a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
