# Source: LoopVectorize/tail-folding-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: fmin
# src = pre-opt (fmin), tgt = post-opt (fmin)
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
	j	.LBB11_1
.LBB11_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fmin.s	fa5, fa5, fa4
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB11_1
	j	.LBB11_2
.LBB11_2:                               # %for.end
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 4 * vlenb
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
	bltu	a1, a0, .LBB11_4
	j	.LBB11_1
.LBB11_1:                               # %vector.ph
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
                                        # implicit-def: $v8m2
	vsetvli	a0, zero, e32, m2, tu, ma
	vfmv.v.f	v8, fa5
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 112
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB11_2
.LBB11_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 112
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vle32.v	v10, (a3)
                                        # implicit-def: $v8m2
	vfmin.vv	v8, v10, v12
	addi	a3, sp, 112
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 112
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB11_2
	j	.LBB11_3
.LBB11_3:                               # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 112
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vfredmin.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 100(sp)                    # 4-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB11_6
	j	.LBB11_4
.LBB11_4:                               # %scalar.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	flw	fa5, 100(sp)                    # 4-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	j	.LBB11_5
.LBB11_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	flw	fa4, 24(sp)                     # 4-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fmin.s	fa5, fa5, fa4
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB11_5
	j	.LBB11_6
.LBB11_6:                               # %for.end
	flw	fa0, 28(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
