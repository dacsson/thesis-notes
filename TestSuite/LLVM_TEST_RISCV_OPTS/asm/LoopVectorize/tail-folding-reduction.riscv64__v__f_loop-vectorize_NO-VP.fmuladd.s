# Source: LoopVectorize/tail-folding-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
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
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 4 * vlenb
	fsw	fa0, 68(sp)                     # 4-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a1, 0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	fsw	fa0, 116(sp)                    # 4-byte Folded Spill
	bltu	a2, a0, .LBB15_4
	j	.LBB15_1
.LBB15_1:                               # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	flw	fa5, 68(sp)                     # 4-byte Folded Reload
	mv	a1, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	lui	a0, 524288
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.x	v8, a0
	vmv1r.v	v10, v8
	vfmv.s.f	v10, fa5
	vmv1r.v	v8, v10
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB15_2
.LBB15_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 88(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 128
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vle32.v	v10, (a5)
	add	a3, a3, a4
                                        # implicit-def: $v8m2
	vle32.v	v8, (a3)
	vfmadd.vv	v8, v10, v12
	addi	a3, sp, 128
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB15_2
	j	.LBB15_3
.LBB15_3:                               # %middle.block
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 128
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	lui	a2, 524288
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vfredusum.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	mv	a2, a1
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 116(sp)                    # 4-byte Folded Spill
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB15_6
	j	.LBB15_4
.LBB15_4:                               # %scalar.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	flw	fa5, 116(sp)                    # 4-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	fsw	fa5, 32(sp)                     # 4-byte Folded Spill
	j	.LBB15_5
.LBB15_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	flw	fa3, 32(sp)                     # 4-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a4, 88(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a4, a4, a3
	flw	fa5, 0(a4)
	add	a2, a2, a3
	flw	fa4, 0(a2)
	fmadd.s	fa5, fa5, fa4, fa3
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 32(sp)                     # 4-byte Folded Spill
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB15_5
	j	.LBB15_6
.LBB15_6:                               # %for.end
	flw	fa0, 36(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 144
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
