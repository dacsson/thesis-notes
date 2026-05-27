# Source: LoopVectorize/pointer-induction.ll
# Function: scalarize_ptr_induction
# src = pre-opt (scalarize_ptr_induction), tgt = post-opt (scalarize_ptr_induction)
# Triple: riscv64, Attrs: v
#

	.globl	src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	lwu	a2, 4(a0)
	lui	a4, %hi(.LCPI1_0)
	ld	a4, %lo(.LCPI1_0)(a4)
	mul	a2, a2, a4
	addi	a2, a2, -4
	sd	a2, 0(a3)
	addi	a0, a0, 12
	xor	a2, a0, a1
	seqz	a2, a2
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	csrr	a3, vlenb
	slli	a3, a3, 1
	sh1add	a3, a3, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xf0, 0x00, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 112 + 6 * vlenb
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	sub	a0, a1, a0
	addi	a0, a0, -12
	lui	a1, 699051
	addi	a1, a1, -1365
	slli	a2, a1, 32
	add	a1, a1, a2
	mulhu	a0, a0, a1
	srli	a0, a0, 3
	addi	a0, a0, 1
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	addi	a4, a0, 8
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	sub	a1, a1, a3
	addi	a1, a1, -12
	lui	a3, 699051
	addi	a3, a3, -1365
	slli	a4, a3, 32
	add	a3, a3, a4
	mulhu	a1, a1, a3
	srli	a1, a1, 3
	sh1add	a1, a1, a1
	sh2add	a1, a1, a2
	addi	a1, a1, 8
	bgeu	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %vector.memcheck
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB1_6
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, tu, ma
	vmv.v.x	v8, a3
	csrr	a3, vlenb
	sh1add	a3, a3, sp
	addi	a3, a3, 112
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vmv.v.x	v8, a2
	csrr	a2, vlenb
	sh2add	a2, a2, sp
	addi	a2, a2, 112
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	sh1add	a1, a1, sp
	addi	a1, a1, 112
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.x	v12, a2
	li	a1, 12
	vsetvli	zero, zero, e64, m2, ta, ma
	vmadd.vx	v8, a1, v12
	addi	a1, sp, 112
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	vsetvli	a1, a0, e8, mf4, ta, ma
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a3, 4
                                        # implicit-def: $v12
	vsetvli	zero, a1, e32, m1, tu, ma
	vluxei64.v	v12, (a3), v8
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vzext.vf2	v8, v12
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vmv.v.i	v12, -4
	lui	a3, %hi(.LCPI1_0)
	ld	a3, %lo(.LCPI1_0)(a3)
	vsetvli	zero, zero, e64, m2, ta, ma
	vmadd.vx	v8, a3, v12
	li	a3, 0
	vsetvli	zero, a1, e64, m2, ta, ma
	vsoxei64.v	v8, (a3), v10
	sub	a0, a0, a1
	sh1add	a1, a1, a1
	sh2add	a1, a1, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_5
.LBB1_5:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	sh2add	a1, a1, sp
	addi	a1, a1, 112
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	addi	a1, sp, 112
	vl2r.v	v12, (a1)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, ta, ma
	vadd.vi	v8, v12, 12
	vmseq.vv	v0, v8, v10
	addi	a0, a0, -1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v9
	vmerge.vim	v9, v8, 1, v0
                                        # implicit-def: $v8
	vsetivli	zero, 1, e8, mf4, ta, ma
	vslidedown.vx	v8, v9, a0
	vmv.x.s	a0, v8
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_8
.LBB1_6:                                # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_7
.LBB1_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	lwu	a2, 4(a0)
	lui	a4, %hi(.LCPI1_0)
	ld	a4, %lo(.LCPI1_0)(a4)
	mul	a2, a2, a4
	addi	a2, a2, -4
	sd	a2, 0(a3)
	addi	a0, a0, 12
	xor	a2, a0, a1
	seqz	a2, a2
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_7
	j	.LBB1_8
.LBB1_8:                                # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sh1add	a1, a1, a1
	add	sp, sp, a1
	.cfi_def_cfa sp, 112
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
