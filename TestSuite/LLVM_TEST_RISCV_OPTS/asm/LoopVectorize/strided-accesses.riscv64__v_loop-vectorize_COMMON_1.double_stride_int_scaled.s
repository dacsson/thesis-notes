# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: double_stride_int_scaled
# src = pre-opt (double_stride_int_scaled), tgt = post-opt (double_stride_int_scaled)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	addiw	a1, a1, 1
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_1
	j	.LBB6_2
.LBB6_2:                                # %exit
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

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
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	li	a0, 12
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_2
# %bb.1:                                # %entry
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
.LBB6_2:                                # %entry
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_8
	j	.LBB6_3
.LBB6_3:                                # %vector.scevcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a1, 1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_8
	j	.LBB6_4
.LBB6_4:                                # %vector.memcheck
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	sub	a0, a0, a2
	li	a2, 0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB6_8
	j	.LBB6_5
.LBB6_5:                                # %vector.ph
	csrr	a1, vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	srli	a0, a1, 1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB6_6
.LBB6_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a6, 80(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 2
	add	a7, a6, a5
	slli	a3, a3, 2
	add	a6, a7, a3
                                        # implicit-def: $v8m2
	vsetvli	t0, zero, e32, m2, ta, ma
	vle32.v	v8, (a7)
                                        # implicit-def: $v12m2
	vle32.v	v12, (a6)
                                        # implicit-def: $v10m2
	vadd.vi	v10, v8, 1
                                        # implicit-def: $v8m2
	vadd.vi	v8, v12, 1
	add	a4, a4, a5
	add	a3, a4, a3
	vse32.v	v10, (a4)
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_6
	j	.LBB6_7
.LBB6_7:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB6_10
	j	.LBB6_8
.LBB6_8:                                # %scalar.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB6_9
.LBB6_9:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	addiw	a1, a1, 1
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_9
	j	.LBB6_10
.LBB6_10:                               # %exit
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
