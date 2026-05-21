# Source: LoopVectorize/riscv-unroll.riscv32__v_loop-vectorize_LMUL2.ll
# Function: array_add
# src = pre-opt (array_add), tgt = post-opt (array_add)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	a3, 16(sp)                      # 4-byte Folded Spill
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	li	a0, 0
	bge	a0, a3, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	li	a1, 0
	mv	a0, a1
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	lw	a4, 20(sp)                      # 4-byte Folded Reload
	lw	a3, 24(sp)                      # 4-byte Folded Reload
	lw	a6, 28(sp)                      # 4-byte Folded Reload
	slli	a5, a0, 2
	add	a6, a6, a5
	lw	a6, 0(a6)
	add	a3, a3, a5
	lw	a3, 0(a3)
	add	a3, a3, a6
	add	a4, a4, a5
	sw	a3, 0(a4)
	addi	a0, a0, 1
	seqz	a3, a0
	add	a2, a2, a3
	mv	a3, a0
	sw	a3, 8(sp)                       # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %for.end.loopexit
	j	.LBB0_4
.LBB0_4:                                # %for.end
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sw	a3, 48(sp)                      # 4-byte Folded Spill
	sw	a2, 52(sp)                      # 4-byte Folded Spill
	sw	a1, 56(sp)                      # 4-byte Folded Spill
	sw	a0, 60(sp)                      # 4-byte Folded Spill
	li	a0, 0
	bge	a0, a3, .LBB0_8
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	li	a3, 0
	mv	a1, a3
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	mv	a1, a0
	sw	a1, 36(sp)                      # 4-byte Folded Spill
	mv	a2, a3
	li	a1, 8
	sw	a3, 40(sp)                      # 4-byte Folded Spill
	sw	a2, 44(sp)                      # 4-byte Folded Spill
	bltu	a0, a1, .LBB0_5
	j	.LBB0_2
.LBB0_2:                                # %vector.ph
	lw	a2, 32(sp)                      # 4-byte Folded Reload
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	andi	a0, a0, -8
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a4, 24(sp)                      # 4-byte Folded Reload
	lw	a3, 20(sp)                      # 4-byte Folded Reload
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	lw	a2, 52(sp)                      # 4-byte Folded Reload
	lw	a6, 56(sp)                      # 4-byte Folded Reload
	lw	a7, 60(sp)                      # 4-byte Folded Reload
	slli	a5, a4, 2
	add	a7, a7, a5
                                        # implicit-def: $v12m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v12, (a7)
	add	a6, a6, a5
                                        # implicit-def: $v10m2
	vle32.v	v10, (a6)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v12
	add	a2, a2, a5
	vse32.v	v8, (a2)
	addi	a2, a4, 8
	sltu	a4, a2, a4
	add	a1, a1, a4
	xor	a0, a2, a0
	xor	a3, a1, a3
	or	a0, a0, a3
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	lw	a3, 32(sp)                      # 4-byte Folded Reload
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	xor	a0, a0, a2
	xor	a3, a3, a1
	or	a0, a0, a3
	sw	a2, 40(sp)                      # 4-byte Folded Spill
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_7
	j	.LBB0_5
.LBB0_5:                                # %scalar.ph
	lw	a1, 40(sp)                      # 4-byte Folded Reload
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	lw	a4, 52(sp)                      # 4-byte Folded Reload
	lw	a3, 56(sp)                      # 4-byte Folded Reload
	lw	a6, 60(sp)                      # 4-byte Folded Reload
	slli	a5, a0, 2
	add	a6, a6, a5
	lw	a6, 0(a6)
	add	a3, a3, a5
	lw	a3, 0(a3)
	add	a3, a3, a6
	add	a4, a4, a5
	sw	a3, 0(a4)
	addi	a0, a0, 1
	seqz	a3, a0
	add	a2, a2, a3
	mv	a3, a0
	sw	a3, 8(sp)                       # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	bne	a0, a1, .LBB0_6
	j	.LBB0_7
.LBB0_7:                                # %for.end.loopexit
	j	.LBB0_8
.LBB0_8:                                # %for.end
	lw	a0, 52(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
