# Source: SLPVectorizer/fround.riscv64__v__zvbb_slp-vectorizer.ll
# Function: llrint_v2i64f32
# src = pre-opt (llrint_v2i64f32), tgt = post-opt (llrint_v2i64f32)
# Triple: riscv64, Attrs: +v,+zvbb
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, tu, ma
	vle32.v	v9, (a0)
	vfmv.f.s	fa5, v9
	fcvt.l.s	a1, fa5
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, mf2, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa5, v8
	fcvt.l.s	a0, fa5
                                        # implicit-def: $v9
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v9, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, tu, ma
	vle32.v	v9, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vfwcvt.x.f.v	v8, v9
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
