# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: add_ult_max
# src = pre-opt (add_ult_max), tgt = post-opt (add_ult_max)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vsrl.vi	v9, v8, 31
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	sltiu	a0, a0, 4
	ret
.Lfunc_end20:
	.size	src, .Lfunc_end20-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v9
	vmv.x.s	a0, v8
	srli	a0, a0, 63
	xori	a0, a0, 1
	ret
.Lfunc_end20:
	.size	tgt, .Lfunc_end20-tgt
	.cfi_endproc
                                        # -- End function
