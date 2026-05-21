# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: smin
# src = pre-opt (smin), tgt = post-opt (smin)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB5_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB5_3:                                # %for.body
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_4
.LBB5_4:                                # %for.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
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
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	vsetvli	a0, a0, e8, mf2, ta, ma
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	slli	a3, a3, 2
	add	a2, a2, a3
                                        # implicit-def: $v10m2
	vsetvli	zero, a0, e32, m2, tu, ma
	vle32.v	v10, (a2)
	lui	a2, 524288
	addiw	a2, a2, -1
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m2, tu, ma
	vmv.s.x	v8, a2
	vsetvli	zero, a0, e32, m2, ta, ma
	vredmin.vs	v8, v10, v8
	vsetvli	zero, a0, e32, m2, ta, ma
	vmv.x.s	a0, v8
	sext.w	a1, a1
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB5_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB5_2 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB5_4:                                # %vector.body
                                        #   in Loop: Header=BB5_2 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a2, a3, a2
	sub	a0, a0, a3
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_5
.LBB5_5:                                # %middle.block
	j	.LBB5_6
.LBB5_6:                                # %for.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
