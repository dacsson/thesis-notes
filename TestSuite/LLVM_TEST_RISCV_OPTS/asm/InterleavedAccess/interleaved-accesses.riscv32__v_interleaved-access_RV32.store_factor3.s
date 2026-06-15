# Source: InterleavedAccess/interleaved-accesses.riscv32__v_interleaved-access_RV32.ll
# Function: store_factor3
# src = pre-opt (store_factor3), tgt = post-opt (store_factor3)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv1r.v	v14, v10
	vmv1r.v	v11, v9
	vmv1r.v	v10, v8
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v11
                                        # implicit-def: $v12m2
	vmv1r.v	v12, v10
                                        # implicit-def: $v16m4
	vmv1r.v	v16, v14
	vmv1r.v	v11, v16
                                        # implicit-def: $v0
	vmv.v.i	v0, 6
                                        # implicit-def: $v10
	vsetivli	zero, 8, e16, m1, tu, ma
	vmv.v.i	v10, 1
                                        # implicit-def: $v16
	vmerge.vim	v16, v10, 0, v0
	csrr	a1, vlenb
	srli	a1, a1, 3
                                        # implicit-def: $v14
	vsetvli	zero, zero, e16, m1, ta, ma
	vslidedown.vx	v14, v16, a1
	vmv.v.v	v15, v14
                                        # implicit-def: $v10
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v10, v11, v15
                                        # implicit-def: $v15
	vrgatherei16.vv	v15, v11, v16
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v15
	vmv.v.v	v17, v10
                                        # implicit-def: $v10
	vsetivli	zero, 8, e16, m1, ta, ma
	vslidedown.vx	v10, v14, a1
	vmv.v.v	v15, v10
                                        # implicit-def: $v14
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v14, v11, v15
	vmv.v.v	v18, v14
                                        # implicit-def: $v14
	vsetivli	zero, 8, e16, m1, ta, ma
	vslidedown.vx	v14, v10, a1
                                        # implicit-def: $v10
	vsetvli	a1, zero, e64, m1, ta, ma
	vrgatherei16.vv	v10, v11, v14
	vmv.v.v	v19, v10
	vmv1r.v	v9, v10
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v12, v8, 4
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v12
	lui	a1, %hi(.LCPI16_0)
	addi	a1, a1, %lo(.LCPI16_0)
                                        # implicit-def: $v20m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vle16.v	v20, (a1)
                                        # implicit-def: $v12m4
	vmv2r.v	v10, v22
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v12, v8, v20
	lui	a1, 1
	addi	a1, a1, -1756
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v8, v12, v16, v0
	vsetivli	zero, 12, e32, m4, ta, ma
	vse32.v	v8, (a0)
	ret
.Lfunc_end16:
	.size	src, .Lfunc_end16-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v13, v10
	vmv1r.v	v12, v9
	vmv1r.v	v11, v8
                                        # implicit-def: $v8_v9_v10
	vmv1r.v	v8, v11
	vmv1r.v	v9, v12
	vmv1r.v	v10, v13
	vsseg3e32.v	v8, (a0)
	ret
.Lfunc_end16:
	.size	tgt, .Lfunc_end16-tgt
	.cfi_endproc
                                        # -- End function
