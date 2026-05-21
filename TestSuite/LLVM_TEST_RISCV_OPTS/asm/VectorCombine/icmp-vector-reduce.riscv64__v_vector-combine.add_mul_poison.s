# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: add_mul_poison
# src = pre-opt (add_mul_poison), tgt = post-opt (add_mul_poison)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vzext.vf2	v8, v9
                                        # implicit-def: $v9
	vid.v	v9
                                        # implicit-def: $v10
	vadd.vi	v10, v9, 1
                                        # implicit-def: $v9
	vmul.vv	v9, v8, v10
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
.Lfunc_end38:
	.size	src, .Lfunc_end38-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end38:
	.size	tgt, .Lfunc_end38-tgt
	.cfi_endproc
                                        # -- End function
