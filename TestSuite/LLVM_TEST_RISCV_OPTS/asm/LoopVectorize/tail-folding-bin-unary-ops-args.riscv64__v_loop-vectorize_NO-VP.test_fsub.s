# Source: LoopVectorize/tail-folding-bin-unary-ops-args.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_fsub
# src = pre-opt (test_fsub), tgt = post-opt (test_fsub)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB14_1
.LBB14_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a2, 1
	slli	a2, a2, 2
	add	a3, a3, a2
	flw	fa5, 0(a3)
	lui	a3, 787456
	fmv.w.x	fa4, a3
	fadd.s	fa5, fa5, fa4
	add	a1, a1, a2
	fsw	fa5, 0(a1)
	li	a1, 100
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB14_1
	j	.LBB14_2
.LBB14_2:                               # %finish.loopexit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	src, .Lfunc_end14-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 16
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB14_2
# %bb.1:                                # %loop.preheader
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB14_2:                               # %loop.preheader
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 100
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB14_7
	j	.LBB14_3
.LBB14_3:                               # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	li	a2, 0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB14_7
	j	.LBB14_4
.LBB14_4:                               # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 96
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB14_5
.LBB14_5:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vle32.v	v10, (a5)
	lui	a5, 263168
	fmv.w.x	fa5, a5
                                        # implicit-def: $v8m2
	vfsub.vf	v8, v10, fa5
	add	a3, a3, a4
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB14_5
	j	.LBB14_6
.LBB14_6:                               # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 100
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB14_9
	j	.LBB14_7
.LBB14_7:                               # %scalar.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB14_8
.LBB14_8:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	addi	a0, a2, 1
	slli	a2, a2, 2
	add	a3, a3, a2
	flw	fa5, 0(a3)
	lui	a3, 787456
	fmv.w.x	fa4, a3
	fadd.s	fa5, fa5, fa4
	add	a1, a1, a2
	fsw	fa5, 0(a1)
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB14_8
	j	.LBB14_9
.LBB14_9:                               # %finish.loopexit
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
	.cfi_endproc
                                        # -- End function
