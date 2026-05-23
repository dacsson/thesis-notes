# Source: VectorCombine/fold-equivalent-reduction-cmp.riscv64__v_vector-combine.ll
# Function: or_ult_0_negative
# src = pre-opt (or_ult_0_negative), tgt = post-opt (or_ult_0_negative)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end25:
	.size	src, .Lfunc_end25-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end25:
	.size	tgt, .Lfunc_end25-tgt
	.cfi_endproc
                                        # -- End function
