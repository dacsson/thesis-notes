# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_multi_op_mismatch
# src = pre-opt (negative_multi_op_mismatch), tgt = post-opt (negative_multi_op_mismatch)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v8
                                        # kill: def $v11 killed $v9 killed $vtype
                                        # kill: def $v8 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vsrl.vi	v8, v10, 31
                                        # implicit-def: $v10
	vsrl.vi	v10, v9, 31
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end72:
	.size	src, .Lfunc_end72-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v8
                                        # kill: def $v11 killed $v9 killed $vtype
                                        # kill: def $v8 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vsrl.vi	v8, v10, 31
                                        # implicit-def: $v10
	vsrl.vi	v10, v9, 31
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end72:
	.size	tgt, .Lfunc_end72-tgt
	.cfi_endproc
                                        # -- End function
