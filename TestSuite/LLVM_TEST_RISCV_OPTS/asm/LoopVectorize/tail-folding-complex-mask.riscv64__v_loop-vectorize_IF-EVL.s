# Source: LoopVectorize/tail-folding-complex-mask.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a7, 96(sp)                      # 8-byte Folded Spill
	sd	a6, 104(sp)                     # 8-byte Folded Spill
	sd	a5, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	bnez	a0, .LBB0_4
	j	.LBB0_2
.LBB0_2:                                # %check.cond1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_5
	j	.LBB0_3
.LBB0_3:                                # %check.cond1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	mv	a2, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_5
	j	.LBB0_6
.LBB0_4:                                # %load.v0
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %load.v1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	addw	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %load.v2.check
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	andi	a0, a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_8
	j	.LBB0_7
.LBB0_7:                                # %load.v2
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	addw	a0, a0, a1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_8
.LBB0_8:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_9
.LBB0_9:                                # %exit
	addi	sp, sp, 128
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	csrr	t0, vlenb
	slli	t1, t0, 2
	add	t0, t1, t0
	sub	sp, sp, t0
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x05, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 5 * vlenb
	sd	a4, 32(sp)                      # 8-byte Folded Spill
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a7, 72(sp)                      # 8-byte Folded Spill
	sd	a6, 80(sp)                      # 8-byte Folded Spill
	sd	a5, 88(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	andi	a3, a2, 1
                                        # implicit-def: $v8
	vsetvli	a5, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a3
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 96
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	xori	a3, a2, 1
	not	a4, a4
	or	a2, a2, a4
	andi	a2, a2, 1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a2
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 96
	vs1r.v	v8, (a4)                        # vscale x 8-byte Folded Spill
	and	a2, a2, a3
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a2
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	andi	a1, a1, 1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a1
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 96
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 72(sp)                      # 8-byte Folded Reload
	ld	a6, 40(sp)                      # 8-byte Folded Reload
	ld	a7, 48(sp)                      # 8-byte Folded Reload
	ld	t0, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 96
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	t0, t0, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v8, (t0), v0.t
	csrr	t0, vlenb
	slli	t0, t0, 1
	add	t0, sp, t0
	addi	t0, t0, 96
	vl1r.v	v0, (t0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v12m4
	vsetvli	t0, zero, e64, m4, ta, ma
	vid.v	v12
	vmsltu.vx	v10, v12, a2
	vmand.mm	v10, v10, v0
	addi	t0, sp, 96
	vs1r.v	v10, (t0)                       # vscale x 8-byte Folded Spill
	add	a7, a7, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v12, (a7), v0.t
	csrr	a7, vlenb
	slli	t0, a7, 1
	add	a7, t0, a7
	add	a7, sp, a7
	addi	a7, a7, 96
	vl1r.v	v0, (a7)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vadd.vv	v10, v12, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v8, v10, v12, v0
	csrr	a7, vlenb
	slli	a7, a7, 2
	add	a7, sp, a7
	addi	a7, a7, 96
	vl1r.v	v0, (a7)                        # vscale x 8-byte Folded Reload
	add	a6, a6, a4
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v14, (a6), v0.t
	andi	a5, a5, 1
                                        # implicit-def: $v10
	vsetvli	a6, zero, e8, mf2, tu, ma
	vmv.v.x	v10, a5
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v0, v10, 0
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v12, 0
                                        # implicit-def: $v10m2
	vmerge.vvm	v10, v12, v14, v0
	addi	a5, sp, 96
	vl1r.v	v0, (a5)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v12, v10, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v8, v10, v12, v0
	add	a3, a3, a4
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 96
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
