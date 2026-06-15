# Source: InterleavedAccess/interleaved-accesses.riscv64__v_interleaved-access_RV64.ll
# Function: store_factor5_vscale
# src = pre-opt (store_factor5_vscale), tgt = post-opt (store_factor5_vscale)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 2
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x0d, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 13 * vlenb
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v13, v12
	vmv1r.v	v14, v11
	vmv1r.v	v15, v10
	vmv1r.v	v16, v9
	vmv1r.v	v17, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8_v9_v10_v11_v12
	vmv1r.v	v8, v17
	vmv1r.v	v9, v16
	vmv1r.v	v10, v15
	vmv1r.v	v11, v14
	vmv1r.v	v12, v13
	csrr	a3, vlenb
	slli	a3, a3, 3
	add	a3, sp, a3
	addi	a3, a3, 32
	vsseg5e8.v	v8, (a3)
	csrr	a0, vlenb
	add	a2, a3, a0
	add	a1, a2, a0
                                        # implicit-def: $v10
	vle8.v	v10, (a1)
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
	add	a1, a1, a0
                                        # implicit-def: $v10
	vle8.v	v10, (a1)
	vmv.v.v	v9, v10
                                        # implicit-def: $v12
	vle8.v	v12, (a3)
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
                                        # implicit-def: $v12
	vle8.v	v12, (a2)
	vmv.v.v	v11, v12
                                        # implicit-def: $v16m4
	vmv2r.v	v16, v10
	vmv2r.v	v18, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v16
	add	a1, a1, a0
                                        # implicit-def: $v20
	vle8.v	v20, (a1)
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v20
	vmv4r.v	v12, v16
	addi	a1, sp, 32
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	li	a1, 5
	call	__muldi3
	addi	a1, sp, 32
	vl8r.v	v8, (a1)                        # vscale x 64-byte Folded Reload
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	vsetvli	zero, a1, e8, m8, ta, ma
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 2
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end20:
	.size	src, .Lfunc_end20-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v13, v12
	vmv1r.v	v14, v11
	vmv1r.v	v15, v10
	vmv1r.v	v16, v9
	vmv1r.v	v17, v8
                                        # implicit-def: $v8_v9_v10_v11_v12
	vmv1r.v	v8, v17
	vmv1r.v	v9, v16
	vmv1r.v	v10, v15
	vmv1r.v	v11, v14
	vmv1r.v	v12, v13
	vsseg5e8.v	v8, (a0)
	ret
.Lfunc_end20:
	.size	tgt, .Lfunc_end20-tgt
	.cfi_endproc
                                        # -- End function
