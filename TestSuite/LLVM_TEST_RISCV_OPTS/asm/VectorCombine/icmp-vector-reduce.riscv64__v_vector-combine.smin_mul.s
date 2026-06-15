# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: smin_mul
# src = pre-opt (smin_mul), tgt = post-opt (smin_mul)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e16, mf2, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
	li	a0, 7
                                        # implicit-def: $v9
	vwmulu.vx	v9, v8, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredmin.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end20:
	.size	src, .Lfunc_end20-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
                                        # kill: def $v9 killed $v8 killed $vtype
                                        # implicit-def: $v9
	vzext.vf2	v9, v8
                                        # implicit-def: $v8
	vredmin.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end20:
	.size	tgt, .Lfunc_end20-tgt
	.cfi_endproc
                                        # -- End function
