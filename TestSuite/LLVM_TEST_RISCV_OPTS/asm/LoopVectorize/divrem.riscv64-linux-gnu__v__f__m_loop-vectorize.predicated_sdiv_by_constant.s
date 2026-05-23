# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize.ll
# Function: predicated_sdiv_by_constant
# src = pre-opt (predicated_sdiv_by_constant), tgt = post-opt (predicated_sdiv_by_constant)
# Triple: riscv64-linux-gnu, Attrs: +v,+f,+m
#

	.globl	src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 3
	add	a0, a0, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	ld	a0, 0(a0)
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a1, 42
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                # %do_op
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	lui	a1, %hi(.LCPI7_0)
	ld	a1, %lo(.LCPI7_0)(a1)
	mulh	a0, a0, a1
	srli	a1, a0, 63
	add	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB7_3
.LBB7_3:                                # %latch
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_4
.LBB7_4:                                # %for.end
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB7_2
.LBB7_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 3
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vle64.v	v10, (a3)
	li	a4, 42
	vsetvli	a5, zero, e64, m2, ta, ma
	vmsne.vx	v0, v10, a4
	lui	a4, %hi(.LCPI7_0)
	ld	a4, %lo(.LCPI7_0)(a4)
                                        # implicit-def: $v8m2
	vmulh.vx	v8, v10, a4
	li	a4, 63
                                        # implicit-def: $v14m2
	vsrl.vx	v14, v8, a4
                                        # implicit-def: $v12m2
	vadd.vv	v12, v8, v14
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmerge.vvm	v8, v10, v12, v0
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB7_2
	j	.LBB7_3
.LBB7_3:                                # %middle.block
	j	.LBB7_4
.LBB7_4:                                # %for.end
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
