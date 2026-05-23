# Source: LoopVectorize/tail-folding-interleave.riscv64__v_loop-vectorize_NO-VP.ll
# Function: store_factor_4_with_gap
# src = pre-opt (store_factor_4_with_gap), tgt = post-opt (store_factor_4_with_gap)
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
	j	.LBB2_1
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 4
	add	a2, a2, a3
	sw	a0, 0(a2)
	sw	a0, 4(a2)
	sw	a0, 12(a2)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 32
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 4 * vlenb
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_2
# %bb.1:                                # %entry
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB2_2:                                # %entry
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_6
	j	.LBB2_3
.LBB2_3:                                # %vector.ph
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sub	a3, a0, a1
	and	a2, a2, a3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e32, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.x	v10, a1
	addi	a1, sp, 96
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 96
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB2_4
.LBB2_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 96
	vl2r.v	v10, (a4)                       # vscale x 16-byte Folded Reload
	addi	a4, sp, 96
	vl2r.v	v12, (a4)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.x	v16, a3
	li	a4, 16
	vsetvli	zero, zero, e32, m2, ta, ma
	vwmaccus.vx	v16, a4, v10
                                        # implicit-def: $v20m4
	vwmulsu.vx	v20, v10, a4
	vsoxei64.v	v10, (a3), v20
	li	a3, 4
	vsoxei64.v	v10, (a3), v16
	li	a3, 12
	vsoxei64.v	v10, (a3), v16
	addw	a0, a0, a2
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB2_4
	j	.LBB2_5
.LBB2_5:                                # %middle.block
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sext.w	a1, a2
	sext.w	a0, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB2_8
	j	.LBB2_6
.LBB2_6:                                # %scalar.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_7
.LBB2_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 4
	add	a2, a2, a3
	sw	a0, 0(a2)
	sw	a0, 4(a2)
	sw	a0, 12(a2)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_7
	j	.LBB2_8
.LBB2_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 96
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
