# Source: LoopVectorize/pr154103.riscv64__v.ll
# Function: pr154103
# src = pre-opt (pr154103), tgt = post-opt (pr154103)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a1, 0
	li	a0, 1
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	lbu	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sh	a1, 0(a3)
	li	a1, 0
	sw	a1, 0(a2)
	addi	a1, a0, 7
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
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
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a1, 0
	li	a0, 1
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	lbu	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sh	a1, 0(a3)
	li	a1, 0
	sw	a1, 0(a2)
	addi	a1, a0, 7
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
