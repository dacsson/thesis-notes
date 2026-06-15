# Source: LoopVectorize/tail-folding-cond-reduction.riscv64__v_loop-vectorize_NO-VP-INLOOP.ll
# Function: step_cond_add
# src = pre-opt (step_cond_add), tgt = post-opt (step_cond_add)
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
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a4, 0(a2)
	sext.w	a2, a0
	slt	a5, a2, a4
	li	a2, 0
	subw	a2, a2, a5
	and	a2, a2, a4
	addw	a2, a2, a3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
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
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 4 * vlenb
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB2_4
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sub	a2, a2, a3
	sd	a2, 64(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e32, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.x	v10, a1
	addi	a1, sp, 144
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	li	a1, 0
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 144
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 96(sp)                      # 8-byte Folded Reload
	csrr	a5, vlenb
	slli	a5, a5, 1
	add	a5, sp, a5
	addi	a5, a5, 144
	vl2r.v	v10, (a5)                       # vscale x 16-byte Folded Reload
	addi	a5, sp, 144
	vl2r.v	v12, (a5)                       # vscale x 16-byte Folded Reload
	slli	a5, a0, 2
	add	a4, a4, a5
                                        # implicit-def: $v16m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vle32.v	v16, (a4)
	vmslt.vv	v0, v10, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v14m2
	vmerge.vvm	v14, v8, v16, v0
                                        # implicit-def: $v9
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v14, v9
	vmv.x.s	a2, v8
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	add	a0, a0, a3
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	mv	a3, a0
	sd	a3, 72(sp)                      # 8-byte Folded Spill
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 144
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	mv	a3, a1
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 128(sp)                     # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB2_6
	j	.LBB2_4
.LBB2_4:                                # %scalar.ph
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_5
.LBB2_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a4, 0(a2)
	sext.w	a2, a0
	slt	a5, a2, a4
	li	a2, 0
	subw	a2, a2, a5
	and	a2, a2, a4
	addw	a2, a2, a3
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_5
	j	.LBB2_6
.LBB2_6:                                # %for.end
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
