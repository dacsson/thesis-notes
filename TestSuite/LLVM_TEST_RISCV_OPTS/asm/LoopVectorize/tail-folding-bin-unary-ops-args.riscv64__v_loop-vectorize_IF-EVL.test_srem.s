# Source: LoopVectorize/tail-folding-bin-unary-ops-args.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: test_srem
# src = pre-opt (test_srem), tgt = post-opt (test_srem)
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
	j	.LBB11_1
.LBB11_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	lb	a0, 0(a0)
	li	a1, 3
	call	__moddi3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB11_1
	j	.LBB11_2
.LBB11_2:                               # %finish.loopexit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	j	.LBB11_1
.LBB11_1:                               # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	bltu	a0, a1, .LBB11_5
	j	.LBB11_2
.LBB11_2:                               # %vector.ph
	li	a0, 100
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB11_3
.LBB11_3:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, m2, ta, ma
	add	a4, a4, a1
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e8, m2, tu, ma
	vle8.v	v10, (a4)
	li	a4, 86
                                        # implicit-def: $v12m2
	vsetvli	a5, zero, e8, m2, ta, ma
	vmulh.vx	v12, v10, a4
                                        # implicit-def: $v14m2
	vsrl.vi	v14, v12, 7
                                        # implicit-def: $v8m2
	vadd.vv	v8, v12, v14
	li	a4, 3
	vnmsub.vx	v8, a4, v10
	add	a3, a3, a1
	vsetvli	zero, a2, e8, m2, ta, ma
	vse8.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB11_3
	j	.LBB11_4
.LBB11_4:                               # %middle.block
	j	.LBB11_7
.LBB11_5:                               # %scalar.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB11_6
.LBB11_6:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	lb	a0, 0(a0)
	li	a1, 3
	call	__moddi3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB11_6
	j	.LBB11_7
.LBB11_7:                               # %finish.loopexit
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
