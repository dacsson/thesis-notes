# Source: LoopVectorize/tail-folding-cond-reduction.riscv64__v_loop-vectorize_NO-VP-OUTLOOP.ll
# Function: step_cond_add_pred
# src = pre-opt (step_cond_add_pred), tgt = post-opt (step_cond_add_pred)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	slli	a3, a0, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sext.w	a0, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB3_3
	j	.LBB3_2
.LBB3_2:                                # %if.then
                                        #   in Loop: Header=BB3_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_3
.LBB3_3:                                # %for.inc
                                        #   in Loop: Header=BB3_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_4
.LBB3_4:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sd	ra, 168(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x01, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 176 + 8 * vlenb
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 128(sp)                     # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	sd	a2, 144(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB3_4
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sub	a2, a2, a3
	sd	a2, 88(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e32, m2, tu, ma
	vmv.v.i	v10, 0
	vmv1r.v	v8, v10
	vmv.s.x	v8, a1
	vmv1r.v	v10, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.x	v12, a0
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 160
	vs2r.v	v12, (a0)                       # vscale x 16-byte Folded Spill
	li	a0, 0
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 160
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 160
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	mv	a5, a4
	slli	a4, a4, 1
	add	a4, a4, a5
	add	a4, sp, a4
	addi	a4, a4, 160
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 2
	add	a4, sp, a4
	addi	a4, a4, 160
	vl2r.v	v8, (a4)                        # vscale x 16-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 160
	vl2r.v	v14, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vle32.v	v10, (a3)
	vmslt.vv	v0, v12, v10
                                        # implicit-def: $v16m2
	vadd.vv	v16, v8, v10
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v10, v8, v16, v0
	addi	a3, sp, 160
	vs2r.v	v10, (a3)                       # vscale x 16-byte Folded Spill
	add	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v12, v14
	mv	a2, a0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 160
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 160
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 160
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	li	a2, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a2, v8
	mv	a3, a1
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB3_8
	j	.LBB3_4
.LBB3_4:                                # %scalar.ph
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB3_5
.LBB3_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	slli	a3, a0, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sext.w	a0, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB3_7
	j	.LBB3_6
.LBB3_6:                                # %if.then
                                        #   in Loop: Header=BB3_5 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB3_7
.LBB3_7:                                # %for.inc
                                        #   in Loop: Header=BB3_5 Depth=1
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_5
	j	.LBB3_8
.LBB3_8:                                # %for.end
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 3
	add	sp, sp, a1
	.cfi_def_cfa sp, 176
	ld	ra, 168(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
