# Source: SLPVectorizer/scatter-vectorize-reversed.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 1, e64, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 1
	vmv.x.s	a1, v9
	slli	a1, a1, 1
	add	a1, a0, a1
	lhu	a1, 0(a1)
	vmv.x.s	a2, v8
	slli	a2, a2, 1
	add	a0, a0, a2
	lhu	a0, 0(a0)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.x	v9, a1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	li	a0, 0
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 2, e64, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 1
	vslideup.vi	v8, v9, 1
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, tu, ma
	vluxei64.v	v8, (a0), v9
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, ta, ma
	vzext.vf2	v9, v8
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.i	v8, 0
	vsetivli	zero, 2, e32, m1, tu, ma
	vmv.v.v	v8, v9
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
