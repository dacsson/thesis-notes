# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_2.ll
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
	addi	sp, sp, -256
	.cfi_def_cfa_offset 256
	sd	ra, 248(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x02, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 256 + 8 * vlenb
	sd	a2, 208(sp)                     # 8-byte Folded Spill
	sd	a1, 216(sp)                     # 8-byte Folded Spill
	sd	a0, 224(sp)                     # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %vector.scevcheck
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	slli	a0, a0, 2
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	sub	a1, a1, a0
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	bltz	a0, .LBB6_3
# %bb.2:                                # %vector.scevcheck
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	sd	a0, 200(sp)                     # 8-byte Folded Spill
.LBB6_3:                                # %vector.scevcheck
	ld	a3, 192(sp)                     # 8-byte Folded Reload
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	li	a2, 1023
	mv	a1, a3
	call	__multi3
	ld	a2, 216(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	mv	a4, a1
	ld	a1, 224(sp)                     # 8-byte Folded Reload
	snez	a4, a4
	sd	a4, 144(sp)                     # 8-byte Folded Spill
	add	a5, a2, a3
	sub	a4, a2, a3
	sltu	a5, a5, a2
	sd	a5, 152(sp)                     # 8-byte Folded Spill
	sltu	a2, a2, a4
	add	a4, a1, a3
	sub	a3, a1, a3
	sltu	a4, a4, a1
	sd	a4, 160(sp)                     # 8-byte Folded Spill
	sltu	a1, a1, a3
	sd	a2, 168(sp)                     # 8-byte Folded Spill
	sd	a1, 176(sp)                     # 8-byte Folded Spill
	bltz	a0, .LBB6_5
# %bb.4:                                # %vector.scevcheck
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	sd	a0, 176(sp)                     # 8-byte Folded Spill
.LBB6_5:                                # %vector.scevcheck
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	ld	a2, 176(sp)                     # 8-byte Folded Reload
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB6_22
	j	.LBB6_6
.LBB6_6:                                # %vector.scevcheck
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB6_22
	j	.LBB6_7
.LBB6_7:                                # %vector.scevcheck
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB6_22
	j	.LBB6_8
.LBB6_8:                                # %vector.scevcheck
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB6_22
	j	.LBB6_9
.LBB6_9:                                # %vector.memcheck
	ld	a0, 216(sp)                     # 8-byte Folded Reload
	ld	a1, 208(sp)                     # 8-byte Folded Reload
	slli	a2, a1, 2
	slli	a1, a1, 12
	sub	a1, a1, a2
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_11
# %bb.10:                               # %vector.memcheck
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
.LBB6_11:                               # %vector.memcheck
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 216(sp)                     # 8-byte Folded Reload
	ld	a2, 120(sp)                     # 8-byte Folded Reload
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_13
# %bb.12:                               # %vector.memcheck
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB6_13:                               # %vector.memcheck
	ld	a0, 224(sp)                     # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	addi	a2, a2, 4
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_15
# %bb.14:                               # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 80(sp)                      # 8-byte Folded Spill
.LBB6_15:                               # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 224(sp)                     # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_17
# %bb.16:                               # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB6_17:                               # %vector.memcheck
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	addi	a1, a1, 4
	bgeu	a0, a1, .LBB6_19
	j	.LBB6_18
.LBB6_18:                               # %vector.memcheck
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB6_22
	j	.LBB6_19
.LBB6_19:                               # %vector.ph
	ld	a0, 208(sp)                     # 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 240
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	li	a0, 1024
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v8
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 240
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB6_20
.LBB6_20:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 216(sp)                     # 8-byte Folded Reload
	ld	a3, 224(sp)                     # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 240
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	addi	a1, sp, 240
	vl4r.v	v16, (a1)                       # vscale x 32-byte Folded Reload
	vsetvli	a1, a0, e8, mf2, ta, ma
                                        # implicit-def: $v8m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vmul.vv	v8, v12, v16
                                        # implicit-def: $v16m4
	vsll.vi	v16, v8, 2
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e32, m2, tu, ma
	vluxei64.v	v10, (a3), v16
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v8, (a2), v16
	sub	a0, a0, a1
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a1
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 240
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB6_20
	j	.LBB6_21
.LBB6_21:                               # %middle.block
	j	.LBB6_24
.LBB6_22:                               # %scalar.ph
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB6_23
.LBB6_23:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 208(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 224(sp)                     # 8-byte Folded Reload
	ld	a2, 216(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
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
	bne	a0, a1, .LBB6_23
	j	.LBB6_24
.LBB6_24:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 256
	ld	ra, 248(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 256
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
