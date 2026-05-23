# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v3f16
# src = pre-opt (shuffle_v3f16), tgt = post-opt (shuffle_v3f16)
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
	beqz	a0, .LBB23_2
	j	.LBB23_1
.LBB23_1:                               # %then
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
	j	.LBB23_3
.LBB23_2:                               # %else
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
	j	.LBB23_3
.LBB23_3:                               # %finally
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	sh	a3, 4(a1)
	slliw	a2, a2, 16
	slli	a0, a0, 48
	srli	a0, a0, 48
	or	a0, a0, a2
	sw	a0, 0(a1)
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end23:
	.size	src, .Lfunc_end23-src
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
	beqz	a0, .LBB23_2
	j	.LBB23_1
.LBB23_1:                               # %then
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
	j	.LBB23_3
.LBB23_2:                               # %else
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
	j	.LBB23_3
.LBB23_3:                               # %finally
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	sh	a3, 4(a1)
	slliw	a2, a2, 16
	slli	a0, a0, 48
	srli	a0, a0, 48
	or	a0, a0, a2
	sw	a0, 0(a1)
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end23:
	.size	tgt, .Lfunc_end23-tgt
	.cfi_endproc
                                        # -- End function
