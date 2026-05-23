# Source: LoopStrengthReduce/icmp-zero.ll
# Function: loop_invariant_definition
# src = pre-opt (loop_invariant_definition), tgt = post-opt (loop_invariant_definition)
# Triple: riscv64, Attrs: v
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
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB11_1
.LBB11_1:                               # %t1
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a1, a0, 1
	li	a0, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB11_1
	j	.LBB11_2
.LBB11_2:                               # %t4
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
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
	li	a0, -1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB11_1
.LBB11_1:                               # %t1
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a1, a0, 1
	li	a0, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB11_1
	j	.LBB11_2
.LBB11_2:                               # %t4
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
