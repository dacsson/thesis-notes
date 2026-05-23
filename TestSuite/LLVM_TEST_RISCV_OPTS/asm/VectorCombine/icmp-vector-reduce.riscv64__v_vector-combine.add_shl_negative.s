# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: add_shl_negative
# src = pre-opt (add_shl_negative), tgt = post-opt (add_shl_negative)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v11 killed $v9 killed $vtype
                                        # kill: def $v10 killed $v8 killed $vtype
                                        # implicit-def: $v10
	vand.vi	v10, v9, 7
                                        # implicit-def: $v9
	vsll.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end33:
	.size	src, .Lfunc_end33-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v11 killed $v9 killed $vtype
                                        # kill: def $v10 killed $v8 killed $vtype
                                        # implicit-def: $v10
	vand.vi	v10, v9, 7
                                        # implicit-def: $v9
	vsll.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end33:
	.size	tgt, .Lfunc_end33-tgt
	.cfi_endproc
                                        # -- End function
