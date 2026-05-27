# Source: InterleavedAccess/interleaved-accesses.riscv64__v_RV64.ll
# Function: store_factor3_vscale
# src = pre-opt (store_factor3_vscale), tgt = post-opt (store_factor3_vscale)
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
	slli	a2, a1, 3
	sub	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x07, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 7 * vlenb
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v11, v10
	vmv1r.v	v12, v9
	vmv1r.v	v13, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8_v9_v10
	vmv1r.v	v8, v13
	vmv1r.v	v9, v12
	vmv1r.v	v10, v11
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 32
	vsseg3e8.v	v8, (a1)
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
                                        # implicit-def: $v12m2
	vmv.v.v	v12, v8
	csrr	a0, vlenb
	add	a1, a1, a0
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
	vmv.v.v	v13, v8
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v12
	add	a1, a1, a0
                                        # implicit-def: $v14
	vle8.v	v14, (a1)
                                        # implicit-def: $v12m2
	vmv.v.v	v12, v14
	vmv2r.v	v10, v12
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	li	a1, 3
	call	__muldi3
	addi	a1, sp, 32
	vl4r.v	v8, (a1)                        # vscale x 32-byte Folded Reload
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	vsetvli	zero, a1, e8, m4, ta, ma
	vse8.v	v8, (a0)
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end17:
	.size	src, .Lfunc_end17-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetvli	a1, zero, e8, m1, ta, ma
	vmv1r.v	v11, v10
	vmv1r.v	v12, v9
	vmv1r.v	v13, v8
                                        # implicit-def: $v8_v9_v10
	vmv1r.v	v8, v13
	vmv1r.v	v9, v12
	vmv1r.v	v10, v11
	vsseg3e8.v	v8, (a0)
	ret
.Lfunc_end17:
	.size	tgt, .Lfunc_end17-tgt
	.cfi_endproc
                                        # -- End function
