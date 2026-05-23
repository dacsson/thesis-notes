# Source: VectorCombine/shuffle-of-intrinsics.riscv64__v_vector-combine.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v9
                                        # kill: def $v11 killed $v10 killed $vtype
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vrsub.vi	v9, v8, 0
                                        # implicit-def: $v11
	vmax.vv	v11, v8, v9
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v11
                                        # implicit-def: $v11
	vrsub.vi	v11, v10, 0
                                        # implicit-def: $v12
	vmax.vv	v12, v10, v11
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
	vmv1r.v	v11, v12
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v8, v10, 4
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv1r.v	v13, v9
	vmv1r.v	v12, v8
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v13
                                        # implicit-def: $v10m2
	vmv1r.v	v10, v12
	vmv1r.v	v9, v12
	vslideup.vi	v10, v8, 4
                                        # implicit-def: $v12m2
	vrsub.vi	v12, v10, 0
                                        # implicit-def: $v8m2
	vmax.vv	v8, v10, v12
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
