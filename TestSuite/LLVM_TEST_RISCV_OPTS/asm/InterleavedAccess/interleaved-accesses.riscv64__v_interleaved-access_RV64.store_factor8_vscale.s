# Source: InterleavedAccess/interleaved-accesses.riscv64__v_interleaved-access_RV64.ll
# Function: store_factor8_vscale
# src = pre-opt (store_factor8_vscale), tgt = post-opt (store_factor8_vscale)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	slli	a1, a1, 3
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v16, v15
	vmv1r.v	v17, v14
	vmv1r.v	v18, v13
	vmv1r.v	v19, v12
	vmv1r.v	v20, v11
	vmv1r.v	v21, v10
	vmv1r.v	v22, v9
	vmv1r.v	v23, v8
                                        # implicit-def: $v8_v9_v10_v11_v12_v13_v14_v15
	vmv1r.v	v8, v23
	vmv1r.v	v9, v22
	vmv1r.v	v10, v21
	vmv1r.v	v11, v20
	vmv1r.v	v12, v19
	vmv1r.v	v13, v18
	vmv1r.v	v14, v17
	vmv1r.v	v15, v16
	addi	a2, sp, 16
	vsseg8e8.v	v8, (a2)
	csrr	t0, vlenb
	add	a1, a2, t0
	add	a4, a1, t0
	add	a3, a4, t0
	add	a6, a3, t0
	add	a5, a6, t0
	add	a7, a5, t0
                                        # implicit-def: $v10
	vle8.v	v10, (a7)
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
	add	a7, a7, t0
                                        # implicit-def: $v10
	vle8.v	v10, (a7)
	vmv.v.v	v9, v10
                                        # implicit-def: $v12
	vle8.v	v12, (a6)
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
                                        # implicit-def: $v12
	vle8.v	v12, (a5)
	vmv.v.v	v11, v12
                                        # implicit-def: $v16m4
	vmv2r.v	v16, v10
	vmv2r.v	v18, v8
                                        # implicit-def: $v10
	vle8.v	v10, (a4)
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
                                        # implicit-def: $v10
	vle8.v	v10, (a3)
	vmv.v.v	v9, v10
                                        # implicit-def: $v12
	vle8.v	v12, (a2)
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
                                        # implicit-def: $v12
	vle8.v	v12, (a1)
	vmv.v.v	v11, v12
                                        # implicit-def: $v20m4
	vmv2r.v	v20, v10
	vmv2r.v	v22, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v20
	vmv4r.v	v12, v16
	vsetvli	a1, zero, e8, m8, ta, ma
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end26:
	.size	src, .Lfunc_end26-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v16, v15
	vmv1r.v	v17, v14
	vmv1r.v	v18, v13
	vmv1r.v	v19, v12
	vmv1r.v	v20, v11
	vmv1r.v	v21, v10
	vmv1r.v	v22, v9
	vmv1r.v	v23, v8
                                        # implicit-def: $v8_v9_v10_v11_v12_v13_v14_v15
	vmv1r.v	v8, v23
	vmv1r.v	v9, v22
	vmv1r.v	v10, v21
	vmv1r.v	v11, v20
	vmv1r.v	v12, v19
	vmv1r.v	v13, v18
	vmv1r.v	v14, v17
	vmv1r.v	v15, v16
	vsseg8e8.v	v8, (a0)
	ret
.Lfunc_end26:
	.size	tgt, .Lfunc_end26-tgt
	.cfi_endproc
                                        # -- End function
