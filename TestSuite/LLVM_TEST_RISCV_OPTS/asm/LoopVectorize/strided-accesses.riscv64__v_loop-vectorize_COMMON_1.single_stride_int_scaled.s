# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: single_stride_int_scaled
# src = pre-opt (single_stride_int_scaled), tgt = post-opt (single_stride_int_scaled)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a0, a1, 3
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a0, 1024
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_5
	j	.LBB3_1
.LBB3_1:                                # %vector.scevcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a1, 1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_5
	j	.LBB3_2
.LBB3_2:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a0, 3
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB3_3
.LBB3_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 2
	add	a4, a4, a5
	slli	a3, a3, 2
	add	a3, a4, a3
                                        # implicit-def: $v8m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vle32.v	v8, (a4)
                                        # implicit-def: $v12m2
	vle32.v	v12, (a3)
                                        # implicit-def: $v10m2
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v12, 1
	vse32.v	v10, (a4)
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_3
	j	.LBB3_4
.LBB3_4:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB3_7
	j	.LBB3_5
.LBB3_5:                                # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB3_6
.LBB3_6:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB3_6
	j	.LBB3_7
.LBB3_7:                                # %exit
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
