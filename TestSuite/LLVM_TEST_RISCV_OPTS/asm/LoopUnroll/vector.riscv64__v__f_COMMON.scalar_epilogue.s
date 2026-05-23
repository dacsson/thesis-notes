# Source: LoopUnroll/vector.riscv64__v__f_COMMON.ll
# Function: scalar_epilogue
# src = pre-opt (scalar_epilogue), tgt = post-opt (scalar_epilogue)
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
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	li	a1, 0
	li	a0, 32
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	bltu	a2, a0, .LBB4_4
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	andi	a1, a1, -32
	sd	a1, 16(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 16, e8, m1, tu, ma
	vmv.v.x	v8, a0
	li	a0, 0
	addi	a1, sp, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	addi	a3, sp, 64
	vl1r.v	v11, (a3)                       # vscale x 8-byte Folded Reload
	add	a3, a2, a0
	addi	a2, a3, 16
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, tu, ma
	vle8.v	v8, (a3)
                                        # implicit-def: $v10
	vle8.v	v10, (a2)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, m1, ta, ma
	vadd.vv	v9, v8, v11
                                        # implicit-def: $v8
	vadd.vv	v8, v10, v11
	vse8.v	v9, (a3)
	vse8.v	v8, (a2)
	addi	a0, a0, 32
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_5
	j	.LBB4_4
.LBB4_4:                                # %scalar.remainder
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	add	a3, a2, a0
	lbu	a2, 0(a3)
	addw	a2, a2, a4
	sb	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_4
	j	.LBB4_5
.LBB4_5:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 80 + 1 * vlenb
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	li	a1, 0
	li	a0, 32
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bltu	a2, a0, .LBB4_4
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	andi	a1, a1, -32
	sd	a1, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 16, e8, m1, tu, ma
	vmv.v.x	v8, a0
	li	a0, 0
	addi	a1, sp, 80
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	addi	a3, sp, 80
	vl1r.v	v11, (a3)                       # vscale x 8-byte Folded Reload
	add	a3, a2, a0
	addi	a2, a3, 16
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, tu, ma
	vle8.v	v8, (a3)
                                        # implicit-def: $v10
	vle8.v	v10, (a2)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, m1, ta, ma
	vadd.vv	v9, v8, v11
                                        # implicit-def: $v8
	vadd.vv	v8, v10, v11
	vse8.v	v9, (a3)
	vse8.v	v8, (a2)
	addi	a0, a0, 32
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_7
	j	.LBB4_4
.LBB4_4:                                # %scalar.remainder.preheader
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %scalar.remainder
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	add	a3, a2, a0
	lbu	a2, 0(a3)
	addw	a2, a2, a4
	sb	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_5
	j	.LBB4_6
.LBB4_6:                                # %exit.loopexit
	j	.LBB4_7
.LBB4_7:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 80
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
