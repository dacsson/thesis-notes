# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: sinpi_f32
# src = pre-opt (sinpi_f32), tgt = post-opt (sinpi_f32)
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
	j	.LBB77_1
.LBB77_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	flw	fa0, 0(a0)
	call	sinpif
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a2
	fsw	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB77_1
	j	.LBB77_2
.LBB77_2:                               # %for.end
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end77:
	.size	src, .Lfunc_end77-src
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
	bltu	a0, a1, .LBB77_4
	j	.LBB77_1
.LBB77_1:                               # %vector.ph
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
	j	.LBB77_2
.LBB77_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a1
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, ta, ma
	vle32.v	v8, (a0)
	call	Sleef_sinpifx_u05rvvm2
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
	bne	a0, a1, .LBB77_2
	j	.LBB77_3
.LBB77_3:                               # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 1000
	mv	a2, a0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB77_6
	j	.LBB77_4
.LBB77_4:                               # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB77_5
.LBB77_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	flw	fa0, 0(a0)
	call	sinpif
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a2
	fsw	fa0, 0(a1)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB77_5
	j	.LBB77_6
.LBB77_6:                               # %for.end
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end77:
	.size	tgt, .Lfunc_end77-tgt
	.cfi_endproc
                                        # -- End function
