# Source: LoopVectorize/truncate-to-minimal-bitwidth-cost._v.ll
# Function: test_minbws_for_trunc
# src = pre-opt (test_minbws_for_trunc), tgt = post-opt (test_minbws_for_trunc)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 48
	srai	a2, a2, 48
	slli	a4, a2, 2
	add	a3, a3, a4
	lw	a3, 0(a3)
	slli	a4, a2, 1
	add	a4, a1, a4
	sh	a3, 0(a4)
	add	a4, a1, a2
	sb	a3, 0(a4)
	slli	a2, a2, 3
	add	a2, a1, a2
	li	a1, 0
	sd	a1, 0(a2)
	addi	a2, a0, 4
	slli	a0, a2, 48
	srli	a0, a0, 48
	li	a1, 1024
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %exit
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 48
	srai	a2, a2, 48
	slli	a4, a2, 2
	add	a3, a3, a4
	lw	a3, 0(a3)
	slli	a4, a2, 1
	add	a4, a1, a4
	sh	a3, 0(a4)
	add	a4, a1, a2
	sb	a3, 0(a4)
	slli	a2, a2, 3
	add	a2, a1, a2
	li	a1, 0
	sd	a1, 0(a2)
	addi	a2, a0, 4
	slli	a0, a2, 48
	srli	a0, a0, 48
	li	a1, 1024
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
