# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: load_store_factor2_i64
# src = pre-opt (load_store_factor2_i64), tgt = post-opt (load_store_factor2_i64)
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
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 4
	add	a2, a1, a2
	ld	a1, 0(a2)
	addi	a1, a1, 1
	sd	a1, 0(a2)
	ld	a1, 8(a2)
	addi	a1, a1, 2
	sd	a1, 8(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	slli	a1, a1, 1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 4
	add	a1, a1, a2
                                        # implicit-def: $v16m4
	vsetivli	zero, 8, e64, m4, tu, ma
	vle64.v	v16, (a1)
	vmv2r.v	v14, v16
                                        # implicit-def: $v8m4
	vsetivli	zero, 4, e64, m4, ta, ma
	vslidedown.vi	v8, v16, 4
                                        # kill: def $v8m2 killed $v8m2 killed $v8m4 killed $vtype
                                        # implicit-def: $v16m2
	vsetivli	zero, 4, e64, m2, ta, ma
	vslideup.vi	v16, v8, 2
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
	vsetivli	zero, 4, e64, m2, ta, mu
	vslideup.vi	v16, v8, 1, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 2
	addi	a2, sp, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
	vmv2r.v	v10, v14
	vsetivli	zero, 4, e64, m2, ta, mu
	vslidedown.vi	v10, v10, 1, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 12
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 32
	vs1r.v	v0, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v12m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmerge.vvm	v12, v10, v16, v0
	addi	a2, sp, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, ta, mu
	vslidedown.vi	v10, v14, 1
	vslidedown.vi	v10, v14, 2, v0.t
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 4
	vmv2r.v	v14, v8
	vsetivli	zero, 4, e64, m2, ta, mu
	vslideup.vi	v14, v8, 1, v0.t
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmerge.vvm	v8, v10, v14, v0
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vadd.vi	v10, v12, 1
                                        # implicit-def: $v12m4
	vmv.v.v	v12, v10
                                        # implicit-def: $v16m2
	vadd.vi	v16, v8, 2
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v16
	vmv2r.v	v10, v16
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v12, v8, 4
	lui	a2, %hi(.LCPI1_0)
	addi	a2, a2, %lo(.LCPI1_0)
                                        # implicit-def: $v16
	vsetvli	zero, zero, e16, m1, tu, ma
	vle16.v	v16, (a2)
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vrgatherei16.vv	v8, v12, v16
	vse64.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
