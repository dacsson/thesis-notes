# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: smax
# src = pre-opt (smax), tgt = post-opt (smax)
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
	j	.LBB6_1
.LBB6_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	sext.w	a0, a0
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB6_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB6_3:                                # %for.body
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_1
	j	.LBB6_4
.LBB6_4:                                # %for.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
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
	j	.LBB6_1
.LBB6_1:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB6_2
.LBB6_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	vsetvli	a1, a1, e8, mf2, ta, ma
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a3, a3, 2
	add	a2, a2, a3
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e32, m2, tu, ma
	vle32.v	v10, (a2)
	lui	a2, 524288
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m2, tu, ma
	vmv.s.x	v8, a2
	vsetvli	zero, a1, e32, m2, ta, ma
	vredmax.vs	v8, v10, v8
	vsetvli	zero, a1, e32, m2, ta, ma
	vmv.x.s	a1, v8
	sext.w	a0, a0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB6_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB6_2 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB6_4:                                # %vector.body
                                        #   in Loop: Header=BB6_2 Depth=1
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
	bnez	a0, .LBB6_2
	j	.LBB6_5
.LBB6_5:                                # %middle.block
	j	.LBB6_6
.LBB6_6:                                # %for.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
