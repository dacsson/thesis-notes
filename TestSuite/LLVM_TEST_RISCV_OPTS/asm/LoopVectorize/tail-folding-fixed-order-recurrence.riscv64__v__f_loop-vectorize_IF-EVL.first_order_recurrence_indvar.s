# Source: LoopVectorize/tail-folding-fixed-order-recurrence.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: first_order_recurrence_indvar
# src = pre-opt (first_order_recurrence_indvar), tgt = post-opt (first_order_recurrence_indvar)
# Triple: riscv64, Attrs: +v,+f
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
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 33
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	addi	a2, a0, 42
	slli	a5, a0, 3
	add	a4, a4, a5
	sd	a3, 0(a4)
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a0, a0, 2
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vid.v	v10
	addiw	a2, a0, -1
	li	a3, 33
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.s.x	v8, a3
                                        # implicit-def: $v12m2
	vmv1r.v	v12, v8
	slli	a2, a2, 32
	srli	a2, a2, 32
	addi	a3, a2, 1
                                        # implicit-def: $v8m2
	vmv1r.v	v13, v14
	vsetvli	zero, a3, e64, m2, ta, ma
	vslideup.vx	v8, v12, a2
	li	a2, 0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 64
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vl2r.v	v14, (a1)                       # vscale x 16-byte Folded Reload
	addi	a1, sp, 64
	vl2r.v	v12, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf4, ta, ma
	li	a5, 42
                                        # implicit-def: $v8m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vadd.vx	v8, v12, a5
	slli	a4, a4, 32
	srli	a4, a4, 32
	addi	a4, a4, -1
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e64, m2, ta, ma
	vslidedown.vx	v10, v14, a4
	vsetvli	zero, a1, e64, m2, ta, ma
	vslideup.vi	v10, v8, 1
	slli	a4, a2, 3
	add	a3, a3, a4
	vsetvli	zero, a1, e64, m2, ta, ma
	vse64.v	v10, (a3)
	add	a2, a1, a2
	sub	a0, a0, a1
                                        # implicit-def: $v10m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vadd.vx	v10, v12, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 64
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %for.end
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
