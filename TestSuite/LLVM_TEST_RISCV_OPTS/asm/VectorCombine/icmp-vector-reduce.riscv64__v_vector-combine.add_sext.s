# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: add_sext
# src = pre-opt (add_sext), tgt = post-opt (add_sext)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
	lui	a0, 2
	addi	a0, a0, -1
                                        # implicit-def: $v9
	vand.vx	v9, v8, a0
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vwredsumu.vs	v8, v9, v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end28:
	.size	src, .Lfunc_end28-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
	lui	a0, 2
	addi	a0, a0, -1
                                        # implicit-def: $v9
	vand.vx	v9, v8, a0
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end28:
	.size	tgt, .Lfunc_end28-tgt
	.cfi_endproc
                                        # -- End function
