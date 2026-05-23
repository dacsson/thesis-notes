# Source: VectorCombine/shuffle-of-intrinsics.riscv64__v_vector-combine.ll
# Function: test3
# src = pre-opt (test3), tgt = post-opt (test3)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v15 killed $v11 killed $vtype
                                        # kill: def $v14 killed $v10 killed $vtype
                                        # kill: def $v13 killed $v9 killed $vtype
                                        # kill: def $v12 killed $v8 killed $vtype
                                        # implicit-def: $v12
	vmax.vv	v12, v8, v9
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v12
                                        # implicit-def: $v12
	vmax.vv	v12, v10, v11
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
	vmv1r.v	v11, v12
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v8, v10, 4
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v15 killed $v11 killed $vtype
                                        # kill: def $v14 killed $v10 killed $vtype
                                        # kill: def $v13 killed $v9 killed $vtype
                                        # kill: def $v12 killed $v8 killed $vtype
                                        # implicit-def: $v12
	vmax.vv	v12, v8, v9
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v12
                                        # implicit-def: $v12
	vmax.vv	v12, v10, v11
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
	vmv1r.v	v11, v12
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v8, v10, 4
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
