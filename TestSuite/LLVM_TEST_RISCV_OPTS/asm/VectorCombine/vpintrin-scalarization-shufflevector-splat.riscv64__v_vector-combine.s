# Source: VectorCombine/vpintrin-scalarization-shufflevector-splat.riscv64__v_vector-combine.ll
# Function: add_v4i64_allonesmask
# src = pre-opt (add_v4i64_allonesmask), tgt = post-opt (add_v4i64_allonesmask)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e64, m2, ta, ma
	vmv2r.v	v10, v8
                                        # kill: def $v8m2 killed $v10m2 killed $vtype
                                        # implicit-def: $v8m2
	vrgather.vi	v8, v10, 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e64, m2, ta, ma
	vmv2r.v	v10, v8
                                        # kill: def $v8m2 killed $v10m2 killed $vtype
                                        # implicit-def: $v8m2
	vrgather.vi	v8, v10, 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
