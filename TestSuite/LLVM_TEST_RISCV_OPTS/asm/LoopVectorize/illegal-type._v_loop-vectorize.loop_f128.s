# Source: LoopVectorize/illegal-type._v_loop-vectorize.ll
# Function: loop_f128
# src = pre-opt (loop_f128), tgt = post-opt (loop_f128)
# Triple: riscv64, Attrs: v
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
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 4
	add	a1, a0, a1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	ld	a0, 0(a1)
	ld	a1, 8(a1)
	li	a3, 0
	mv	a2, a3
	call	__addtf3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	mv	a4, a1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a4, 8(a3)
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.end
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 4
	add	a1, a0, a1
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	ld	a0, 0(a1)
	ld	a1, 8(a1)
	li	a3, 0
	mv	a2, a3
	call	__addtf3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	mv	a4, a1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a4, 8(a3)
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.end
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
