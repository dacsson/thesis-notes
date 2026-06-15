# Source: VectorCombine/shuffle-of-intrinsics.riscv64__v_vector-combine.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
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
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
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
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
