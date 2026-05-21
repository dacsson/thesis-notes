# Source: LoopStrengthReduce/many-geps.ll
# Function: main
# src = pre-opt (main), tgt = post-opt (main)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a0, a1
	jalr	a1
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 5
	slli	a2, a0, 3
	add	a3, a2, a3
	slli	a2, a0, 7
	sub	a2, a2, a3
	add	a2, a1, a2
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sw	a1, 8(a2)
	sw	a1, 12(a2)
	sw	a1, 16(a2)
	sw	a1, 20(a2)
	sw	a1, 24(a2)
	sw	a1, 28(a2)
	sw	a1, 32(a2)
	sw	a1, 36(a2)
	sd	a1, 40(a2)
	sw	a1, 48(a2)
	sw	a1, 72(a2)
	sd	a1, 80(a2)
	addi	a0, a0, 1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	li	a1, 0
	mv	a0, a1
	jalr	a1
	mv	t3, a0
	li	a0, 72
	li	a1, 48
	li	a2, 40
	li	a3, 36
	li	a4, 32
	li	a5, 28
	li	a6, 24
	li	a7, 20
	li	t0, 16
	li	t1, 12
	li	t2, 8
	sd	t3, 8(sp)                       # 8-byte Folded Spill
	sd	t2, 16(sp)                      # 8-byte Folded Spill
	sd	t1, 24(sp)                      # 8-byte Folded Spill
	sd	t0, 32(sp)                      # 8-byte Folded Spill
	sd	a7, 40(sp)                      # 8-byte Folded Spill
	sd	a6, 48(sp)                      # 8-byte Folded Spill
	sd	a5, 56(sp)                      # 8-byte Folded Spill
	sd	a4, 64(sp)                      # 8-byte Folded Spill
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	ld	a6, 48(sp)                      # 8-byte Folded Reload
	ld	a7, 40(sp)                      # 8-byte Folded Reload
	ld	t0, 32(sp)                      # 8-byte Folded Reload
	ld	t1, 24(sp)                      # 8-byte Folded Reload
	ld	t2, 16(sp)                      # 8-byte Folded Reload
	ld	t5, 8(sp)                       # 8-byte Folded Reload
	add	t4, t5, t2
	li	t3, 0
	sd	t3, 0(sp)                       # 8-byte Folded Spill
	sw	t3, 0(t4)
	add	t4, t5, t1
	sw	t3, 0(t4)
	add	t4, t5, t0
	sw	t3, 0(t4)
	add	t4, t5, a7
	sw	t3, 0(t4)
	add	t4, t5, a6
	sw	t3, 0(t4)
	add	t4, t5, a5
	sw	t3, 0(t4)
	add	t4, t5, a4
	sw	t3, 0(t4)
	add	t4, t5, a3
	sw	t3, 0(t4)
	add	t4, t5, a2
	sd	t3, 0(t4)
	add	t6, t5, a1
	sw	t3, 0(t6)
	add	t5, t5, a0
	sw	t3, 0(t5)
	sd	t3, 40(t4)
	addi	a0, a0, 88
	addi	a1, a1, 88
	addi	a2, a2, 88
	addi	a3, a3, 88
	addi	a4, a4, 88
	addi	a5, a5, 88
	addi	a6, a6, 88
	addi	a7, a7, 88
	addi	t0, t0, 88
	addi	t1, t1, 88
	addi	t2, t2, 88
	sd	t2, 16(sp)                      # 8-byte Folded Spill
	sd	t1, 24(sp)                      # 8-byte Folded Spill
	sd	t0, 32(sp)                      # 8-byte Folded Spill
	sd	a7, 40(sp)                      # 8-byte Folded Spill
	sd	a6, 48(sp)                      # 8-byte Folded Spill
	sd	a5, 56(sp)                      # 8-byte Folded Spill
	sd	a4, 64(sp)                      # 8-byte Folded Spill
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
