# Source: LoopVectorize/masked_gather_scatter.riscv64__v__zvl256b__d_loop-vectorize_RV64.ll
# Function: foo4
# src = pre-opt (foo4), tgt = post-opt (foo4)
# Triple: riscv64, Attrs: +v,+zvl256b,+d
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a1, 0(a0)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	li	a0, 99
	blt	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
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
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a2, a0, 16
	srli	a0, a2, 4
	li	a1, 625
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %for.end
	addi	sp, sp, 48
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a3, vlenb
	slli	a4, a3, 1
	add	a3, a4, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 3 * vlenb
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.memcheck
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	lui	a0, 20
	addi	a0, a0, -2040
	add	a3, a1, a0
	lui	a0, 10
	addi	a0, a0, -1020
	add	a0, a5, a0
	lui	a4, 39
	addi	a4, a4, 8
	add	a4, a2, a4
	sltu	a0, a1, a0
	sltu	a5, a5, a3
	and	a0, a0, a5
	sltu	a1, a1, a4
	sltu	a2, a2, a3
	and	a1, a1, a2
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_6
	j	.LBB0_2
.LBB0_2:                                # %vector.memcheck
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
                                        # implicit-def: $v10m2
	vsetvli	a0, zero, e64, m2, ta, ma
	vid.v	v10
                                        # implicit-def: $v8m2
	vsll.vi	v8, v10, 4
	li	a0, 625
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 80
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a1, a2, 4
                                        # implicit-def: $v12m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vsll.vi	v12, v10, 2
                                        # implicit-def: $v8
	vsetvli	zero, a2, e32, m1, tu, ma
	vluxei64.v	v8, (a5), v12
	li	a5, 100
	vsetvli	a6, zero, e32, m1, ta, ma
	vmslt.vx	v0, v8, a5
	addi	a5, sp, 80
	vs1r.v	v0, (a5)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vsll.vi	v14, v10, 4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e64, m2, ta, mu
	vluxei64.v	v12, (a4), v14, v0.t
	addi	a4, sp, 80
	vl1r.v	v0, (a4)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v14m2
	vsetvli	a4, zero, e32, m1, ta, ma
	vfwcvt.f.x.v	v14, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vfadd.vv	v8, v12, v14
                                        # implicit-def: $v12m2
	vsll.vi	v12, v10, 3
	vsetvli	zero, a2, e64, m2, ta, ma
	vsoxei64.v	v8, (a3), v12, v0.t
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a1
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 80
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	j	.LBB0_10
.LBB0_6:                                # %scalar.ph
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a1, 0(a0)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 99
	blt	a0, a1, .LBB0_9
	j	.LBB0_8
.LBB0_8:                                # %if.then
                                        #   in Loop: Header=BB0_7 Depth=1
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	slli	a4, a1, 4
	add	a3, a3, a4
	fld	fa5, 0(a3)
	fcvt.d.w	fa4, a2
	fadd.d	fa5, fa5, fa4
	slli	a1, a1, 3
	add	a0, a0, a1
	fsd	fa5, 0(a0)
	j	.LBB0_9
.LBB0_9:                                # %for.inc
                                        #   in Loop: Header=BB0_7 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a2, a0, 16
	srli	a0, a2, 4
	li	a1, 625
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_7
	j	.LBB0_10
.LBB0_10:                               # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
