# Source: LoopVectorize/tail-folding-cond-reduction.riscv64__v_loop-vectorize_NO-VP-INLOOP.ll
# Function: cond_add_pred
# src = pre-opt (cond_add_pred), tgt = post-opt (cond_add_pred)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a1, 4
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_4
.LBB1_4:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 128(sp)                     # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	sd	a2, 144(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB1_4
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sub	a1, a1, a2
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 112(sp)                     # 8-byte Folded Reload
	slli	a5, a0, 2
	add	a4, a4, a5
                                        # implicit-def: $v12m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vle32.v	v12, (a4)
	vmsgt.vi	v0, v12, 3
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v10m2
	vmerge.vvm	v10, v8, v12, v0
                                        # implicit-def: $v9
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a2, v8
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	mv	a3, a1
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB1_8
	j	.LBB1_4
.LBB1_4:                                # %scalar.ph
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a1, 4
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB1_7
	j	.LBB1_6
.LBB1_6:                                # %if.then
                                        #   in Loop: Header=BB1_5 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_7
.LBB1_7:                                # %for.inc
                                        #   in Loop: Header=BB1_5 Depth=1
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_5
	j	.LBB1_8
.LBB1_8:                                # %for.end
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
