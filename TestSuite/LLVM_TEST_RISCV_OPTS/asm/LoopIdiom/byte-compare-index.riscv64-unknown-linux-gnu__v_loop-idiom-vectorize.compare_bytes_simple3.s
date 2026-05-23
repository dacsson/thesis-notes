# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop-idiom-vectorize.ll
# Function: compare_bytes_simple3
# src = pre-opt (compare_bytes_simple3), tgt = post-opt (compare_bytes_simple3)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a5, 40(sp)                      # 8-byte Folded Spill
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB6_3
	j	.LBB6_2
.LBB6_2:                                # %while.body
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	slli	a4, a3, 32
	srli	a4, a4, 32
	add	a0, a0, a4
	lbu	a0, 0(a0)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB6_1
	j	.LBB6_3
.LBB6_3:                                # %while.end
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a0, 0(a1)
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a5, 40(sp)                      # 8-byte Folded Spill
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB6_3
	j	.LBB6_2
.LBB6_2:                                # %while.body
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	slli	a4, a3, 32
	srli	a4, a4, 32
	add	a0, a0, a4
	lbu	a0, 0(a0)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB6_1
	j	.LBB6_3
.LBB6_3:                                # %while.end
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a0, 0(a1)
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
