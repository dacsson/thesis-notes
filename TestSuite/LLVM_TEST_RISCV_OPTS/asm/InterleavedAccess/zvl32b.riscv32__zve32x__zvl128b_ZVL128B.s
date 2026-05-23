# Source: InterleavedAccess/zvl32b.riscv32__zve32x__zvl128b_ZVL128B.ll
# Function: load_factor2_large
# src = pre-opt (load_factor2_large), tgt = post-opt (load_factor2_large)
# Triple: riscv32, Attrs: +zve32x,+zvl128b
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	li	a1, 32
                                        # implicit-def: $v0m8
	vsetvli	zero, a1, e32, m8, tu, ma
	vle32.v	v0, (a0)
	vsetivli	zero, 16, e16, m2, ta, ma
	vmv4r.v	v12, v0
                                        # implicit-def: $v8m2
	vid.v	v8
                                        # implicit-def: $v20m2
	vadd.vv	v20, v8, v8
                                        # implicit-def: $v8m2
	vadd.vi	v8, v20, -16
                                        # implicit-def: $v24m8
	vsetivli	zero, 16, e32, m8, ta, ma
	vslidedown.vi	v24, v0, 16
	vmv4r.v	v16, v24
                                        # implicit-def: $v28m4
	vsetivli	zero, 16, e32, m4, ta, ma
	vrgatherei16.vv	v28, v16, v8
	lui	a0, 5
	addi	a0, a0, 1365
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v8, a0
                                        # implicit-def: $v24m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vcompress.vm	v24, v12, v8
	li	a0, -256
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a0
	addi	a0, sp, 16
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v8, v24, v28, v0
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v24m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vadd.vi	v24, v20, -15
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v20, v16, v24
	lui	a0, 11
	addi	a0, a0, -1366
                                        # implicit-def: $v24
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v24, a0
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vcompress.vm	v16, v12, v24
                                        # implicit-def: $v12m4
	vmerge.vvm	v12, v16, v20, v0
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v12m4_v16m4
	vsetivli	zero, 16, e32, m4, ta, ma
	vlseg2e32.v	v12, (a0)
	vmv4r.v	v8, v12
	vmv4r.v	v12, v16
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
