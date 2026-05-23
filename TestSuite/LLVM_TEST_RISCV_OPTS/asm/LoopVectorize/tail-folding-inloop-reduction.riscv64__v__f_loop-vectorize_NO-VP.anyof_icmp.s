# Source: LoopVectorize/tail-folding-inloop-reduction.riscv64__v__f_loop-vectorize_NO-VP.ll
# Function: anyof_icmp
# src = pre-opt (anyof_icmp), tgt = post-opt (anyof_icmp)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	j	.LBB16_1
.LBB16_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	li	a1, 3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB16_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB16_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB16_3:                               # %for.body
                                        #   in Loop: Header=BB16_1 Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB16_1
	j	.LBB16_4
.LBB16_4:                               # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end16:
	.size	src, .Lfunc_end16-src
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
	csrr	a4, vlenb
	slli	a4, a4, 1
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x01, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 176 + 2 * vlenb
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 128(sp)                     # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	sd	a2, 144(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB16_6
	j	.LBB16_1
.LBB16_1:                               # %vector.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	vsetvli	a0, zero, e8, mf2, ta, ma
	vmclr.m	v8
	li	a0, 0
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 160
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB16_2
.LBB16_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	csrr	a4, vlenb
	add	a4, sp, a4
	addi	a4, a4, 160
	vl1r.v	v8, (a4)                        # vscale x 8-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vle32.v	v10, (a3)
	vmsle.vi	v9, v10, 2
	vmor.mm	v8, v8, v9
	addi	a3, sp, 160
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 160
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	bne	a0, a1, .LBB16_2
	j	.LBB16_3
.LBB16_3:                               # %middle.block
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	addi	a0, sp, 160
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	vcpop.m	a0, v8
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB16_5
# %bb.4:                                # %middle.block
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
.LBB16_5:                               # %middle.block
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	mv	a3, a1
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 144(sp)                     # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB16_10
	j	.LBB16_6
.LBB16_6:                               # %scalar.ph
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB16_7
.LBB16_7:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	li	a1, 3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB16_9
# %bb.8:                                # %for.body
                                        #   in Loop: Header=BB16_7 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB16_9:                               # %for.body
                                        #   in Loop: Header=BB16_7 Depth=1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB16_7
	j	.LBB16_10
.LBB16_10:                              # %for.end
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 176
	ld	ra, 168(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end16:
	.size	tgt, .Lfunc_end16-tgt
	.cfi_endproc
                                        # -- End function
