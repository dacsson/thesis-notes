# Source: InterleavedAccess/interleaved-accesses.riscv32__v_RV32.ll
# Function: store_factor4_vscale
# src = pre-opt (store_factor4_vscale), tgt = post-opt (store_factor4_vscale)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	slli	a1, a1, 2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 4 * vlenb
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v12, v11
	vmv1r.v	v13, v10
	vmv1r.v	v14, v9
	vmv1r.v	v15, v8
                                        # implicit-def: $v8_v9_v10_v11
	vmv1r.v	v8, v15
	vmv1r.v	v9, v14
	vmv1r.v	v10, v13
	vmv1r.v	v11, v12
	addi	a2, sp, 16
	vsseg4e8.v	v8, (a2)
	csrr	a4, vlenb
	add	a1, a2, a4
	add	a3, a1, a4
                                        # implicit-def: $v8
	vle8.v	v8, (a3)
                                        # implicit-def: $v12m2
	vmv.v.v	v12, v8
	add	a3, a3, a4
                                        # implicit-def: $v8
	vle8.v	v8, (a3)
	vmv.v.v	v13, v8
                                        # implicit-def: $v8
	vle8.v	v8, (a2)
                                        # implicit-def: $v14m2
	vmv.v.v	v14, v8
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
	vmv.v.v	v15, v8
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v14
	vmv2r.v	v10, v12
	vsetvli	a1, zero, e8, m4, ta, ma
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end19:
	.size	src, .Lfunc_end19-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v12, v11
	vmv1r.v	v13, v10
	vmv1r.v	v14, v9
	vmv1r.v	v15, v8
                                        # implicit-def: $v8_v9_v10_v11
	vmv1r.v	v8, v15
	vmv1r.v	v9, v14
	vmv1r.v	v10, v13
	vmv1r.v	v11, v12
	vsseg4e8.v	v8, (a0)
	ret
.Lfunc_end19:
	.size	tgt, .Lfunc_end19-tgt
	.cfi_endproc
                                        # -- End function
