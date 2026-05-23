# Source: VectorCombine/vecreduce-of-cast.riscv32__v_vector-combine.ll
# Function: reduce_add_trunc_v8i8_to_v8i32
# src = pre-opt (reduce_add_trunc_v8i8_to_v8i32), tgt = post-opt (reduce_add_trunc_v8i8_to_v8i32)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v10m2
	vzext.vf4	v10, v8
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v10m2
	vzext.vf4	v10, v8
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
