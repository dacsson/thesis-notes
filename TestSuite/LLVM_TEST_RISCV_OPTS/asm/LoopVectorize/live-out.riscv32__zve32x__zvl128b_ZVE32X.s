# Source: LoopVectorize/live-out.riscv32__zve32x__zvl128b_ZVE32X.ll
# Function: live_out
# src = pre-opt (live_out), tgt = post-opt (live_out)
# Triple: riscv32, Attrs: +zve32x,+zvl128b
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	mv	a3, a2
	mv	a2, a1
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sw	a3, 16(sp)                      # 4-byte Folded Spill
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	lw	a3, 24(sp)                      # 4-byte Folded Reload
	lw	a4, 16(sp)                      # 4-byte Folded Reload
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	slli	a5, a3, 2
	add	a1, a1, a5
	lw	a1, 0(a1)
	addi	a3, a3, 1
	seqz	a5, a3
	add	a2, a2, a5
	xor	a0, a3, a0
	xor	a4, a2, a4
	or	a0, a0, a4
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a3, vlenb
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 2 * vlenb
	sw	a0, 64(sp)                      # 4-byte Folded Spill
	sw	a2, 68(sp)                      # 4-byte Folded Spill
	sw	a1, 72(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	lw	a0, 68(sp)                      # 4-byte Folded Reload
	lw	a1, 72(sp)                      # 4-byte Folded Reload
	li	a3, 0
	mv	a2, a3
	sw	a3, 48(sp)                      # 4-byte Folded Spill
	sw	a2, 52(sp)                      # 4-byte Folded Spill
	sw	a1, 56(sp)                      # 4-byte Folded Spill
	sw	a0, 60(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	lw	a1, 52(sp)                      # 4-byte Folded Reload
	lw	a2, 56(sp)                      # 4-byte Folded Reload
	lw	a3, 60(sp)                      # 4-byte Folded Reload
	sw	a3, 32(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 3
	li	a2, 4
	li	a3, 0
	mv	a1, a3
	call	__muldi3
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	mv	a3, a0
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	sw	a3, 36(sp)                      # 4-byte Folded Spill
	sltu	a4, a0, a1
	sw	a4, 40(sp)                      # 4-byte Folded Spill
	sltu	a2, a2, a3
	sw	a2, 44(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB0_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a0, 40(sp)                      # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
.LBB0_4:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a0, 44(sp)                      # 4-byte Folded Reload
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_6
# %bb.5:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	sw	a0, 16(sp)                      # 4-byte Folded Spill
.LBB0_6:                                # %vector.body
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	lw	a3, 24(sp)                      # 4-byte Folded Reload
	lw	a4, 64(sp)                      # 4-byte Folded Reload
	lw	a5, 16(sp)                      # 4-byte Folded Reload
	sw	a5, 12(sp)                      # 4-byte Folded Spill
	slli	a6, a3, 2
	add	a4, a4, a6
                                        # implicit-def: $v8m2
	vsetvli	zero, a5, e32, m2, tu, ma
	vle32.v	v8, (a4)
	addi	a4, sp, 80
	vs2r.v	v8, (a4)                        # vscale x 16-byte Folded Spill
	add	a4, a5, a3
	sltu	a3, a4, a5
	add	a3, a2, a3
	sub	a2, a1, a5
	sltu	a1, a1, a5
	sub	a1, a0, a1
	or	a0, a2, a1
	sw	a4, 48(sp)                      # 4-byte Folded Spill
	sw	a3, 52(sp)                      # 4-byte Folded Spill
	sw	a2, 56(sp)                      # 4-byte Folded Spill
	sw	a1, 60(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_7
.LBB0_7:                                # %middle.block
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	addi	a1, sp, 80
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	addi	a0, a0, -1
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v8, v10, a0
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	j	.LBB0_8
.LBB0_8:                                # %exit
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 96
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
