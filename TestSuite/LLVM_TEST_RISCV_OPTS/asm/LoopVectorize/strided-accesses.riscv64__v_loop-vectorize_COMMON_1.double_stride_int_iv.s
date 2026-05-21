# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: double_stride_int_iv
# src = pre-opt (double_stride_int_iv), tgt = post-opt (double_stride_int_iv)
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
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a1, 2
	add	a4, a3, a4
	lw	a3, 0(a4)
	addiw	a3, a3, 1
	sw	a3, 0(a4)
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
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
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	srli	a0, a1, 3
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a0, 1024
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB7_5
	j	.LBB7_1
.LBB7_1:                                # %vector.scevcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a1, 1
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_5
	j	.LBB7_2
.LBB7_2:                                # %vector.ph
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
	j	.LBB7_3
.LBB7_3:                                # %vector.body
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
	bne	a0, a1, .LBB7_3
	j	.LBB7_4
.LBB7_4:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB7_7
	j	.LBB7_5
.LBB7_5:                                # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB7_6
.LBB7_6:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	slli	a4, a1, 2
	add	a4, a3, a4
	lw	a3, 0(a4)
	addiw	a3, a3, 1
	sw	a3, 0(a4)
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB7_6
	j	.LBB7_7
.LBB7_7:                                # %exit
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
