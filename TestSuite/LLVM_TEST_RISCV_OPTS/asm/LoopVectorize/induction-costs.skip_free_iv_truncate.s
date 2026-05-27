# Source: LoopVectorize/induction-costs.ll
# Function: skip_free_iv_truncate
# src = pre-opt (skip_free_iv_truncate), tgt = post-opt (skip_free_iv_truncate)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a0, a0, 48
	srai	a1, a0, 48
	mv	a0, a1
	addi	a2, a2, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 1
	add	a2, a1, a2
	li	a1, 0
	sh	a1, 0(a2)
	addi	a2, a0, 3
	mv	a3, a2
	li	a1, 99
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 32
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
	addi	sp, sp, -224
	.cfi_def_cfa_offset 224
	sd	ra, 216(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x01, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 224 + 8 * vlenb
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	slli	a1, a1, 48
	srai	a1, a1, 48
	sd	a1, 168(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	addi	a0, a0, -8
	li	a0, 99
	sd	a0, 184(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 192(sp)                     # 8-byte Folded Spill
	blt	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	sd	a0, 192(sp)                     # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	sub	a0, a0, a1
	li	a1, 1
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_4
# %bb.3:                                # %entry
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 152(sp)                     # 8-byte Folded Spill
.LBB0_4:                                # %entry
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	sub	a0, a0, a2
	sub	a0, a0, a1
	li	a1, 3
	call	__udivdi3
	mv	a1, a0
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	add	a0, a0, a1
	addi	a0, a0, 1
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %vector.memcheck
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	slli	a2, a1, 1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	li	a0, 99
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	blt	a0, a1, .LBB0_7
# %bb.6:                                # %vector.memcheck
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
.LBB0_7:                                # %vector.memcheck
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a1
	li	a1, 1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_9
# %bb.8:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 80(sp)                      # 8-byte Folded Spill
.LBB0_9:                                # %vector.memcheck
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a2
	sub	a0, a0, a1
	li	a1, 3
	call	__udivdi3
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a5, 88(sp)                      # 8-byte Folded Reload
	ld	a4, 168(sp)                     # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	add	a2, a2, a3
	slli	a6, a2, 1
	slli	a3, a2, 2
	add	a3, a3, a6
	add	a3, a3, a5
	add	a3, a3, a0
	addi	a3, a3, 2
	slli	a4, a4, 3
	add	a5, a0, a4
	slli	a6, a2, 3
	slli	a2, a2, 4
	add	a2, a2, a6
	add	a2, a2, a4
	add	a4, a0, a2
	addi	a0, a4, 8
	addi	a2, a5, -8
	sltu	a0, a1, a0
	sltu	a5, a5, a3
	and	a0, a0, a5
	sltu	a1, a1, a4
	sltu	a2, a2, a3
	and	a1, a1, a2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_14
	j	.LBB0_10
.LBB0_10:                               # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_14
	j	.LBB0_11
.LBB0_11:                               # %vector.ph
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	ld	a1, 168(sp)                     # 8-byte Folded Reload
                                        # implicit-def: $v16m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v16, a1
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vid.v	v8
	li	a1, 3
	vmadd.vx	v8, a1, v16
	addi	a1, sp, 208
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_12
.LBB0_12:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	addi	a1, sp, 208
	vl8r.v	v16, (a1)                       # vscale x 64-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a1, a2, 1
	add	a1, a1, a2
                                        # implicit-def: $v24m8
	vsetvli	a4, zero, e64, m8, ta, ma
	vadd.vv	v24, v16, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e16, m2, ta, ma
	vsoxei64.v	v8, (a3), v24
	sub	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e64, m8, ta, ma
	vadd.vx	v8, v16, a1
	addi	a1, sp, 208
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_12
	j	.LBB0_13
.LBB0_13:                               # %middle.block
	j	.LBB0_16
.LBB0_14:                               # %scalar.ph
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_15
.LBB0_15:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	slli	a2, a0, 1
	add	a2, a1, a2
	li	a1, 0
	sh	a1, 0(a2)
	addi	a2, a0, 3
	mv	a3, a2
	li	a1, 99
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_15
	j	.LBB0_16
.LBB0_16:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 224
	ld	ra, 216(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 224
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
