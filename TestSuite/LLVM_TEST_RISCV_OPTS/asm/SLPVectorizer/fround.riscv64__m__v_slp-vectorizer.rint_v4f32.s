# Source: SLPVectorizer/fround.riscv64__m__v_slp-vectorizer.ll
# Function: rint_v4f32
# src = pre-opt (rint_v4f32), tgt = post-opt (rint_v4f32)
# Triple: riscv64, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a0)
	addi	a0, sp, 64
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	vfmv.f.s	fa5, v8
	fsw	fa5, 52(sp)                     # 4-byte Folded Spill
	lui	a0, 307200
	fmv.w.x	fa3, a0
	fsw	fa3, 56(sp)                     # 4-byte Folded Spill
	fabs.s	fa4, fa5
	flt.s	a0, fa4, fa3
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB0_2
# %bb.1:                                # %entry
	flw	fa4, 52(sp)                     # 4-byte Folded Reload
	fcvt.w.s	a0, fa4
	fcvt.s.w	fa5, a0
	fsgnj.s	fa5, fa5, fa4
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
.LBB0_2:                                # %entry
	flw	fa3, 56(sp)                     # 4-byte Folded Reload
	flw	fa5, 60(sp)                     # 4-byte Folded Reload
	addi	a0, sp, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa5, 40(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa5, v8
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	fabs.s	fa4, fa5
	flt.s	a0, fa4, fa3
	fsw	fa5, 48(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB0_4
# %bb.3:                                # %entry
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	fcvt.w.s	a0, fa4
	fcvt.s.w	fa5, a0
	fsgnj.s	fa5, fa5, fa4
	fsw	fa5, 48(sp)                     # 4-byte Folded Spill
.LBB0_4:                                # %entry
	flw	fa3, 56(sp)                     # 4-byte Folded Reload
	flw	fa5, 48(sp)                     # 4-byte Folded Reload
	addi	a0, sp, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa5, v8
	fsw	fa5, 32(sp)                     # 4-byte Folded Spill
	fabs.s	fa4, fa5
	flt.s	a0, fa4, fa3
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB0_6
# %bb.5:                                # %entry
	flw	fa4, 32(sp)                     # 4-byte Folded Reload
	fcvt.w.s	a0, fa4
	fcvt.s.w	fa5, a0
	fsgnj.s	fa5, fa5, fa4
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
.LBB0_6:                                # %entry
	flw	fa3, 56(sp)                     # 4-byte Folded Reload
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
	addi	a0, sp, 64
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	fsw	fa5, 16(sp)                     # 4-byte Folded Spill
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa5, v8
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	fabs.s	fa4, fa5
	flt.s	a0, fa4, fa3
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB0_8
# %bb.7:                                # %entry
	flw	fa4, 20(sp)                     # 4-byte Folded Reload
	fcvt.w.s	a0, fa4
	fcvt.s.w	fa5, a0
	fsgnj.s	fa5, fa5, fa4
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
.LBB0_8:                                # %entry
	flw	fa4, 16(sp)                     # 4-byte Folded Reload
	flw	fa3, 28(sp)                     # 4-byte Folded Reload
	flw	fa2, 40(sp)                     # 4-byte Folded Reload
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v9, fa2
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa3
                                        # implicit-def: $v9
	vfslide1down.vf	v9, v8, fa4
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa5
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a0)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vfabs.v	v9, v8
	lui	a0, 307200
	fmv.w.x	fa5, a0
	vmflt.vf	v0, v9, fa5
	addi	a0, sp, 16
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10
	vfcvt.x.f.v	v10, v8, v0.t
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v9
	vfcvt.f.x.v	v9, v10, v0.t
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
	vsetvli	zero, zero, e32, m1, ta, mu
	vfsgnj.vv	v8, v9, v8, v0.t
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
