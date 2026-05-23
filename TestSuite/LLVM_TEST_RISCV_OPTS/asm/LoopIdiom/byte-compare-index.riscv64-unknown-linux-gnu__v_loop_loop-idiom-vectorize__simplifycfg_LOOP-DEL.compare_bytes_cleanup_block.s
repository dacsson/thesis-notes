# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop_loop-idiom-vectorize__simplifycfg_LOOP-DEL.ll
# Function: compare_bytes_cleanup_block
# src = pre-opt (compare_bytes_cleanup_block), tgt = post-opt (compare_bytes_cleanup_block)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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
	.cfi_remember_state
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB4_3
	j	.LBB4_2
.LBB4_2:                                # %while.body
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_1
	j	.LBB4_4
.LBB4_3:                                # %cleanup.thread
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB4_4:                                # %if.end
	.cfi_restore_state
	addi	sp, sp, 32
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %mismatch_loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	addiw	a2, a2, 1
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB4_3
	j	.LBB4_2
.LBB4_2:                                # %mismatch_loop
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	sext.w	a0, a1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_1
	j	.LBB4_3
.LBB4_3:                                # %common.ret
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
