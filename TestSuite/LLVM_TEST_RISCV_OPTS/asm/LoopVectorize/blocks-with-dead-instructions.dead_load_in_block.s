# Source: LoopVectorize/blocks-with-dead-instructions.ll
# Function: dead_load_in_block
# src = pre-opt (dead_load_in_block), tgt = post-opt (dead_load_in_block)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	zext.b	a0, a2
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lw	a0, 0(a0)
	beqz	a0, .LBB8_3
	j	.LBB8_2
.LBB8_2:                                # %then
                                        #   in Loop: Header=BB8_1 Depth=1
	j	.LBB8_3
.LBB8_3:                                # %loop.latch
                                        #   in Loop: Header=BB8_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a3, a2, a3
	li	a2, 0
	sw	a2, 0(a3)
	addi	a2, a0, 3
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_1
	j	.LBB8_4
.LBB8_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

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
	csrr	a4, vlenb
	slli	a4, a4, 2
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 4 * vlenb
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	zext.b	a0, a2
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	li	a1, 1
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_2
# %bb.1:                                # %entry
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB8_2:                                # %entry
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a1
	li	a1, 3
	call	__udivdi3
	mv	a1, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	add	a0, a0, a1
	addi	a0, a0, 1
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	j	.LBB8_3
.LBB8_3:                                # %vector.memcheck
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	li	a1, 1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_5
# %bb.4:                                # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
.LBB8_5:                                # %vector.memcheck
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a1
	li	a1, 3
	call	__udivdi3
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	add	a3, a3, a4
	slli	a4, a3, 2
	slli	a3, a3, 3
	add	a3, a3, a4
	add	a3, a3, a1
	addi	a3, a3, 4
	slli	a0, a0, 2
	add	a5, a2, a0
	addi	a4, a2, 4
	add	a0, a4, a0
	sltu	a0, a1, a0
	sltu	a5, a5, a3
	and	a0, a0, a5
	sltu	a1, a1, a4
	sltu	a2, a2, a3
	and	a1, a1, a2
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB8_10
	j	.LBB8_6
.LBB8_6:                                # %vector.memcheck
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB8_10
	j	.LBB8_7
.LBB8_7:                                # %vector.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v12m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v12
	li	a1, 3
                                        # implicit-def: $v8m4
	vmul.vx	v8, v12, a1
	addi	a1, sp, 144
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB8_8
.LBB8_8:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	addi	a1, sp, 144
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a1, a2, 1
	add	a1, a1, a2
                                        # implicit-def: $v16m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vsll.vi	v16, v12, 2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e32, m2, ta, ma
	vsoxei64.v	v8, (a3), v16
	sub	a0, a0, a2
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a1
	addi	a1, sp, 144
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB8_8
	j	.LBB8_9
.LBB8_9:                                # %middle.block
	j	.LBB8_14
.LBB8_10:                               # %scalar.ph
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_11
.LBB8_11:                               # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	lw	a0, 0(a0)
	beqz	a0, .LBB8_13
	j	.LBB8_12
.LBB8_12:                               # %then
                                        #   in Loop: Header=BB8_11 Depth=1
	j	.LBB8_13
.LBB8_13:                               # %loop.latch
                                        #   in Loop: Header=BB8_11 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a3, a2, a3
	li	a2, 0
	sw	a2, 0(a3)
	addi	a2, a0, 3
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB8_11
	j	.LBB8_14
.LBB8_14:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
