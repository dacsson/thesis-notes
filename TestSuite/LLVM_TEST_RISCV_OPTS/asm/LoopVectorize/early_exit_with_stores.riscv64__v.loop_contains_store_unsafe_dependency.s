# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: loop_contains_store_unsafe_dependency
# src = pre-opt (loop_contains_store_unsafe_dependency), tgt = post-opt (loop_contains_store_unsafe_dependency)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	call	get_an_unknown_offset
	li	a1, 20
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %entry
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
.LBB4_2:                                # %entry
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 1
	add	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_3
.LBB4_3:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a4, a3, a2
	lh	a3, 0(a4)
	addiw	a3, a3, 1
	sh	a3, 0(a4)
	add	a1, a1, a2
	lh	a1, 0(a1)
	add	a2, a0, a2
	li	a0, 42
	sh	a0, 0(a2)
	li	a0, 500
	blt	a0, a1, .LBB4_5
	j	.LBB4_4
.LBB4_4:                                # %for.inc
                                        #   in Loop: Header=BB4_3 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_3
	j	.LBB4_5
.LBB4_5:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	call	get_an_unknown_offset
	li	a1, 20
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %entry
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
.LBB4_2:                                # %entry
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 1
	add	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_3
.LBB4_3:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a4, a3, a2
	lh	a3, 0(a4)
	addiw	a3, a3, 1
	sh	a3, 0(a4)
	add	a1, a1, a2
	lh	a1, 0(a1)
	add	a2, a0, a2
	li	a0, 42
	sh	a0, 0(a2)
	li	a0, 500
	blt	a0, a1, .LBB4_5
	j	.LBB4_4
.LBB4_4:                                # %for.inc
                                        #   in Loop: Header=BB4_3 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_3
	j	.LBB4_5
.LBB4_5:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
