# Source: LoopVectorize/masked_gather_scatter.riscv32__v__zvl256b__d_loop-vectorize_RV32.ll
# Function: foo4
# src = pre-opt (foo4), tgt = post-opt (foo4)
# Triple: riscv32, Attrs: +v,+zvl256b,+d
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	sw	a2, 0(sp)                       # 4-byte Folded Spill
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a1, 0(a0)
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	li	a0, 99
	blt	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	lw	a2, 8(sp)                       # 4-byte Folded Reload
	lw	a3, 16(sp)                      # 4-byte Folded Reload
	slli	a4, a1, 4
	add	a3, a3, a4
	fld	fa5, 0(a3)
	fcvt.d.w	fa4, a2
	fadd.d	fa5, fa5, fa4
	slli	a1, a1, 3
	add	a0, a0, a1
	fsd	fa5, 0(a0)
	j	.LBB0_3
.LBB0_3:                                # %for.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 0(sp)                       # 4-byte Folded Reload
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	addi	a2, a1, 16
	sltu	a1, a2, a1
	add	a1, a0, a1
	srli	a0, a1, 4
	seqz	a0, a0
	slli	a4, a1, 28
	srli	a3, a2, 4
	or	a3, a3, a4
	sltiu	a3, a3, 625
	and	a0, a0, a3
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %for.end
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sw	ra, 124(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a3, vlenb
	slli	a4, a3, 2
	add	a3, a4, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x05, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 5 * vlenb
	sw	a2, 84(sp)                      # 4-byte Folded Spill
	sw	a1, 88(sp)                      # 4-byte Folded Spill
	sw	a0, 92(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.scevcheck
	lw	a1, 92(sp)                      # 4-byte Folded Reload
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	lui	a0, 20
	addi	a0, a0, -2048
	add	a0, a1, a0
	lui	a3, 39
	add	a2, a2, a3
	sw	a2, 72(sp)                      # 4-byte Folded Spill
	li	a2, 0
	mv	a3, a2
	sw	a3, 76(sp)                      # 4-byte Folded Spill
	sw	a2, 80(sp)                      # 4-byte Folded Spill
	bltu	a0, a1, .LBB0_14
	j	.LBB0_2
.LBB0_2:                                # %vector.scevcheck
	lw	a0, 80(sp)                      # 4-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_14
	j	.LBB0_3
.LBB0_3:                                # %vector.scevcheck
	lw	a0, 72(sp)                      # 4-byte Folded Reload
	lw	a1, 88(sp)                      # 4-byte Folded Reload
	bltu	a0, a1, .LBB0_14
	j	.LBB0_4
.LBB0_4:                                # %vector.scevcheck
	lw	a0, 76(sp)                      # 4-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_14
	j	.LBB0_5
.LBB0_5:                                # %vector.memcheck
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	lw	a1, 92(sp)                      # 4-byte Folded Reload
	lw	a0, 84(sp)                      # 4-byte Folded Reload
	lui	a3, 10
	addi	a3, a3, -1020
	add	a5, a0, a3
	lui	a3, 20
	addi	a3, a3, -2040
	add	a3, a1, a3
	lui	a4, 39
	addi	a4, a4, 8
	add	a4, a2, a4
	sltu	a0, a0, a3
	sltu	a5, a1, a5
	and	a0, a0, a5
	sltu	a1, a1, a4
	sltu	a2, a2, a3
	and	a1, a1, a2
	sw	a1, 68(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_14
	j	.LBB0_6
.LBB0_6:                                # %vector.memcheck
	lw	a0, 68(sp)                      # 4-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_14
	j	.LBB0_7
.LBB0_7:                                # %vector.ph
                                        # implicit-def: $v10m2
	vsetvli	a0, zero, e64, m2, ta, ma
	vid.v	v10
                                        # implicit-def: $v8m2
	vsll.vi	v8, v10, 4
	li	a0, 0
	li	a1, 625
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 112
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sw	a1, 60(sp)                      # 4-byte Folded Spill
	sw	a0, 64(sp)                      # 4-byte Folded Spill
	j	.LBB0_8
.LBB0_8:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 60(sp)                      # 4-byte Folded Reload
	lw	a1, 64(sp)                      # 4-byte Folded Reload
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 112
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	sw	a0, 40(sp)                      # 4-byte Folded Spill
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 112
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 3
	li	a2, 2
	li	a3, 0
	mv	a1, a3
	call	__muldi3
	lw	a2, 40(sp)                      # 4-byte Folded Reload
	mv	a3, a0
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	sw	a3, 48(sp)                      # 4-byte Folded Spill
	sltu	a4, a0, a1
	sw	a4, 52(sp)                      # 4-byte Folded Spill
	sltu	a2, a2, a3
	sw	a2, 56(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB0_10
# %bb.9:                                # %vector.body
                                        #   in Loop: Header=BB0_8 Depth=1
	lw	a0, 52(sp)                      # 4-byte Folded Reload
	sw	a0, 56(sp)                      # 4-byte Folded Spill
.LBB0_10:                               # %vector.body
                                        #   in Loop: Header=BB0_8 Depth=1
	lw	a1, 40(sp)                      # 4-byte Folded Reload
	lw	a0, 56(sp)                      # 4-byte Folded Reload
	sw	a1, 36(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_12
# %bb.11:                               # %vector.body
                                        #   in Loop: Header=BB0_8 Depth=1
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	sw	a0, 36(sp)                      # 4-byte Folded Spill
.LBB0_12:                               # %vector.body
                                        #   in Loop: Header=BB0_8 Depth=1
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	lw	a1, 40(sp)                      # 4-byte Folded Reload
	lw	a2, 92(sp)                      # 4-byte Folded Reload
	lw	a4, 88(sp)                      # 4-byte Folded Reload
	lw	a5, 84(sp)                      # 4-byte Folded Reload
	lw	a3, 36(sp)                      # 4-byte Folded Reload
	csrr	a6, vlenb
	add	a6, sp, a6
	addi	a6, a6, 112
	vl2r.v	v10, (a6)                       # vscale x 16-byte Folded Reload
	slli	a6, a3, 4
	srli	a7, a3, 28
	sw	a7, 100(sp)
	sw	a6, 96(sp)
	addi	a6, sp, 96
                                        # implicit-def: $v12m2
	vsetvli	a7, zero, e64, m2, tu, ma
	vlse64.v	v12, (a6), zero
                                        # implicit-def: $v15
	vsetvli	zero, zero, e32, m1, ta, ma
	vnsrl.wi	v15, v10, 0
                                        # implicit-def: $v9
	vsll.vi	v9, v15, 2
                                        # implicit-def: $v8
	vsetvli	zero, a3, e32, m1, tu, ma
	vluxei32.v	v8, (a5), v9
	li	a5, 100
	vsetvli	a6, zero, e32, m1, ta, ma
	vmslt.vx	v0, v8, a5
	addi	a5, sp, 112
	vs1r.v	v0, (a5)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vsll.vi	v9, v15, 4
                                        # implicit-def: $v16m2
	vsetvli	zero, a3, e64, m2, ta, mu
	vluxei32.v	v16, (a4), v9, v0.t
	addi	a4, sp, 112
	vl1r.v	v0, (a4)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v18m2
	vsetvli	a4, zero, e32, m1, ta, ma
	vfwcvt.f.x.v	v18, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vfadd.vv	v8, v16, v18
                                        # implicit-def: $v14
	vsetvli	zero, zero, e32, m1, ta, ma
	vsll.vi	v14, v15, 3
	vsetvli	zero, a3, e64, m2, ta, ma
	vsoxei32.v	v8, (a2), v14, v0.t
	sub	a2, a1, a3
	sltu	a1, a1, a3
	sub	a1, a0, a1
                                        # implicit-def: $v8m2
	vsetvli	a0, zero, e64, m2, ta, ma
	vadd.vv	v8, v10, v12
	or	a0, a2, a1
	csrr	a3, vlenb
	slli	a4, a3, 1
	add	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 112
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	sw	a2, 60(sp)                      # 4-byte Folded Spill
	sw	a1, 64(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_8
	j	.LBB0_13
.LBB0_13:                               # %middle.block
	j	.LBB0_18
.LBB0_14:                               # %scalar.ph
	li	a1, 0
	mv	a0, a1
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	sw	a0, 32(sp)                      # 4-byte Folded Spill
	j	.LBB0_15
.LBB0_15:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 84(sp)                      # 4-byte Folded Reload
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 32(sp)                      # 4-byte Folded Reload
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a1, 0(a0)
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	li	a0, 99
	blt	a0, a1, .LBB0_17
	j	.LBB0_16
.LBB0_16:                               # %if.then
                                        #   in Loop: Header=BB0_15 Depth=1
	lw	a0, 92(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a3, 88(sp)                      # 4-byte Folded Reload
	slli	a4, a1, 4
	add	a3, a3, a4
	fld	fa5, 0(a3)
	fcvt.d.w	fa4, a2
	fadd.d	fa5, fa5, fa4
	slli	a1, a1, 3
	add	a0, a0, a1
	fsd	fa5, 0(a0)
	j	.LBB0_17
.LBB0_17:                               # %for.inc
                                        #   in Loop: Header=BB0_15 Depth=1
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	addi	a2, a1, 16
	sltu	a1, a2, a1
	add	a1, a0, a1
	srli	a0, a1, 4
	seqz	a0, a0
	slli	a4, a1, 28
	srli	a3, a2, 4
	or	a3, a3, a4
	sltiu	a3, a3, 625
	and	a0, a0, a3
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_15
	j	.LBB0_18
.LBB0_18:                               # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	lw	ra, 124(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
