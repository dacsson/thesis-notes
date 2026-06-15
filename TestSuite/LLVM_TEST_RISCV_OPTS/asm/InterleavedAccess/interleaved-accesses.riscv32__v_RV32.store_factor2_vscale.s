# Source: InterleavedAccess/interleaved-accesses.riscv32__v_RV32.ll
# Function: store_factor2_vscale
# src = pre-opt (store_factor2_vscale), tgt = post-opt (store_factor2_vscale)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v10m2
	vsetvli	a1, zero, e8, m1, ta, ma
	vwaddu.vv	v10, v8, v9
	li	a1, -1
	vwmaccu.vx	v10, a1, v9
	vmv1r.v	v12, v10
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v12
	vmv1r.v	v10, v11
	vmv1r.v	v9, v10
	vsetvli	a1, zero, e8, m2, ta, ma
	vse8.v	v8, (a0)
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v10, v9
	vmv1r.v	v11, v8
                                        # implicit-def: $v8_v9
	vmv1r.v	v8, v11
	vmv1r.v	v9, v10
	vsseg2e8.v	v8, (a0)
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
