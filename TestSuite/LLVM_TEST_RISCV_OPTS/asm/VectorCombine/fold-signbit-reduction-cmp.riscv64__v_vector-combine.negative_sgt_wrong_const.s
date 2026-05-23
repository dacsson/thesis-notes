# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_sgt_wrong_const
# src = pre-opt (negative_sgt_wrong_const), tgt = post-opt (negative_sgt_wrong_const)
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
	slti	a0, a0, 2
	xori	a0, a0, 1
	ret
.Lfunc_end28:
	.size	src, .Lfunc_end28-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
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
	slti	a0, a0, 2
	xori	a0, a0, 1
	ret
.Lfunc_end28:
	.size	tgt, .Lfunc_end28-tgt
	.cfi_endproc
                                        # -- End function
