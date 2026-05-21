# Source: LoopVectorize/tail-folding-div.riscv64__v_loop-vectorize_NO-VP.ll
# Function: test_sdiv_divisor_invariant_safeimm
# src = pre-opt (test_sdiv_divisor_invariant_safeimm), tgt = post-opt (test_sdiv_divisor_invariant_safeimm)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 3
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	ld	a0, 0(a0)
	li	a1, 3
	call	__divdi3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
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
# %bb.0:                                # %loop.preheader
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %loop.preheader
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 80(sp)                      # 8-byte Folded Spill
.LBB4_2:                                # %loop.preheader
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_6
	j	.LBB4_3
.LBB4_3:                                # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_4
.LBB4_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 64(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 3
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vle64.v	v8, (a5)
	lui	a5, %hi(.LCPI4_0)
	ld	a5, %lo(.LCPI4_0)(a5)
                                        # implicit-def: $v10m2
	vmulh.vx	v10, v8, a5
	li	a5, 63
                                        # implicit-def: $v12m2
	vsrl.vx	v12, v10, a5
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	add	a3, a3, a4
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_4
	j	.LBB4_5
.LBB4_5:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_8
	j	.LBB4_6
.LBB4_6:                                # %scalar.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_7
.LBB4_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 3
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	ld	a0, 0(a0)
	li	a1, 3
	call	__divdi3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_7
	j	.LBB4_8
.LBB4_8:                                # %exit
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
