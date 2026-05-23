# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: mul
# src = pre-opt (mul), tgt = post-opt (mul)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	call	__muldi3
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.end
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sd	ra, 168(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x01, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 176 + 1 * vlenb
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	li	a3, 0
	li	a0, 8
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	sd	a2, 144(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB1_4
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	andi	a0, a0, -8
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	li	a0, 1
	li	a2, 0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a2, a1, a2
	addi	a1, a2, 16
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a2)
                                        # implicit-def: $v9
	vle32.v	v9, (a1)
	addi	a1, sp, 160
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vslidedown.vi	v10, v8, 2
                                        # implicit-def: $v9
	vmul.vv	v9, v8, v10
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 1
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
	vmv.x.s	a1, v8
	call	__muldi3
	addi	a1, sp, 160
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a1, 56(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, ta, ma
	vslidedown.vi	v10, v8, 2
                                        # implicit-def: $v9
	vmul.vv	v9, v8, v10
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 1
                                        # implicit-def: $v8
	vmul.vv	v8, v9, v10
	vmv.x.s	a1, v8
	call	__muldi3
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	addi	a0, a0, 8
	mv	a4, a0
	sd	a4, 88(sp)                      # 8-byte Folded Spill
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	call	__muldi3
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	mv	a3, a1
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB1_6
	j	.LBB1_4
.LBB1_4:                                # %scalar.ph
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB1_5
.LBB1_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	call	__muldi3
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_5
	j	.LBB1_6
.LBB1_6:                                # %for.end
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 176
	ld	ra, 168(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
