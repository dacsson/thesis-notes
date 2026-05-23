# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: i1_umax_eq_0
# src = pre-opt (i1_umax_eq_0), tgt = post-opt (i1_umax_eq_0)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e8, mf4, ta, ma
                                        # kill: def $v8 killed $v0 killed $vtype
	vcpop.m	a0, v0
	seqz	a0, a0
	ret
.Lfunc_end46:
	.size	src, .Lfunc_end46-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e8, mf4, ta, ma
                                        # kill: def $v8 killed $v0 killed $vtype
	vcpop.m	a0, v0
	seqz	a0, a0
	ret
.Lfunc_end46:
	.size	tgt, .Lfunc_end46-tgt
	.cfi_endproc
                                        # -- End function
