# Source: InterleavedAccess/zve32x.riscv64__zve64x__zvl128b_interleaved-access_ZVE64X.ll
# Function: load_large_vector
# src = pre-opt (load_large_vector), tgt = post-opt (load_large_vector)
# Triple: riscv64, Attrs: +zve64x,+zvl128b
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
                                        # implicit-def: $v24m8
	vsetivli	zero, 12, e8, m1, tu, ma
	vle64.v	v24, (a0)
	vmv4r.v	v20, v24
	li	a0, 73
                                        # implicit-def: $v8
	vmv.s.x	v8, a0
                                        # implicit-def: $v16m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vcompress.vm	v16, v20, v8
                                        # implicit-def: $v8m8
	vsetivli	zero, 8, e64, m8, ta, ma
	vslidedown.vi	v8, v24, 8
	vmv4r.v	v12, v8
                                        # implicit-def: $v24m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vrgather.vi	v24, v12, 1
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
	addi	a0, sp, 16
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vmerge.vvm	v8, v16, v24, v0
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # kill: def $v8m2 killed $v8m2 killed $v8m4 killed $vtype
	li	a0, 146
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vcompress.vm	v16, v20, v10
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vrgather.vi	v20, v12, 2
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v12, v16, v20, v0
	vmv2r.v	v10, v12
	vsetivli	zero, 4, e64, m2, ta, ma
	vmsne.vv	v0, v8, v10
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
                                        # implicit-def: $v12m2_v14m2_v16m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vlseg3e64.v	v12, (a0)
	vmv2r.v	v10, v14
	vmv2r.v	v8, v12
	vmsne.vv	v0, v8, v10
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
