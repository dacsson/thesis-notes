# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: load_store_factor4
# src = pre-opt (load_store_factor4), tgt = post-opt (load_store_factor4)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 5
	add	a2, a1, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a2)
	addi	a1, a1, 1
	sd	a1, 0(a2)
	ld	a1, 8(a2)
	addi	a1, a1, 2
	sd	a1, 8(a2)
	ld	a1, 16(a2)
	addi	a1, a1, 3
	sd	a1, 16(a2)
	ld	a1, 24(a2)
	addi	a1, a1, 4
	sd	a1, 24(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
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
	slli	a1, a1, 3
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 8 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 5
	add	a1, a1, a2
                                        # implicit-def: $v16m8
	vsetivli	zero, 16, e64, m8, tu, ma
	vle64.v	v16, (a1)
	vmv4r.v	v28, v16
                                        # implicit-def: $v8m8
	vsetivli	zero, 8, e64, m8, ta, ma
	vslidedown.vi	v8, v16, 8
                                        # kill: def $v8m4 killed $v8m4 killed $v8m8 killed $vtype
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 32
	vs4r.v	v8, (a2)                        # vscale x 32-byte Folded Spill
                                        # implicit-def: $v24m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vslidedown.vi	v24, v8, 1
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 4
	addi	a2, sp, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
	vmv4r.v	v20, v24
	vsetivli	zero, 8, e64, m4, ta, mu
	vslideup.vi	v20, v8, 2, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 2
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
	vmv4r.v	v16, v28
	vsetivli	zero, 8, e64, m4, ta, mu
	vslidedown.vi	v16, v16, 3, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 12
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v12m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vmerge.vvm	v12, v16, v20, v0
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vmv2r.v	v16, v12
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e64, m4, ta, mu
	vslidedown.vi	v20, v28, 1
	vslidedown.vi	v20, v28, 4, v0.t
	addi	a2, sp, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v4m4
	vslidedown.vi	v4, v8, 2
	vslideup.vi	v4, v8, 1, v0.t
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v12, v20, v4, v0
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vmv2r.v	v14, v12
                                        # implicit-def: $v4m4
	vsetvli	zero, zero, e64, m4, ta, mu
	vslidedown.vi	v4, v28, 2
	vslidedown.vi	v4, v28, 5, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
	vsetivli	zero, 8, e64, m4, ta, mu
	vslidedown.vi	v8, v8, 3, v0.t
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v20, v4, v8, v0
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 32
	vl4r.v	v8, (a2)                        # vscale x 32-byte Folded Reload
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vmv2r.v	v12, v20
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e64, m4, ta, mu
	vslidedown.vi	v20, v28, 3
	vslidedown.vi	v20, v28, 6, v0.t
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vslidedown.vi	v24, v8, 4, v0.t
	csrr	a2, vlenb
	slli	a3, a2, 3
	sub	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v8, v20, v24, v0
                                        # kill: def $v8m2 killed $v8m2 killed $v8m4 killed $vtype
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vadd.vi	v10, v16, 1
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v10
                                        # implicit-def: $v10m2
	vadd.vi	v10, v14, 2
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v10
                                        # implicit-def: $v10m2
	vadd.vi	v10, v12, 3
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v10
                                        # implicit-def: $v12m2
	vadd.vi	v12, v8, 4
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v12
	vmv2r.v	v10, v12
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v20, v8, 4
                                        # implicit-def: $v8m8
	vmv.v.v	v8, v20
	vmv2r.v	v18, v20
	vslideup.vi	v24, v16, 4
                                        # implicit-def: $v16m8
	vmv.v.v	v16, v24
	vmv4r.v	v12, v24
	vsetivli	zero, 16, e64, m8, ta, ma
	vslideup.vi	v16, v8, 8
	lui	a2, %hi(.LCPI4_0)
	addi	a2, a2, %lo(.LCPI4_0)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, tu, ma
	vle8.v	v8, (a2)
                                        # implicit-def: $v24m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vsext.vf2	v24, v8
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
	vse64.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
