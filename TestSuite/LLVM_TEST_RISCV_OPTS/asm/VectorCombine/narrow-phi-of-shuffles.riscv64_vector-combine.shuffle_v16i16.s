# Source: VectorCombine/narrow-phi-of-shuffles.riscv64_vector-combine.ll
# Function: shuffle_v16i16
# src = pre-opt (shuffle_v16i16), tgt = post-opt (shuffle_v16i16)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -432
	.cfi_def_cfa_offset 432
	sd	ra, 424(sp)                     # 8-byte Folded Spill
	sd	s0, 416(sp)                     # 8-byte Folded Spill
	sd	s1, 408(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	sd	a1, 376(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 376(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 384(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 392(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 400(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB8_2
	j	.LBB8_1
.LBB8_1:                                # %then
	ld	s0, 392(sp)                     # 8-byte Folded Reload
	mv	a0, s0
	sd	a0, 240(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 232(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 224(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 216(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 208(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 200(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 176(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 168(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 160(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	call	func0
	ld	t6, 128(sp)                     # 8-byte Folded Reload
	ld	t5, 136(sp)                     # 8-byte Folded Reload
	ld	t4, 144(sp)                     # 8-byte Folded Reload
	ld	t3, 152(sp)                     # 8-byte Folded Reload
	ld	t2, 160(sp)                     # 8-byte Folded Reload
	ld	t1, 168(sp)                     # 8-byte Folded Reload
	ld	t0, 176(sp)                     # 8-byte Folded Reload
	ld	a7, 184(sp)                     # 8-byte Folded Reload
	ld	a6, 192(sp)                     # 8-byte Folded Reload
	ld	a5, 200(sp)                     # 8-byte Folded Reload
	ld	a4, 208(sp)                     # 8-byte Folded Reload
	ld	a3, 216(sp)                     # 8-byte Folded Reload
	ld	a2, 224(sp)                     # 8-byte Folded Reload
	ld	a1, 232(sp)                     # 8-byte Folded Reload
	ld	a0, 240(sp)                     # 8-byte Folded Reload
	sd	s0, 248(sp)                     # 8-byte Folded Spill
	sd	t6, 256(sp)                     # 8-byte Folded Spill
	sd	t5, 264(sp)                     # 8-byte Folded Spill
	sd	t4, 272(sp)                     # 8-byte Folded Spill
	sd	t3, 280(sp)                     # 8-byte Folded Spill
	sd	t2, 288(sp)                     # 8-byte Folded Spill
	sd	t1, 296(sp)                     # 8-byte Folded Spill
	sd	t0, 304(sp)                     # 8-byte Folded Spill
	sd	a7, 312(sp)                     # 8-byte Folded Spill
	sd	a6, 320(sp)                     # 8-byte Folded Spill
	sd	a5, 328(sp)                     # 8-byte Folded Spill
	sd	a4, 336(sp)                     # 8-byte Folded Spill
	sd	a3, 344(sp)                     # 8-byte Folded Spill
	sd	a2, 352(sp)                     # 8-byte Folded Spill
	sd	a1, 360(sp)                     # 8-byte Folded Spill
	sd	a0, 368(sp)                     # 8-byte Folded Spill
	j	.LBB8_3
.LBB8_2:                                # %else
	ld	s0, 384(sp)                     # 8-byte Folded Reload
	mv	a0, s0
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	func1
	ld	t6, 8(sp)                       # 8-byte Folded Reload
	ld	t5, 16(sp)                      # 8-byte Folded Reload
	ld	t4, 24(sp)                      # 8-byte Folded Reload
	ld	t3, 32(sp)                      # 8-byte Folded Reload
	ld	t2, 40(sp)                      # 8-byte Folded Reload
	ld	t1, 48(sp)                      # 8-byte Folded Reload
	ld	t0, 56(sp)                      # 8-byte Folded Reload
	ld	a7, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	ld	a4, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	s0, 248(sp)                     # 8-byte Folded Spill
	sd	t6, 256(sp)                     # 8-byte Folded Spill
	sd	t5, 264(sp)                     # 8-byte Folded Spill
	sd	t4, 272(sp)                     # 8-byte Folded Spill
	sd	t3, 280(sp)                     # 8-byte Folded Spill
	sd	t2, 288(sp)                     # 8-byte Folded Spill
	sd	t1, 296(sp)                     # 8-byte Folded Spill
	sd	t0, 304(sp)                     # 8-byte Folded Spill
	sd	a7, 312(sp)                     # 8-byte Folded Spill
	sd	a6, 320(sp)                     # 8-byte Folded Spill
	sd	a5, 328(sp)                     # 8-byte Folded Spill
	sd	a4, 336(sp)                     # 8-byte Folded Spill
	sd	a3, 344(sp)                     # 8-byte Folded Spill
	sd	a2, 352(sp)                     # 8-byte Folded Spill
	sd	a1, 360(sp)                     # 8-byte Folded Spill
	sd	a0, 368(sp)                     # 8-byte Folded Spill
	j	.LBB8_3
.LBB8_3:                                # %finally
	ld	a1, 400(sp)                     # 8-byte Folded Reload
	ld	s1, 248(sp)                     # 8-byte Folded Reload
	ld	s0, 256(sp)                     # 8-byte Folded Reload
	ld	t6, 264(sp)                     # 8-byte Folded Reload
	ld	t5, 272(sp)                     # 8-byte Folded Reload
	ld	t4, 280(sp)                     # 8-byte Folded Reload
	ld	t3, 288(sp)                     # 8-byte Folded Reload
	ld	t2, 296(sp)                     # 8-byte Folded Reload
	ld	t1, 304(sp)                     # 8-byte Folded Reload
	ld	t0, 312(sp)                     # 8-byte Folded Reload
	ld	a7, 320(sp)                     # 8-byte Folded Reload
	ld	a6, 328(sp)                     # 8-byte Folded Reload
	ld	a5, 336(sp)                     # 8-byte Folded Reload
	ld	a4, 344(sp)                     # 8-byte Folded Reload
	ld	a3, 352(sp)                     # 8-byte Folded Reload
	ld	a2, 360(sp)                     # 8-byte Folded Reload
	ld	a0, 368(sp)                     # 8-byte Folded Reload
	sh	s1, 0(a1)
	sh	s0, 2(a1)
	sh	t6, 4(a1)
	sh	t5, 6(a1)
	sh	t4, 8(a1)
	sh	t3, 10(a1)
	sh	t2, 12(a1)
	sh	t1, 14(a1)
	sh	t0, 16(a1)
	sh	a7, 18(a1)
	sh	a6, 20(a1)
	sh	a5, 22(a1)
	sh	a4, 24(a1)
	sh	a3, 26(a1)
	sh	a2, 28(a1)
	sh	a0, 30(a1)
	ld	ra, 424(sp)                     # 8-byte Folded Reload
	ld	s0, 416(sp)                     # 8-byte Folded Reload
	ld	s1, 408(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 432
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -432
	.cfi_def_cfa_offset 432
	sd	ra, 424(sp)                     # 8-byte Folded Spill
	sd	s0, 416(sp)                     # 8-byte Folded Spill
	sd	s1, 408(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	sd	a1, 376(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 376(sp)                     # 8-byte Folded Reload
	ld	a3, 16(a0)
	sd	a3, 384(sp)                     # 8-byte Folded Spill
	ld	a3, 8(a0)
	sd	a3, 392(sp)                     # 8-byte Folded Spill
	ld	a0, 0(a0)
	andi	a0, a2, 1
	sd	a1, 400(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB8_2
	j	.LBB8_1
.LBB8_1:                                # %then
	ld	s0, 392(sp)                     # 8-byte Folded Reload
	mv	a0, s0
	sd	a0, 240(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 232(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 224(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 216(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 208(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 200(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 176(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 168(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 160(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	call	func0
	ld	t6, 128(sp)                     # 8-byte Folded Reload
	ld	t5, 136(sp)                     # 8-byte Folded Reload
	ld	t4, 144(sp)                     # 8-byte Folded Reload
	ld	t3, 152(sp)                     # 8-byte Folded Reload
	ld	t2, 160(sp)                     # 8-byte Folded Reload
	ld	t1, 168(sp)                     # 8-byte Folded Reload
	ld	t0, 176(sp)                     # 8-byte Folded Reload
	ld	a7, 184(sp)                     # 8-byte Folded Reload
	ld	a6, 192(sp)                     # 8-byte Folded Reload
	ld	a5, 200(sp)                     # 8-byte Folded Reload
	ld	a4, 208(sp)                     # 8-byte Folded Reload
	ld	a3, 216(sp)                     # 8-byte Folded Reload
	ld	a2, 224(sp)                     # 8-byte Folded Reload
	ld	a1, 232(sp)                     # 8-byte Folded Reload
	ld	a0, 240(sp)                     # 8-byte Folded Reload
	sd	s0, 248(sp)                     # 8-byte Folded Spill
	sd	t6, 256(sp)                     # 8-byte Folded Spill
	sd	t5, 264(sp)                     # 8-byte Folded Spill
	sd	t4, 272(sp)                     # 8-byte Folded Spill
	sd	t3, 280(sp)                     # 8-byte Folded Spill
	sd	t2, 288(sp)                     # 8-byte Folded Spill
	sd	t1, 296(sp)                     # 8-byte Folded Spill
	sd	t0, 304(sp)                     # 8-byte Folded Spill
	sd	a7, 312(sp)                     # 8-byte Folded Spill
	sd	a6, 320(sp)                     # 8-byte Folded Spill
	sd	a5, 328(sp)                     # 8-byte Folded Spill
	sd	a4, 336(sp)                     # 8-byte Folded Spill
	sd	a3, 344(sp)                     # 8-byte Folded Spill
	sd	a2, 352(sp)                     # 8-byte Folded Spill
	sd	a1, 360(sp)                     # 8-byte Folded Spill
	sd	a0, 368(sp)                     # 8-byte Folded Spill
	j	.LBB8_3
.LBB8_2:                                # %else
	ld	s0, 384(sp)                     # 8-byte Folded Reload
	mv	a0, s0
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a0, s0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	func1
	ld	t6, 8(sp)                       # 8-byte Folded Reload
	ld	t5, 16(sp)                      # 8-byte Folded Reload
	ld	t4, 24(sp)                      # 8-byte Folded Reload
	ld	t3, 32(sp)                      # 8-byte Folded Reload
	ld	t2, 40(sp)                      # 8-byte Folded Reload
	ld	t1, 48(sp)                      # 8-byte Folded Reload
	ld	t0, 56(sp)                      # 8-byte Folded Reload
	ld	a7, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	ld	a4, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	s0, 248(sp)                     # 8-byte Folded Spill
	sd	t6, 256(sp)                     # 8-byte Folded Spill
	sd	t5, 264(sp)                     # 8-byte Folded Spill
	sd	t4, 272(sp)                     # 8-byte Folded Spill
	sd	t3, 280(sp)                     # 8-byte Folded Spill
	sd	t2, 288(sp)                     # 8-byte Folded Spill
	sd	t1, 296(sp)                     # 8-byte Folded Spill
	sd	t0, 304(sp)                     # 8-byte Folded Spill
	sd	a7, 312(sp)                     # 8-byte Folded Spill
	sd	a6, 320(sp)                     # 8-byte Folded Spill
	sd	a5, 328(sp)                     # 8-byte Folded Spill
	sd	a4, 336(sp)                     # 8-byte Folded Spill
	sd	a3, 344(sp)                     # 8-byte Folded Spill
	sd	a2, 352(sp)                     # 8-byte Folded Spill
	sd	a1, 360(sp)                     # 8-byte Folded Spill
	sd	a0, 368(sp)                     # 8-byte Folded Spill
	j	.LBB8_3
.LBB8_3:                                # %finally
	ld	a1, 400(sp)                     # 8-byte Folded Reload
	ld	s1, 248(sp)                     # 8-byte Folded Reload
	ld	s0, 256(sp)                     # 8-byte Folded Reload
	ld	t6, 264(sp)                     # 8-byte Folded Reload
	ld	t5, 272(sp)                     # 8-byte Folded Reload
	ld	t4, 280(sp)                     # 8-byte Folded Reload
	ld	t3, 288(sp)                     # 8-byte Folded Reload
	ld	t2, 296(sp)                     # 8-byte Folded Reload
	ld	t1, 304(sp)                     # 8-byte Folded Reload
	ld	t0, 312(sp)                     # 8-byte Folded Reload
	ld	a7, 320(sp)                     # 8-byte Folded Reload
	ld	a6, 328(sp)                     # 8-byte Folded Reload
	ld	a5, 336(sp)                     # 8-byte Folded Reload
	ld	a4, 344(sp)                     # 8-byte Folded Reload
	ld	a3, 352(sp)                     # 8-byte Folded Reload
	ld	a2, 360(sp)                     # 8-byte Folded Reload
	ld	a0, 368(sp)                     # 8-byte Folded Reload
	sh	s1, 0(a1)
	sh	s0, 2(a1)
	sh	t6, 4(a1)
	sh	t5, 6(a1)
	sh	t4, 8(a1)
	sh	t3, 10(a1)
	sh	t2, 12(a1)
	sh	t1, 14(a1)
	sh	t0, 16(a1)
	sh	a7, 18(a1)
	sh	a6, 20(a1)
	sh	a5, 22(a1)
	sh	a4, 24(a1)
	sh	a3, 26(a1)
	sh	a2, 28(a1)
	sh	a0, 30(a1)
	ld	ra, 424(sp)                     # 8-byte Folded Reload
	ld	s0, 416(sp)                     # 8-byte Folded Reload
	ld	s1, 408(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 432
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
