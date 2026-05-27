# Source: LoopVectorize/tail-folding-call-intrinsics.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: vp_cttz
# src = pre-opt (vp_cttz), tgt = post-opt (vp_cttz)
# Triple: riscv64, Attrs: +v
#

	.globl	src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	li	a5, 0
	subw	a5, a5, a2
	and	a5, a2, a5
	sd	a5, 8(sp)                       # 8-byte Folded Spill
	slliw	a2, a5, 4
	subw	a2, a5, a2
	slliw	a6, a5, 6
	addw	a2, a2, a6
	slliw	a6, a5, 8
	addw	a2, a2, a6
	slliw	a6, a5, 10
	addw	a2, a2, a6
	slliw	a6, a5, 12
	subw	a2, a2, a6
	slliw	a6, a5, 14
	subw	a2, a2, a6
	slliw	a6, a5, 16
	addw	a2, a2, a6
	slliw	a6, a5, 18
	subw	a2, a2, a6
	slliw	a6, a5, 23
	subw	a2, a2, a6
	slliw	a5, a5, 27
	addw	a2, a2, a5
	srliw	a5, a2, 27
	lui	a2, %hi(.LCPI5_0)
	addi	a2, a2, %lo(.LCPI5_0)
	add	a2, a2, a5
	lbu	a2, 0(a2)
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	bltu	a0, a1, .LBB5_5
	j	.LBB5_2
.LBB5_2:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB5_3
.LBB5_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a5, a5, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v10, (a5)
                                        # implicit-def: $v12m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vrsub.vi	v12, v10, 0
                                        # implicit-def: $v8m2
	vand.vv	v8, v10, v12
                                        # implicit-def: $v12m4
	vfwcvt.f.xu.v	v12, v8
	li	a5, 52
                                        # implicit-def: $v10m2
	vnsrl.wx	v10, v12, a5
	li	a5, 1023
                                        # implicit-def: $v8m2
	vsub.vx	v8, v10, a5
	add	a3, a3, a4
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_3
	j	.LBB5_4
.LBB5_4:                                # %middle.block
	j	.LBB5_7
.LBB5_5:                                # %scalar.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB5_6
.LBB5_6:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	li	a5, 0
	subw	a5, a5, a2
	and	a5, a2, a5
	sd	a5, 8(sp)                       # 8-byte Folded Spill
	slliw	a2, a5, 4
	subw	a2, a5, a2
	slliw	a6, a5, 6
	addw	a2, a2, a6
	slliw	a6, a5, 8
	addw	a2, a2, a6
	slliw	a6, a5, 10
	addw	a2, a2, a6
	slliw	a6, a5, 12
	subw	a2, a2, a6
	slliw	a6, a5, 14
	subw	a2, a2, a6
	slliw	a6, a5, 16
	addw	a2, a2, a6
	slliw	a6, a5, 18
	subw	a2, a2, a6
	slliw	a6, a5, 23
	subw	a2, a2, a6
	slliw	a5, a5, 27
	addw	a2, a2, a5
	srliw	a5, a2, 27
	lui	a2, %hi(.LCPI5_0)
	addi	a2, a2, %lo(.LCPI5_0)
	add	a2, a2, a5
	lbu	a2, 0(a2)
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_6
	j	.LBB5_7
.LBB5_7:                                # %exit
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
