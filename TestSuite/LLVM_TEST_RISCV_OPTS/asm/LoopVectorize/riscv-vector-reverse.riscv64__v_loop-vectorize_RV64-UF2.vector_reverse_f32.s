# Source: LoopVectorize/riscv-vector-reverse.riscv64__v_loop-vectorize_RV64-UF2.ll
# Function: vector_reverse_f32
# src = pre-opt (vector_reverse_f32), tgt = post-opt (vector_reverse_f32)
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
	.cfi_remember_state
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a0, a2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a2, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %for.body.preheader
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_3
.LBB2_2:                                # %for.cond.cleanup
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.LBB2_3:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	addiw	a2, a2, -1
	slli	a3, a2, 32
	srli	a3, a3, 30
	add	a4, a4, a3
	flw	fa5, 0(a4)
	lui	a4, 260096
	fmv.w.x	fa4, a4
	fadd.s	fa5, fa5, fa4
	add	a0, a0, a3
	fsw	fa5, 0(a0)
	addi	a3, a1, -1
	li	a0, 1
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_3
	j	.LBB2_2
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -192
	.cfi_def_cfa_offset 192
	sd	ra, 184(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x01, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 192 + 1 * vlenb
	.cfi_remember_state
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	li	a0, 0
	bge	a0, a2, .LBB2_10
	j	.LBB2_1
.LBB2_1:                                # %for.body.preheader
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	slli	a0, a2, 32
	srli	a0, a0, 32
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a3, a1, 3
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	mv	a3, a0
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_8
	j	.LBB2_2
.LBB2_2:                                # %vector.scevcheck
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	addi	a1, a3, -1
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	addiw	a0, a2, -1
	subw	a1, a0, a1
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_8
	j	.LBB2_3
.LBB2_3:                                # %vector.scevcheck
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	srli	a0, a0, 32
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB2_8
	j	.LBB2_4
.LBB2_4:                                # %vector.memcheck
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a4, 152(sp)                     # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	sub	a0, a0, a4
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_8
	j	.LBB2_5
.LBB2_5:                                # %vector.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	slli	a2, a1, 2
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 3
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sub	a1, a1, a2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	subw	a0, a0, a1
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	j	.LBB2_6
.LBB2_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 136(sp)                     # 8-byte Folded Reload
	ld	a5, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 128(sp)                     # 8-byte Folded Reload
	ld	a7, 144(sp)                     # 8-byte Folded Reload
	not	a6, a0
	addw	a6, a6, a7
	slli	a6, a6, 32
	srli	a6, a6, 30
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
	addi	a7, sp, 176
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
	lui	a7, 260096
	fmv.w.x	fa5, a7
                                        # implicit-def: $v12m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vfadd.vf	v12, v10, fa5
	vmv1r.v	v10, v13
	vmv1r.v	v11, v12
                                        # implicit-def: $v12m2
	vfadd.vf	v12, v14, fa5
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
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_6
	j	.LBB2_7
.LBB2_7:                                # %middle.block
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB2_9
	j	.LBB2_8
.LBB2_8:                                # %scalar.ph
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_11
.LBB2_9:                                # %for.cond.cleanup.loopexit
	j	.LBB2_10
.LBB2_10:                               # %for.cond.cleanup
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 192
	ld	ra, 184(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.LBB2_11:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	ld	a4, 128(sp)                     # 8-byte Folded Reload
	addiw	a2, a2, -1
	slli	a3, a2, 32
	srli	a3, a3, 30
	add	a4, a4, a3
	flw	fa5, 0(a4)
	lui	a4, 260096
	fmv.w.x	fa4, a4
	fadd.s	fa5, fa5, fa4
	add	a0, a0, a3
	fsw	fa5, 0(a0)
	addi	a3, a1, -1
	li	a0, 1
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_11
	j	.LBB2_9
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
