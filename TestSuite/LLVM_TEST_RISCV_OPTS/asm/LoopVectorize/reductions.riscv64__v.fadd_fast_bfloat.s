# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fadd_fast_bfloat
# src = pre-opt (fadd_fast_bfloat), tgt = post-opt (fadd_fast_bfloat)
# Triple: riscv64, Attrs: +v
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
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa5, zero
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	fsw	fa5, 52(sp)                     # 4-byte Folded Spill
	j	.LBB11_1
.LBB11_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	flw	fa0, 52(sp)                     # 4-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	lhu	a0, 0(a0)
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsw	fa5, 4(sp)                      # 4-byte Folded Spill
	call	__truncsfbf2
	flw	fa5, 4(sp)                      # 4-byte Folded Reload
	fmv.x.w	a0, fa0
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	fsw	fa5, 52(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB11_1
	j	.LBB11_2
.LBB11_2:                               # %for.end
	flw	fa0, 20(sp)                     # 4-byte Folded Reload
	call	__truncsfbf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
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
	sd	s0, 96(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	csrr	a2, vlenb
	mv	a3, a2
	slli	a2, a2, 1
	add	a3, a3, a2
	slli	a2, a2, 2
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xf0, 0x00, 0x22, 0x11, 0x0b, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 112 + 11 * vlenb
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa5, zero
	li	a2, 0
	li	a0, 32
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	fsw	fa5, 92(sp)                     # 4-byte Folded Spill
	bltu	a1, a0, .LBB11_4
	j	.LBB11_1
.LBB11_1:                               # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vmv.v.i	v8, 0
	andi	a0, a0, -32
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	vmv2r.v	v10, v8
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 96
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 96
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB11_2
.LBB11_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 3
	add	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 96
	vl2r.v	v8, (a3)                        # vscale x 16-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 3
	sub	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 96
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	slli	a3, a0, 1
	add	a3, a2, a3
	addi	a2, a3, 32
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vle16.v	v14, (a3)
                                        # implicit-def: $v12m2
	vle16.v	v12, (a2)
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e16, m2, ta, ma
	vfwcvtbf16.f.f.v	v20, v14
                                        # implicit-def: $v24m4
	vfwcvtbf16.f.f.v	v24, v10
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v16, v20, v24
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v10, v16
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
                                        # implicit-def: $v16m4
	vfwcvtbf16.f.f.v	v16, v12
                                        # implicit-def: $v20m4
	vfwcvtbf16.f.f.v	v20, v8
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v16, v20
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v8, v12
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 32
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB11_2
	j	.LBB11_3
.LBB11_3:                               # %middle.block
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 96
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 96
	vl2r.v	v8, (a0)                        # vscale x 16-byte Folded Reload
                                        # implicit-def: $v16m4
	vfwcvtbf16.f.f.v	v16, v8
                                        # implicit-def: $v8m4
	vfwcvtbf16.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v8, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v8, v12
	addi	a0, sp, 96
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetivli	zero, 1, e16, m2, ta, ma
	vslidedown.vi	v10, v8, 15
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a0, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 14
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a1, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 13
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a2, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 12
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a3, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 11
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a4, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 10
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a5, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 9
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a6, v10
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v8, 8
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
	vmv.x.s	a7, v10
	csrr	t0, vlenb
	slli	t0, t0, 1
	add	t0, sp, t0
	addi	t0, t0, 96
	vs1r.v	v8, (t0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetivli	zero, 1, e16, m1, ta, ma
	vslidedown.vi	v9, v8, 7
	vmv.x.s	t0, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 6
	vmv.x.s	t1, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 5
	vmv.x.s	t2, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 4
	vmv.x.s	t3, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 3
	vmv.x.s	t4, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 2
	vmv.x.s	t5, v9
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 1
	vmv.x.s	t6, v9
	vmv.x.s	s0, v8
	slliw	s0, s0, 16
	fmv.w.x	fa5, s0
	slliw	t6, t6, 16
	fmv.w.x	fa4, t6
	fadd.s	fa5, fa5, fa4
	slliw	t5, t5, 16
	fmv.w.x	fa4, t5
	fadd.s	fa5, fa5, fa4
	slliw	t4, t4, 16
	fmv.w.x	fa4, t4
	fadd.s	fa5, fa5, fa4
	slliw	t3, t3, 16
	fmv.w.x	fa4, t3
	fadd.s	fa5, fa5, fa4
	slliw	t2, t2, 16
	fmv.w.x	fa4, t2
	fadd.s	fa5, fa5, fa4
	slliw	t1, t1, 16
	fmv.w.x	fa4, t1
	fadd.s	fa5, fa5, fa4
	slliw	t0, t0, 16
	fmv.w.x	fa4, t0
	fadd.s	fa5, fa5, fa4
	slliw	a7, a7, 16
	fmv.w.x	fa4, a7
	fadd.s	fa5, fa5, fa4
	slliw	a6, a6, 16
	fmv.w.x	fa4, a6
	fadd.s	fa5, fa5, fa4
	slliw	a5, a5, 16
	fmv.w.x	fa4, a5
	fadd.s	fa5, fa5, fa4
	slliw	a4, a4, 16
	fmv.w.x	fa4, a4
	fadd.s	fa5, fa5, fa4
	slliw	a3, a3, 16
	fmv.w.x	fa4, a3
	fadd.s	fa5, fa5, fa4
	slliw	a2, a2, 16
	fmv.w.x	fa4, a2
	fadd.s	fa5, fa5, fa4
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	fadd.s	fa5, fa5, fa4
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	mv	a2, a1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 92(sp)                     # 4-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB11_6
	j	.LBB11_4
.LBB11_4:                               # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	flw	fa5, 92(sp)                     # 4-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 40(sp)                     # 4-byte Folded Spill
	j	.LBB11_5
.LBB11_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	flw	fa0, 40(sp)                     # 4-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	lhu	a0, 0(a0)
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	call	__truncsfbf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	fmv.x.w	a0, fa0
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 40(sp)                     # 4-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB11_5
	j	.LBB11_6
.LBB11_6:                               # %for.end
	flw	fa0, 44(sp)                     # 4-byte Folded Reload
	call	__truncsfbf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 2
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 112
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	ld	s0, 96(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
