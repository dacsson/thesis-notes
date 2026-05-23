# Source: LoopVectorize/tail-folding-fixed-order-recurrence.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: first_order_recurrence
# src = pre-opt (first_order_recurrence), tgt = post-opt (first_order_recurrence)
# Triple: riscv64, Attrs: +v,+f
#

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
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
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
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.end
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a3, vlenb
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 2 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a1, 40(sp)                      # 8-byte Folded Reload
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
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a6, 56(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 64
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf2, ta, ma
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
                                        # implicit-def: $v10m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vadd.vv	v10, v12, v8
	add	a3, a3, a4
	vsetvli	zero, a1, e32, m2, ta, ma
	vse32.v	v10, (a3)
	add	a2, a1, a2
	sub	a0, a0, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %for.end
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
