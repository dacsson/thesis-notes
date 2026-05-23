# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: sincospi_f32
# src = pre-opt (sincospi_f32), tgt = post-opt (sincospi_f32)
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
	j	.LBB73_1
.LBB73_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a3, a3, a2
	flw	fa0, 0(a3)
	add	a0, a0, a2
	add	a1, a1, a2
	call	sincospif
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB73_1
	j	.LBB73_2
.LBB73_2:                               # %for.cond.cleanup
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end73:
	.size	src, .Lfunc_end73-src
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
	j	.LBB73_1
.LBB73_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a3, a3, a2
	flw	fa0, 0(a3)
	add	a0, a0, a2
	add	a1, a1, a2
	call	sincospif
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB73_1
	j	.LBB73_2
.LBB73_2:                               # %for.cond.cleanup
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end73:
	.size	tgt, .Lfunc_end73-tgt
	.cfi_endproc
                                        # -- End function
