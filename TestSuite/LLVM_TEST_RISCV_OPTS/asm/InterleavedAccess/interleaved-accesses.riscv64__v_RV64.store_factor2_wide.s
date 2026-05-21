# Source: InterleavedAccess/interleaved-accesses.riscv64__v_RV64.ll
# Function: store_factor2_wide
# src = pre-opt (store_factor2_wide), tgt = post-opt (store_factor2_wide)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv2r.v	v12, v10
	vmv2r.v	v14, v8
                                        # kill: def $v10m2 killed $v12m2 killed $vtype
                                        # kill: def $v8m2 killed $v14m2 killed $vtype
                                        # implicit-def: $v8m4
	vwaddu.vv	v8, v14, v12
	li	a1, -1
	vwmaccu.vx	v8, a1, v12
	vsetivli	zero, 16, e32, m4, ta, ma
	vse32.v	v8, (a0)
	ret
.Lfunc_end21:
	.size	src, .Lfunc_end21-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv2r.v	v14, v10
	vmv2r.v	v12, v8
                                        # implicit-def: $v8m2_v10m2
	vmv2r.v	v8, v12
	vmv2r.v	v10, v14
	vsseg2e32.v	v8, (a0)
	ret
.Lfunc_end21:
	.size	tgt, .Lfunc_end21-tgt
	.cfi_endproc
                                        # -- End function
