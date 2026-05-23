# Source: LoopVectorize/tail-folding-bin-unary-ops-args.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_udiv
# src = pre-opt (test_udiv), tgt = post-opt (test_udiv)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 3
	call	__udivdi3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %finish.loopexit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 1
	li	a0, 32
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB10_2
# %bb.1:                                # %loop.preheader
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB10_2:                               # %loop.preheader
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 100
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB10_7
	j	.LBB10_3
.LBB10_3:                               # %vector.memcheck
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB10_7
	j	.LBB10_4
.LBB10_4:                               # %vector.ph
	csrr	a0, vlenb
	slli	a1, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 96
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB10_5
.LBB10_5:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	add	a4, a4, a0
                                        # implicit-def: $v8m2
	vsetvli	a5, zero, e8, m2, ta, ma
	vle8.v	v8, (a4)
	li	a4, -85
                                        # implicit-def: $v10m2
	vmulhu.vx	v10, v8, a4
                                        # implicit-def: $v8m2
	vsrl.vi	v8, v10, 1
	add	a3, a3, a0
	vse8.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_5
	j	.LBB10_6
.LBB10_6:                               # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	li	a1, 100
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB10_9
	j	.LBB10_7
.LBB10_7:                               # %scalar.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB10_8
.LBB10_8:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 3
	call	__udivdi3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_8
	j	.LBB10_9
.LBB10_9:                               # %finish.loopexit
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
