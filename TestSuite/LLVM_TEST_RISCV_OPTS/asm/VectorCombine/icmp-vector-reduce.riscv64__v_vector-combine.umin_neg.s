# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: umin_neg
# src = pre-opt (umin_neg), tgt = post-opt (umin_neg)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vrsub.vi	v9, v8, 0
                                        # implicit-def: $v8
	vredminu.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
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
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
