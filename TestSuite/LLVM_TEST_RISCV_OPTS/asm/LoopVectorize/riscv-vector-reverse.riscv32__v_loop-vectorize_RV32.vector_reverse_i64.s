# Source: LoopVectorize/riscv-vector-reverse.riscv32__v_loop-vectorize_RV32.ll
# Function: vector_reverse_i64
# src = pre-opt (vector_reverse_i64), tgt = post-opt (vector_reverse_i64)
# Triple: riscv32, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	.cfi_remember_state
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	li	a0, 0
	bge	a0, a2, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %for.body.preheader
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	li	a1, 0
	mv	a2, a0
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	j	.LBB1_3
.LBB1_2:                                # %for.cond.cleanup
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB1_3:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	lw	a3, 8(sp)                       # 4-byte Folded Reload
	lw	a4, 28(sp)                      # 4-byte Folded Reload
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	addi	a1, a1, -1
	slli	a5, a1, 2
	add	a0, a0, a5
	lw	a0, 0(a0)
	addi	a0, a0, 1
	add	a4, a4, a5
	sw	a0, 0(a4)
	sltiu	a4, a3, 2
	seqz	a0, a2
	and	a0, a0, a4
	seqz	a4, a3
	sub	a2, a2, a4
	addi	a3, a3, -1
	sw	a3, 8(sp)                       # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_3
	j	.LBB1_2
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_remember_state
	sw	a2, 72(sp)                      # 4-byte Folded Spill
	sw	a1, 76(sp)                      # 4-byte Folded Spill
	sw	a0, 80(sp)                      # 4-byte Folded Spill
	sw	a0, 84(sp)                      # 4-byte Folded Spill
	sw	a1, 88(sp)                      # 4-byte Folded Spill
	li	a0, 0
	bge	a0, a2, .LBB1_12
	j	.LBB1_1
.LBB1_1:                                # %for.body.preheader
	lw	a0, 72(sp)                      # 4-byte Folded Reload
	li	a1, 0
	sw	a1, 64(sp)                      # 4-byte Folded Spill
	sw	a0, 68(sp)                      # 4-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.memcheck
	lw	a0, 88(sp)                      # 4-byte Folded Reload
	lw	a2, 84(sp)                      # 4-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	bltu	a0, a1, .LBB1_10
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
	lw	a0, 64(sp)                      # 4-byte Folded Reload
	lw	a1, 68(sp)                      # 4-byte Folded Reload
	li	a3, 0
	mv	a2, a3
	sw	a3, 48(sp)                      # 4-byte Folded Spill
	sw	a2, 52(sp)                      # 4-byte Folded Spill
	sw	a1, 56(sp)                      # 4-byte Folded Spill
	sw	a0, 60(sp)                      # 4-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	lw	a1, 52(sp)                      # 4-byte Folded Reload
	lw	a2, 56(sp)                      # 4-byte Folded Reload
	lw	a3, 60(sp)                      # 4-byte Folded Reload
	sw	a3, 32(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 3
	li	a2, 4
	li	a3, 0
	mv	a1, a3
	call	__muldi3
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	mv	a3, a0
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	sw	a3, 36(sp)                      # 4-byte Folded Spill
	sltu	a4, a0, a1
	sw	a4, 40(sp)                      # 4-byte Folded Spill
	sltu	a2, a2, a3
	sw	a2, 44(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB1_6
# %bb.5:                                # %vector.body
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 40(sp)                      # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
.LBB1_6:                                # %vector.body
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_8
# %bb.7:                                # %vector.body
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	sw	a0, 16(sp)                      # 4-byte Folded Spill
.LBB1_8:                                # %vector.body
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	lw	a3, 24(sp)                      # 4-byte Folded Reload
	lw	a4, 80(sp)                      # 4-byte Folded Reload
	lw	a6, 76(sp)                      # 4-byte Folded Reload
	lw	a7, 72(sp)                      # 4-byte Folded Reload
	lw	a5, 16(sp)                      # 4-byte Folded Reload
	sub	a7, a7, a3
	slli	a7, a7, 2
	addi	a7, a7, -4
	add	t0, a6, a7
	li	a6, -4
                                        # implicit-def: $v10m2
	vsetvli	zero, a5, e32, m2, tu, ma
	vlse32.v	v10, (t0), a6
                                        # implicit-def: $v8m2
	vsetvli	t0, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	add	a4, a4, a7
	vsetvli	zero, a5, e32, m2, ta, ma
	vsse32.v	v8, (a4), a6
	add	a4, a5, a3
	sltu	a3, a4, a5
	add	a3, a2, a3
	sub	a2, a1, a5
	sltu	a1, a1, a5
	sub	a1, a0, a1
	or	a0, a2, a1
	sw	a4, 48(sp)                      # 4-byte Folded Spill
	sw	a3, 52(sp)                      # 4-byte Folded Spill
	sw	a2, 56(sp)                      # 4-byte Folded Spill
	sw	a1, 60(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_9
.LBB1_9:                                # %middle.block
	j	.LBB1_11
.LBB1_10:                               # %scalar.ph
	lw	a0, 72(sp)                      # 4-byte Folded Reload
	lw	a1, 64(sp)                      # 4-byte Folded Reload
	lw	a2, 68(sp)                      # 4-byte Folded Reload
	sw	a2, 4(sp)                       # 4-byte Folded Spill
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB1_13
.LBB1_11:                               # %for.cond.cleanup.loopexit
	j	.LBB1_12
.LBB1_12:                               # %for.cond.cleanup
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.LBB1_13:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	lw	a2, 8(sp)                       # 4-byte Folded Reload
	lw	a3, 4(sp)                       # 4-byte Folded Reload
	lw	a4, 80(sp)                      # 4-byte Folded Reload
	lw	a0, 76(sp)                      # 4-byte Folded Reload
	addi	a1, a1, -1
	slli	a5, a1, 2
	add	a0, a0, a5
	lw	a0, 0(a0)
	addi	a0, a0, 1
	add	a4, a4, a5
	sw	a0, 0(a4)
	sltiu	a4, a3, 2
	seqz	a0, a2
	and	a0, a0, a4
	seqz	a4, a3
	sub	a2, a2, a4
	addi	a3, a3, -1
	sw	a3, 4(sp)                       # 4-byte Folded Spill
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_13
	j	.LBB1_11
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
