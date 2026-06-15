# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_3.ll
# Function: double_stride_int_scaled
# src = pre-opt (double_stride_int_scaled), tgt = post-opt (double_stride_int_scaled)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	addiw	a1, a1, 1
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_1
	j	.LBB6_2
.LBB6_2:                                # %exit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
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
	slli	a3, a3, 2
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x02, 0x22, 0x11, 0x0c, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 304 + 12 * vlenb
	sd	a2, 240(sp)                     # 8-byte Folded Spill
	sd	a1, 248(sp)                     # 8-byte Folded Spill
	sd	a0, 256(sp)                     # 8-byte Folded Spill
	csrr	a1, vlenb
	li	a0, 79
	sd	a0, 264(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 272(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_2
# %bb.1:                                # %entry
	ld	a0, 264(sp)                     # 8-byte Folded Reload
	sd	a0, 272(sp)                     # 8-byte Folded Spill
.LBB6_2:                                # %entry
	ld	a1, 272(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a2, 232(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_24
	j	.LBB6_3
.LBB6_3:                                # %vector.scevcheck
	ld	a0, 240(sp)                     # 8-byte Folded Reload
	slli	a0, a0, 2
	sd	a0, 208(sp)                     # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 216(sp)                     # 8-byte Folded Spill
	sub	a1, a1, a0
	sd	a1, 224(sp)                     # 8-byte Folded Spill
	bltz	a0, .LBB6_5
# %bb.4:                                # %vector.scevcheck
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	sd	a0, 224(sp)                     # 8-byte Folded Spill
.LBB6_5:                                # %vector.scevcheck
	ld	a3, 216(sp)                     # 8-byte Folded Reload
	ld	a0, 224(sp)                     # 8-byte Folded Reload
	li	a2, 1023
	mv	a1, a3
	call	__multi3
	ld	a2, 248(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	mv	a4, a1
	ld	a1, 256(sp)                     # 8-byte Folded Reload
	snez	a4, a4
	sd	a4, 168(sp)                     # 8-byte Folded Spill
	add	a5, a2, a3
	sub	a4, a2, a3
	sltu	a5, a5, a2
	sd	a5, 176(sp)                     # 8-byte Folded Spill
	sltu	a2, a2, a4
	add	a4, a1, a3
	sub	a3, a1, a3
	sltu	a4, a4, a1
	sd	a4, 184(sp)                     # 8-byte Folded Spill
	sltu	a1, a1, a3
	sd	a2, 192(sp)                     # 8-byte Folded Spill
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	bltz	a0, .LBB6_7
# %bb.6:                                # %vector.scevcheck
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	sd	a0, 200(sp)                     # 8-byte Folded Spill
.LBB6_7:                                # %vector.scevcheck
	ld	a2, 168(sp)                     # 8-byte Folded Reload
	ld	a1, 216(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	ld	a3, 200(sp)                     # 8-byte Folded Reload
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	sd	a1, 232(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB6_24
	j	.LBB6_8
.LBB6_8:                                # %vector.scevcheck
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 232(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB6_24
	j	.LBB6_9
.LBB6_9:                                # %vector.scevcheck
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 232(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB6_24
	j	.LBB6_10
.LBB6_10:                               # %vector.scevcheck
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 232(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB6_24
	j	.LBB6_11
.LBB6_11:                               # %vector.memcheck
	ld	a0, 248(sp)                     # 8-byte Folded Reload
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	slli	a2, a1, 2
	slli	a1, a1, 12
	sub	a1, a1, a2
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_13
# %bb.12:                               # %vector.memcheck
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 136(sp)                     # 8-byte Folded Spill
.LBB6_13:                               # %vector.memcheck
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	ld	a1, 248(sp)                     # 8-byte Folded Reload
	ld	a2, 136(sp)                     # 8-byte Folded Reload
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_15
# %bb.14:                               # %vector.memcheck
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
.LBB6_15:                               # %vector.memcheck
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	addi	a2, a2, 4
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_17
# %bb.16:                               # %vector.memcheck
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB6_17:                               # %vector.memcheck
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 256(sp)                     # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_19
# %bb.18:                               # %vector.memcheck
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB6_19:                               # %vector.memcheck
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	addi	a1, a1, 4
	li	a2, 0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bgeu	a0, a1, .LBB6_21
	j	.LBB6_20
.LBB6_20:                               # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 232(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_24
	j	.LBB6_21
.LBB6_21:                               # %vector.ph
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	csrr	a2, vlenb
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	srli	a0, a2, 1
                                        # implicit-def: $v8m4
	vsetvli	a3, zero, e64, m4, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 288
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	li	a0, 0
	subw	a2, a0, a2
	andi	a2, a2, 1024
	sd	a2, 40(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 288
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v8
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	a0, sp, a0
	addi	a0, a0, 288
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	j	.LBB6_22
.LBB6_22:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 248(sp)                     # 8-byte Folded Reload
	ld	a4, 256(sp)                     # 8-byte Folded Reload
	csrr	a5, vlenb
	slli	a5, a5, 3
	add	a5, sp, a5
	addi	a5, a5, 288
	vl4r.v	v8, (a5)                        # vscale x 32-byte Folded Reload
	addi	a5, sp, 288
	vl4r.v	v16, (a5)                       # vscale x 32-byte Folded Reload
	csrr	a5, vlenb
	slli	a5, a5, 2
	add	a5, sp, a5
	addi	a5, a5, 288
	vl4r.v	v24, (a5)                       # vscale x 32-byte Folded Reload
                                        # implicit-def: $v12m4
	vadd.vv	v12, v8, v16
                                        # implicit-def: $v20m4
	vmul.vv	v20, v8, v24
                                        # implicit-def: $v8m4
	vmul.vv	v8, v12, v24
                                        # implicit-def: $v24m4
	vsll.vi	v24, v20, 2
                                        # implicit-def: $v20m4
	vsll.vi	v20, v8, 2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v8, (a4), v24
                                        # implicit-def: $v28m2
	vluxei64.v	v28, (a4), v20
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v28, 1
	vsoxei64.v	v10, (a3), v24
	vsoxei64.v	v8, (a3), v20
	add	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vadd.vv	v8, v12, v16
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, sp, a2
	addi	a2, a2, 288
	vs4r.v	v8, (a2)                        # vscale x 32-byte Folded Spill
	bne	a0, a1, .LBB6_22
	j	.LBB6_23
.LBB6_23:                               # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 232(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB6_26
	j	.LBB6_24
.LBB6_24:                               # %scalar.ph
	ld	a0, 232(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB6_25
.LBB6_25:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 256(sp)                     # 8-byte Folded Reload
	ld	a2, 248(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	addiw	a1, a1, 1
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_25
	j	.LBB6_26
.LBB6_26:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 304
	ld	ra, 296(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 304
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
