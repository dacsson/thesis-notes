# Source: LoopVectorize/early-exit-live-out.riscv64__v_RV64.ll
# Function: early_exit_live_out
# src = pre-opt (early_exit_live_out), tgt = post-opt (early_exit_live_out)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a2, 0
	li	a1, 1024
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 3 * vlenb
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	srli	a1, a0, 1
	li	a2, 0
	li	a0, 1024
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_8
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	slli	a1, a0, 2
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vle32.v	v10, (a3)
	addi	a3, sp, 144
	vs2r.v	v10, (a3)                       # vscale x 16-byte Folded Spill
	vmsne.vi	v8, v10, 0
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 144
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	vcpop.m	a0, v8
	xor	a1, a1, a2
	seqz	a1, a1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_5
	j	.LBB0_3
.LBB0_3:                                # %vector.body.interim
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a1, 1024
	mv	a3, a0
	sd	a3, 128(sp)                     # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_11
	j	.LBB0_8
.LBB0_5:                                # %vector.early.exit
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 144
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 1
	vfirst.m	a0, v8
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bltz	a0, .LBB0_7
# %bb.6:                                # %vector.early.exit
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
.LBB0_7:                                # %vector.early.exit
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 144
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v8, v10, a0
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_8:                                # %scalar.ph
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	mv	a1, a0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_11
	j	.LBB0_10
.LBB0_10:                               # %latch
                                        #   in Loop: Header=BB0_9 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a2, 0
	li	a1, 1024
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_9
	j	.LBB0_11
.LBB0_11:                               # %exit
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	sp, sp, a1
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
