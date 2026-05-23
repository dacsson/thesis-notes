# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v8f16
# src = pre-opt (shuffle_v8f16), tgt = post-opt (shuffle_v8f16)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -240
	.cfi_def_cfa_offset 240
	sd	ra, 232(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 208(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 216(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 224(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB26_2
	j	.LBB26_1
.LBB26_1:                               # %then
	ld	a0, 216(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a7, 72(sp)                      # 8-byte Folded Reload
	ld	a6, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 88(sp)                      # 8-byte Folded Reload
	ld	a4, 96(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a7, 136(sp)                     # 8-byte Folded Spill
	sd	a6, 144(sp)                     # 8-byte Folded Spill
	sd	a5, 152(sp)                     # 8-byte Folded Spill
	sd	a4, 160(sp)                     # 8-byte Folded Spill
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	j	.LBB26_3
.LBB26_2:                               # %else
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
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
	ld	a7, 8(sp)                       # 8-byte Folded Reload
	ld	a6, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a7, 136(sp)                     # 8-byte Folded Spill
	sd	a6, 144(sp)                     # 8-byte Folded Spill
	sd	a5, 152(sp)                     # 8-byte Folded Spill
	sd	a4, 160(sp)                     # 8-byte Folded Spill
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	j	.LBB26_3
.LBB26_3:                               # %finally
	ld	a1, 224(sp)                     # 8-byte Folded Reload
	ld	t0, 136(sp)                     # 8-byte Folded Reload
	ld	a7, 144(sp)                     # 8-byte Folded Reload
	ld	a6, 152(sp)                     # 8-byte Folded Reload
	ld	a5, 160(sp)                     # 8-byte Folded Reload
	ld	a4, 168(sp)                     # 8-byte Folded Reload
	ld	a3, 176(sp)                     # 8-byte Folded Reload
	ld	a2, 184(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	sh	t0, 0(a1)
	sh	a7, 2(a1)
	sh	a6, 4(a1)
	sh	a5, 6(a1)
	sh	a4, 8(a1)
	sh	a3, 10(a1)
	sh	a2, 12(a1)
	sh	a0, 14(a1)
	ld	ra, 232(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 240
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end26:
	.size	src, .Lfunc_end26-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -240
	.cfi_def_cfa_offset 240
	sd	ra, 232(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 208(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 216(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 224(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB26_2
	j	.LBB26_1
.LBB26_1:                               # %then
	ld	a0, 216(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	call	func0
	ld	a7, 72(sp)                      # 8-byte Folded Reload
	ld	a6, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 88(sp)                      # 8-byte Folded Reload
	ld	a4, 96(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a7, 136(sp)                     # 8-byte Folded Spill
	sd	a6, 144(sp)                     # 8-byte Folded Spill
	sd	a5, 152(sp)                     # 8-byte Folded Spill
	sd	a4, 160(sp)                     # 8-byte Folded Spill
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	j	.LBB26_3
.LBB26_2:                               # %else
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
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
	ld	a7, 8(sp)                       # 8-byte Folded Reload
	ld	a6, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a7, 136(sp)                     # 8-byte Folded Spill
	sd	a6, 144(sp)                     # 8-byte Folded Spill
	sd	a5, 152(sp)                     # 8-byte Folded Spill
	sd	a4, 160(sp)                     # 8-byte Folded Spill
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	j	.LBB26_3
.LBB26_3:                               # %finally
	ld	a1, 224(sp)                     # 8-byte Folded Reload
	ld	t0, 136(sp)                     # 8-byte Folded Reload
	ld	a7, 144(sp)                     # 8-byte Folded Reload
	ld	a6, 152(sp)                     # 8-byte Folded Reload
	ld	a5, 160(sp)                     # 8-byte Folded Reload
	ld	a4, 168(sp)                     # 8-byte Folded Reload
	ld	a3, 176(sp)                     # 8-byte Folded Reload
	ld	a2, 184(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	sh	t0, 0(a1)
	sh	a7, 2(a1)
	sh	a6, 4(a1)
	sh	a5, 6(a1)
	sh	a4, 8(a1)
	sh	a3, 10(a1)
	sh	a2, 12(a1)
	sh	a0, 14(a1)
	ld	ra, 232(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 240
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end26:
	.size	tgt, .Lfunc_end26-tgt
	.cfi_endproc
                                        # -- End function
