# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_multi_overflow
# src = pre-opt (negative_multi_overflow), tgt = post-opt (negative_multi_overflow)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmv1r.v	v10, v9
	vmv1r.v	v12, v8
                                        # kill: def $v11 killed $v10 killed $vtype
                                        # kill: def $v8 killed $v12 killed $vtype
                                        # implicit-def: $v9
	vand.vi	v9, v10, 3
                                        # implicit-def: $v10
	vand.vi	v10, v12, 3
                                        # implicit-def: $v8
	vsrl.vi	v8, v10, 1
                                        # implicit-def: $v10
	vsrl.vi	v10, v9, 1
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 3
	seqz	a0, a0
	ret
.Lfunc_end69:
	.size	src, .Lfunc_end69-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmv1r.v	v10, v9
	vmv1r.v	v12, v8
                                        # kill: def $v11 killed $v10 killed $vtype
                                        # kill: def $v8 killed $v12 killed $vtype
                                        # implicit-def: $v9
	vand.vi	v9, v10, 3
                                        # implicit-def: $v10
	vand.vi	v10, v12, 3
                                        # implicit-def: $v8
	vsrl.vi	v8, v10, 1
                                        # implicit-def: $v10
	vsrl.vi	v10, v9, 1
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	andi	a0, a0, 3
	seqz	a0, a0
	ret
.Lfunc_end69:
	.size	tgt, .Lfunc_end69-tgt
	.cfi_endproc
                                        # -- End function
