# Source: InterleavedAccess/interleaved-accesses.riscv32__v_RV32.ll
# Function: store_factor4
# src = pre-opt (store_factor4), tgt = post-opt (store_factor4)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv1r.v	v19, v11
	vmv1r.v	v18, v10
	vmv1r.v	v17, v9
	vmv1r.v	v16, v8
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v17
                                        # implicit-def: $v12m2
	vmv1r.v	v12, v16
                                        # implicit-def: $v14m2
	vmv1r.v	v14, v19
                                        # implicit-def: $v10m2
	vmv1r.v	v10, v18
	vmv1r.v	v15, v16
	vslideup.vi	v10, v14, 4
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v10
	lui	a1, %hi(.LCPI18_0)
	addi	a1, a1, %lo(.LCPI18_0)
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vle16.v	v10, (a1)
                                        # implicit-def: $v16m4
	vmv2r.v	v22, v14
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v16, v20, v10
	vmv1r.v	v9, v10
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v12, v8, 4
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v12
	lui	a1, %hi(.LCPI18_1)
	addi	a1, a1, %lo(.LCPI18_1)
                                        # implicit-def: $v20m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vle16.v	v20, (a1)
                                        # implicit-def: $v12m4
	vmv2r.v	v10, v22
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v12, v8, v20
	lui	a1, 13
	addi	a1, a1, -820
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v8, v12, v16, v0
	vse32.v	v8, (a0)
	ret
.Lfunc_end18:
	.size	src, .Lfunc_end18-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v15, v11
	vmv1r.v	v14, v10
	vmv1r.v	v13, v9
	vmv1r.v	v12, v8
                                        # implicit-def: $v8_v9_v10_v11
	vmv1r.v	v8, v12
	vmv1r.v	v9, v13
	vmv1r.v	v10, v14
	vmv1r.v	v11, v15
	vsseg4e32.v	v8, (a0)
	ret
.Lfunc_end18:
	.size	tgt, .Lfunc_end18-tgt
	.cfi_endproc
                                        # -- End function
