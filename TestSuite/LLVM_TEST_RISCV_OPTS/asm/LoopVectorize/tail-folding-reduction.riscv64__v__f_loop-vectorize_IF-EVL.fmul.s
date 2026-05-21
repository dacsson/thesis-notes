# Source: LoopVectorize/tail-folding-reduction.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: fmul
# src = pre-opt (fmul), tgt = post-opt (fmul)
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
	j	.LBB10_1
.LBB10_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fmul.s	fa5, fa5, fa4
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %for.end
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	csrr	a2, vlenb
	slli	a2, a2, 3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 8 * vlenb
	fsw	fa0, 60(sp)                     # 4-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a0, 16
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	fsw	fa0, 92(sp)                     # 4-byte Folded Spill
	bltu	a1, a0, .LBB10_4
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	flw	fa5, 60(sp)                     # 4-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	andi	a0, a0, -16
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	lui	a0, 260096
                                        # implicit-def: $v8m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v8, a0
	vmv1r.v	v12, v8
	vfmv.s.f	v12, fa5
	vmv2r.v	v10, v8
	vmv1r.v	v10, v12
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 96
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 96
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 96
	vl2r.v	v14, (a3)                       # vscale x 16-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 2
	add	a3, sp, a3
	addi	a3, a3, 96
	vl2r.v	v16, (a3)                       # vscale x 16-byte Folded Reload
	slli	a3, a0, 2
	add	a3, a2, a3
	addi	a2, a3, 32
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vle32.v	v8, (a3)
                                        # implicit-def: $v12m2
	vle32.v	v12, (a2)
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfmul.vv	v10, v8, v16
	addi	a2, sp, 96
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vfmul.vv	v8, v12, v14
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 16
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 96
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	addi	a2, sp, 96
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v10m2
	vfmul.vv	v10, v8, v12
                                        # implicit-def: $v12m2
	vslidedown.vi	v12, v10, 4
                                        # implicit-def: $v8m2
	vfmul.vv	v8, v10, v12
                                        # implicit-def: $v12m2
	vslidedown.vi	v12, v8, 2
                                        # implicit-def: $v10m2
	vfmul.vv	v10, v8, v12
                                        # implicit-def: $v12m2
	vrgather.vi	v12, v10, 1
                                        # implicit-def: $v8m2
	vfmul.vv	v8, v10, v12
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	mv	a2, a1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 92(sp)                     # 4-byte Folded Spill
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB10_6
	j	.LBB10_4
.LBB10_4:                               # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	flw	fa5, 92(sp)                     # 4-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	fsw	fa5, 32(sp)                     # 4-byte Folded Spill
	j	.LBB10_5
.LBB10_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	flw	fa4, 32(sp)                     # 4-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fmul.s	fa5, fa5, fa4
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 32(sp)                     # 4-byte Folded Spill
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB10_5
	j	.LBB10_6
.LBB10_6:                               # %for.end
	flw	fa0, 36(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 96
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
