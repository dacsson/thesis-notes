# Source: PreISelIntrinsicLowering/memset-pattern.riscv64_pre-isel-intrinsic-lowering.ll
# Function: memset_pattern_i256_x
# src = pre-opt (memset_pattern_i256_x), tgt = post-opt (memset_pattern_i256_x)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -64
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	ld	a0, 24(a1)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	ld	a0, 16(a1)
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	ld	a0, 8(a1)
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	ld	a0, 0(a1)
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	beqz	a2, .LBB4_2
	j	.LBB4_1
.LBB4_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	ld	a6, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a7, a0, 5
	add	a3, a3, a7
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	srli	a7, a6, 56
	sb	a7, 15(a3)
	srli	a7, a6, 48
	sb	a7, 14(a3)
	srli	a7, a6, 40
	sb	a7, 13(a3)
	srli	a7, a6, 32
	sb	a7, 12(a3)
	srli	a7, a6, 24
	sb	a7, 11(a3)
	srli	a7, a6, 16
	sb	a7, 10(a3)
	srli	a7, a6, 8
	sb	a7, 9(a3)
	sb	a6, 8(a3)
	srli	a6, a5, 56
	sb	a6, 7(a3)
	srli	a6, a5, 48
	sb	a6, 6(a3)
	srli	a6, a5, 40
	sb	a6, 5(a3)
	srli	a6, a5, 32
	sb	a6, 4(a3)
	srli	a6, a5, 24
	sb	a6, 3(a3)
	srli	a6, a5, 16
	sb	a6, 2(a3)
	srli	a6, a5, 8
	sb	a6, 1(a3)
	sb	a5, 0(a3)
	srli	a5, a4, 56
	sb	a5, 23(a3)
	srli	a5, a4, 48
	sb	a5, 22(a3)
	srli	a5, a4, 40
	sb	a5, 21(a3)
	srli	a5, a4, 32
	sb	a5, 20(a3)
	srli	a5, a4, 24
	sb	a5, 19(a3)
	srli	a5, a4, 16
	sb	a5, 18(a3)
	sb	a4, 16(a3)
	srli	a4, a4, 8
	sb	a4, 17(a3)
	srli	a4, a2, 56
	sb	a4, 31(a3)
	srli	a4, a2, 48
	sb	a4, 30(a3)
	srli	a4, a2, 40
	sb	a4, 29(a3)
	srli	a4, a2, 32
	sb	a4, 28(a3)
	srli	a4, a2, 24
	sb	a4, 27(a3)
	srli	a4, a2, 16
	sb	a4, 26(a3)
	sb	a2, 24(a3)
	srli	a2, a2, 8
	sb	a2, 25(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %memset.pattern-post-expansion
	addi	sp, sp, 64
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -64
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	ld	a0, 24(a1)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	ld	a0, 16(a1)
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	ld	a0, 8(a1)
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	ld	a0, 0(a1)
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	beqz	a2, .LBB4_2
	j	.LBB4_1
.LBB4_1:                                # %memset.pattern-expansion-main-body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	ld	a6, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a7, a0, 5
	add	a3, a3, a7
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	srli	a7, a6, 56
	sb	a7, 15(a3)
	srli	a7, a6, 48
	sb	a7, 14(a3)
	srli	a7, a6, 40
	sb	a7, 13(a3)
	srli	a7, a6, 32
	sb	a7, 12(a3)
	srli	a7, a6, 24
	sb	a7, 11(a3)
	srli	a7, a6, 16
	sb	a7, 10(a3)
	srli	a7, a6, 8
	sb	a7, 9(a3)
	sb	a6, 8(a3)
	srli	a6, a5, 56
	sb	a6, 7(a3)
	srli	a6, a5, 48
	sb	a6, 6(a3)
	srli	a6, a5, 40
	sb	a6, 5(a3)
	srli	a6, a5, 32
	sb	a6, 4(a3)
	srli	a6, a5, 24
	sb	a6, 3(a3)
	srli	a6, a5, 16
	sb	a6, 2(a3)
	srli	a6, a5, 8
	sb	a6, 1(a3)
	sb	a5, 0(a3)
	srli	a5, a4, 56
	sb	a5, 23(a3)
	srli	a5, a4, 48
	sb	a5, 22(a3)
	srli	a5, a4, 40
	sb	a5, 21(a3)
	srli	a5, a4, 32
	sb	a5, 20(a3)
	srli	a5, a4, 24
	sb	a5, 19(a3)
	srli	a5, a4, 16
	sb	a5, 18(a3)
	sb	a4, 16(a3)
	srli	a4, a4, 8
	sb	a4, 17(a3)
	srli	a4, a2, 56
	sb	a4, 31(a3)
	srli	a4, a2, 48
	sb	a4, 30(a3)
	srli	a4, a2, 40
	sb	a4, 29(a3)
	srli	a4, a2, 32
	sb	a4, 28(a3)
	srli	a4, a2, 24
	sb	a4, 27(a3)
	srli	a4, a2, 16
	sb	a4, 26(a3)
	sb	a2, 24(a3)
	srli	a2, a2, 8
	sb	a2, 25(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %memset.pattern-post-expansion
	addi	sp, sp, 64
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
                                        # -- End function
