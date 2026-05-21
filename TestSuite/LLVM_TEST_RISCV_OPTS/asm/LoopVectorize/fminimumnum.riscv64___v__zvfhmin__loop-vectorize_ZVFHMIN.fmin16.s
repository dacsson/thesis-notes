# Source: LoopVectorize/fminimumnum.riscv64___v__zvfhmin__loop-vectorize_ZVFHMIN.ll
# Function: fmin16
# src = pre-opt (fmin16), tgt = post-opt (fmin16)
# Triple: riscv64, Attrs: "+v,+zvfhmin"
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lhu	a0, 0(a0)
	add	a1, a1, a2
	lhu	a1, 0(a1)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	sh	a1, 0(a2)
	addi	a0, a0, 1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
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
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.memcheck
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sub	a0, a2, a0
	sub	a2, a2, a3
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_6
	j	.LBB4_2
.LBB4_2:                                # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB4_6
	j	.LBB4_3
.LBB4_3:                                # %vector.ph
	lui	a0, 1
	li	a1, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB4_4
.LBB4_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	ld	a6, 88(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a4, a1, 1
	add	a6, a6, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v12, (a6)
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v8, (a5)
                                        # implicit-def: $v16m4
	vsetvli	a5, zero, e16, m2, ta, ma
	vfwcvt.f.f.v	v16, v8
                                        # implicit-def: $v8m4
	vfwcvt.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfmin.vv	v12, v8, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvt.f.f.w	v8, v12
	add	a3, a3, a4
	vsetvli	zero, a2, e16, m2, ta, ma
	vse16.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_4
	j	.LBB4_5
.LBB4_5:                                # %middle.block
	j	.LBB4_8
.LBB4_6:                                # %scalar.ph
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB4_7
.LBB4_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	add	a2, a2, a1
	lhu	a2, 0(a2)
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	lhu	a0, 0(a0)
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	fsw	fa0, 12(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 12(sp)                     # 4-byte Folded Reload
	fmin.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	add	a2, a2, a3
	sh	a1, 0(a2)
	addi	a0, a0, 1
	lui	a1, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_7
	j	.LBB4_8
.LBB4_8:                                # %exit
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
