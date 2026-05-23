# Source: InterleavedAccess/interleaved-accesses.riscv64__v_RV64.ll
# Function: store_factor2
# src = pre-opt (store_factor2), tgt = post-opt (store_factor2)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmv1r.v	v10, v8
                                        # kill: def $v11 killed $v9 killed $vtype
                                        # kill: def $v8 killed $v10 killed $vtype
                                        # implicit-def: $v8
	vwaddu.vv	v8, v10, v9
	li	a1, -1
	vwmaccu.vx	v8, a1, v9
	vsetivli	zero, 16, e8, m1, ta, ma
	vse8.v	v8, (a0)
	ret
.Lfunc_end14:
	.size	src, .Lfunc_end14-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmv1r.v	v11, v9
	vmv1r.v	v10, v8
                                        # implicit-def: $v8_v9
	vmv1r.v	v8, v10
	vmv1r.v	v9, v11
	vsseg2e8.v	v8, (a0)
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
	.cfi_endproc
                                        # -- End function
