# Source: LoopVectorize/tail-folding-div.riscv64__v_loop-vectorize_IF-EVL.ll
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 3
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vle64.v	v8, (a5)
	lui	a5, %hi(.LCPI4_0)
	ld	a5, %lo(.LCPI4_0)(a5)
                                        # implicit-def: $v10m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vmulh.vx	v10, v8, a5
	li	a5, 63
                                        # implicit-def: $v12m2
	vsrl.vx	v12, v10, a5
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
