# Source: SLPVectorizer/math-function.riscv64__v__f_slp-vectorizer.ll
# Function: int_sqrt_4x
# src = pre-opt (int_sqrt_4x), tgt = post-opt (int_sqrt_4x)
# Triple: riscv64, Attrs: +v,+f
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v9, (a0)
	vfmv.f.s	fa5, v9
	fsqrt.s	fa2, fa5
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa5, v8
	fsqrt.s	fa3, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa5, v8
	fsqrt.s	fa4, fa5
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa5, v8
	fsqrt.s	fa5, fa5
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v9, fa2
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa3
                                        # implicit-def: $v9
	vfslide1down.vf	v9, v8, fa4
                                        # implicit-def: $v8
	vfslide1down.vf	v8, v9, fa5
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
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
	vfsqrt.v	v8, v9
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
