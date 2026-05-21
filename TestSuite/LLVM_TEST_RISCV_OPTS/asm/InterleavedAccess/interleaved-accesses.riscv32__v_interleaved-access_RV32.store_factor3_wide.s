# Source: InterleavedAccess/interleaved-accesses.riscv32__v_interleaved-access_RV32.ll
# Function: store_factor3_wide
# src = pre-opt (store_factor3_wide), tgt = post-opt (store_factor3_wide)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	slli	a1, a1, 4
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
	vsetivli	zero, 16, e32, m4, ta, ma
	vmv2r.v	v20, v12
	vmv2r.v	v18, v10
	vmv2r.v	v16, v8
                                        # implicit-def: $v8m8
	vmv2r.v	v8, v20
	addi	a1, sp, 16
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
                                        # implicit-def: $v12m4
	vmv2r.v	v12, v18
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v16
	vmv2r.v	v14, v16
	vslideup.vi	v8, v12, 8
                                        # implicit-def: $v24m8
	vmv.v.v	v24, v8
	li	a1, 32
	lui	a2, %hi(.LCPI22_0)
	addi	a2, a2, %lo(.LCPI22_0)
                                        # implicit-def: $v4m4
	vsetvli	zero, a1, e16, m4, tu, ma
	vle16.v	v4, (a2)
                                        # implicit-def: $v16m8
	vsetvli	zero, a1, e16, m4, tu, ma
	vmv4r.v	v28, v8
	addi	a2, sp, 16
	vl8r.v	v8, (a2)                        # vscale x 64-byte Folded Reload
	vsetvli	zero, a1, e32, m8, ta, ma
	vrgatherei16.vv	v16, v24, v4
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, sp, a2
	addi	a2, a2, 16
	vs8r.v	v16, (a2)                       # vscale x 64-byte Folded Spill
	lui	a2, %hi(.LCPI22_1)
	addi	a2, a2, %lo(.LCPI22_1)
                                        # implicit-def: $v6m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vle16.v	v6, (a2)
                                        # implicit-def: $v24m8
	vmv4r.v	v12, v16
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, sp, a2
	addi	a2, a2, 16
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	vmv2r.v	v10, v4
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v24, v8, v6
	lui	a2, 2341
	addi	a2, a2, -1756
                                        # implicit-def: $v0
	vsetvli	zero, zero, e32, m4, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v8m8
	vsetvli	zero, a1, e32, m8, tu, ma
	vmerge.vvm	v8, v16, v24, v0
	vsetivli	zero, 24, e32, m8, ta, ma
	vse32.v	v8, (a0)
	csrr	a0, vlenb
	slli	a0, a0, 4
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end22:
	.size	src, .Lfunc_end22-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 8, e32, m2, ta, ma
	vmv2r.v	v18, v12
	vmv2r.v	v16, v10
	vmv2r.v	v14, v8
                                        # implicit-def: $v8m2_v10m2_v12m2
	vmv2r.v	v8, v14
	vmv2r.v	v10, v16
	vmv2r.v	v12, v18
	vsseg3e32.v	v8, (a0)
	ret
.Lfunc_end22:
	.size	tgt, .Lfunc_end22-tgt
	.cfi_endproc
                                        # -- End function
