# Source: LoopUnroll/runtime-unroll-max-trip-count._no-default-unroll_loop-unroll.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	mv	a0, a1
	addiw	a1, a1, 5
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	sw	a2, 0(a3)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 32
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	mv	a0, a1
	addiw	a1, a1, 5
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sext.w	a3, a0
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	sw	a2, 0(a3)
	addiw	a0, a0, 1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	bgeu	a0, a1, .LBB0_5
	j	.LBB0_2
.LBB0_2:                                # %loop.1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	sext.w	a3, a3
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	sw	a2, 0(a3)
	addiw	a0, a0, 2
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	bgeu	a0, a1, .LBB0_5
	j	.LBB0_3
.LBB0_3:                                # %loop.2
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	sext.w	a3, a3
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	sw	a2, 0(a3)
	addiw	a0, a0, 3
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	bgeu	a0, a1, .LBB0_5
	j	.LBB0_4
.LBB0_4:                                # %loop.3
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	sext.w	a3, a3
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	sw	a2, 0(a3)
	addiw	a0, a0, 4
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_1
	j	.LBB0_5
.LBB0_5:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
