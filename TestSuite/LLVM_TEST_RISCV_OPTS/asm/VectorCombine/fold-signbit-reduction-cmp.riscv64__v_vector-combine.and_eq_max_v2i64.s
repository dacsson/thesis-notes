# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: and_eq_max_v2i64
# src = pre-opt (and_eq_max_v2i64), tgt = post-opt (and_eq_max_v2i64)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 2, e64, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
	li	a0, 63
                                        # implicit-def: $v9
	vsrl.vx	v9, v8, a0
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v9
	vmv.x.s	a0, v8
	addi	a0, a0, -1
	seqz	a0, a0
	ret
.Lfunc_end24:
	.size	src, .Lfunc_end24-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 2, e64, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v9
	vmv.x.s	a0, v8
	srli	a0, a0, 63
	ret
.Lfunc_end24:
	.size	tgt, .Lfunc_end24-tgt
	.cfi_endproc
                                        # -- End function
