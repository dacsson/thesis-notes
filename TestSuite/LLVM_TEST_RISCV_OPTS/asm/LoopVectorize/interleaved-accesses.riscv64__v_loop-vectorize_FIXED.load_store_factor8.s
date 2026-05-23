# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: load_store_factor8
# src = pre-opt (load_store_factor8), tgt = post-opt (load_store_factor8)
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
	j	.LBB8_1
.LBB8_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 6
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
	ld	a1, 56(a2)
	addi	a1, a1, 8
	sd	a1, 56(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
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
	j	.LBB8_1
.LBB8_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	j	.LBB8_2
.LBB8_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	slli	a2, a0, 6
	add	a1, a1, a2
                                        # implicit-def: $v16m8
	vsetivli	zero, 16, e64, m8, tu, ma
	vle64.v	v16, (a1)
	vmv2r.v	v10, v16
	vmv1r.v	v9, v16
	addi	a2, sp, 128
	vse64.v	v16, (a2)
	vmv.x.s	a2, v9
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, a2
	ld	a2, 248(sp)
	ld	a3, 184(sp)
	ld	a4, 240(sp)
	ld	a5, 176(sp)
	ld	a6, 232(sp)
	ld	a7, 168(sp)
	ld	t0, 224(sp)
	ld	t1, 160(sp)
	ld	t2, 216(sp)
	ld	t3, 208(sp)
	ld	t4, 200(sp)
	ld	t5, 192(sp)
                                        # implicit-def: $v16
	vslide1down.vx	v16, v8, t5
                                        # implicit-def: $v8
	vsetivli	zero, 1, e64, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	t5, v8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, t5
                                        # implicit-def: $v15
	vslide1down.vx	v15, v8, t4
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v10, 2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	t4, v8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, t4
                                        # implicit-def: $v14
	vslide1down.vx	v14, v8, t3
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v10, 3
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	t3, v8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, t3
                                        # implicit-def: $v13
	vslide1down.vx	v13, v8, t2
                                        # implicit-def: $v8
	vmv.v.x	v8, t1
                                        # implicit-def: $v12
	vslide1down.vx	v12, v8, t0
                                        # implicit-def: $v8
	vmv.v.x	v8, a7
                                        # implicit-def: $v11
	vslide1down.vx	v11, v8, a6
                                        # implicit-def: $v8
	vmv.v.x	v8, a5
                                        # implicit-def: $v10
	vslide1down.vx	v10, v8, a4
                                        # implicit-def: $v9
	vmv.v.x	v9, a3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v9
	vsetvli	zero, zero, e64, m1, ta, ma
	vadd.vi	v9, v16, 1
                                        # implicit-def: $v20m2
	vmv.v.v	v20, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v15, 2
                                        # implicit-def: $v22m2
	vmv.v.v	v22, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v14, 3
                                        # implicit-def: $v24m2
	vmv.v.v	v24, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v13, 4
                                        # implicit-def: $v16m2
	vmv.v.v	v16, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v12, 5
                                        # implicit-def: $v12m2
	vmv.v.v	v12, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v11, 6
                                        # implicit-def: $v14m2
	vmv.v.v	v14, v9
                                        # implicit-def: $v9
	vadd.vi	v9, v10, 7
                                        # implicit-def: $v18m2
	vmv.v.v	v18, v9
                                        # implicit-def: $v10
	vadd.vi	v10, v8, 8
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
	vmv1r.v	v9, v10
	vsetivli	zero, 4, e64, m2, ta, ma
	vslideup.vi	v18, v8, 2
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v18
	vmv1r.v	v15, v18
	vslideup.vi	v12, v14, 2
                                        # implicit-def: $v28m4
	vmv.v.v	v28, v12
	vmv2r.v	v10, v12
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v28, v8, 4
                                        # implicit-def: $v8m8
	vmv.v.v	v8, v28
	vmv1r.v	v17, v18
	vsetivli	zero, 4, e64, m2, ta, ma
	vslideup.vi	v24, v16, 2
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v24
	vmv1r.v	v23, v24
	vslideup.vi	v20, v22, 2
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v20
	vmv2r.v	v18, v20
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v24, v16, 4
                                        # implicit-def: $v16m8
	vmv.v.v	v16, v24
	vmv4r.v	v12, v24
	vsetivli	zero, 16, e64, m8, ta, ma
	vslideup.vi	v16, v8, 8
	lui	a2, %hi(.LCPI8_0)
	addi	a2, a2, %lo(.LCPI8_0)
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
	addi	a0, a0, 2
	li	a1, 1024
	mv	a2, a0
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB8_2
	j	.LBB8_3
.LBB8_3:                                # %middle.block
	j	.LBB8_4
.LBB8_4:                                # %exit
	addi	sp, s0, -384
	.cfi_def_cfa sp, 384
	ld	ra, 376(sp)                     # 8-byte Folded Reload
	ld	s0, 368(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 384
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
