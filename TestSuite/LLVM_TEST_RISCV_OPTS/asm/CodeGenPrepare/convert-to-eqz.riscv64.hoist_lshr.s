# Source: CodeGenPrepare/convert-to-eqz.riscv64.ll
# Function: hoist_lshr
# src = pre-opt (hoist_lshr), tgt = post-opt (hoist_lshr)
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
	zext.b	a0, a1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	li	a2, 255
	li	a1, 8
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %if.then
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 56
	srli	a0, a0, 59
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	slli	a0, a0, 56
	srli	a0, a0, 59
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a1, 255
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %if.then
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
