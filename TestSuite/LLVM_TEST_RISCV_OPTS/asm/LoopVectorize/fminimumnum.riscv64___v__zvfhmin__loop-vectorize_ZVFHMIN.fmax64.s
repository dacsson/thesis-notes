# Source: LoopVectorize/fminimumnum.riscv64___v__zvfhmin__loop-vectorize_ZVFHMIN.ll
# Function: fmax64
# src = pre-opt (fmax64), tgt = post-opt (fmax64)
# Triple: riscv64, Attrs: "+v,+zvfhmin"
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
	j	.LBB3_1
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a2
	ld	a0, 0(a0)
	add	a1, a1, a2
	ld	a1, 0(a1)
	call	fmaximum_num
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
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
	srli	a1, a0, 2
	li	a0, 15
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_2
# %bb.1:                                # %entry
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
.LBB3_2:                                # %entry
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	li	a2, 0
	lui	a0, 1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_8
	j	.LBB3_3
.LBB3_3:                                # %vector.memcheck
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
	bltu	a0, a1, .LBB3_8
	j	.LBB3_4
.LBB3_4:                                # %vector.memcheck
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_8
	j	.LBB3_5
.LBB3_5:                                # %vector.ph
	csrr	a0, vlenb
	srli	a0, a0, 2
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_6
.LBB3_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a5, a5, a3
                                        # implicit-def: $v10m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vle64.v	v10, (a5)
	add	a4, a4, a3
                                        # implicit-def: $v12m2
	vle64.v	v12, (a4)
                                        # implicit-def: $v8m2
	vfmax.vv	v8, v10, v12
	add	a2, a2, a3
	vse64.v	v8, (a2)
	add	a0, a0, a1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_6
	j	.LBB3_7
.LBB3_7:                                # %middle.block
	lui	a1, 1
	li	a0, 1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_10
	j	.LBB3_8
.LBB3_8:                                # %scalar.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_9
.LBB3_9:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a4, a4, a2
	fld	fa5, 0(a4)
	add	a3, a3, a2
	fld	fa4, 0(a3)
	fmax.d	fa5, fa5, fa4
	add	a1, a1, a2
	fsd	fa5, 0(a1)
	addi	a0, a0, 1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB3_9
	j	.LBB3_10
.LBB3_10:                               # %exit
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
