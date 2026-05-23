# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: loop_contains_store_uncounted_exit_is_not_guaranteed_to_execute
# src = pre-opt (loop_contains_store_uncounted_exit_is_not_guaranteed_to_execute), tgt = post-opt (loop_contains_store_uncounted_exit_is_not_guaranteed_to_execute)
# Triple: riscv64, Attrs: +v
#

	.globl	src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB14_1
.LBB14_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a1, 1
	add	a2, a0, a2
	lh	a0, 0(a2)
	addiw	a0, a0, 1
	sh	a0, 0(a2)
	slli	a0, a1, 2
	sub	a0, a1, a0
	slli	a2, a1, 4
	add	a0, a0, a2
	slli	a2, a1, 6
	sub	a0, a0, a2
	slli	a2, a1, 8
	add	a0, a0, a2
	slli	a2, a1, 10
	sub	a0, a0, a2
	slli	a2, a1, 12
	add	a0, a0, a2
	slli	a2, a1, 14
	sub	a0, a0, a2
	slli	a2, a1, 16
	add	a0, a0, a2
	slli	a2, a1, 18
	sub	a0, a0, a2
	slli	a2, a1, 20
	add	a0, a0, a2
	slli	a2, a1, 22
	sub	a0, a0, a2
	slli	a2, a1, 24
	add	a0, a0, a2
	slli	a2, a1, 26
	sub	a0, a0, a2
	slli	a2, a1, 28
	add	a0, a0, a2
	slli	a2, a1, 30
	sub	a0, a0, a2
	slli	a2, a1, 32
	add	a0, a0, a2
	slli	a2, a1, 34
	sub	a0, a0, a2
	slli	a2, a1, 36
	add	a0, a0, a2
	slli	a2, a1, 38
	sub	a0, a0, a2
	slli	a2, a1, 40
	add	a0, a0, a2
	slli	a2, a1, 42
	sub	a0, a0, a2
	slli	a2, a1, 44
	add	a0, a0, a2
	slli	a2, a1, 46
	sub	a0, a0, a2
	slli	a2, a1, 48
	add	a0, a0, a2
	slli	a2, a1, 50
	sub	a0, a0, a2
	slli	a2, a1, 52
	add	a0, a0, a2
	slli	a2, a1, 54
	sub	a0, a0, a2
	slli	a2, a1, 56
	add	a0, a0, a2
	slli	a2, a1, 58
	sub	a0, a0, a2
	slli	a2, a1, 60
	add	a0, a0, a2
	slli	a1, a1, 62
	sub	a0, a0, a1
	lui	a1, %hi(.LCPI14_0)
	ld	a1, %lo(.LCPI14_0)(a1)
	bltu	a0, a1, .LBB14_3
	j	.LBB14_2
.LBB14_2:                               # %ee.block
                                        #   in Loop: Header=BB14_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a1, a1, 1
	add	a0, a0, a1
	lh	a1, 0(a0)
	li	a0, 500
	blt	a0, a1, .LBB14_4
	j	.LBB14_3
.LBB14_3:                               # %for.inc
                                        #   in Loop: Header=BB14_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB14_1
	j	.LBB14_4
.LBB14_4:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	src, .Lfunc_end14-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB14_1
.LBB14_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a1, 1
	add	a2, a0, a2
	lh	a0, 0(a2)
	addiw	a0, a0, 1
	sh	a0, 0(a2)
	slli	a0, a1, 2
	sub	a0, a1, a0
	slli	a2, a1, 4
	add	a0, a0, a2
	slli	a2, a1, 6
	sub	a0, a0, a2
	slli	a2, a1, 8
	add	a0, a0, a2
	slli	a2, a1, 10
	sub	a0, a0, a2
	slli	a2, a1, 12
	add	a0, a0, a2
	slli	a2, a1, 14
	sub	a0, a0, a2
	slli	a2, a1, 16
	add	a0, a0, a2
	slli	a2, a1, 18
	sub	a0, a0, a2
	slli	a2, a1, 20
	add	a0, a0, a2
	slli	a2, a1, 22
	sub	a0, a0, a2
	slli	a2, a1, 24
	add	a0, a0, a2
	slli	a2, a1, 26
	sub	a0, a0, a2
	slli	a2, a1, 28
	add	a0, a0, a2
	slli	a2, a1, 30
	sub	a0, a0, a2
	slli	a2, a1, 32
	add	a0, a0, a2
	slli	a2, a1, 34
	sub	a0, a0, a2
	slli	a2, a1, 36
	add	a0, a0, a2
	slli	a2, a1, 38
	sub	a0, a0, a2
	slli	a2, a1, 40
	add	a0, a0, a2
	slli	a2, a1, 42
	sub	a0, a0, a2
	slli	a2, a1, 44
	add	a0, a0, a2
	slli	a2, a1, 46
	sub	a0, a0, a2
	slli	a2, a1, 48
	add	a0, a0, a2
	slli	a2, a1, 50
	sub	a0, a0, a2
	slli	a2, a1, 52
	add	a0, a0, a2
	slli	a2, a1, 54
	sub	a0, a0, a2
	slli	a2, a1, 56
	add	a0, a0, a2
	slli	a2, a1, 58
	sub	a0, a0, a2
	slli	a2, a1, 60
	add	a0, a0, a2
	slli	a1, a1, 62
	sub	a0, a0, a1
	lui	a1, %hi(.LCPI14_0)
	ld	a1, %lo(.LCPI14_0)(a1)
	bltu	a0, a1, .LBB14_3
	j	.LBB14_2
.LBB14_2:                               # %ee.block
                                        #   in Loop: Header=BB14_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a1, a1, 1
	add	a0, a0, a1
	lh	a1, 0(a0)
	li	a0, 500
	blt	a0, a1, .LBB14_4
	j	.LBB14_3
.LBB14_3:                               # %for.inc
                                        #   in Loop: Header=BB14_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB14_1
	j	.LBB14_4
.LBB14_4:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
	.cfi_endproc
                                        # -- End function
