# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: smax_shl
# src = pre-opt (smax_shl), tgt = post-opt (smax_shl)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v8
                                        # kill: def $v11 killed $v9 killed $vtype
                                        # kill: def $v8 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vzext.vf2	v8, v10
                                        # implicit-def: $v10
	vand.vi	v10, v9, 7
                                        # implicit-def: $v9
	vsll.vv	v9, v8, v10
                                        # implicit-def: $v8
	vredmax.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end26:
	.size	src, .Lfunc_end26-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vzext.vf2	v9, v8
                                        # implicit-def: $v8
	vredmax.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end26:
	.size	tgt, .Lfunc_end26-tgt
	.cfi_endproc
                                        # -- End function
