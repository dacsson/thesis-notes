# Source: SLPVectorizer/fround.riscv32__m__v_slp-vectorizer.ll
# Function: lrint_v4i32f32
# src = pre-opt (lrint_v4i32f32), tgt = post-opt (lrint_v4i32f32)
# Triple: riscv32, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a0)
	vfmv.f.s	fa5, v9
	fcvt.w.s	a3, fa5
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa5, v8
	fcvt.w.s	a2, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa5, v8
	fcvt.w.s	a1, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa5, v8
	fcvt.w.s	a0, fa5
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.x	v9, a3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vfcvt.x.f.v	v8, v9
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
