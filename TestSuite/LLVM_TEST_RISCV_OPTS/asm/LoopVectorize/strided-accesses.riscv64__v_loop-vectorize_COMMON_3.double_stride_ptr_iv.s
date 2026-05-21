# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_3.ll
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
	addi	sp, sp, -304
	.cfi_def_cfa_offset 304
	sd	ra, 296(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x02, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 304 + 8 * vlenb
	sd	a2, 240(sp)                     # 8-byte Folded Spill
	sd	a1, 248(sp)                     # 8-byte Folded Spill
	sd	a0, 256(sp)                     # 8-byte Folded Spill
	csrr	a1, vlenb
	li	a0, 28
	sd	a0, 264(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 272(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_2
# %bb.1:                                # %entry
	ld	a0, 264(sp)                     # 8-byte Folded Reload
	sd	a0, 272(sp)                     # 8-byte Folded Spill
.LBB8_2:                                # %entry
	ld	a2, 248(sp)                     # 8-byte Folded Reload
	ld	a3, 256(sp)                     # 8-byte Folded Reload
	ld	a1, 272(sp)                     # 8-byte Folded Reload
	li	a4, 0
	li	a0, 1024
	sd	a4, 216(sp)                     # 8-byte Folded Spill
	sd	a3, 224(sp)                     # 8-byte Folded Spill
	sd	a2, 232(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_16
	j	.LBB8_3
.LBB8_3:                                # %vector.memcheck
	ld	a0, 248(sp)                     # 8-byte Folded Reload
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	slli	a1, a2, 10
	sub	a1, a1, a2
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 208(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_5
# %bb.4:                                # %vector.memcheck
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	sd	a0, 208(sp)                     # 8-byte Folded Spill
.LBB8_5:                                # %vector.memcheck
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	ld	a1, 248(sp)                     # 8-byte Folded Reload
	ld	a2, 208(sp)                     # 8-byte Folded Reload
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_7
# %bb.6:                                # %vector.memcheck
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	sd	a0, 184(sp)                     # 8-byte Folded Spill
.LBB8_7:                                # %vector.memcheck
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	ld	a2, 184(sp)                     # 8-byte Folded Reload
	addi	a2, a2, 4
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 168(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_9
# %bb.8:                                # %vector.memcheck
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	sd	a0, 168(sp)                     # 8-byte Folded Spill
.LBB8_9:                                # %vector.memcheck
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a1, 256(sp)                     # 8-byte Folded Reload
	ld	a2, 168(sp)                     # 8-byte Folded Reload
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 144(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_11
# %bb.10:                               # %vector.memcheck
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	sd	a0, 144(sp)                     # 8-byte Folded Spill
.LBB8_11:                               # %vector.memcheck
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	addi	a1, a1, 4
	li	a2, 0
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bgeu	a0, a1, .LBB8_13
	j	.LBB8_12
.LBB8_12:                               # %vector.memcheck
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a2, 248(sp)                     # 8-byte Folded Reload
	ld	a3, 256(sp)                     # 8-byte Folded Reload
	ld	a4, 128(sp)                     # 8-byte Folded Reload
	sd	a4, 216(sp)                     # 8-byte Folded Spill
	sd	a3, 224(sp)                     # 8-byte Folded Spill
	sd	a2, 232(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_16
	j	.LBB8_13
.LBB8_13:                               # %vector.ph
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	csrr	a2, vlenb
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	srli	a0, a2, 1
                                        # implicit-def: $v8m4
	vsetvli	a3, zero, e64, m4, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 288
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	li	a0, 0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	subw	a0, a0, a2
	andi	a0, a0, 1024
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a3, 240(sp)                     # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 256(sp)                     # 8-byte Folded Reload
	addi	a4, sp, 288
	vl4r.v	v12, (a4)                       # vscale x 32-byte Folded Reload
	mv	a4, a0
	ld	a0, 248(sp)                     # 8-byte Folded Reload
	add	a5, a1, a4
	sd	a5, 88(sp)                      # 8-byte Folded Spill
	add	a4, a0, a4
	sd	a4, 96(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vmul.vx	v8, v12, a3
	csrr	a3, vlenb
	slli	a3, a3, 2
	add	a3, sp, a3
	addi	a3, a3, 288
	vs4r.v	v8, (a3)                        # vscale x 32-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	j	.LBB8_14
.LBB8_14:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a4, 120(sp)                     # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 240(sp)                     # 8-byte Folded Reload
	csrr	a5, vlenb
	slli	a5, a5, 2
	add	a5, sp, a5
	addi	a5, a5, 288
	vl4r.v	v20, (a5)                       # vscale x 32-byte Folded Reload
	sd	a4, 48(sp)                      # 8-byte Folded Spill
	sd	a3, 40(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	a5, zero, e64, m4, ta, ma
	vid.v	v8
                                        # implicit-def: $v16m4
	vmul.vx	v16, v8, a0
                                        # implicit-def: $v8m4
	vadd.vx	v8, v16, a4
                                        # implicit-def: $v12m4
	vadd.vx	v12, v16, a3
                                        # implicit-def: $v24m4
	vadd.vv	v24, v12, v20
                                        # implicit-def: $v12m4
	vadd.vv	v12, v8, v20
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v8, (a3), v16
	li	a3, 0
                                        # implicit-def: $v20m2
	vluxei64.v	v20, (a3), v24
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v20, 1
	vsoxei64.v	v10, (a4), v16
	vsoxei64.v	v8, (a3), v12
	add	a2, a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	add	a3, a3, a4
	add	a2, a2, a4
	mv	a4, a0
	sd	a4, 104(sp)                     # 8-byte Folded Spill
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB8_14
	j	.LBB8_15
.LBB8_15:                               # %middle.block
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a4, a0
	sd	a4, 216(sp)                     # 8-byte Folded Spill
	sd	a3, 224(sp)                     # 8-byte Folded Spill
	sd	a2, 232(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB8_18
	j	.LBB8_16
.LBB8_16:                               # %scalar.ph
	ld	a2, 216(sp)                     # 8-byte Folded Reload
	ld	a1, 224(sp)                     # 8-byte Folded Reload
	ld	a0, 232(sp)                     # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB8_17
.LBB8_17:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	lw	a4, 0(a3)
	addiw	a4, a4, 1
	sw	a4, 0(a1)
	add	a3, a3, a2
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a4, a0
	sd	a4, 16(sp)                      # 8-byte Folded Spill
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_17
	j	.LBB8_18
.LBB8_18:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 304
	ld	ra, 296(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 304
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
