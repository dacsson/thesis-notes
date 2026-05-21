# Source: LoopVectorize/riscv-vector-reverse.riscv64__v_loop-vectorize_RV64-UF2.ll
# Function: vector_reverse_i32
# src = pre-opt (vector_reverse_i32), tgt = post-opt (vector_reverse_i32)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 1023
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a2, a1, -1
	slli	a4, a2, 2
	add	a0, a0, a4
	lw	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a4
	sw	a0, 0(a3)
	li	a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_1
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 1 * vlenb
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a0, a1, 3
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	li	a0, 1023
	mv	a2, a0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a0, 3
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1023
	call	__umoddi3
	mv	a1, a0
	xori	a0, a1, 1023
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	li	a6, 1023
	sub	a6, a6, a0
	slli	a6, a6, 2
	addi	a6, a6, -4
	add	a7, a4, a6
	slli	a4, a5, 2
	addi	a4, a4, -4
	sub	t0, a7, a4
	add	t1, a5, a5
	li	a5, 1
	sub	a5, a5, t1
	slli	a5, a5, 2
	add	a7, a7, a5
                                        # implicit-def: $v8m2
	vsetvli	t1, zero, e32, m2, ta, ma
	vle32.v	v8, (t0)
	vmv1r.v	v10, v9
	vmv1r.v	v11, v8
                                        # implicit-def: $v8m2
	vle32.v	v8, (a7)
	vmv1r.v	v13, v9
	vmv1r.v	v12, v8
	csrr	a7, vlenb
	srli	a7, a7, 2
	addiw	a7, a7, -1
                                        # implicit-def: $v8
	vsetvli	t0, zero, e32, m1, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vrsub.vx	v9, v8, a7
	addi	a7, sp, 112
	vs1r.v	v9, (a7)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vrgather.vv	v8, v11, v9
                                        # implicit-def: $v14
	vrgather.vv	v14, v10, v9
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v14
	vmv.v.v	v11, v8
                                        # implicit-def: $v8
	vrgather.vv	v8, v12, v9
                                        # implicit-def: $v12
	vrgather.vv	v12, v13, v9
                                        # implicit-def: $v14m2
	vmv.v.v	v14, v12
	vmv.v.v	v15, v8
                                        # implicit-def: $v12m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vadd.vi	v12, v10, 1
	vmv1r.v	v10, v13
	vmv1r.v	v11, v12
                                        # implicit-def: $v12m2
	vadd.vi	v12, v14, 1
	vmv1r.v	v8, v13
	vmv1r.v	v13, v12
	add	a3, a3, a6
	sub	a4, a3, a4
	add	a3, a3, a5
                                        # implicit-def: $v12
	vsetvli	a5, zero, e32, m1, ta, ma
	vrgather.vv	v12, v11, v9
                                        # implicit-def: $v14
	vrgather.vv	v14, v10, v9
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v14
	vmv.v.v	v11, v12
                                        # implicit-def: $v12
	vrgather.vv	v12, v13, v9
                                        # implicit-def: $v13
	vrgather.vv	v13, v8, v9
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v13
	vmv.v.v	v9, v12
	vsetvli	a5, zero, e32, m2, ta, ma
	vse32.v	v10, (a4)
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	li	a1, 1023
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_6
	j	.LBB0_4
.LBB0_4:                                # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addi	a2, a1, -1
	slli	a4, a2, 2
	add	a0, a0, a4
	lw	a0, 0(a0)
	addiw	a0, a0, 1
	add	a3, a3, a4
	sw	a0, 0(a3)
	li	a0, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_5
	j	.LBB0_6
.LBB0_6:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
