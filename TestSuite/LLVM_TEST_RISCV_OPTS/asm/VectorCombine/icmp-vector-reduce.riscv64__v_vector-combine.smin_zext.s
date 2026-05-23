# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: smin_zext
# src = pre-opt (smin_zext), tgt = post-opt (smin_zext)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
	lui	a0, 8
	addi	a0, a0, -1
                                        # implicit-def: $v8
	vand.vx	v8, v9, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v9, v8
                                        # implicit-def: $v8
	vredmin.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end17:
	.size	src, .Lfunc_end17-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
	lui	a0, 8
	addi	a0, a0, -1
                                        # implicit-def: $v9
	vand.vx	v9, v8, a0
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredmin.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end17:
	.size	tgt, .Lfunc_end17-tgt
	.cfi_endproc
                                        # -- End function
