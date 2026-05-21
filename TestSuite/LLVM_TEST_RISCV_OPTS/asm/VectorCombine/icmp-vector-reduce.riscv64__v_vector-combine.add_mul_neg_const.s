# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: add_mul_neg_const
# src = pre-opt (add_mul_neg_const), tgt = post-opt (add_mul_neg_const)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 1, e32, m4, tu, ma
	vmv1r.v	v10, v8
                                        # kill: def $v8 killed $v10 killed $vtype
	lui	a0, 20528
	addi	a0, a0, -253
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetivli	zero, 4, e16, mf2, ta, ma
	vsext.vf2	v8, v9
                                        # implicit-def: $v9
	vwmulsu.vv	v9, v8, v10
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
.Lfunc_end40:
	.size	src, .Lfunc_end40-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 1, e32, m4, tu, ma
	vmv1r.v	v10, v8
                                        # kill: def $v8 killed $v10 killed $vtype
	lui	a0, 20528
	addi	a0, a0, -253
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetivli	zero, 4, e16, mf2, ta, ma
	vsext.vf2	v8, v9
                                        # implicit-def: $v9
	vwmulsu.vv	v9, v8, v10
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
.Lfunc_end40:
	.size	tgt, .Lfunc_end40-tgt
	.cfi_endproc
                                        # -- End function
