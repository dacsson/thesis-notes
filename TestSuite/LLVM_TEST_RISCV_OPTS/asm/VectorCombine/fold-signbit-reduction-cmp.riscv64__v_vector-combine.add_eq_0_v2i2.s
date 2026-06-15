# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: add_eq_0_v2i2
# src = pre-opt (add_eq_0_v2i2), tgt = post-opt (add_eq_0_v2i2)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 2, e8, mf8, ta, ma
	vmv1r.v	v10, v8
                                        # kill: def $v9 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vand.vi	v8, v10, 3
                                        # implicit-def: $v9
	vsrl.vi	v9, v8, 1
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf8, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf8, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 3
	seqz	a0, a0
	ret
.Lfunc_end38:
	.size	src, .Lfunc_end38-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 2, e8, mf8, ta, ma
	vmv1r.v	v10, v8
                                        # kill: def $v9 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vand.vi	v8, v10, 3
                                        # implicit-def: $v9
	vsrl.vi	v9, v8, 1
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf8, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf8, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 3
	seqz	a0, a0
	ret
.Lfunc_end38:
	.size	tgt, .Lfunc_end38-tgt
	.cfi_endproc
                                        # -- End function
