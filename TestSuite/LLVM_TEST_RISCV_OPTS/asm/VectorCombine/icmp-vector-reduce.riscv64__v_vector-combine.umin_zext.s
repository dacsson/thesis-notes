# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: umin_zext
# src = pre-opt (umin_zext), tgt = post-opt (umin_zext)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vzext.vf2	v9, v8
                                        # implicit-def: $v8
	vredminu.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
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
	vredminu.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
