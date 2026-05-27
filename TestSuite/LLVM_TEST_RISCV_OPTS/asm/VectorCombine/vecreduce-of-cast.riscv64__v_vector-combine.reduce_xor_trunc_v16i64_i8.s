# Source: VectorCombine/vecreduce-of-cast.riscv64__v_vector-combine.ll
# Function: reduce_xor_trunc_v16i64_i8
# src = pre-opt (reduce_xor_trunc_v16i64_i8), tgt = post-opt (reduce_xor_trunc_v16i64_i8)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 16, e32, m4, ta, ma
	vmv8r.v	v16, v8
                                        # kill: def $v8m8 killed $v16m8 killed $vtype
                                        # implicit-def: $v12m4
	vnsrl.wi	v12, v16, 0
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vnsrl.wi	v10, v12, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, m1, ta, ma
	vnsrl.wi	v9, v10, 0
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, ta, ma
	vredxor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 1, e64, m8, tu, ma
	vmv8r.v	v16, v8
                                        # kill: def $v8m8 killed $v16m8 killed $vtype
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetivli	zero, 16, e64, m8, ta, ma
	vredxor.vs	v8, v16, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
