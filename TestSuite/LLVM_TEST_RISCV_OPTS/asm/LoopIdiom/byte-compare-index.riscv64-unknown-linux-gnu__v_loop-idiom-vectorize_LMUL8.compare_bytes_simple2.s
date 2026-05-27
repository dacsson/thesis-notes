# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop-idiom-vectorize_LMUL8.ll
# Function: compare_bytes_simple2
# src = pre-opt (compare_bytes_simple2), tgt = post-opt (compare_bytes_simple2)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a5, 64(sp)                      # 8-byte Folded Spill
	sd	a4, 72(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB5_3
	j	.LBB5_2
.LBB5_2:                                # %while.body
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	slli	a4, a3, 32
	srli	a4, a4, 32
	add	a0, a0, a4
	lbu	a0, 0(a0)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	mv	a4, a3
	sd	a4, 72(sp)                      # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB5_1
	j	.LBB5_3
.LBB5_3:                                # %while.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sw	a0, 0(a1)
	addi	sp, sp, 80
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a5, 64(sp)                      # 8-byte Folded Spill
	sd	a4, 72(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB5_3
	j	.LBB5_2
.LBB5_2:                                # %while.body
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	slli	a4, a3, 32
	srli	a4, a4, 32
	add	a0, a0, a4
	lbu	a0, 0(a0)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	mv	a4, a3
	sd	a4, 72(sp)                      # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB5_1
	j	.LBB5_3
.LBB5_3:                                # %while.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sw	a0, 0(a1)
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
