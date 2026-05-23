# Source: VectorCombine/fold-equivalent-reduction-cmp.riscv64__v_vector-combine.ll
# Function: or_sgt_m1
# src = pre-opt (or_sgt_m1), tgt = post-opt (or_sgt_m1)
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
	srli	a0, a0, 63
	xori	a0, a0, 1
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
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
	srli	a0, a0, 63
	xori	a0, a0, 1
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
