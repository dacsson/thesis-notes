# Source: LoopVectorize/inloop-reduction.riscv64-linux-gnu__v__d_loop-vectorize_INLOOP.ll
# Function: add_i16_i32
# src = pre-opt (add_i16_i32), tgt = post-opt (add_i16_i32)
# Triple: riscv64-linux-gnu, Attrs: +v,+d
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	sext.w	a4, a0
	slli	a4, a4, 1
	add	a3, a3, a4
	lh	a3, 0(a3)
	addw	a2, a2, a3
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.cond.cleanup
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bge	a0, a1, .LBB0_10
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	csrr	a1, vlenb
	li	a0, 16
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_3
# %bb.2:                                # %for.body.preheader
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB0_3:                                # %for.body.preheader
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a2, 0
	mv	a3, a2
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_7
	j	.LBB0_4
.LBB0_4:                                # %vector.ph
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	csrr	a2, vlenb
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sub	a2, a0, a2
	and	a1, a1, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 104(sp)                     # 8-byte Folded Reload
	sext.w	a5, a0
	slli	a5, a5, 1
	add	a4, a4, a5
                                        # implicit-def: $v10m2
	vsetvli	a5, zero, e16, m2, ta, ma
	vle16.v	v10, (a4)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m4, tu, ma
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m2, ta, ma
	vwredsum.vs	v8, v10, v9
	vsetvli	zero, zero, e32, m4, ta, ma
	vmv.x.s	a2, v8
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	addw	a0, a0, a3
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_5
	j	.LBB0_6
.LBB0_6:                                # %middle.block
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sext.w	a1, a3
	sext.w	a0, a0
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_9
	j	.LBB0_7
.LBB0_7:                                # %scalar.ph
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_8
.LBB0_8:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	sext.w	a4, a0
	slli	a4, a4, 1
	add	a3, a3, a4
	lh	a3, 0(a3)
	addw	a2, a2, a3
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_8
	j	.LBB0_9
.LBB0_9:                                # %for.cond.cleanup.loopexit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	j	.LBB0_10
.LBB0_10:                               # %for.cond.cleanup
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
