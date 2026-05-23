# Source: LoopVectorize/zvl1024b-crash.riscv64__v__zvl1024b.ll
# Function: foo
# src = pre-opt (foo), tgt = post-opt (foo)
# Triple: riscv64, Attrs: +v,+zvl1024b
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	.cfi_remember_state
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_1:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.LBB0_2:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	.cfi_restore_state
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sext.w	a0, a0
	li	a1, 53
	beq	a0, a1, .LBB0_8
	j	.LBB0_3
.LBB0_3:                                # %loop
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, -159
	li	a1, 4
	bltu	a0, a1, .LBB0_8
	j	.LBB0_4
.LBB0_4:                                # %loop
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 172
	beq	a0, a1, .LBB0_8
	j	.LBB0_5
.LBB0_5:                                # %loop
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	li	a1, 243
	beq	a0, a1, .LBB0_8
	j	.LBB0_6
.LBB0_6:                                # %loop
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, -308
	li	a1, 2
	bltu	a0, a1, .LBB0_8
	j	.LBB0_7
.LBB0_7:                                # %loop.split
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB0_8
.LBB0_8:                                # %exiting
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a2, a0, 1
	li	a1, 523
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_1
	j	.LBB0_2
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x05, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 5 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v20m4
	vsetvli	a1, zero, e32, m4, tu, ma
	vmv.v.x	v20, a0
	addi	a0, sp, 48
	vs4r.v	v20, (a0)                       # vscale x 32-byte Folded Spill
	li	a0, 308
	vsetvli	zero, zero, e32, m4, ta, ma
	vmseq.vx	v8, v20, a0
	li	a0, 309
	vmseq.vx	v16, v20, a0
	li	a0, 160
	vmseq.vx	v15, v20, a0
	li	a0, 243
	vmseq.vx	v14, v20, a0
	li	a0, 53
	vmseq.vx	v13, v20, a0
	li	a0, 162
	vmseq.vx	v12, v20, a0
	li	a0, 161
	vmseq.vx	v11, v20, a0
	li	a0, 172
	vmseq.vx	v10, v20, a0
	li	a0, 159
	vmseq.vx	v9, v20, a0
	vmor.mm	v8, v8, v16
	vmor.mm	v8, v8, v15
	vmor.mm	v8, v8, v14
	vmor.mm	v8, v8, v13
	vmor.mm	v8, v8, v12
	vmor.mm	v8, v8, v11
	vmor.mm	v8, v8, v10
	vmor.mm	v8, v8, v9
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	li	a0, 524
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 48
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
                                        # implicit-def: $v16m8
	vsetvli	a4, zero, e64, m8, ta, ma
	vid.v	v16
	vmsltu.vx	v8, v16, a2
	vmnand.mm	v0, v8, v9
	add	a3, a3, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e8, m1, ta, ma
	vse8.v	v8, (a3), v0.t
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
