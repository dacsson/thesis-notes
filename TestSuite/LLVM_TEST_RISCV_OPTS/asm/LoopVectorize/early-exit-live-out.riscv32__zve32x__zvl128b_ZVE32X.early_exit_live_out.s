# Source: LoopVectorize/early-exit-live-out.riscv32__zve32x__zvl128b_ZVE32X.ll
# Function: early_exit_live_out
# src = pre-opt (early_exit_live_out), tgt = post-opt (early_exit_live_out)
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
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	mv	a1, a0
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	addi	a3, a1, 1
	seqz	a1, a3
	add	a2, a0, a1
	xori	a0, a3, 1024
	or	a0, a0, a2
	li	a1, 0
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %exit
	lw	a0, 16(sp)                      # 4-byte Folded Reload
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
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sw	ra, 140(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x90, 0x01, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 144 + 3 * vlenb
	sw	a0, 88(sp)                      # 4-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 3
	sw	a0, 92(sp)                      # 4-byte Folded Spill
	li	a2, 1
	li	a3, 0
	sw	a3, 108(sp)                     # 4-byte Folded Spill
	mv	a1, a3
	call	__muldi3
	lw	a3, 108(sp)                     # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 92(sp)                      # 4-byte Folded Reload
	sw	a2, 96(sp)                      # 4-byte Folded Spill
	mv	a2, a1
	lw	a1, 96(sp)                      # 4-byte Folded Reload
	sw	a2, 100(sp)                     # 4-byte Folded Spill
	sw	a1, 104(sp)                     # 4-byte Folded Spill
	li	a2, 4
	mv	a1, a3
	call	__muldi3
	lw	a2, 108(sp)                     # 4-byte Folded Reload
	sw	a0, 112(sp)                     # 4-byte Folded Spill
	mv	a0, a1
	lw	a1, 112(sp)                     # 4-byte Folded Reload
	sltiu	a1, a1, 1025
	seqz	a0, a0
	and	a0, a0, a1
	mv	a1, a2
	sw	a2, 116(sp)                     # 4-byte Folded Spill
	sw	a1, 120(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB0_8
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	lw	a0, 104(sp)                     # 4-byte Folded Reload
	lw	a1, 100(sp)                     # 4-byte Folded Reload
	srli	a2, a0, 30
	slli	a1, a1, 2
	or	a3, a1, a2
	sw	a3, 56(sp)                      # 4-byte Folded Spill
	slli	a2, a0, 2
	sw	a2, 60(sp)                      # 4-byte Folded Spill
	li	a0, 1024
	sw	a0, 64(sp)                      # 4-byte Folded Spill
	li	a1, 0
	sw	a1, 68(sp)                      # 4-byte Folded Spill
	call	__umoddi3
	mv	a2, a0
	lw	a0, 64(sp)                      # 4-byte Folded Reload
	mv	a3, a1
	lw	a1, 68(sp)                      # 4-byte Folded Reload
	sltiu	a4, a2, 1025
	xori	a4, a4, 1
	add	a3, a3, a4
	sub	a3, a1, a3
	sw	a3, 72(sp)                      # 4-byte Folded Spill
	sub	a0, a0, a2
	sw	a0, 76(sp)                      # 4-byte Folded Spill
	mv	a0, a1
	sw	a1, 80(sp)                      # 4-byte Folded Spill
	sw	a0, 84(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a3, 76(sp)                      # 4-byte Folded Reload
	lw	a4, 72(sp)                      # 4-byte Folded Reload
	lw	a5, 56(sp)                      # 4-byte Folded Reload
	lw	a1, 60(sp)                      # 4-byte Folded Reload
	lw	a6, 88(sp)                      # 4-byte Folded Reload
	lw	a2, 80(sp)                      # 4-byte Folded Reload
	lw	a0, 84(sp)                      # 4-byte Folded Reload
	slli	a7, a2, 2
	add	a6, a6, a7
                                        # implicit-def: $v10m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vle32.v	v10, (a6)
	addi	a6, sp, 128
	vs2r.v	v10, (a6)                       # vscale x 16-byte Folded Spill
	vmsne.vi	v8, v10, 0
	csrr	a6, vlenb
	slli	a6, a6, 1
	add	a6, sp, a6
	addi	a6, a6, 128
	vs1r.v	v8, (a6)                        # vscale x 8-byte Folded Spill
	add	a1, a2, a1
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	sltu	a2, a1, a2
	add	a0, a0, a5
	add	a2, a0, a2
	sw	a2, 48(sp)                      # 4-byte Folded Spill
	vcpop.m	a0, v8
	xor	a2, a2, a4
	xor	a1, a1, a3
	or	a1, a1, a2
	seqz	a1, a1
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_5
	j	.LBB0_3
.LBB0_3:                                # %vector.body.interim
                                        #   in Loop: Header=BB0_2 Depth=1
	lw	a1, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 44(sp)                      # 4-byte Folded Reload
	lw	a0, 52(sp)                      # 4-byte Folded Reload
	andi	a0, a0, 1
	sw	a2, 80(sp)                      # 4-byte Folded Spill
	sw	a1, 84(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	lw	a2, 72(sp)                      # 4-byte Folded Reload
	lw	a3, 76(sp)                      # 4-byte Folded Reload
	xori	a0, a3, 1024
	or	a0, a0, a2
	li	a1, 0
	sw	a3, 116(sp)                     # 4-byte Folded Spill
	sw	a2, 120(sp)                     # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB0_11
	j	.LBB0_8
.LBB0_5:                                # %vector.early.exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 128
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 1
	vfirst.m	a0, v8
	sw	a0, 32(sp)                      # 4-byte Folded Spill
	sw	a1, 36(sp)                      # 4-byte Folded Spill
	bltz	a0, .LBB0_7
# %bb.6:                                # %vector.early.exit
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	sw	a0, 36(sp)                      # 4-byte Folded Spill
.LBB0_7:                                # %vector.early.exit
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	addi	a1, sp, 128
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v8, v10, a0
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	sw	a0, 40(sp)                      # 4-byte Folded Spill
	j	.LBB0_11
.LBB0_8:                                # %scalar.ph
	lw	a1, 116(sp)                     # 4-byte Folded Reload
	lw	a0, 120(sp)                     # 4-byte Folded Reload
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 88(sp)                      # 4-byte Folded Reload
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	mv	a1, a0
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_11
	j	.LBB0_10
.LBB0_10:                               # %latch
                                        #   in Loop: Header=BB0_9 Depth=1
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	addi	a3, a1, 1
	seqz	a1, a3
	add	a2, a0, a1
	xori	a0, a3, 1024
	or	a0, a0, a2
	li	a1, 0
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_9
	j	.LBB0_11
.LBB0_11:                               # %exit
	lw	a0, 40(sp)                      # 4-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	sp, sp, a1
	.cfi_def_cfa sp, 144
	lw	ra, 140(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
