# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: ldexp_f64
# src = pre-opt (ldexp_f64), tgt = post-opt (ldexp_f64)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB50_1
.LBB50_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a3, a1, 3
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	add	a2, a2, a3
	fld	fa0, 0(a2)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	call	ldexp
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a1, a1, a2
	fsd	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB50_1
	j	.LBB50_2
.LBB50_2:                               # %for.end
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end50:
	.size	src, .Lfunc_end50-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	srli	a1, a0, 2
	li	a2, 0
	li	a0, 1000
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB50_4
	j	.LBB50_1
.LBB50_1:                               # %vector.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	slli	a1, a0, 1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	li	a0, 1000
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB50_2
.LBB50_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	slli	a3, a1, 3
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	add	a2, a2, a3
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vle64.v	v8, (a2)
	slli	a1, a1, 2
	add	a0, a0, a1
                                        # implicit-def: $v10
	vle32.v	v10, (a0)
	call	Sleef_ldexpdx_rvvm2
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	add	a3, a3, a4
	vsetvli	a4, zero, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB50_2
	j	.LBB50_3
.LBB50_3:                               # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	li	a1, 1000
	mv	a2, a0
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB50_6
	j	.LBB50_4
.LBB50_4:                               # %scalar.ph
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB50_5
.LBB50_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a3, a1, 3
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	add	a2, a2, a3
	fld	fa0, 0(a2)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	call	ldexp
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a1, a1, a2
	fsd	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB50_5
	j	.LBB50_6
.LBB50_6:                               # %for.end
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end50:
	.size	tgt, .Lfunc_end50-tgt
	.cfi_endproc
                                        # -- End function
