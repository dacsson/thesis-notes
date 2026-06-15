# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: add_neg
# src = pre-opt (add_neg), tgt = post-opt (add_neg)
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
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end29:
	.size	src, .Lfunc_end29-src
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
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end29:
	.size	tgt, .Lfunc_end29-tgt
	.cfi_endproc
                                        # -- End function
