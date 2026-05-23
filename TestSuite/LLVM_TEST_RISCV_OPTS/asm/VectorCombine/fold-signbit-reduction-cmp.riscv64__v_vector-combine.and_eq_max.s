# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: and_eq_max
# src = pre-opt (and_eq_max), tgt = post-opt (and_eq_max)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vsrl.vi	v9, v8, 31
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v9
	vmv.x.s	a0, v8
	addi	a0, a0, -1
	seqz	a0, a0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
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
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
