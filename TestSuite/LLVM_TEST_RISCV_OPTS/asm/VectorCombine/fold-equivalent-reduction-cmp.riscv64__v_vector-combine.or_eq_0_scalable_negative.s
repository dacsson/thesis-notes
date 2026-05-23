# Source: VectorCombine/fold-equivalent-reduction-cmp.riscv64__v_vector-combine.ll
# Function: or_eq_0_scalable_negative
# src = pre-opt (or_eq_0_scalable_negative), tgt = post-opt (or_eq_0_scalable_negative)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetvli	a0, zero, e32, m2, ta, ma
	vmv2r.v	v10, v8
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vredor.vs	v8, v10, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end27:
	.size	src, .Lfunc_end27-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a0, zero, e32, m2, ta, ma
	vmv2r.v	v10, v8
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vredor.vs	v8, v10, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end27:
	.size	tgt, .Lfunc_end27-tgt
	.cfi_endproc
                                        # -- End function
