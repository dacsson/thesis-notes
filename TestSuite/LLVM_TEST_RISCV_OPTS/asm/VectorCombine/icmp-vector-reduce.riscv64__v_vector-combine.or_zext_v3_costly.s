# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: or_zext_v3_costly
# src = pre-opt (or_zext_v3_costly), tgt = post-opt (or_zext_v3_costly)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
	vmset.m	v0
                                        # implicit-def: $v9
	vzext.vf4	v9, v8
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetivli	zero, 3, e32, m1, ta, ma
	vredor.vs	v8, v9, v10, v0.t
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e8, mf4, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
	vmset.m	v0
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetivli	zero, 3, e8, mf4, ta, ma
	vredor.vs	v8, v9, v10, v0.t
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
