# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: loop_contains_store
# src = pre-opt (loop_contains_store), tgt = post-opt (loop_contains_store)
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
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 3
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a3, a2, 2
	add	a0, a0, a3
	lbu	a5, 0(a0)
	lbu	a4, 1(a0)
	slli	a4, a4, 8
	or	a4, a4, a5
	lbu	a5, 2(a0)
	slli	a5, a5, 16
	lb	a0, 3(a0)
	slli	a0, a0, 24
	or	a0, a0, a5
	or	a0, a0, a4
	add	a1, a1, a3
	sw	a0, 0(a1)
	li	a1, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %loop.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 67
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %loop.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
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
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 3
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a3, a2, 2
	add	a0, a0, a3
	lbu	a5, 0(a0)
	lbu	a4, 1(a0)
	slli	a4, a4, 8
	or	a4, a4, a5
	lbu	a5, 2(a0)
	slli	a5, a5, 16
	lb	a0, 3(a0)
	slli	a0, a0, 24
	or	a0, a0, a5
	or	a0, a0, a4
	add	a1, a1, a3
	sw	a0, 0(a1)
	li	a1, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %loop.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 67
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %loop.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
