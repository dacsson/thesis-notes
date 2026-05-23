# Source: PreISelIntrinsicLowering/memset-pattern.riscv64_pre-isel-intrinsic-lowering.ll
# Function: memset_pattern_i128_x
# src = pre-opt (memset_pattern_i128_x), tgt = post-opt (memset_pattern_i128_x)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -48
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	beqz	a3, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 4
	add	a3, a3, a5
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	srli	a5, a4, 56
	sb	a5, 15(a3)
	srli	a5, a4, 48
	sb	a5, 14(a3)
	srli	a5, a4, 40
	sb	a5, 13(a3)
	srli	a5, a4, 32
	sb	a5, 12(a3)
	srli	a5, a4, 24
	sb	a5, 11(a3)
	srli	a5, a4, 16
	sb	a5, 10(a3)
	srli	a5, a4, 8
	sb	a5, 9(a3)
	sb	a4, 8(a3)
	srli	a4, a2, 56
	sb	a4, 7(a3)
	srli	a4, a2, 48
	sb	a4, 6(a3)
	srli	a4, a2, 40
	sb	a4, 5(a3)
	srli	a4, a2, 32
	sb	a4, 4(a3)
	srli	a4, a2, 24
	sb	a4, 3(a3)
	srli	a4, a2, 16
	sb	a4, 2(a3)
	srli	a4, a2, 8
	sb	a4, 1(a3)
	sb	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %memset.pattern-post-expansion
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -48
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	beqz	a3, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 4
	add	a3, a3, a5
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	srli	a5, a4, 56
	sb	a5, 15(a3)
	srli	a5, a4, 48
	sb	a5, 14(a3)
	srli	a5, a4, 40
	sb	a5, 13(a3)
	srli	a5, a4, 32
	sb	a5, 12(a3)
	srli	a5, a4, 24
	sb	a5, 11(a3)
	srli	a5, a4, 16
	sb	a5, 10(a3)
	srli	a5, a4, 8
	sb	a5, 9(a3)
	sb	a4, 8(a3)
	srli	a4, a2, 56
	sb	a4, 7(a3)
	srli	a4, a2, 48
	sb	a4, 6(a3)
	srli	a4, a2, 40
	sb	a4, 5(a3)
	srli	a4, a2, 32
	sb	a4, 4(a3)
	srli	a4, a2, 24
	sb	a4, 3(a3)
	srli	a4, a2, 16
	sb	a4, 2(a3)
	srli	a4, a2, 8
	sb	a4, 1(a3)
	sb	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %memset.pattern-post-expansion
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
                                        # -- End function
