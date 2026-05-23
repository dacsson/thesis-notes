# Source: LoopVectorize/divrem.riscv64-linux-gnu__v__f__m_loop-vectorize_FIXED.ll
# Function: predicated_udiv_by_constant
# src = pre-opt (predicated_udiv_by_constant), tgt = post-opt (predicated_udiv_by_constant)
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
	j	.LBB6_1
.LBB6_1:                                # %for.body
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
	beq	a0, a1, .LBB6_3
	j	.LBB6_2
.LBB6_2:                                # %do_op
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	lui	a1, %hi(.LCPI6_0)
	ld	a1, %lo(.LCPI6_0)(a1)
	mulhu	a0, a0, a1
	srli	a0, a0, 4
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB6_3
.LBB6_3:                                # %latch
                                        #   in Loop: Header=BB6_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_1
	j	.LBB6_4
.LBB6_4:                                # %for.end
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB6_2
.LBB6_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a1, a1, a2
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v8, (a1)
	li	a2, 42
	vsetvli	zero, zero, e64, m2, ta, ma
	vmsne.vx	v0, v8, a2
	lui	a2, %hi(.LCPI6_0)
	ld	a2, %lo(.LCPI6_0)(a2)
                                        # implicit-def: $v10m2
	vmulhu.vx	v10, v8, a2
                                        # implicit-def: $v8m2
	vsrl.vi	v8, v10, 4
	vse64.v	v8, (a1), v0.t
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB6_2
	j	.LBB6_3
.LBB6_3:                                # %middle.block
	j	.LBB6_4
.LBB6_4:                                # %for.end
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
