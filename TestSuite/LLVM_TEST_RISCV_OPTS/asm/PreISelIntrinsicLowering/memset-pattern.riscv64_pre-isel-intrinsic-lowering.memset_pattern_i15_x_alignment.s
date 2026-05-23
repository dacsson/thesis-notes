# Source: PreISelIntrinsicLowering/memset-pattern.riscv64_pre-isel-intrinsic-lowering.ll
# Function: memset_pattern_i15_x_alignment
# src = pre-opt (memset_pattern_i15_x_alignment), tgt = post-opt (memset_pattern_i15_x_alignment)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -48
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	beqz	a2, .LBB5_2
	j	.LBB5_1
.LBB5_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 1
	add	a3, a3, a4
	slli	a4, a2, 49
	srli	a4, a4, 57
	sb	a4, 1(a3)
	sb	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %memset.pattern-post-expansion
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB5_4
	j	.LBB5_3
.LBB5_3:                                # %memset.pattern-expansion-main-body2
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 1
	add	a3, a3, a4
	slli	a2, a2, 49
	srli	a2, a2, 49
	sh	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_3
	j	.LBB5_4
.LBB5_4:                                # %memset.pattern-post-expansion1
	addi	sp, sp, 48
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -48
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	beqz	a2, .LBB5_2
	j	.LBB5_1
.LBB5_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 1
	add	a3, a3, a4
	slli	a4, a2, 49
	srli	a4, a4, 57
	sb	a4, 1(a3)
	sb	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %memset.pattern-post-expansion
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB5_4
	j	.LBB5_3
.LBB5_3:                                # %memset.pattern-expansion-main-body2
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 1
	add	a3, a3, a4
	slli	a2, a2, 49
	srli	a2, a2, 49
	sh	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_3
	j	.LBB5_4
.LBB5_4:                                # %memset.pattern-post-expansion1
	addi	sp, sp, 48
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
                                        # -- End function
