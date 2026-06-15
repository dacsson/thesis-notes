# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_IF-EVL.ll
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
	fsw	fa0, 60(sp)                     # 4-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a0, 8
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	fsw	fa0, 92(sp)                     # 4-byte Folded Spill
	bltu	a1, a0, .LBB10_4
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	flw	fa4, 60(sp)                     # 4-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	andi	a0, a0, -8
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	lui	a1, 260096
	fmv.w.x	fa5, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	fsw	fa4, 52(sp)                     # 4-byte Folded Spill
	fsw	fa5, 56(sp)                     # 4-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 56(sp)                     # 4-byte Folded Reload
	flw	fa4, 52(sp)                     # 4-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a3, a2, a3
	addi	a2, a3, 16
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a3)
                                        # implicit-def: $v8
	vle32.v	v8, (a2)
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vslidedown.vi	v11, v9, 2
                                        # implicit-def: $v10
	vfmul.vv	v10, v9, v11
                                        # implicit-def: $v11
	vrgather.vi	v11, v10, 1
                                        # implicit-def: $v9
	vfmul.vv	v9, v10, v11
	vfmv.f.s	fa3, v9
	fmul.s	fa4, fa4, fa3
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v10
	vslidedown.vi	v10, v8, 2
                                        # implicit-def: $v9
	vfmul.vv	v9, v8, v10
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 1
                                        # implicit-def: $v8
	vfmul.vv	v8, v9, v10
	vfmv.f.s	fa3, v8
	fmul.s	fa5, fa5, fa3
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 8
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	fsw	fa4, 52(sp)                     # 4-byte Folded Spill
	fsw	fa5, 56(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	flw	fa4, 24(sp)                     # 4-byte Folded Reload
	fmul.s	fa5, fa5, fa4
	mv	a2, a1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 92(sp)                     # 4-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB10_6
	j	.LBB10_4
.LBB10_4:                               # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	flw	fa5, 92(sp)                     # 4-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	fsw	fa5, 16(sp)                     # 4-byte Folded Spill
	j	.LBB10_5
.LBB10_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	flw	fa4, 16(sp)                     # 4-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fmul.s	fa5, fa5, fa4
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 16(sp)                     # 4-byte Folded Spill
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB10_5
	j	.LBB10_6
.LBB10_6:                               # %for.end
	flw	fa0, 20(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
