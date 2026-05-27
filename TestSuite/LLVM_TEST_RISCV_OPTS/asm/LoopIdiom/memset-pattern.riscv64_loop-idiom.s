# Source: LoopIdiom/memset-pattern.riscv64_loop-idiom.ll
# Function: double_memset
# src = pre-opt (double_memset), tgt = post-opt (double_memset)
# Triple: riscv64, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	.cfi_remember_state
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_1:                                # %for.cond.cleanup
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB0_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a2, a1, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a1, 64
	sb	a1, 7(a2)
	li	a1, 9
	sb	a1, 6(a2)
	li	a1, 33
	sb	a1, 5(a2)
	li	a1, -7
	sb	a1, 4(a2)
	li	a1, -16
	sb	a1, 3(a2)
	li	a1, 27
	sb	a1, 2(a2)
	li	a1, 134
	sb	a1, 1(a2)
	li	a1, 110
	sb	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 16
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_1
	j	.LBB0_2
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	.cfi_remember_state
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_1:                                # %for.cond.cleanup
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB0_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a2, a1, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a1, 64
	sb	a1, 7(a2)
	li	a1, 9
	sb	a1, 6(a2)
	li	a1, 33
	sb	a1, 5(a2)
	li	a1, -7
	sb	a1, 4(a2)
	li	a1, -16
	sb	a1, 3(a2)
	li	a1, 27
	sb	a1, 2(a2)
	li	a1, 134
	sb	a1, 1(a2)
	li	a1, 110
	sb	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 16
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_1
	j	.LBB0_2
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
