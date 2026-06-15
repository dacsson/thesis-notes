# Source: SLPVectorizer/fround.riscv64__m__v_slp-vectorizer.ll
# Function: lrint_v8i32f32
# src = pre-opt (lrint_v8i32f32), tgt = post-opt (lrint_v8i32f32)
# Triple: riscv64, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
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
	fcvt.l.s	a6, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa5, v8
	fcvt.l.s	a5, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa5, v8
	fcvt.l.s	a4, fa5
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
	fcvt.l.s	a2, fa5
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 6
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	fcvt.l.s	a1, fa5
                                        # implicit-def: $v8m2
	vslidedown.vi	v8, v10, 7
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa5, v8
	fcvt.l.s	a0, fa5
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v10, a7
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a6
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a5
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a4
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a3
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a2
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a1
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v10, (a0)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfcvt.x.f.v	v8, v10
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
