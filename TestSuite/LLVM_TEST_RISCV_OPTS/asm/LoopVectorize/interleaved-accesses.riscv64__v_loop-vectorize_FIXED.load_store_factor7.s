# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: load_store_factor7
# src = pre-opt (load_store_factor7), tgt = post-opt (load_store_factor7)
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
	j	.LBB7_1
.LBB7_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	slli	a2, a0, 6
	sub	a2, a2, a3
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
	ld	a1, 32(a2)
	addi	a1, a1, 5
	sd	a1, 32(a2)
	ld	a1, 40(a2)
	addi	a1, a1, 6
	sd	a1, 40(a2)
	ld	a1, 48(a2)
	addi	a1, a1, 7
	sd	a1, 48(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_2
.LBB7_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -384
	.cfi_def_cfa_offset 384
	sd	ra, 376(sp)                     # 8-byte Folded Spill
	sd	s0, 368(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 384
	.cfi_def_cfa s0, 0
	andi	sp, sp, -128
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	j	.LBB7_2
.LBB7_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	slli	a3, a0, 3
	slli	a2, a0, 6
	sub	a2, a2, a3
	add	a1, a1, a2
                                        # implicit-def: $v16m8
	vsetivli	zero, 14, e64, m8, tu, ma
	vle64.v	v16, (a1)
	vmv1r.v	v9, v16
	vmv2r.v	v10, v16
	vmv4r.v	v24, v16
                                        # implicit-def: $v12m4
	vsetivli	zero, 4, e64, m4, ta, ma
	vslidedown.vi	v12, v24, 4
	vmv2r.v	v14, v12
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 2
	vmv2r.v	v12, v10
	vsetivli	zero, 4, e64, m2, ta, mu
	vslidedown.vi	v12, v14, 2, v0.t
	vmv1r.v	v15, v12
                                        # implicit-def: $v8
	vsetivli	zero, 1, e64, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a2, v8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, a2
	addi	a2, sp, 128
	vsetivli	zero, 16, e64, m8, ta, ma
	vse64.v	v16, (a2)
	ld	a2, 192(sp)
                                        # implicit-def: $v14
	vsetivli	zero, 2, e64, m1, tu, ma
	vslide1down.vx	v14, v8, a2
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v10, 2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a2, v8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, a2
	ld	a2, 200(sp)
                                        # implicit-def: $v13
	vslide1down.vx	v13, v8, a2
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v10, 3
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a2, v8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, a2
	ld	a2, 208(sp)
                                        # implicit-def: $v12
	vslide1down.vx	v12, v8, a2
	ld	a2, 160(sp)
                                        # implicit-def: $v8
	vmv.v.x	v8, a2
	ld	a2, 216(sp)
                                        # implicit-def: $v11
	vslide1down.vx	v11, v8, a2
	ld	a2, 168(sp)
                                        # implicit-def: $v8
	vmv.v.x	v8, a2
	ld	a2, 224(sp)
                                        # implicit-def: $v10
	vslide1down.vx	v10, v8, a2
	ld	a2, 176(sp)
                                        # implicit-def: $v9
	vmv.v.x	v9, a2
	ld	a2, 232(sp)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vsetvli	zero, zero, e64, m1, ta, ma
	vadd.vi	v9, v15, 1
                                        # implicit-def: $v18m2
	vmv.v.v	v18, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v14, 2
                                        # implicit-def: $v22m2
	vmv.v.v	v22, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v13, 3
                                        # implicit-def: $v20m2
	vmv.v.v	v20, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v12, 4
                                        # implicit-def: $v16m2
	vmv.v.v	v16, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v11, 5
                                        # implicit-def: $v12m2
	vmv.v.v	v12, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v10, 6
                                        # implicit-def: $v14m2
	vmv.v.v	v14, v9
                                        # implicit-def: $v24
	vadd.vi	v24, v8, 7
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v24
	vmv1r.v	v23, v24
	vsetivli	zero, 4, e64, m2, ta, ma
	vslideup.vi	v18, v22, 2
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v18
	vmv1r.v	v17, v18
	vslideup.vi	v20, v16, 2
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v20
	vmv2r.v	v18, v20
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v24, v16, 4
                                        # implicit-def: $v16m8
	vmv.v.v	v16, v24
	vmv1r.v	v15, v24
	vsetivli	zero, 4, e64, m2, ta, ma
	vslideup.vi	v12, v14, 2
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v12
	vmv2r.v	v10, v12
	vmv1r.v	v9, v12
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v24, v8, 4
                                        # implicit-def: $v8m8
	vmv.v.v	v8, v24
	vmv4r.v	v12, v24
	vsetivli	zero, 16, e64, m8, ta, ma
	vslideup.vi	v16, v8, 8
	lui	a2, %hi(.LCPI7_0)
	addi	a2, a2, %lo(.LCPI7_0)
                                        # implicit-def: $v24m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vle16.v	v24, (a2)
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
	vsetivli	zero, 14, e64, m8, ta, ma
	vse64.v	v8, (a1)
	addi	a0, a0, 2
	li	a1, 1024
	mv	a2, a0
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB7_2
	j	.LBB7_3
.LBB7_3:                                # %middle.block
	j	.LBB7_4
.LBB7_4:                                # %exit
	addi	sp, s0, -384
	.cfi_def_cfa sp, 384
	ld	ra, 376(sp)                     # 8-byte Folded Reload
	ld	s0, 368(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 384
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
