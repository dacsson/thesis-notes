# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: modf_f64
# src = pre-opt (modf_f64), tgt = post-opt (modf_f64)
# Triple: riscv64, Attrs: v
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
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB62_1
.LBB62_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 3
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	add	a2, a2, a1
	fld	fa0, 0(a2)
	add	a0, a0, a1
	call	modf
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a1, a1, a2
	fsd	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB62_1
	j	.LBB62_2
.LBB62_2:                               # %for.cond.cleanup
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end62:
	.size	src, .Lfunc_end62-src
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
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB62_1
.LBB62_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 3
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	add	a2, a2, a1
	fld	fa0, 0(a2)
	add	a0, a0, a1
	call	modf
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a1, a1, a2
	fsd	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB62_1
	j	.LBB62_2
.LBB62_2:                               # %for.cond.cleanup
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end62:
	.size	tgt, .Lfunc_end62-tgt
	.cfi_endproc
                                        # -- End function
