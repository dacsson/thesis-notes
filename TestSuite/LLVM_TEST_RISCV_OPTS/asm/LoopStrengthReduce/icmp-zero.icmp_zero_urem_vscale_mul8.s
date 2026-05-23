# Source: LoopStrengthReduce/icmp-zero.ll
# Function: icmp_zero_urem_vscale_mul8
# src = pre-opt (icmp_zero_urem_vscale_mul8), tgt = post-opt (icmp_zero_urem_vscale_mul8)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	csrr	a1, vlenb
	addi	a1, a1, -1
	and	a0, a0, a1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 0(a3)
	addi	a0, a0, 2
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_2
.LBB7_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
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
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	csrr	a1, vlenb
	addi	a1, a1, -1
	and	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 0(a2)
	addi	a0, a0, -2
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB7_1
	j	.LBB7_2
.LBB7_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
