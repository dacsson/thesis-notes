# Source: LoopVectorize/transform-narrow-interleave-to-widen-memory.riscv64__v.ll
# Function: interleave_group_with_countable_early_exit
# src = pre-opt (interleave_group_with_countable_early_exit), tgt = post-opt (interleave_group_with_countable_early_exit)
# Triple: riscv64, Attrs: +v
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	bgeu	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %exit1
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB1_3:                                # %loop.latch
                                        #   in Loop: Header=BB1_1 Depth=1
	.cfi_restore_state
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a1, 4
	add	a3, a2, a3
	li	a2, 0
	sd	a2, 0(a3)
	sd	a2, 8(a3)
	addi	a2, a1, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_4
.LBB1_4:                                # %exit2
	addi	sp, sp, 32
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
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	.cfi_remember_state
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	addi	a0, a0, 1
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 38
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
# %bb.1:                                # %entry
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 136(sp)                     # 8-byte Folded Spill
.LBB1_2:                                # %entry
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bgeu	a0, a1, .LBB1_12
	j	.LBB1_3
.LBB1_3:                                # %vector.scevcheck
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	slli	a4, a2, 4
	srli	a0, a4, 4
	xor	a0, a0, a2
	snez	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	add	a0, a1, a4
	addi	a2, a1, 8
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	add	a2, a2, a4
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_12
	j	.LBB1_4
.LBB1_4:                                # %vector.scevcheck
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_12
	j	.LBB1_5
.LBB1_5:                                # %vector.scevcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_12
	j	.LBB1_6
.LBB1_6:                                # %vector.scevcheck
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_12
	j	.LBB1_7
.LBB1_7:                                # %vector.ph
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	csrr	a1, vlenb
	srli	a1, a1, 3
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	addi	a2, a1, -1
	and	a0, a0, a2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB1_9
# %bb.8:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
.LBB1_9:                                # %vector.ph
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_10:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	slli	a4, a0, 4
	add	a3, a3, a4
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, tu, ma
	vmv.v.i	v8, 0
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_10
	j	.LBB1_11
.LBB1_11:                               # %middle.block
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB1_12
.LBB1_12:                               # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_13
.LBB1_13:                               # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	bgeu	a0, a1, .LBB1_15
	j	.LBB1_14
.LBB1_14:                               # %exit1
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.LBB1_15:                               # %loop.latch
                                        #   in Loop: Header=BB1_13 Depth=1
	.cfi_restore_state
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	slli	a3, a1, 4
	add	a3, a2, a3
	li	a2, 0
	sd	a2, 0(a3)
	sd	a2, 8(a3)
	addi	a2, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_13
	j	.LBB1_16
.LBB1_16:                               # %exit2
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
