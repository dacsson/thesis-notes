# Source: LoopVectorize/tail-folding-bin-unary-ops-args.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: test_ashr
# src = pre-opt (test_ashr), tgt = post-opt (test_ashr)
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
	j	.LBB5_1
.LBB5_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a3, 1
	add	a1, a1, a3
	lb	a1, 0(a1)
	srli	a1, a1, 1
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %finish.loopexit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	bltu	a0, a1, .LBB5_5
	j	.LBB5_2
.LBB5_2:                                # %vector.ph
	li	a0, 100
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_3
.LBB5_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, m2, ta, ma
	add	a4, a4, a1
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e8, m2, tu, ma
	vle8.v	v10, (a4)
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e8, m2, ta, ma
	vsra.vi	v8, v10, 1
	add	a3, a3, a1
	vsetvli	zero, a2, e8, m2, ta, ma
	vse8.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_3
	j	.LBB5_4
.LBB5_4:                                # %middle.block
	j	.LBB5_7
.LBB5_5:                                # %scalar.ph
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_6
.LBB5_6:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	addi	a0, a3, 1
	add	a1, a1, a3
	lb	a1, 0(a1)
	srli	a1, a1, 1
	add	a2, a2, a3
	sb	a1, 0(a2)
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB5_6
	j	.LBB5_7
.LBB5_7:                                # %finish.loopexit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
