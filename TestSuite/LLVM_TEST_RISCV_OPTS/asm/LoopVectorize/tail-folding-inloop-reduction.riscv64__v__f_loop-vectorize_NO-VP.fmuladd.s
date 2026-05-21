# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: fmuladd
# src = pre-opt (fmuladd), tgt = post-opt (fmuladd)
# Triple: riscv64, Attrs: +v,+f
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fsw	fa0, 44(sp)                     # 4-byte Folded Spill
	j	.LBB15_1
.LBB15_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	flw	fa3, 44(sp)                     # 4-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a4, a4, a3
	flw	fa5, 0(a4)
	add	a2, a2, a3
	flw	fa4, 0(a2)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 4(sp)                      # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB15_1
	j	.LBB15_2
.LBB15_2:                               # %for.end
	flw	fa0, 4(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	fsw	fa0, 52(sp)                     # 4-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a1, 0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	fsw	fa0, 100(sp)                    # 4-byte Folded Spill
	bltu	a2, a0, .LBB15_4
	j	.LBB15_1
.LBB15_1:                               # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	flw	fa5, 52(sp)                     # 4-byte Folded Reload
	mv	a1, a0
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	fsw	fa5, 48(sp)                     # 4-byte Folded Spill
	j	.LBB15_2
.LBB15_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 48(sp)                     # 4-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a5, 72(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vle32.v	v8, (a5)
	add	a3, a3, a4
                                        # implicit-def: $v12m2
	vle32.v	v12, (a3)
                                        # implicit-def: $v10m2
	vfmul.vv	v10, v8, v12
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vfmv.s.f	v9, fa5
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vfredusum.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	fsw	fa5, 48(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB15_2
	j	.LBB15_3
.LBB15_3:                               # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 100(sp)                    # 4-byte Folded Spill
	fsw	fa5, 16(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB15_6
	j	.LBB15_4
.LBB15_4:                               # %scalar.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	flw	fa5, 100(sp)                    # 4-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	j	.LBB15_5
.LBB15_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	flw	fa3, 12(sp)                     # 4-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a4, a4, a3
	flw	fa5, 0(a4)
	add	a2, a2, a3
	flw	fa4, 0(a2)
	fmadd.s	fa5, fa5, fa4, fa3
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 12(sp)                     # 4-byte Folded Spill
	fsw	fa5, 16(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB15_5
	j	.LBB15_6
.LBB15_6:                               # %for.end
	flw	fa0, 16(sp)                     # 4-byte Folded Reload
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
