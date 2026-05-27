# Source: InterleavedAccess/zvl32b.riscv32__zve32x__zvl32b_interleaved-access_ZVL32B.ll
# Function: load_factor2_large
# src = pre-opt (load_factor2_large), tgt = post-opt (load_factor2_large)
# Triple: riscv32, Attrs: +zve32x,+zvl32b
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	sw	s10, 32(sp)                     # 4-byte Folded Spill
	sw	s11, 28(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	.cfi_offset s7, -36
	.cfi_offset s8, -40
	.cfi_offset s9, -44
	.cfi_offset s10, -48
	.cfi_offset s11, -52
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	mv	a1, a0
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a2, 0(a0)
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	lw	a2, 8(a0)
	lw	a3, 16(a0)
	lw	a4, 24(a0)
	lw	a5, 32(a0)
	lw	a6, 40(a0)
	lw	a7, 48(a0)
	lw	t0, 56(a0)
	lw	t1, 64(a0)
	lw	t2, 72(a0)
	lw	t3, 80(a0)
	lw	t4, 88(a0)
	lw	t5, 96(a0)
	lw	t6, 104(a0)
	lw	s0, 112(a0)
	lw	s1, 120(a0)
	lw	s2, 4(a0)
	lw	s3, 12(a0)
	lw	s4, 20(a0)
	lw	s5, 28(a0)
	lw	s6, 36(a0)
	lw	s7, 44(a0)
	lw	s8, 52(a0)
	lw	s9, 60(a0)
	lw	s10, 68(a0)
	lw	s11, 76(a0)
	lw	ra, 84(a0)
	lw	a0, 92(a0)
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 100(a0)
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 108(a0)
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 116(a0)
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 124(a0)
	sw	a0, 124(a1)
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	sw	a0, 120(a1)
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a0, 116(a1)
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	sw	a0, 112(a1)
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	sw	a0, 108(a1)
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	ra, 104(a1)
	sw	s11, 100(a1)
	sw	s10, 96(a1)
	sw	s9, 92(a1)
	sw	s8, 88(a1)
	sw	s7, 84(a1)
	sw	s6, 80(a1)
	sw	s5, 76(a1)
	sw	s4, 72(a1)
	sw	s3, 68(a1)
	sw	s2, 64(a1)
	sw	s1, 60(a1)
	sw	s0, 56(a1)
	sw	t6, 52(a1)
	sw	t5, 48(a1)
	sw	t4, 44(a1)
	sw	t3, 40(a1)
	sw	t2, 36(a1)
	sw	t1, 32(a1)
	sw	t0, 28(a1)
	sw	a7, 24(a1)
	sw	a6, 20(a1)
	sw	a5, 16(a1)
	sw	a4, 12(a1)
	sw	a3, 8(a1)
	sw	a2, 4(a1)
	sw	a0, 0(a1)
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	lw	s10, 32(sp)                     # 4-byte Folded Reload
	lw	s11, 28(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	.cfi_restore s11
	addi	sp, sp, 80
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
# %bb.0:
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	sw	s10, 32(sp)                     # 4-byte Folded Spill
	sw	s11, 28(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	.cfi_offset s7, -36
	.cfi_offset s8, -40
	.cfi_offset s9, -44
	.cfi_offset s10, -48
	.cfi_offset s11, -52
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	mv	a1, a0
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a2, 0(a0)
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	lw	a2, 8(a0)
	lw	a3, 16(a0)
	lw	a4, 24(a0)
	lw	a5, 32(a0)
	lw	a6, 40(a0)
	lw	a7, 48(a0)
	lw	t0, 56(a0)
	lw	t1, 64(a0)
	lw	t2, 72(a0)
	lw	t3, 80(a0)
	lw	t4, 88(a0)
	lw	t5, 96(a0)
	lw	t6, 104(a0)
	lw	s0, 112(a0)
	lw	s1, 120(a0)
	lw	s2, 4(a0)
	lw	s3, 12(a0)
	lw	s4, 20(a0)
	lw	s5, 28(a0)
	lw	s6, 36(a0)
	lw	s7, 44(a0)
	lw	s8, 52(a0)
	lw	s9, 60(a0)
	lw	s10, 68(a0)
	lw	s11, 76(a0)
	lw	ra, 84(a0)
	lw	a0, 92(a0)
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 100(a0)
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 108(a0)
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 116(a0)
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a0, 124(a0)
	sw	a0, 124(a1)
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	sw	a0, 120(a1)
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a0, 116(a1)
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	sw	a0, 112(a1)
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	sw	a0, 108(a1)
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	ra, 104(a1)
	sw	s11, 100(a1)
	sw	s10, 96(a1)
	sw	s9, 92(a1)
	sw	s8, 88(a1)
	sw	s7, 84(a1)
	sw	s6, 80(a1)
	sw	s5, 76(a1)
	sw	s4, 72(a1)
	sw	s3, 68(a1)
	sw	s2, 64(a1)
	sw	s1, 60(a1)
	sw	s0, 56(a1)
	sw	t6, 52(a1)
	sw	t5, 48(a1)
	sw	t4, 44(a1)
	sw	t3, 40(a1)
	sw	t2, 36(a1)
	sw	t1, 32(a1)
	sw	t0, 28(a1)
	sw	a7, 24(a1)
	sw	a6, 20(a1)
	sw	a5, 16(a1)
	sw	a4, 12(a1)
	sw	a3, 8(a1)
	sw	a2, 4(a1)
	sw	a0, 0(a1)
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	lw	s10, 32(sp)                     # 4-byte Folded Reload
	lw	s11, 28(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	.cfi_restore s11
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
