# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: interleaved_load_instead_of_strided
# src = pre-opt (interleaved_load_instead_of_strided), tgt = post-opt (interleaved_load_instead_of_strided)
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
	j	.LBB10_1
.LBB10_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 4
	add	a2, a1, a2
	lw	a1, 0(a2)
	lw	a4, 4(a2)
	lw	a3, 12(a2)
	addw	a1, a1, a4
	addw	a1, a1, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a1, a1, 2
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xf0, 0x00, 0x22, 0x11, 0x1c, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 112 + 28 * vlenb
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a0, a1, 3
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a0, 1024
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB10_4
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 2
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 96
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	slli	a1, a0, 3
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v8
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	a0, sp, a0
	addi	a0, a0, 96
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 3
	add	a4, sp, a4
	addi	a4, a4, 96
	vl4r.v	v8, (a4)                        # vscale x 32-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 2
	add	a4, sp, a4
	addi	a4, a4, 96
	vl4r.v	v16, (a4)                       # vscale x 32-byte Folded Reload
                                        # implicit-def: $v12m4
	vadd.vv	v12, v8, v16
                                        # implicit-def: $v24m4
	vsll.vi	v24, v8, 4
                                        # implicit-def: $v8m4
	vadd.vx	v8, v24, a3
                                        # kill: def $v8 killed $v8 killed $v8m4 killed $vtype
	vmv.x.s	a5, v8
                                        # implicit-def: $v16m4
	vsll.vi	v16, v12, 4
	addi	a4, sp, 96
	vs4r.v	v16, (a4)                       # vscale x 32-byte Folded Spill
                                        # implicit-def: $v8m4
	vadd.vx	v8, v16, a3
                                        # kill: def $v8 killed $v8 killed $v8m4 killed $vtype
	vmv.x.s	a4, v8
                                        # implicit-def: $v16m8
	vsetvli	a6, zero, e32, m8, ta, ma
	vle32.v	v16, (a5)
	csrr	a5, vlenb
	slli	a5, a5, 2
	mv	a6, a5
	slli	a5, a5, 1
	add	a5, a5, a6
	add	a5, sp, a5
	addi	a5, a5, 96
	vse32.v	v16, (a5)
                                        # implicit-def: $v16m2_v18m2_v20m2_v22m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vlseg4e32.v	v16, (a5)
	vmv2r.v	v6, v22
	vmv2r.v	v2, v18
	vmv2r.v	v28, v16
                                        # implicit-def: $v16m8
	vsetvli	a5, zero, e32, m8, ta, ma
	vle32.v	v16, (a4)
	csrr	a4, vlenb
	slli	a4, a4, 2
	mv	a5, a4
	slli	a4, a4, 2
	add	a4, a4, a5
	add	a4, sp, a4
	addi	a4, a4, 96
	vse32.v	v16, (a4)
                                        # implicit-def: $v16m2_v18m2_v20m2_v22m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vlseg4e32.v	v16, (a4)
	vmv2r.v	v30, v22
	vmv2r.v	v4, v18
	vmv2r.v	v10, v16
	addi	a4, sp, 96
	vl4r.v	v20, (a4)                       # vscale x 32-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 2
	add	a4, sp, a4
	addi	a4, a4, 96
	vl4r.v	v16, (a4)                       # vscale x 32-byte Folded Reload
                                        # implicit-def: $v8m2
	vadd.vv	v8, v28, v2
                                        # implicit-def: $v28m2
	vadd.vv	v28, v10, v4
                                        # implicit-def: $v10m2
	vadd.vv	v10, v8, v6
                                        # implicit-def: $v8m2
	vadd.vv	v8, v28, v30
	vsoxei64.v	v10, (a3), v24
	vsoxei64.v	v8, (a3), v20
	add	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vadd.vv	v8, v12, v16
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, sp, a2
	addi	a2, a2, 96
	vs4r.v	v8, (a2)                        # vscale x 32-byte Folded Spill
	bne	a0, a1, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB10_6
	j	.LBB10_4
.LBB10_4:                               # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB10_5
.LBB10_5:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 4
	add	a2, a1, a2
	lw	a1, 0(a2)
	lw	a4, 4(a2)
	lw	a3, 12(a2)
	addw	a1, a1, a4
	addw	a1, a1, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB10_5
	j	.LBB10_6
.LBB10_6:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	mv	a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 112
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
