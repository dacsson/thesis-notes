# Source: VectorCombine/vecreduce-of-cast.riscv64__v_vector-combine.ll
# Function: reduce_or_trunc_v8i32_i8
# src = pre-opt (reduce_or_trunc_v8i32_i8), tgt = post-opt (reduce_or_trunc_v8i32_i8)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e16, m1, ta, ma
	vmv2r.v	v10, v8
                                        # kill: def $v8m2 killed $v10m2 killed $vtype
                                        # implicit-def: $v8
	vnsrl.wi	v8, v10, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vnsrl.wi	v9, v8, 0
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv2r.v	v10, v8
                                        # kill: def $v12m2 killed $v10m2 killed $vtype
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vredor.vs	v8, v10, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
