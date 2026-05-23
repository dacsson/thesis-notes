# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_wrong_cmp_const
# src = pre-opt (negative_wrong_cmp_const), tgt = post-opt (negative_wrong_cmp_const)
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
	addi	a0, a0, -2
	seqz	a0, a0
	ret
.Lfunc_end26:
	.size	src, .Lfunc_end26-src
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
	addi	a0, a0, -2
	seqz	a0, a0
	ret
.Lfunc_end26:
	.size	tgt, .Lfunc_end26-tgt
	.cfi_endproc
                                        # -- End function
