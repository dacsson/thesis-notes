# Source: LoopVectorize/riscv-vector-reverse.riscv32__v_loop-vectorize_RV32.ll
# Function: vector_reverse_f32_simplify
# src = pre-opt (vector_reverse_f32_simplify), tgt = post-opt (vector_reverse_f32_simplify)
# Triple: riscv32, Attrs: +v
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
	sw	a1, 0(sp)                       # 4-byte Folded Spill
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	li	a0, 0
	li	a1, 1023
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a3, 8(sp)                       # 4-byte Folded Reload
	lw	a4, 4(sp)                       # 4-byte Folded Reload
	lw	a6, 0(sp)                       # 4-byte Folded Reload
	seqz	a1, a3
	sub	a1, a0, a1
	addi	a2, a3, -1
	slli	a5, a2, 2
	add	a6, a6, a5
	flw	fa5, 0(a6)
	lui	a6, 260096
	fmv.w.x	fa4, a6
	fadd.s	fa5, fa5, fa4
	add	a4, a4, a5
	fsw	fa5, 0(a4)
	sltiu	a3, a3, 2
	seqz	a0, a0
	and	a0, a0, a3
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	li	a3, 0
	mv	a0, a3
	li	a1, 1023
	mv	a2, a3
	sw	a3, 36(sp)                      # 4-byte Folded Spill
	sw	a2, 40(sp)                      # 4-byte Folded Spill
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	sw	a0, 48(sp)                      # 4-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
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
	beq	a0, a1, .LBB3_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB3_2 Depth=1
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	sw	a0, 32(sp)                      # 4-byte Folded Spill
.LBB3_4:                                # %vector.body
                                        #   in Loop: Header=BB3_2 Depth=1
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	bnez	a0, .LBB3_6
# %bb.5:                                # %vector.body
                                        #   in Loop: Header=BB3_2 Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a0, 4(sp)                       # 4-byte Folded Spill
.LBB3_6:                                # %vector.body
                                        #   in Loop: Header=BB3_2 Depth=1
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
	lui	t0, 260096
	fmv.w.x	fa5, t0
                                        # implicit-def: $v8m2
	vsetvli	t0, zero, e32, m2, ta, ma
	vfadd.vf	v8, v10, fa5
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
	bnez	a0, .LBB3_2
	j	.LBB3_7
.LBB3_7:                                # %middle.block
	j	.LBB3_8
.LBB3_8:                                # %exit
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
