# Source: PreISelIntrinsicLowering/memset-pattern.riscv64_pre-isel-intrinsic-lowering.ll
# Function: memset_pattern_i128_1
# src = pre-opt (memset_pattern_i128_1), tgt = post-opt (memset_pattern_i128_1)
# Triple: riscv64, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -48
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 4
	add	a2, a2, a4
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	srli	a4, a3, 56
	sb	a4, 15(a2)
	srli	a4, a3, 48
	sb	a4, 14(a2)
	srli	a4, a3, 40
	sb	a4, 13(a2)
	srli	a4, a3, 32
	sb	a4, 12(a2)
	srli	a4, a3, 24
	sb	a4, 11(a2)
	srli	a4, a3, 16
	sb	a4, 10(a2)
	srli	a4, a3, 8
	sb	a4, 9(a2)
	sb	a3, 8(a2)
	srli	a3, a1, 56
	sb	a3, 7(a2)
	srli	a3, a1, 48
	sb	a3, 6(a2)
	srli	a3, a1, 40
	sb	a3, 5(a2)
	srli	a3, a1, 32
	sb	a3, 4(a2)
	srli	a3, a1, 24
	sb	a3, 3(a2)
	srli	a3, a1, 16
	sb	a3, 2(a2)
	srli	a3, a1, 8
	sb	a3, 1(a2)
	sb	a1, 0(a2)
	addi	a0, a0, 1
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %memset.pattern-post-expansion
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -48
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 4
	add	a2, a2, a4
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	srli	a4, a3, 56
	sb	a4, 15(a2)
	srli	a4, a3, 48
	sb	a4, 14(a2)
	srli	a4, a3, 40
	sb	a4, 13(a2)
	srli	a4, a3, 32
	sb	a4, 12(a2)
	srli	a4, a3, 24
	sb	a4, 11(a2)
	srli	a4, a3, 16
	sb	a4, 10(a2)
	srli	a4, a3, 8
	sb	a4, 9(a2)
	sb	a3, 8(a2)
	srli	a3, a1, 56
	sb	a3, 7(a2)
	srli	a3, a1, 48
	sb	a3, 6(a2)
	srli	a3, a1, 40
	sb	a3, 5(a2)
	srli	a3, a1, 32
	sb	a3, 4(a2)
	srli	a3, a1, 24
	sb	a3, 3(a2)
	srli	a3, a1, 16
	sb	a3, 2(a2)
	srli	a3, a1, 8
	sb	a3, 1(a2)
	sb	a1, 0(a2)
	addi	a0, a0, 1
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %memset.pattern-post-expansion
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
                                        # -- End function
