# Source: LoopVectorize/tail-folding-bin-unary-ops-args.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_mul
# src = pre-opt (test_mul), tgt = post-opt (test_mul)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a3, 1
	add	a1, a1, a3
	lbu	a4, 0(a1)
	slliw	a1, a4, 1
	addw	a1, a1, a4
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %finish.loopexit
	addi	sp, sp, 32
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
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 1
	li	a0, 32
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_2
# %bb.1:                                # %loop.preheader
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB8_2:                                # %loop.preheader
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 100
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_7
	j	.LBB8_3
.LBB8_3:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	li	a2, 0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_7
	j	.LBB8_4
.LBB8_4:                                # %vector.ph
	csrr	a0, vlenb
	slli	a1, a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 96
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB8_5
.LBB8_5:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	add	a4, a4, a0
                                        # implicit-def: $v10m2
	vsetvli	a5, zero, e8, m2, ta, ma
	vle8.v	v10, (a4)
	li	a4, 3
                                        # implicit-def: $v8m2
	vmul.vx	v8, v10, a4
	add	a3, a3, a0
	vse8.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_5
	j	.LBB8_6
.LBB8_6:                                # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 100
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB8_9
	j	.LBB8_7
.LBB8_7:                                # %scalar.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB8_8
.LBB8_8:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	addi	a0, a3, 1
	add	a1, a1, a3
	lbu	a4, 0(a1)
	slliw	a1, a4, 1
	addw	a1, a1, a4
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB8_8
	j	.LBB8_9
.LBB8_9:                                # %finish.loopexit
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
