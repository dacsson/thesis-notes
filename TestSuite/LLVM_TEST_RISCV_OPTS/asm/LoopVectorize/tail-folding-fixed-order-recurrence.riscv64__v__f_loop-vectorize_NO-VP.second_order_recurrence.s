# Source: LoopVectorize/tail-folding-fixed-order-recurrence.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: second_order_recurrence
# src = pre-opt (second_order_recurrence), tgt = post-opt (second_order_recurrence)
# Triple: riscv64, Attrs: +v,+f
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
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 22
	li	a1, 33
	li	a2, 0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a5, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a6, a0, 2
	add	a3, a3, a6
	lw	a3, 0(a3)
	addw	a4, a2, a4
	add	a5, a5, a6
	sw	a4, 0(a5)
	addi	a0, a0, 1
	mv	a4, a0
	sd	a4, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.end
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 8 * vlenb
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a1, 22
	li	a3, 33
	li	a4, 0
	sd	a4, 96(sp)                      # 8-byte Folded Spill
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	bltu	a2, a0, .LBB1_4
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 1
	addiw	a0, a0, -1
	li	a1, 33
                                        # implicit-def: $v10
	vsetvli	a2, zero, e32, m1, tu, ma
	vmv.s.x	v10, a1
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v10
	slli	a0, a0, 32
	srli	a0, a0, 32
	addi	a1, a0, 1
                                        # implicit-def: $v10m2
	vmv1r.v	v9, v12
	vsetvli	zero, a1, e32, m2, ta, ma
	vslideup.vx	v10, v8, a0
	li	a2, 22
                                        # implicit-def: $v8
	vsetvli	a3, zero, e32, m2, tu, ma
	vmv.s.x	v8, a2
                                        # implicit-def: $v12m2
	vmv1r.v	v12, v8
                                        # implicit-def: $v8m2
	vmv1r.v	v13, v14
	vsetvli	zero, a1, e32, m2, ta, ma
	vslideup.vx	v8, v12, a0
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	mv	a6, a4
	slli	a4, a4, 1
	add	a4, a4, a6
	add	a4, sp, a4
	addi	a4, a4, 128
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 2
	add	a4, sp, a4
	addi	a4, a4, 128
	vl2r.v	v14, (a4)                       # vscale x 16-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vle32.v	v10, (a5)
	addi	a5, sp, 128
	vs2r.v	v10, (a5)                       # vscale x 16-byte Folded Spill
	csrr	a5, vlenb
	srli	a5, a5, 1
	addi	a5, a5, -1
                                        # implicit-def: $v8m2
	vslidedown.vx	v8, v14, a5
	vslideup.vi	v8, v10, 1
	csrr	a6, vlenb
	slli	a6, a6, 1
	add	a6, sp, a6
	addi	a6, a6, 128
	vs2r.v	v8, (a6)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v14m2
	vslidedown.vx	v14, v12, a5
	vslideup.vi	v14, v8, 1
                                        # implicit-def: $v12m2
	vadd.vv	v12, v8, v14
	add	a3, a3, a4
	vse32.v	v12, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 128
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	addi	a2, sp, 128
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	srli	a2, a2, 1
	addiw	a2, a2, -1
	slli	a2, a2, 32
	srli	a2, a2, 32
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v8, v12, a2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a3, v8
                                        # implicit-def: $v8m2
	vslidedown.vx	v8, v10, a2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a2, v8
	mv	a4, a1
	sd	a4, 96(sp)                      # 8-byte Folded Spill
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB1_6
	j	.LBB1_4
.LBB1_4:                                # %scalar.ph
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	slli	a6, a0, 2
	add	a3, a3, a6
	lw	a3, 0(a3)
	addw	a4, a2, a4
	add	a5, a5, a6
	sw	a4, 0(a5)
	addi	a0, a0, 1
	mv	a4, a0
	sd	a4, 16(sp)                      # 8-byte Folded Spill
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_5
	j	.LBB1_6
.LBB1_6:                                # %for.end
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 144
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
