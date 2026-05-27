# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_2.ll
# Function: double_stride_ptr_iv
# src = pre-opt (double_stride_ptr_iv), tgt = post-opt (double_stride_ptr_iv)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	lw	a4, 0(a3)
	addiw	a4, a4, 1
	sw	a4, 0(a1)
	add	a3, a3, a2
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a4, a0
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %exit
	addi	sp, sp, 32
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
	addi	sp, sp, -192
	.cfi_def_cfa_offset 192
	sd	ra, 184(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	sd	a0, 176(sp)                     # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %vector.memcheck
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	ld	a2, 160(sp)                     # 8-byte Folded Reload
	slli	a1, a2, 10
	sub	a1, a1, a2
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_3
# %bb.2:                                # %vector.memcheck
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 152(sp)                     # 8-byte Folded Spill
.LBB8_3:                                # %vector.memcheck
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_5
# %bb.4:                                # %vector.memcheck
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB8_5:                                # %vector.memcheck
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	addi	a2, a2, 4
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_7
# %bb.6:                                # %vector.memcheck
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
.LBB8_7:                                # %vector.memcheck
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_9
# %bb.8:                                # %vector.memcheck
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB8_9:                                # %vector.memcheck
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	addi	a1, a1, 4
	bgeu	a0, a1, .LBB8_11
	j	.LBB8_10
.LBB8_10:                               # %vector.memcheck
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB8_14
	j	.LBB8_11
.LBB8_11:                               # %vector.ph
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a2, 176(sp)                     # 8-byte Folded Reload
	li	a0, 1024
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB8_12
.LBB8_12:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a4, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v8
                                        # implicit-def: $v12m4
	vmul.vx	v12, v8, a0
	vsetvli	a1, a2, e8, mf2, ta, ma
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e32, m2, tu, ma
	vluxei64.v	v10, (a4), v12
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v8, (a3), v12
	sub	a2, a2, a1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	add	a1, a1, a3
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB8_12
	j	.LBB8_13
.LBB8_13:                               # %middle.block
	j	.LBB8_16
.LBB8_14:                               # %scalar.ph
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_15
.LBB8_15:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 160(sp)                     # 8-byte Folded Reload
	lw	a4, 0(a3)
	addiw	a4, a4, 1
	sw	a4, 0(a1)
	add	a3, a3, a2
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a4, a0
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_15
	j	.LBB8_16
.LBB8_16:                               # %exit
	ld	ra, 184(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
