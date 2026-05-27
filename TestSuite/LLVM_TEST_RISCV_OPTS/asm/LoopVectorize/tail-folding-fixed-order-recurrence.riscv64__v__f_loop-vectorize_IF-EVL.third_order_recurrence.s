# Source: LoopVectorize/tail-folding-fixed-order-recurrence.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: third_order_recurrence
# src = pre-opt (third_order_recurrence), tgt = post-opt (third_order_recurrence)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 11
	li	a1, 22
	li	a2, 33
	li	a3, 0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a6, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	slli	a7, a0, 2
	add	a4, a4, a7
	lw	a4, 0(a4)
	addw	a5, a2, a5
	addw	a5, a5, a3
	add	a6, a6, a7
	sw	a5, 0(a6)
	addi	a0, a0, 1
	mv	a5, a0
	sd	a5, 32(sp)                      # 8-byte Folded Spill
	sd	a4, 40(sp)                      # 8-byte Folded Spill
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %for.end
	addi	sp, sp, 64
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a3, vlenb
	slli	a3, a3, 1
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 6 * vlenb
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a0, a0, 1
	addiw	a2, a0, -1
	li	a3, 33
                                        # implicit-def: $v10
	vsetvli	a4, zero, e32, m1, tu, ma
	vmv.s.x	v10, a3
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v10
	slli	a2, a2, 32
	srli	a2, a2, 32
	addi	a3, a2, 1
                                        # implicit-def: $v12m2
	vmv1r.v	v9, v10
	vsetvli	zero, a3, e32, m2, ta, ma
	vslideup.vx	v12, v8, a2
	li	a4, 22
                                        # implicit-def: $v10
	vsetvli	a5, zero, e32, m2, tu, ma
	vmv.s.x	v10, a4
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v10
                                        # implicit-def: $v10m2
	vmv1r.v	v9, v14
	vsetvli	zero, a3, e32, m2, ta, ma
	vslideup.vx	v10, v8, a2
                                        # implicit-def: $v8
	vsetvli	a4, zero, e32, m1, tu, ma
	vmv.v.i	v8, 11
                                        # implicit-def: $v14m2
	vmv1r.v	v14, v8
                                        # implicit-def: $v8m2
	vmv1r.v	v15, v16
	vsetvli	zero, a3, e32, m2, ta, ma
	vslideup.vx	v8, v14, a2
	li	a2, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 80
	vs2r.v	v12, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 80
	vl2r.v	v16, (a1)                       # vscale x 16-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 80
	vl2r.v	v14, (a1)                       # vscale x 16-byte Folded Reload
	addi	a1, sp, 80
	vl2r.v	v8, (a1)                        # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf2, ta, ma
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a4, a2, 2
	add	a6, a6, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a1, e32, m2, tu, ma
	vle32.v	v12, (a6)
	slli	a5, a5, 32
	srli	a5, a5, 32
	addi	a5, a5, -1
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e32, m2, ta, ma
	vslidedown.vx	v10, v8, a5
	vsetvli	zero, a1, e32, m2, ta, ma
	vslideup.vi	v10, v12, 1
                                        # implicit-def: $v8m2
	vsetvli	zero, a1, e32, m2, ta, ma
	vslidedown.vx	v8, v14, a5
	vsetvli	zero, a1, e32, m2, ta, ma
	vslideup.vi	v8, v10, 1
                                        # implicit-def: $v14m2
	vsetvli	zero, a1, e32, m2, ta, ma
	vslidedown.vx	v14, v16, a5
	vsetvli	zero, a1, e32, m2, ta, ma
	vslideup.vi	v14, v8, 1
                                        # implicit-def: $v16m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vadd.vv	v16, v8, v14
                                        # implicit-def: $v14m2
	vadd.vv	v14, v16, v10
	add	a3, a3, a4
	vsetvli	zero, a1, e32, m2, ta, ma
	vse32.v	v14, (a3)
	add	a2, a1, a2
	sub	a0, a0, a1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 80
	vs2r.v	v12, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 80
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %for.end
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
