# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v4i32
# src = pre-opt (shuffle_v4i32), tgt = post-opt (shuffle_v4i32)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB11_2
	j	.LBB11_1
.LBB11_1:                               # %then
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB11_3
.LBB11_2:                               # %else
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	func1
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB11_3
.LBB11_3:                               # %finally
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sw	a4, 0(a1)
	sw	a3, 4(a1)
	sw	a2, 8(a1)
	sw	a0, 12(a1)
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
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
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB11_2
	j	.LBB11_1
.LBB11_1:                               # %then
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB11_3
.LBB11_2:                               # %else
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	func1
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB11_3
.LBB11_3:                               # %finally
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sw	a4, 0(a1)
	sw	a3, 4(a1)
	sw	a2, 8(a1)
	sw	a0, 12(a1)
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
