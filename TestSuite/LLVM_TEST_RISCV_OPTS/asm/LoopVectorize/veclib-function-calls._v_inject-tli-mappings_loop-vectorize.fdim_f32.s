# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: fdim_f32
# src = pre-opt (fdim_f32), tgt = post-opt (fdim_f32)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB37_1
.LBB37_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	flw	fa1, 0(a0)
	fmv.s	fa0, fa1
	call	fdimf
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a2
	fsw	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB37_1
	j	.LBB37_2
.LBB37_2:                               # %for.end
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end37:
	.size	src, .Lfunc_end37-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	srli	a1, a0, 1
	li	a2, 0
	li	a0, 1000
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB37_4
	j	.LBB37_1
.LBB37_1:                               # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1000
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB37_2
.LBB37_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a1
                                        # implicit-def: $v10m2
	vsetvli	a1, zero, e32, m2, ta, ma
	vle32.v	v10, (a0)
	vmv.v.v	v8, v10
	call	Sleef_fdimfx_rvvm2
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	add	a3, a3, a4
	vsetvli	a4, zero, e32, m2, ta, ma
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB37_2
	j	.LBB37_3
.LBB37_3:                               # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 1000
	mv	a2, a0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB37_6
	j	.LBB37_4
.LBB37_4:                               # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB37_5
.LBB37_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	flw	fa1, 0(a0)
	fmv.s	fa0, fa1
	call	fdimf
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a2
	fsw	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB37_5
	j	.LBB37_6
.LBB37_6:                               # %for.end
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end37:
	.size	tgt, .Lfunc_end37-tgt
	.cfi_endproc
                                        # -- End function
