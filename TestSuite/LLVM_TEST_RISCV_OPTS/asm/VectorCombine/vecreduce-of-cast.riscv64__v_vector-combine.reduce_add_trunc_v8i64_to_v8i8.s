# Source: VectorCombine/vecreduce-of-cast.riscv64__v_vector-combine.ll
# Function: reduce_add_trunc_v8i64_to_v8i8
# src = pre-opt (reduce_add_trunc_v8i64_to_v8i8), tgt = post-opt (reduce_add_trunc_v8i64_to_v8i8)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv4r.v	v12, v8
                                        # kill: def $v8m4 killed $v12m4 killed $vtype
                                        # implicit-def: $v10m2
	vnsrl.wi	v10, v12, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m1, ta, ma
	vnsrl.wi	v8, v10, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vnsrl.wi	v9, v8, 0
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 1, e64, m8, tu, ma
	vmv4r.v	v12, v8
                                        # kill: def $v8m4 killed $v12m4 killed $vtype
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetivli	zero, 8, e64, m4, ta, ma
	vredsum.vs	v8, v12, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
