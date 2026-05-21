# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_FIXED.ll
# Function: load_store_factor3_i32
# src = pre-opt (load_store_factor3_i32), tgt = post-opt (load_store_factor3_i32)
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
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 2
	slli	a2, a0, 3
	add	a2, a2, a3
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	lw	a1, 4(a2)
	addiw	a1, a1, 2
	sw	a1, 4(a2)
	lw	a1, 8(a2)
	addiw	a1, a1, 3
	sw	a1, 8(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 2
	slli	a2, a0, 3
	add	a2, a2, a3
	add	a1, a1, a2
                                        # implicit-def: $v24m8
	vsetivli	zero, 24, e16, m4, tu, ma
	vle32.v	v24, (a1)
	vmv4r.v	v20, v24
	lui	a2, 9
	addi	a2, a2, 585
                                        # implicit-def: $v0
	vmv.s.x	v0, a2
                                        # implicit-def: $v8m8
	vsetivli	zero, 16, e32, m8, ta, ma
	vslidedown.vi	v8, v24, 16
                                        # kill: def $v8m4 killed $v8m4 killed $v8m8 killed $vtype
                                        # implicit-def: $v16m4
	vsetivli	zero, 16, e32, m4, tu, ma
	vmerge.vvm	v16, v8, v20, v0
	lui	a2, %hi(.LCPI2_0)
	addi	a2, a2, %lo(.LCPI2_0)
                                        # implicit-def: $v24m2
	vle16.v	v24, (a2)
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v12, v16, v24
	vmv2r.v	v14, v12
	lui	a2, 2
	addi	a2, a2, 1170
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v24m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v24, v8, v20, v0
	lui	a2, %hi(.LCPI2_1)
	addi	a2, a2, %lo(.LCPI2_1)
                                        # implicit-def: $v12m2
	vle16.v	v12, (a2)
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v16, v24, v12
	vmv2r.v	v12, v16
	lui	a2, 5
	addi	a2, a2, -1756
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v16, v8, v20, v0
	lui	a2, %hi(.LCPI2_2)
	addi	a2, a2, %lo(.LCPI2_2)
                                        # implicit-def: $v20m2
	vle16.v	v20, (a2)
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v8, v16, v20
                                        # kill: def $v8m2 killed $v8m2 killed $v8m4 killed $vtype
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, ta, ma
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
	vsetivli	zero, 16, e32, m4, ta, ma
	vslideup.vi	v24, v16, 8
                                        # implicit-def: $v16m8
	vmv.v.v	v16, v24
	li	a2, 32
	vmv4r.v	v12, v24
	vmv2r.v	v10, v24
	vsetvli	zero, a2, e32, m8, ta, ma
	vslideup.vi	v16, v8, 16
	lui	a3, %hi(.LCPI2_3)
	addi	a3, a3, %lo(.LCPI2_3)
                                        # implicit-def: $v24m4
	vsetvli	zero, a2, e16, m4, tu, ma
	vle16.v	v24, (a3)
                                        # implicit-def: $v8m8
	vsetvli	zero, a2, e32, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
	vsetivli	zero, 24, e32, m8, ta, ma
	vse32.v	v8, (a1)
	addi	a0, a0, 8
	li	a1, 1024
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
