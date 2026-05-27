# Source: LoopVectorize/blocks-with-dead-instructions.ll
# Function: multiple_blocks_with_dead_inst_multiple_successors_6
# src = pre-opt (multiple_blocks_with_dead_inst_multiple_successors_6), tgt = post-opt (multiple_blocks_with_dead_inst_multiple_successors_6)
# Triple: riscv64, Attrs: v
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
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	lhu	a0, 0(a0)
	bnez	a0, .LBB5_4
	j	.LBB5_2
.LBB5_2:                                # %then
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB5_4
	j	.LBB5_3
.LBB5_3:                                # %then.1
                                        #   in Loop: Header=BB5_1 Depth=1
	j	.LBB5_6
.LBB5_4:                                # %else
                                        #   in Loop: Header=BB5_1 Depth=1
	j	.LBB5_5
.LBB5_5:                                # %else.2
                                        #   in Loop: Header=BB5_1 Depth=1
	j	.LBB5_6
.LBB5_6:                                # %loop.latch
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	sh	a2, 0(a3)
	addi	a0, a0, 3
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_7
.LBB5_7:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
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
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a1, vlenb
	slli	a1, a1, 3
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 8 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	addi	a0, a2, -3
	li	a1, 3
	call	__udivdi3
	addi	a0, a0, 1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v16m8
	vsetvli	a1, zero, e64, m8, ta, ma
	vid.v	v16
	li	a1, 3
                                        # implicit-def: $v8m8
	vmul.vx	v8, v16, a1
	addi	a1, sp, 48
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 48
	vl8r.v	v16, (a1)                       # vscale x 64-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a1, a2, 1
	add	a1, a1, a2
                                        # implicit-def: $v24m8
	vsetvli	a4, zero, e64, m8, ta, ma
	vadd.vv	v24, v16, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e16, m2, ta, ma
	vsoxei64.v	v8, (a3), v24
	sub	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e64, m8, ta, ma
	vadd.vx	v8, v16, a1
	addi	a1, sp, 48
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_3
.LBB5_3:                                # %middle.block
	j	.LBB5_4
.LBB5_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
