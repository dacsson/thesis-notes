# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: fadd
# src = pre-opt (fadd), tgt = post-opt (fadd)
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
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fsw	fa0, 44(sp)                     # 4-byte Folded Spill
	j	.LBB9_1
.LBB9_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fadd.s	fa5, fa5, fa4
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB9_1
	j	.LBB9_2
.LBB9_2:                                # %for.end
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
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
	fsw	fa0, 60(sp)                     # 4-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a2, a0, 3
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a2, 0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	fsw	fa0, 100(sp)                    # 4-byte Folded Spill
	bltu	a1, a0, .LBB9_4
	j	.LBB9_1
.LBB9_1:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	flw	fa5, 60(sp)                     # 4-byte Folded Reload
	mv	a1, a0
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	fsw	fa5, 56(sp)                     # 4-byte Folded Spill
	j	.LBB9_2
.LBB9_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	flw	fa5, 56(sp)                     # 4-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vle32.v	v10, (a3)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vfmv.s.f	v9, fa5
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vfredusum.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	fsw	fa5, 56(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB9_2
	j	.LBB9_3
.LBB9_3:                                # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 100(sp)                    # 4-byte Folded Spill
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB9_6
	j	.LBB9_4
.LBB9_4:                                # %scalar.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	flw	fa5, 100(sp)                    # 4-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB9_5
.LBB9_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	flw	fa4, 20(sp)                     # 4-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fadd.s	fa5, fa5, fa4
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 20(sp)                     # 4-byte Folded Spill
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB9_5
	j	.LBB9_6
.LBB9_6:                                # %for.end
	flw	fa0, 24(sp)                     # 4-byte Folded Reload
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
