# Source: SimplifyCFG/select-trunc-i64.riscv32_simplifycfg.ll
# Function: select_trunc_i64
# src = pre-opt (select_trunc_i64), tgt = post-opt (select_trunc_i64)
# Triple: riscv32, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	mv	a2, a1
	mv	a1, a0
	srai	a3, a1, 31
	srai	a0, a2, 31
	add	a1, a2, a1
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	sltu	a2, a1, a2
	add	a0, a0, a3
	add	a0, a0, a2
	sw	a0, 36(sp)                      # 4-byte Folded Spill
	li	a2, 0
	slt	a2, a2, a0
	sw	a2, 40(sp)                      # 4-byte Folded Spill
	srli	a1, a1, 31
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_2
# %bb.1:                                # %entry
	lw	a0, 40(sp)                      # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
.LBB0_2:                                # %entry
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	lui	a1, 524288
	addi	a1, a1, -1
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_8
	j	.LBB0_3
.LBB0_3:                                # %cond.false
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	lw	a2, 32(sp)                      # 4-byte Folded Reload
	lui	a1, 524288
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	sltu	a2, a1, a2
	srli	a1, a0, 31
	xori	a1, a1, 1
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	li	a1, -1
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB0_5
# %bb.4:                                # %cond.false
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	sw	a0, 24(sp)                      # 4-byte Folded Spill
.LBB0_5:                                # %cond.false
	lw	a1, 32(sp)                      # 4-byte Folded Reload
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_7
# %bb.6:                                # %cond.false
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	sw	a0, 12(sp)                      # 4-byte Folded Spill
.LBB0_7:                                # %cond.false
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_8
.LBB0_8:                                # %cond.end7
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	mv	a2, a1
	mv	a1, a0
	srai	a3, a1, 31
	srai	a0, a2, 31
	add	a1, a2, a1
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	sltu	a2, a1, a2
	add	a0, a0, a3
	add	a0, a0, a2
	sw	a0, 36(sp)                      # 4-byte Folded Spill
	li	a2, 0
	slt	a2, a2, a0
	sw	a2, 40(sp)                      # 4-byte Folded Spill
	srli	a1, a1, 31
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_2
# %bb.1:                                # %entry
	lw	a0, 40(sp)                      # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
.LBB0_2:                                # %entry
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	lw	a2, 32(sp)                      # 4-byte Folded Reload
	lw	a1, 44(sp)                      # 4-byte Folded Reload
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	srli	a1, a0, 31
	xori	a1, a1, 1
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	lui	a1, 524288
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sltu	a2, a1, a2
	li	a1, -1
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB0_4
# %bb.3:                                # %entry
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	sw	a0, 28(sp)                      # 4-byte Folded Spill
.LBB0_4:                                # %entry
	lw	a1, 32(sp)                      # 4-byte Folded Reload
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_6
# %bb.5:                                # %entry
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a0, 12(sp)                      # 4-byte Folded Spill
.LBB0_6:                                # %entry
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	sw	a2, 4(sp)                       # 4-byte Folded Spill
	addi	a1, a1, -1
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	bnez	a0, .LBB0_8
# %bb.7:                                # %entry
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	sw	a0, 8(sp)                       # 4-byte Folded Spill
.LBB0_8:                                # %entry
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
