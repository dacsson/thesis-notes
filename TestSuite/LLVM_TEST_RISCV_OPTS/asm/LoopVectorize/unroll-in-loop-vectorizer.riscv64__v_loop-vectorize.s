# Source: LoopVectorize/unroll-in-loop-vectorizer.riscv64__v_loop-vectorize.ll
# Function: small_loop
# src = pre-opt (small_loop), tgt = post-opt (small_loop)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_2
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
	addiw	a2, a2, 6
	sw	a2, 0(a3)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a1, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %loop.preheader
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 2
	add	a3, a2, a3
	lw	a2, 0(a3)
	addiw	a2, a2, 6
	sw	a2, 0(a3)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %exit.loopexit
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
