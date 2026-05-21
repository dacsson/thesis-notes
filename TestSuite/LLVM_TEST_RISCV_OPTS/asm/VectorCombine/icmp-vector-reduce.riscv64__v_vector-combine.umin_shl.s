# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: umin_shl
# src = pre-opt (umin_shl), tgt = post-opt (umin_shl)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v9
                                        # kill: def $v11 killed $v10 killed $vtype
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vsll.vv	v9, v8, v10
                                        # implicit-def: $v8
	vredminu.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredminu.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
