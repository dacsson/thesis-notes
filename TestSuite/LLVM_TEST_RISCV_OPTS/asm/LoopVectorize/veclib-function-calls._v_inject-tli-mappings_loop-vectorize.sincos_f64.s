# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: sincos_f64
# src = pre-opt (sincos_f64), tgt = post-opt (sincos_f64)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB70_1
.LBB70_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 3
	add	a3, a3, a2
	fld	fa0, 0(a3)
	add	a0, a0, a2
	add	a1, a1, a2
	call	sincos
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB70_1
	j	.LBB70_2
.LBB70_2:                               # %for.cond.cleanup
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end70:
	.size	src, .Lfunc_end70-src
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB70_1
.LBB70_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 3
	add	a3, a3, a2
	fld	fa0, 0(a3)
	add	a0, a0, a2
	add	a1, a1, a2
	call	sincos
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB70_1
	j	.LBB70_2
.LBB70_2:                               # %for.cond.cleanup
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end70:
	.size	tgt, .Lfunc_end70-tgt
	.cfi_endproc
                                        # -- End function
