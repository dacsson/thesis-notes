# Source: SLPVectorizer/fround.riscv64__m__v_slp-vectorizer.ll
# Function: llrint_v8i64f32
# src = pre-opt (llrint_v8i64f32), tgt = post-opt (llrint_v8i64f32)
# Triple: riscv64, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	sd	s0, 112(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 128
	.cfi_def_cfa s0, 0
	andi	sp, sp, -64
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v10, (a0)
	vmv1r.v	v9, v10
	vfmv.f.s	fa5, v9
	fcvt.l.s	a7, fa5
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa5, v8
	fcvt.l.s	a0, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa5, v8
	fcvt.l.s	a1, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa5, v8
	fcvt.l.s	a2, fa5
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vi	v8, v10, 4
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	fcvt.l.s	a3, fa5
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 5
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	fcvt.l.s	a4, fa5
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 6
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	fcvt.l.s	a5, fa5
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 7
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	fcvt.l.s	a6, fa5
	sd	a7, 0(sp)
	sd	a6, 56(sp)
	sd	a5, 48(sp)
	sd	a4, 40(sp)
	sd	a3, 32(sp)
	sd	a2, 24(sp)
	sd	a1, 16(sp)
	sd	a0, 8(sp)
	mv	a0, sp
                                        # implicit-def: $v8m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vle64.v	v8, (a0)
	addi	sp, s0, -128
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	ld	s0, 112(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v14m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v14, (a0)
	vmv1r.v	v8, v14
                                        # implicit-def: $v12m2
	vsetivli	zero, 4, e32, m1, ta, ma
	vfwcvt.x.f.v	v12, v8
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v12
                                        # implicit-def: $v12m2
	vsetivli	zero, 4, e32, m2, ta, ma
	vslidedown.vi	v12, v14, 4
                                        # kill: def $v12 killed $v12 killed $v12m2 killed $vtype
                                        # implicit-def: $v16m2
	vsetivli	zero, 4, e32, m1, ta, ma
	vfwcvt.x.f.v	v16, v12
                                        # implicit-def: $v12m4
	vmv2r.v	v12, v16
	vmv2r.v	v14, v16
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v8, v12, 4
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
