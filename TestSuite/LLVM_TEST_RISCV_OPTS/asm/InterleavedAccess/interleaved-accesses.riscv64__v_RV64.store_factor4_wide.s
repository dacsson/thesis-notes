# Source: InterleavedAccess/interleaved-accesses.riscv64__v_RV64.ll
# Function: store_factor4_wide
# src = pre-opt (store_factor4_wide), tgt = post-opt (store_factor4_wide)
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
	vsetivli	zero, 16, e32, m4, ta, ma
	vmv2r.v	v30, v14
	vmv2r.v	v28, v12
	vmv2r.v	v26, v10
	vmv2r.v	v24, v8
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v26
                                        # implicit-def: $v16m4
	vmv2r.v	v16, v24
                                        # implicit-def: $v20m4
	vmv2r.v	v20, v30
                                        # implicit-def: $v12m4
	vmv2r.v	v12, v28
	vmv2r.v	v22, v24
	vslideup.vi	v12, v20, 8
                                        # implicit-def: $v0m8
	vmv.v.v	v0, v12
	li	a1, 32
	lui	a2, %hi(.LCPI23_0)
	addi	a2, a2, %lo(.LCPI23_0)
                                        # implicit-def: $v12m4
	vsetvli	zero, a1, e16, m4, tu, ma
	vle16.v	v12, (a2)
                                        # implicit-def: $v24m8
	vsetvli	zero, a1, e16, m4, tu, ma
	vmv4r.v	v4, v20
	vsetvli	zero, a1, e32, m8, ta, ma
	vrgatherei16.vv	v24, v0, v12
	vsetivli	zero, 16, e32, m4, ta, ma
	vmv2r.v	v10, v12
	vslideup.vi	v16, v8, 8
                                        # implicit-def: $v8m8
	vmv.v.v	v8, v16
	lui	a2, %hi(.LCPI23_1)
	addi	a2, a2, %lo(.LCPI23_1)
                                        # implicit-def: $v4m4
	vsetvli	zero, a1, e16, m4, tu, ma
	vle16.v	v4, (a2)
                                        # implicit-def: $v16m8
	vsetvli	zero, a1, e16, m4, tu, ma
	vmv4r.v	v12, v16
	addi	a2, sp, 16
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	vsetvli	zero, a1, e32, m8, ta, ma
	vrgatherei16.vv	v16, v8, v4
	lui	a2, 838861
	addi	a2, a2, -820
                                        # implicit-def: $v0
	vsetivli	zero, 1, e32, m8, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v8m8
	vsetvli	zero, a1, e32, m8, tu, ma
	vmerge.vvm	v8, v16, v24, v0
	vsetvli	zero, a1, e32, m8, ta, ma
	vse32.v	v8, (a0)
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end23:
	.size	src, .Lfunc_end23-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv2r.v	v22, v14
	vmv2r.v	v20, v12
	vmv2r.v	v18, v10
	vmv2r.v	v16, v8
                                        # implicit-def: $v8m2_v10m2_v12m2_v14m2
	vmv2r.v	v8, v16
	vmv2r.v	v10, v18
	vmv2r.v	v12, v20
	vmv2r.v	v14, v22
	vsseg4e32.v	v8, (a0)
	ret
.Lfunc_end23:
	.size	tgt, .Lfunc_end23-tgt
	.cfi_endproc
                                        # -- End function
