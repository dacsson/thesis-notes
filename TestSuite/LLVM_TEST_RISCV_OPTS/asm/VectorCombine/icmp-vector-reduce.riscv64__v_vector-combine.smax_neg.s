# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: smax_neg
# src = pre-opt (smax_neg), tgt = post-opt (smax_neg)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv1r.v	v10, v8
                                        # kill: def $v8 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vmv.v.i	v8, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, ta, ma
	vwsubu.vv	v9, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredmax.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end24:
	.size	src, .Lfunc_end24-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv1r.v	v10, v8
                                        # kill: def $v8 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vmv.v.i	v8, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, ta, ma
	vwsubu.vv	v9, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredmax.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end24:
	.size	tgt, .Lfunc_end24-tgt
	.cfi_endproc
                                        # -- End function
