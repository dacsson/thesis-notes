# Source: LoopVectorize/riscv-unroll.riscv64__v_loop-vectorize_LMUL2.ll
# Function: array_add
# src = pre-opt (array_add), tgt = post-opt (array_add)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sext.w	a1, a3
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a1, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
	lw	a5, 0(a5)
	add	a2, a2, a4
	lw	a2, 0(a2)
	addw	a2, a2, a5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a2, a0, 1
	addiw	a0, a0, 1
	sext.w	a1, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %for.end.loopexit
	j	.LBB0_4
.LBB0_4:                                # %for.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sext.w	a1, a3
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a1, .LBB0_8
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sext.w	a0, a0
	li	a2, 0
	li	a1, 8
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_5
	j	.LBB0_2
.LBB0_2:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	andi	a0, a0, -8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 64(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a5, a5, a3
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v12, (a5)
	add	a4, a4, a3
                                        # implicit-def: $v10m2
	vle32.v	v10, (a4)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v12
	add	a2, a2, a3
	vse32.v	v8, (a2)
	addi	a0, a0, 8
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_3
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_7
	j	.LBB0_5
.LBB0_5:                                # %scalar.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 64(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
	lw	a5, 0(a5)
	add	a2, a2, a4
	lw	a2, 0(a2)
	addw	a2, a2, a5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a2, a0, 1
	addiw	a0, a0, 1
	sext.w	a1, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_6
	j	.LBB0_7
.LBB0_7:                                # %for.end.loopexit
	j	.LBB0_8
.LBB0_8:                                # %for.end
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
