# Source: LoopVectorize/riscv-vector-reverse.riscv32__v_loop-vectorize_RV32.ll
# Function: vector_reverse_i32
# src = pre-opt (vector_reverse_i32), tgt = post-opt (vector_reverse_i32)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	a1, 0(sp)                       # 4-byte Folded Spill
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	li	a0, 0
	li	a1, 1023
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a3, 8(sp)                       # 4-byte Folded Reload
	lw	a5, 4(sp)                       # 4-byte Folded Reload
	lw	a4, 0(sp)                       # 4-byte Folded Reload
	seqz	a1, a3
	sub	a1, a0, a1
	addi	a2, a3, -1
	slli	a6, a2, 2
	add	a4, a4, a6
	lw	a4, 0(a4)
	addi	a4, a4, 1
	add	a5, a5, a6
	sw	a4, 0(a5)
	sltiu	a3, a3, 2
	seqz	a0, a0
	and	a0, a0, a3
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_1
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	li	a3, 0
	mv	a0, a3
	li	a1, 1023
	mv	a2, a3
	sw	a3, 36(sp)                      # 4-byte Folded Spill
	sw	a2, 40(sp)                      # 4-byte Folded Spill
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	sw	a0, 48(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	lw	a1, 40(sp)                      # 4-byte Folded Reload
	lw	a2, 44(sp)                      # 4-byte Folded Reload
	lw	a3, 48(sp)                      # 4-byte Folded Reload
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 3
	li	a2, 4
	li	a3, 0
	mv	a1, a3
	call	__muldi3
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	mv	a3, a0
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sltu	a4, a0, a1
	sw	a4, 28(sp)                      # 4-byte Folded Spill
	sltu	a2, a2, a3
	sw	a2, 32(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB0_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	sw	a0, 32(sp)                      # 4-byte Folded Spill
.LBB0_4:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	bnez	a0, .LBB0_6
# %bb.5:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a0, 4(sp)                       # 4-byte Folded Spill
.LBB0_6:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	lw	a2, 8(sp)                       # 4-byte Folded Reload
	lw	a3, 12(sp)                      # 4-byte Folded Reload
	lw	a4, 56(sp)                      # 4-byte Folded Reload
	lw	a6, 52(sp)                      # 4-byte Folded Reload
	lw	a5, 4(sp)                       # 4-byte Folded Reload
	li	a7, 1022
	sub	a7, a7, a3
	slli	a7, a7, 2
	add	t0, a6, a7
	li	a6, -4
                                        # implicit-def: $v10m2
	vsetvli	zero, a5, e32, m2, tu, ma
	vlse32.v	v10, (t0), a6
                                        # implicit-def: $v8m2
	vsetvli	t0, zero, e32, m2, ta, ma
	vadd.vi	v8, v10, 1
	add	a4, a4, a7
	vsetvli	zero, a5, e32, m2, ta, ma
	vsse32.v	v8, (a4), a6
	add	a4, a5, a3
	sltu	a3, a4, a5
	add	a3, a2, a3
	sub	a2, a1, a5
	sltu	a1, a1, a5
	sub	a1, a0, a1
	or	a0, a2, a1
	sw	a4, 36(sp)                      # 4-byte Folded Spill
	sw	a3, 40(sp)                      # 4-byte Folded Spill
	sw	a2, 44(sp)                      # 4-byte Folded Spill
	sw	a1, 48(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_7
.LBB0_7:                                # %middle.block
	j	.LBB0_8
.LBB0_8:                                # %exit
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
