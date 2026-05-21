# Source: LoopVectorize/safe-dep-distance.riscv64-linux-gnu__v__f_loop-vectorize.ll
# Function: safe_load_store_distance_not_pow_of_2
# src = pre-opt (safe_load_store_distance_not_pow_of_2), tgt = post-opt (safe_load_store_distance_not_pow_of_2)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
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
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 1
	lui	a2, %hi(a)
	addi	a2, a2, %lo(a)
	add	a3, a2, a3
	li	a2, 0
	sh	a2, 192(a3)
	addi	a2, a0, 3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a1, a1, 2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 4 * vlenb
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	li	a1, 1
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %entry
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
.LBB4_2:                                # %entry
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a1
	li	a1, 3
	call	__udivdi3
	mv	a1, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	add	a0, a0, a1
	addi	a0, a0, 1
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a1, 9
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_8
	j	.LBB4_3
.LBB4_3:                                # %vector.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 7
	li	a1, 8
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_5
# %bb.4:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
.LBB4_5:                                # %vector.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	sub	a1, a0, a1
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a0, a1, 1
	add	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v12m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vid.v	v12
	li	a0, 3
                                        # implicit-def: $v8m4
	vmul.vx	v8, v12, a0
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	addi	a0, sp, 128
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	j	.LBB4_6
.LBB4_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 128
	vl4r.v	v12, (a2)                       # vscale x 32-byte Folded Reload
	lui	a2, %hi(a)
	addi	a2, a2, %lo(a)
	addi	a2, a2, 192
                                        # implicit-def: $v16m4
	vadd.vv	v16, v12, v12
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m1, tu, ma
	vmv.v.i	v8, 0
	vsoxei64.v	v8, (a2), v16
	addi	a0, a0, 8
	li	a2, 24
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	addi	a2, sp, 128
	vs4r.v	v8, (a2)                        # vscale x 32-byte Folded Spill
	bne	a0, a1, .LBB4_6
	j	.LBB4_7
.LBB4_7:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB4_8
.LBB4_8:                                # %scalar.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_9:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 1
	lui	a2, %hi(a)
	addi	a2, a2, %lo(a)
	add	a3, a2, a3
	li	a2, 0
	sh	a2, 192(a3)
	addi	a2, a0, 3
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_9
	j	.LBB4_10
.LBB4_10:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 144
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
