# Source: InterleavedAccess/interleaved-accesses.riscv32__v_RV32.ll
# Function: store_factor6_vscale
# src = pre-opt (store_factor6_vscale), tgt = post-opt (store_factor6_vscale)
# Triple: riscv32, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x0e, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 14 * vlenb
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v14, v13
	vmv1r.v	v15, v12
	vmv1r.v	v16, v11
	vmv1r.v	v17, v10
	vmv1r.v	v18, v9
	vmv1r.v	v19, v8
	sw	a0, 8(sp)                       # 4-byte Folded Spill
                                        # implicit-def: $v8_v9_v10_v11_v12_v13
	vmv1r.v	v8, v19
	vmv1r.v	v9, v18
	vmv1r.v	v10, v17
	vmv1r.v	v11, v16
	vmv1r.v	v12, v15
	vmv1r.v	v13, v14
	csrr	a3, vlenb
	slli	a3, a3, 3
	add	a3, sp, a3
	addi	a3, a3, 16
	vsseg6e8.v	v8, (a3)
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
                                        # implicit-def: $v16
	vle8.v	v16, (a1)
                                        # implicit-def: $v20m2
	vmv.v.v	v20, v16
	add	a1, a1, a0
                                        # implicit-def: $v16
	vle8.v	v16, (a1)
	vmv.v.v	v21, v16
                                        # implicit-def: $v16m4
	vmv2r.v	v16, v20
	vmv4r.v	v12, v16
	addi	a1, sp, 16
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	li	a1, 6
	call	__mulsi3
	addi	a1, sp, 16
	vl8r.v	v8, (a1)                        # vscale x 64-byte Folded Reload
	mv	a1, a0
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	vsetvli	zero, a1, e8, m8, ta, ma
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end24:
	.size	src, .Lfunc_end24-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v14, v13
	vmv1r.v	v15, v12
	vmv1r.v	v16, v11
	vmv1r.v	v17, v10
	vmv1r.v	v18, v9
	vmv1r.v	v19, v8
                                        # implicit-def: $v8_v9_v10_v11_v12_v13
	vmv1r.v	v8, v19
	vmv1r.v	v9, v18
	vmv1r.v	v10, v17
	vmv1r.v	v11, v16
	vmv1r.v	v12, v15
	vmv1r.v	v13, v14
	vsseg6e8.v	v8, (a0)
	ret
.Lfunc_end24:
	.size	tgt, .Lfunc_end24-tgt
	.cfi_endproc
                                        # -- End function
