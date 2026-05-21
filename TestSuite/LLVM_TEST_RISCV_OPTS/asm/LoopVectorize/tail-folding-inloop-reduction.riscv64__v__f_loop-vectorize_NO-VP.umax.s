# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: umax
# src = pre-opt (umax), tgt = post-opt (umax)
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
	j	.LBB8_1
.LBB8_1:                                # %for.body
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
	bltu	a0, a1, .LBB8_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB8_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB8_3:                                # %for.body
                                        #   in Loop: Header=BB8_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_4
.LBB8_4:                                # %for.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sd	ra, 168(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 152(sp)                     # 8-byte Folded Spill
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB8_6
	j	.LBB8_1
.LBB8_1:                                # %vector.ph
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sub	a1, a1, a2
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	j	.LBB8_2
.LBB8_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a1, a1, a2
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e32, m2, ta, ma
	vle32.v	v10, (a1)
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vredmaxu.vs	v8, v10, v9
	vmv.x.s	a1, v8
	sext.w	a0, a0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB8_2 Depth=1
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 80(sp)                      # 8-byte Folded Spill
.LBB8_4:                                # %vector.body
                                        #   in Loop: Header=BB8_2 Depth=1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB8_2
	j	.LBB8_5
.LBB8_5:                                # %middle.block
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	mv	a3, a1
	sd	a3, 152(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 160(sp)                     # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB8_10
	j	.LBB8_6
.LBB8_6:                                # %scalar.ph
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB8_7
.LBB8_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	sext.w	a0, a0
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_9
# %bb.8:                                # %for.body
                                        #   in Loop: Header=BB8_7 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB8_9:                                # %for.body
                                        #   in Loop: Header=BB8_7 Depth=1
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_7
	j	.LBB8_10
.LBB8_10:                               # %for.end
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	ra, 168(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
