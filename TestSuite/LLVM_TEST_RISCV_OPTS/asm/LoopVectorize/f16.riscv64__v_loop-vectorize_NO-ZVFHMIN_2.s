# Source: LoopVectorize/f16.riscv64__v_loop-vectorize_NO-ZVFHMIN_2.ll
# Function: fadd
# src = pre-opt (fadd), tgt = post-opt (fadd)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a1, a1, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lhu	a1, 0(a1)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	sh	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a1, a1, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lhu	a1, 0(a1)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	fadd.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	sh	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
