# Source: LoopVectorize/riscv-vector-reverse.riscv64__v_loop-vectorize_RV64.ll
# Function: vector_reverse_i64
# src = pre-opt (vector_reverse_i64), tgt = post-opt (vector_reverse_i64)
# Triple: riscv64, Attrs: +v
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
	.cfi_remember_state
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a0, a2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a2, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %for.body.preheader
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_2:                                # %for.cond.cleanup
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.LBB1_3:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addiw	a2, a2, -1
	slli	a4, a2, 32
	srli	a4, a4, 30
	add	a0, a0, a4
	lw	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a4
	sw	a0, 0(a3)
	addi	a3, a1, -1
	li	a0, 1
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_3
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
	.cfi_remember_state
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a2, .LBB1_10
	j	.LBB1_1
.LBB1_1:                                # %for.body.preheader
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a0, a0, 32
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.scevcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	addi	a1, a1, -1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	addiw	a0, a0, -1
	subw	a1, a0, a1
	bltu	a0, a1, .LBB1_8
	j	.LBB1_3
.LBB1_3:                                # %vector.scevcheck
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	srli	a0, a0, 32
	bnez	a0, .LBB1_8
	j	.LBB1_4
.LBB1_4:                                # %vector.memcheck
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	bltu	a0, a1, .LBB1_8
	j	.LBB1_5
.LBB1_5:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_6
.LBB1_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	not	a5, a1
	addw	a5, a5, a6
	slli	a5, a5, 32
	srli	a5, a5, 30
	add	a6, a4, a5
	li	a4, -4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vlse32.v	v10, (a6), a4
                                        # implicit-def: $v8m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	add	a3, a3, a5
	vsetvli	zero, a2, e32, m2, ta, ma
	vsse32.v	v8, (a3), a4
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_6
	j	.LBB1_7
.LBB1_7:                                # %middle.block
	j	.LBB1_9
.LBB1_8:                                # %scalar.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_11
.LBB1_9:                                # %for.cond.cleanup.loopexit
	j	.LBB1_10
.LBB1_10:                               # %for.cond.cleanup
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.LBB1_11:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addiw	a2, a2, -1
	slli	a4, a2, 32
	srli	a4, a4, 30
	add	a0, a0, a4
	lw	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a4
	sw	a0, 0(a3)
	addi	a3, a1, -1
	li	a0, 1
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_11
	j	.LBB1_9
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
