# Source: VectorCombine/vecreduce-of-cast.riscv64__v_vector-combine.ll
# Function: reduce_mul_trunc_v8i64_i16
# src = pre-opt (reduce_mul_trunc_v8i64_i16), tgt = post-opt (reduce_mul_trunc_v8i64_i16)
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
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, m1, ta, ma
	vnsrl.wi	v9, v10, 0
                                        # implicit-def: $v10
	vslidedown.vi	v10, v9, 4
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
                                        # implicit-def: $v10
	vslidedown.vi	v10, v8, 2
                                        # implicit-def: $v9
	vmul.vv	v9, v8, v10
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 1
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv4r.v	v12, v8
                                        # kill: def $v8m4 killed $v12m4 killed $vtype
                                        # implicit-def: $v10m2
	vnsrl.wi	v10, v12, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, m1, ta, ma
	vnsrl.wi	v9, v10, 0
                                        # implicit-def: $v10
	vslidedown.vi	v10, v9, 4
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
                                        # implicit-def: $v10
	vslidedown.vi	v10, v8, 2
                                        # implicit-def: $v9
	vmul.vv	v9, v8, v10
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 1
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
