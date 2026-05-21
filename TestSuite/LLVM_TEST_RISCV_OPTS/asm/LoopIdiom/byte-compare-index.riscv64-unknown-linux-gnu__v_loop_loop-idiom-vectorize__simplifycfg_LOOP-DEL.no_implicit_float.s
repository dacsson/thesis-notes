# Source: LoopIdiom/byte-compare-index.riscv64-unknown-linux-gnu__v_loop_loop-idiom-vectorize__simplifycfg_LOOP-DEL.ll
# Function: no_implicit_float
# src = pre-opt (no_implicit_float), tgt = post-opt (no_implicit_float)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                # %while.body
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB7_1
	j	.LBB7_3
.LBB7_3:                                # %while.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                # %while.body
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 32
	srli	a3, a3, 32
	add	a0, a0, a3
	lbu	a0, 0(a0)
	add	a1, a1, a3
	lbu	a1, 0(a1)
	mv	a3, a2
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB7_1
	j	.LBB7_3
.LBB7_3:                                # %while.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
