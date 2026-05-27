# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_3.ll
# Function: single_constant_stride_ptr_iv
# src = pre-opt (single_constant_stride_ptr_iv), tgt = post-opt (single_constant_stride_ptr_iv)
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
	li	a1, 0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	lw	a2, 0(a1)
	addiw	a2, a2, 1
	sw	a2, 0(a1)
	addi	a2, a1, 8
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 0(sp)                       # 8-byte Folded Spill
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

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a1, a1, 2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 4 * vlenb
	mv	a2, a0
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a0, a1, 3
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	li	a3, 0
	li	a0, 1023
	sd	a3, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_6
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	slli	a1, a0, 3
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB2_3
# %bb.2:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB2_3:                                # %vector.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	sub	a2, a2, a3
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 3
	add	a2, a0, a2
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 5
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 144
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	li	a1, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB2_4
.LBB2_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 80(sp)                      # 8-byte Folded Reload
	addi	a4, sp, 144
	vl4r.v	v20, (a4)                       # vscale x 32-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v8
                                        # implicit-def: $v16m4
	vsll.vi	v16, v8, 3
                                        # implicit-def: $v8m4
	vadd.vx	v8, v16, a2
	vmv1r.v	v12, v8
	vmv.x.s	a4, v12
                                        # implicit-def: $v12m4
	vadd.vv	v12, v8, v20
	vmv1r.v	v10, v12
                                        # implicit-def: $v20m4
	vsetvli	a5, zero, e32, m4, ta, ma
	vle32.v	v20, (a4)
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vnsrl.wi	v8, v20, 0
	vsetvli	zero, zero, e64, m4, ta, ma
	vmv.x.s	a4, v10
                                        # implicit-def: $v24m4
	vsetvli	a5, zero, e32, m4, ta, ma
	vle32.v	v24, (a4)
                                        # implicit-def: $v20m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vnsrl.wi	v20, v24, 0
                                        # implicit-def: $v10m2
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v20, 1
	vsoxei64.v	v10, (a2), v16
	li	a4, 0
	vsoxei64.v	v8, (a4), v12
	add	a0, a0, a3
	slli	a3, a3, 3
	add	a2, a2, a3
	mv	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_4
	j	.LBB2_5
.LBB2_5:                                # %middle.block
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	j	.LBB2_6
.LBB2_6:                                # %scalar.ph
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB2_7
.LBB2_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	lw	a2, 0(a1)
	addiw	a2, a2, 1
	sw	a2, 0(a1)
	addi	a2, a1, 8
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_7
	j	.LBB2_8
.LBB2_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
