# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: load_store_factor3_i64
# src = pre-opt (load_store_factor3_i64), tgt = post-opt (load_store_factor3_i64)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 3
	slli	a2, a0, 4
	add	a2, a2, a3
	add	a2, a1, a2
	ld	a1, 0(a2)
	addi	a1, a1, 1
	sd	a1, 0(a2)
	ld	a1, 8(a2)
	addi	a1, a1, 2
	sd	a1, 8(a2)
	ld	a1, 16(a2)
	addi	a1, a1, 3
	sd	a1, 16(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 1 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	slli	a2, a0, 4
	add	a2, a2, a3
	add	a1, a1, a2
                                        # implicit-def: $v24m8
	vsetivli	zero, 12, e8, m1, tu, ma
	vle64.v	v24, (a1)
	vmv4r.v	v20, v24
	li	a2, 73
                                        # implicit-def: $v8
	vmv.s.x	v8, a2
                                        # implicit-def: $v16m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vcompress.vm	v16, v20, v8
                                        # implicit-def: $v8m8
	vsetivli	zero, 8, e64, m8, ta, ma
	vslidedown.vi	v8, v24, 8
                                        # kill: def $v8m4 killed $v8m4 killed $v8m8 killed $vtype
                                        # implicit-def: $v24m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vrgather.vi	v24, v8, 1
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
	addi	a2, sp, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v12m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vmerge.vvm	v12, v16, v24, v0
	addi	a2, sp, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vmv2r.v	v14, v12
	li	a2, 146
                                        # implicit-def: $v12
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v12, a2
                                        # implicit-def: $v24m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vcompress.vm	v24, v20, v12
                                        # implicit-def: $v28m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vrgather.vi	v28, v8, 2
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v16, v24, v28, v0
	vmv2r.v	v12, v16
	li	a2, 36
                                        # implicit-def: $v0
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v16, v8, v20, v0
	li	a2, 3
	slli	a2, a2, 32
	addi	a2, a2, 5
	slli	a2, a2, 16
	addi	a2, a2, 2
                                        # implicit-def: $v20
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v20, a2
                                        # implicit-def: $v8m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vrgatherei16.vv	v8, v16, v20
                                        # kill: def $v8m2 killed $v8m2 killed $v8m4 killed $vtype
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vadd.vi	v10, v14, 1
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v10
                                        # implicit-def: $v10m2
	vadd.vi	v10, v12, 2
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v10
                                        # implicit-def: $v20m2
	vadd.vi	v20, v8, 3
                                        # implicit-def: $v8m8
	vmv.v.v	v8, v20
	vmv2r.v	v18, v20
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v24, v16, 4
                                        # implicit-def: $v16m8
	vmv.v.v	v16, v24
	vmv4r.v	v12, v24
	vmv2r.v	v10, v24
	vsetivli	zero, 16, e64, m8, ta, ma
	vslideup.vi	v16, v8, 8
	lui	a2, %hi(.LCPI3_0)
	addi	a2, a2, %lo(.LCPI3_0)
                                        # implicit-def: $v24m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vle16.v	v24, (a2)
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
	vsetivli	zero, 12, e64, m8, ta, ma
	vse64.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	j	.LBB3_4
.LBB3_4:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
