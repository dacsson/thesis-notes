# Source: VectorCombine/vecreduce-of-cast.riscv32__v_vector-combine.ll
# Function: reduce_or_sext_v8i16_to_v8i32
# src = pre-opt (reduce_or_sext_v8i16_to_v8i32), tgt = post-opt (reduce_or_sext_v8i16_to_v8i32)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e16, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e16, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
