# Source: LoopVectorize/tail-folding-call-intrinsics.riscv64__v_loop-vectorize_NO-VP.ll
# Function: log10
# src = pre-opt (log10), tgt = post-opt (log10)
# Triple: riscv64, Attrs: +v
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
	j	.LBB9_1
.LBB9_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	add	a0, a0, a1
	flw	fa0, 0(a0)
	call	log10f
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	fsw	fa0, 0(a2)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB9_1
	j	.LBB9_2
.LBB9_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	slli	a4, a3, 1
	add	a3, a4, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 3 * vlenb
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	li	a1, 0
	li	a0, 12
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	bltu	a2, a0, .LBB9_5
	j	.LBB9_1
.LBB9_1:                                # %vector.memcheck
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	sub	a0, a0, a1
	li	a2, 0
	li	a1, 16
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB9_5
	j	.LBB9_2
.LBB9_2:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	andi	a0, a0, -4
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	j	.LBB9_3
.LBB9_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	add	a0, a0, a1
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a0)
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 144
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	log10f
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 144
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa0, 52(sp)                     # 4-byte Folded Spill
	vsetivli	zero, 1, e32, m1, ta, ma
	vfmv.f.s	fa0, v8
	call	log10f
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 144
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fmv.s	fa5, fa0
	flw	fa0, 52(sp)                     # 4-byte Folded Reload
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v10, fa5
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v10, fa0
	addi	a0, sp, 144
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	log10f
	addi	a0, sp, 144
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 144
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vfslide1down.vf	v8, v10, fa0
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 144
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	log10f
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 1
	add	a4, sp, a4
	addi	a4, a4, 144
	vl1r.v	v9, (a4)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vfslide1down.vf	v8, v9, fa0
	add	a2, a2, a3
	vse32.v	v8, (a2)
	addi	a0, a0, 4
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB9_3
	j	.LBB9_4
.LBB9_4:                                # %middle.block
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB9_7
	j	.LBB9_5
.LBB9_5:                                # %scalar.ph
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB9_6
.LBB9_6:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a0, a0, a1
	flw	fa0, 0(a0)
	call	log10f
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	add	a2, a2, a3
	fsw	fa0, 0(a2)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB9_6
	j	.LBB9_7
.LBB9_7:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
