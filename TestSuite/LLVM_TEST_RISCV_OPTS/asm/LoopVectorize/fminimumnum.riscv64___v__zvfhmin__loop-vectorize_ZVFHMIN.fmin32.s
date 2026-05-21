# Source: LoopVectorize/fminimumnum.riscv64___v__zvfhmin__loop-vectorize_ZVFHMIN.ll
# Function: fmin32
# src = pre-opt (fmin32), tgt = post-opt (fmin32)
# Triple: riscv64, Attrs: "+v,+zvfhmin"
#

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
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a2
	lw	a0, 0(a0)
	add	a1, a1, a2
	lw	a1, 0(a1)
	call	fminimum_numf
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 15
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	li	a2, 0
	lui	a0, 1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_8
	j	.LBB0_3
.LBB0_3:                                # %vector.memcheck
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sub	a0, a2, a0
	sub	a2, a2, a3
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_8
	j	.LBB0_4
.LBB0_4:                                # %vector.memcheck
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_8
	j	.LBB0_5
.LBB0_5:                                # %vector.ph
	csrr	a0, vlenb
	srli	a0, a0, 1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a5, a5, a3
                                        # implicit-def: $v10m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vle32.v	v10, (a5)
	add	a4, a4, a3
                                        # implicit-def: $v12m2
	vle32.v	v12, (a4)
                                        # implicit-def: $v8m2
	vfmin.vv	v8, v10, v12
	add	a2, a2, a3
	vse32.v	v8, (a2)
	add	a0, a0, a1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_6
	j	.LBB0_7
.LBB0_7:                                # %middle.block
	lui	a1, 1
	li	a0, 1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_10
	j	.LBB0_8
.LBB0_8:                                # %scalar.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 2
	add	a4, a4, a2
	flw	fa5, 0(a4)
	add	a3, a3, a2
	flw	fa4, 0(a3)
	fmin.s	fa5, fa5, fa4
	add	a1, a1, a2
	fsw	fa5, 0(a1)
	addi	a0, a0, 1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_9
	j	.LBB0_10
.LBB0_10:                               # %exit
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
