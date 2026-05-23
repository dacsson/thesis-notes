# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v6f16
# src = pre-opt (shuffle_v6f16), tgt = post-opt (shuffle_v6f16)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -192
	.cfi_def_cfa_offset 192
	sd	ra, 184(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 160(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 176(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB25_2
	j	.LBB25_1
.LBB25_1:                               # %then
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a5, 104(sp)                     # 8-byte Folded Spill
	sd	a4, 112(sp)                     # 8-byte Folded Spill
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	j	.LBB25_3
.LBB25_2:                               # %else
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	func1
	ld	a5, 8(sp)                       # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a5, 104(sp)                     # 8-byte Folded Spill
	sd	a4, 112(sp)                     # 8-byte Folded Spill
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	j	.LBB25_3
.LBB25_3:                               # %finally
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a4, 104(sp)                     # 8-byte Folded Reload
	ld	a6, 112(sp)                     # 8-byte Folded Reload
	ld	a5, 120(sp)                     # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	slli	a5, a5, 48
	srli	a5, a5, 16
	slli	a3, a3, 48
	or	a5, a3, a5
	lui	a3, 16
	addi	a3, a3, -1
	and	a4, a4, a3
	slliw	a6, a6, 16
	or	a4, a4, a6
	slli	a4, a4, 32
	srli	a4, a4, 32
	or	a4, a4, a5
	sd	a4, 0(a1)
	and	a0, a0, a3
	slliw	a2, a2, 16
	or	a0, a0, a2
	sw	a0, 8(a1)
	ld	ra, 184(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end25:
	.size	src, .Lfunc_end25-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -192
	.cfi_def_cfa_offset 192
	sd	ra, 184(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 160(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 176(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB25_2
	j	.LBB25_1
.LBB25_1:                               # %then
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a5, 104(sp)                     # 8-byte Folded Spill
	sd	a4, 112(sp)                     # 8-byte Folded Spill
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	j	.LBB25_3
.LBB25_2:                               # %else
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	func1
	ld	a5, 8(sp)                       # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a5, 104(sp)                     # 8-byte Folded Spill
	sd	a4, 112(sp)                     # 8-byte Folded Spill
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	j	.LBB25_3
.LBB25_3:                               # %finally
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a4, 104(sp)                     # 8-byte Folded Reload
	ld	a6, 112(sp)                     # 8-byte Folded Reload
	ld	a5, 120(sp)                     # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	slli	a5, a5, 48
	srli	a5, a5, 16
	slli	a3, a3, 48
	or	a5, a3, a5
	lui	a3, 16
	addi	a3, a3, -1
	and	a4, a4, a3
	slliw	a6, a6, 16
	or	a4, a4, a6
	slli	a4, a4, 32
	srli	a4, a4, 32
	or	a4, a4, a5
	sd	a4, 0(a1)
	and	a0, a0, a3
	slliw	a2, a2, 16
	or	a0, a0, a2
	sw	a0, 8(a1)
	ld	ra, 184(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end25:
	.size	tgt, .Lfunc_end25-tgt
	.cfi_endproc
                                        # -- End function
