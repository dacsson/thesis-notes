# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: single_constant_stride_int_scaled
# src = pre-opt (single_constant_stride_int_scaled), tgt = post-opt (single_constant_stride_int_scaled)
# Triple: riscv64, Attrs: +v
#

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
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 5
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a1, a1, 3
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 8 * vlenb
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a0, a1, 3
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a0, 1023
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 2
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, sp, a1
	addi	a1, a1, 112
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	slli	a1, a0, 3
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_3
# %bb.2:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB0_3:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v8
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	addi	a0, sp, 112
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	addi	a4, sp, 112
	vl4r.v	v8, (a4)                        # vscale x 32-byte Folded Reload
	csrr	a4, vlenb
	slli	a4, a4, 2
	add	a4, sp, a4
	addi	a4, a4, 112
	vl4r.v	v16, (a4)                       # vscale x 32-byte Folded Reload
                                        # implicit-def: $v12m4
	vadd.vv	v12, v8, v16
                                        # implicit-def: $v24m4
	vsll.vi	v24, v8, 5
                                        # implicit-def: $v20m4
	vsll.vi	v20, v12, 5
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vluxei64.v	v8, (a3), v24
                                        # implicit-def: $v28m2
	vluxei64.v	v28, (a3), v20
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v28, 1
	vsoxei64.v	v10, (a3), v24
	vsoxei64.v	v8, (a3), v20
	add	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vadd.vv	v8, v12, v16
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 112
	vs4r.v	v8, (a2)                        # vscale x 32-byte Folded Spill
	bne	a0, a1, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 5
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
