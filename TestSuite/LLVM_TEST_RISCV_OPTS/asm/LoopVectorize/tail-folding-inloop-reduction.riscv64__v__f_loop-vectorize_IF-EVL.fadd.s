# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_IF-EVL.ll
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	fsw	fa0, 44(sp)                     # 4-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB9_1
.LBB9_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	flw	fa5, 44(sp)                     # 4-byte Folded Reload
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB9_2
.LBB9_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v10, (a3)
	lui	a3, 524288
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m2, tu, ma
	vmv.s.x	v8, a3
                                        # implicit-def: $v9
	vfmv.s.f	v9, fa5
	vsetvli	zero, a2, e32, m2, ta, ma
	vfredusum.vs	v8, v10, v9
	vsetvli	zero, a2, e32, m2, ta, ma
	vfmv.f.s	fa5, v8
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB9_2
	j	.LBB9_3
.LBB9_3:                                # %middle.block
	j	.LBB9_4
.LBB9_4:                                # %for.end
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
