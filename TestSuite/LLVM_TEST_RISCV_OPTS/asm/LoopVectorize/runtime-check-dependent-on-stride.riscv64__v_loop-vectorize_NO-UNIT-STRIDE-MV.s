# Source: LoopVectorize/runtime-check-dependent-on-stride.riscv64__v_loop-vectorize_NO-UNIT-STRIDE-MV.ll
# Function: foo
# src = pre-opt (foo), tgt = post-opt (foo)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	addi	a1, a3, 2
	mv	a0, a1
	call	__muldi3
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 3
	add	a0, a0, a1
	addi	a0, a0, 128
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a5, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a5, a5, 3
	add	a1, a1, a5
	add	a2, a2, a5
	slli	a4, a4, 3
	add	a3, a3, a4
	ld	a1, 0(a1)
	ld	a3, 0(a3)
	add	a1, a1, a3
	sd	a1, 0(a2)
	li	a1, 64
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
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
# %bb.0:                                # %entry
	addi	sp, sp, -256
	.cfi_def_cfa_offset 256
	sd	ra, 248(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x02, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 256 + 4 * vlenb
	sd	a3, 192(sp)                     # 8-byte Folded Spill
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	sd	a0, 216(sp)                     # 8-byte Folded Spill
	addi	a1, a3, 2
	sd	a1, 208(sp)                     # 8-byte Folded Spill
	mv	a0, a1
	call	__muldi3
	ld	a1, 216(sp)                     # 8-byte Folded Reload
	slli	a0, a0, 3
	add	a0, a0, a1
	addi	a0, a0, 128
	sd	a0, 224(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.scevcheck
	ld	a2, 200(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	slli	a0, a0, 3
	sd	a0, 160(sp)                     # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	sub	a1, a1, a0
	add	a2, a2, a0
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	sd	a1, 184(sp)                     # 8-byte Folded Spill
	bltz	a0, .LBB0_3
# %bb.2:                                # %vector.scevcheck
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	sd	a0, 184(sp)                     # 8-byte Folded Spill
.LBB0_3:                                # %vector.scevcheck
	ld	a3, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	li	a2, 62
	mv	a1, a3
	call	__multi3
	mv	a2, a0
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	mv	a3, a1
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	snez	a3, a3
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	add	a3, a1, a2
	sub	a2, a1, a2
	sltu	a3, a3, a1
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sltu	a1, a1, a2
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	bltz	a0, .LBB0_5
# %bb.4:                                # %vector.scevcheck
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 152(sp)                     # 8-byte Folded Spill
.LBB0_5:                                # %vector.scevcheck
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	bnez	a0, .LBB0_16
	j	.LBB0_6
.LBB0_6:                                # %vector.scevcheck
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_16
	j	.LBB0_7
.LBB0_7:                                # %vector.memcheck
	ld	a1, 208(sp)                     # 8-byte Folded Reload
	mv	a0, a1
	call	__muldi3
	ld	a2, 192(sp)                     # 8-byte Folded Reload
	ld	a1, 200(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 216(sp)                     # 8-byte Folded Reload
	slli	a3, a3, 3
	add	a3, a3, a0
	addi	a4, a3, 136
	sd	a4, 80(sp)                      # 8-byte Folded Spill
	addi	a3, a3, 640
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	addi	a3, a0, 8
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	addi	a0, a0, 512
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	slli	a0, a2, 9
	slli	a2, a2, 3
	sub	a0, a0, a2
	add	a0, a1, a0
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	add	a1, a1, a2
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_9
# %bb.8:                                # %vector.memcheck
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB0_9:                                # %vector.memcheck
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_11
# %bb.10:                               # %vector.memcheck
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB0_11:                               # %vector.memcheck
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	addi	a4, a4, 8
	sltu	a0, a1, a0
	sltu	a5, a5, a3
	and	a0, a0, a5
	sltu	a1, a1, a4
	sltu	a2, a2, a3
	and	a1, a1, a2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_16
	j	.LBB0_12
.LBB0_12:                               # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_16
	j	.LBB0_13
.LBB0_13:                               # %vector.ph
	ld	a0, 192(sp)                     # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 240
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vid.v	v10
                                        # implicit-def: $v8m2
	vadd.vi	v8, v10, 1
	li	a0, 63
	li	a1, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 240
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_14
.LBB0_14:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 200(sp)                     # 8-byte Folded Reload
	ld	a3, 224(sp)                     # 8-byte Folded Reload
	ld	a5, 216(sp)                     # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 240
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	addi	a2, sp, 240
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a6, a1, 3
                                        # implicit-def: $v12m2
	vsetvli	a7, zero, e64, m2, ta, ma
	vmul.vv	v12, v10, v8
	addi	a6, a6, 8
	add	a5, a5, a6
	add	a3, a3, a6
                                        # implicit-def: $v8m2
	vsll.vi	v8, v12, 3
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vle64.v	v12, (a5)
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vluxei64.v	v14, (a4), v8
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vadd.vv	v8, v12, v14
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 240
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_14
	j	.LBB0_15
.LBB0_15:                               # %middle.block
	j	.LBB0_18
.LBB0_16:                               # %scalar.ph
	li	a0, 1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_17
.LBB0_17:                               # %header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	addi	a2, a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a5, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 216(sp)                     # 8-byte Folded Reload
	ld	a2, 224(sp)                     # 8-byte Folded Reload
	ld	a3, 200(sp)                     # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a5, a5, 3
	add	a1, a1, a5
	add	a2, a2, a5
	slli	a4, a4, 3
	add	a3, a3, a4
	ld	a1, 0(a1)
	ld	a3, 0(a3)
	add	a1, a1, a3
	sd	a1, 0(a2)
	li	a1, 64
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_17
	j	.LBB0_18
.LBB0_18:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 256
	ld	ra, 248(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 256
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
