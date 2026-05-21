# Source: LoopVectorize/tail-folding-interleave.riscv64__v_loop-vectorize_NO-VP.ll
# Function: store_factor_4_with_tail_gap
# src = pre-opt (store_factor_4_with_tail_gap), tgt = post-opt (store_factor_4_with_tail_gap)
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
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 4
	add	a2, a2, a3
	sw	a0, 0(a2)
	sw	a0, 4(a2)
	sw	a0, 8(a2)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	slli	a2, a2, 1
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 2 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sext.w	a0, a1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a1, 8
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_4
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 8, e32, m2, ta, ma
	vid.v	v8
	andi	a0, a0, -8
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	addi	a0, sp, 64
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	addi	a3, sp, 64
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 4
	add	a2, a2, a3
                                        # implicit-def: $v16m8
	vmv2r.v	v16, v10
                                        # implicit-def: $v12m4
	vmv2r.v	v12, v10
	vmv4r.v	v24, v12
	vmv2r.v	v26, v8
	vsetivli	zero, 16, e32, m4, ta, ma
	vslideup.vi	v12, v24, 8
                                        # implicit-def: $v24m8
	vmv.v.v	v24, v12
	li	a3, 32
	vmv4r.v	v20, v12
	vmv2r.v	v18, v8
	vsetvli	zero, a3, e32, m8, ta, ma
	vslideup.vi	v24, v16, 16
	lui	a4, %hi(.LCPI4_0)
	addi	a4, a4, %lo(.LCPI4_0)
                                        # implicit-def: $v8m2
	vsetvli	zero, a3, e8, m2, tu, ma
	vle8.v	v8, (a4)
                                        # implicit-def: $v12m4
	vsetvli	zero, a3, e16, m4, ta, ma
	vsext.vf2	v12, v8
                                        # implicit-def: $v16m8
	vsetvli	zero, a3, e32, m8, ta, ma
	vrgatherei16.vv	v16, v24, v12
	lui	a4, 489335
	addi	a4, a4, 1911
                                        # implicit-def: $v0
	vsetivli	zero, 1, e32, m8, tu, ma
	vmv.s.x	v0, a4
	vsetvli	zero, a3, e32, m8, ta, ma
	vse32.v	v16, (a2), v0.t
	addiw	a0, a0, 8
                                        # implicit-def: $v8m2
	vsetivli	zero, 8, e32, m2, ta, ma
	vadd.vi	v8, v10, 8
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sext.w	a1, a2
	sext.w	a0, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_6
	j	.LBB4_4
.LBB4_4:                                # %scalar.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sext.w	a3, a0
	slli	a3, a3, 4
	add	a2, a2, a3
	sw	a0, 0(a2)
	sw	a0, 4(a2)
	sw	a0, 8(a2)
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_5
	j	.LBB4_6
.LBB4_6:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
