# Source: LoopVectorize/tail-folding-fixed-order-recurrence.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: FOR_reduction
# src = pre-opt (FOR_reduction), tgt = post-opt (FOR_reduction)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 33
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	slli	a5, a0, 2
	add	a2, a2, a5
	lw	a2, 0(a2)
	addw	a3, a3, a2
	add	a4, a4, a5
	sw	a3, 0(a4)
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %for.end
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 4 * vlenb
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a0, a0, 1
	addiw	a2, a0, -1
	li	a3, 33
                                        # implicit-def: $v8
	vsetvli	a4, zero, e32, m1, tu, ma
	vmv.s.x	v8, a3
                                        # implicit-def: $v10m2
	vmv1r.v	v10, v8
	slli	a2, a2, 32
	srli	a2, a2, 32
	addi	a3, a2, 1
                                        # implicit-def: $v8m2
	vmv1r.v	v11, v12
	vsetvli	zero, a3, e32, m2, ta, ma
	vslideup.vx	v8, v10, a2
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a5, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a6, 88(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 96
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf2, ta, ma
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a4, a2, 2
	add	a6, a6, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a1, e32, m2, tu, ma
	vle32.v	v8, (a6)
	slli	a5, a5, 32
	srli	a5, a5, 32
	addi	a5, a5, -1
                                        # implicit-def: $v12m2
	vsetvli	zero, a1, e32, m2, ta, ma
	vslidedown.vx	v12, v10, a5
	vsetvli	zero, a1, e32, m2, ta, ma
	vslideup.vi	v12, v8, 1
	addi	a5, sp, 96
	vs2r.v	v12, (a5)                       # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vadd.vv	v10, v12, v8
	add	a3, a3, a4
	vsetvli	zero, a1, e32, m2, ta, ma
	vse32.v	v10, (a3)
	mv	a3, a1
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	add	a2, a1, a2
	sub	a0, a0, a1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 96
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	addi	a0, a0, -1
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v8, v10, a0
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_4
.LBB3_4:                                # %for.end
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 96
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
