# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v3f32
# src = pre-opt (shuffle_v3f32), tgt = post-opt (shuffle_v3f32)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 80(sp)                      # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB30_2
	j	.LBB30_1
.LBB30_1:                               # %then
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB30_3
.LBB30_2:                               # %else
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	func1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB30_3
.LBB30_3:                               # %finally
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	sw	a3, 8(a1)
	slli	a2, a2, 32
	slli	a0, a0, 32
	srli	a0, a0, 32
	or	a0, a0, a2
	sd	a0, 0(a1)
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end30:
	.size	src, .Lfunc_end30-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 80(sp)                      # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB30_2
	j	.LBB30_1
.LBB30_1:                               # %then
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB30_3
.LBB30_2:                               # %else
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	func1
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB30_3
.LBB30_3:                               # %finally
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	sw	a3, 8(a1)
	slli	a2, a2, 32
	slli	a0, a0, 32
	srli	a0, a0, 32
	or	a0, a0, a2
	sd	a0, 0(a1)
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end30:
	.size	tgt, .Lfunc_end30-tgt
	.cfi_endproc
                                        # -- End function
