# Source: LoopVectorize/tail-folding-interleave.riscv64__v_loop-vectorize_NO-VP.ll
# Function: load_factor_4_reverse
# src = pre-opt (load_factor_4_reverse), tgt = post-opt (load_factor_4_reverse)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
	lw	a3, 0(a2)
	addw	a1, a1, a3
	lw	a3, 4(a2)
	addw	a1, a1, a3
	lw	a3, 8(a2)
	addw	a1, a1, a3
	lw	a2, 12(a2)
	addw	a2, a1, a2
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a1, a0, -1
	li	a0, 0
	mv	a3, a1
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	csrr	a2, vlenb
	slli	a2, a2, 2
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x0c, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 12 * vlenb
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	addi	a2, a0, -1
	srai	a1, a2, 63
	and	a1, a1, a2
	sub	a0, a0, a1
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_2
# %bb.1:                                # %entry
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
.LBB5_2:                                # %entry
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	li	a2, 0
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_6
	j	.LBB5_3
.LBB5_3:                                # %vector.ph
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sub	a1, a0, a1
	and	a3, a3, a1
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sub	a3, a2, a3
	sd	a3, 56(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	a3, zero, e64, m4, tu, ma
	vmv.v.x	v8, a2
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v12
	li	a2, -1
	vmadd.vx	v12, a2, v8
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 128
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 128
	vs4r.v	v12, (a0)                       # vscale x 32-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 2
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB5_4
.LBB5_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	mv	a5, a4
	slli	a4, a4, 2
	add	a4, a4, a5
	add	a4, sp, a4
	addi	a4, a4, 128
	vl2r.v	v8, (a4)                        # vscale x 16-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	mv	a5, a4
	slli	a4, a4, 1
	add	a4, a4, a5
	add	a4, sp, a4
	addi	a4, a4, 128
	vl4r.v	v16, (a4)                       # vscale x 32-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 128
	vl4r.v	v20, (a4)                       # vscale x 32-byte Folded Reload
                                        # implicit-def: $v28m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vsll.vi	v28, v16, 4
                                        # implicit-def: $v24m4
	vadd.vx	v24, v28, a3
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v12, (a3), v28
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v10, v8, v12
	li	a3, 4
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v12, (a3), v24
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v12
	li	a3, 8
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v12, (a3), v24
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v10, v8, v12
	li	a3, 12
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v12, (a3), v24
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v12
	addi	a3, sp, 128
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a0, a0, a2
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vadd.vv	v12, v16, v20
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 128
	vs4r.v	v12, (a2)                       # vscale x 32-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 2
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB5_4
	j	.LBB5_5
.LBB5_5:                                # %middle.block
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 128
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	li	a2, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a2, v8
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 80(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB5_8
	j	.LBB5_6
.LBB5_6:                                # %scalar.ph
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_7
.LBB5_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
	lw	a3, 0(a2)
	addw	a1, a1, a3
	lw	a3, 4(a2)
	addw	a1, a1, a3
	lw	a3, 8(a2)
	addw	a1, a1, a3
	lw	a2, 12(a2)
	addw	a2, a1, a2
	addi	a1, a0, -1
	li	a0, 0
	mv	a3, a1
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB5_7
	j	.LBB5_8
.LBB5_8:                                # %exit
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	sp, sp, a1
	.cfi_def_cfa sp, 128
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
