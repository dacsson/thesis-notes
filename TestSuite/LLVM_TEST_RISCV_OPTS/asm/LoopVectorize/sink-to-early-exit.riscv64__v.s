# Source: LoopVectorize/sink-to-early-exit.riscv64__v.ll
# Function: sink_to_early_exit
# src = pre-opt (sink_to_early_exit), tgt = post-opt (sink_to_early_exit)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -2032
	.cfi_def_cfa_offset 2032
	sd	ra, 2024(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	addi	sp, sp, -80
	.cfi_def_cfa_offset 2112
	.cfi_remember_state
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	addi	a0, sp, 1080
	li	a1, 1024
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	call	init_mem
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	addi	a0, sp, 56
	call	init_mem
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	addi	a0, sp, 1080
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, sp, 56
	add	a1, a1, a2
	lbu	a1, 0(a1)
	add	a2, a2, a3
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %loop.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_3:                                # %loop.early.exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	.cfi_def_cfa_offset 2032
	ld	ra, 2024(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 2032
	.cfi_def_cfa_offset 0
	ret
.LBB0_4:                                # %loop.end
	.cfi_restore_state
	li	a0, 0
	addi	sp, sp, 80
	.cfi_def_cfa_offset 2032
	ld	ra, 2024(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 2032
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
	addi	sp, sp, -2032
	.cfi_def_cfa_offset 2032
	sd	ra, 2024(sp)                    # 8-byte Folded Spill
	sd	s0, 2016(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 2032
	.cfi_def_cfa s0, 0
	.cfi_remember_state
	addi	sp, sp, -224
	csrr	a1, vlenb
	slli	a1, a1, 2
	mv	a2, a1
	slli	a1, a1, 2
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	andi	sp, sp, -64
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	addi	a0, sp, 1200
	li	a1, 1024
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	call	init_mem
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	addi	a0, sp, 176
	call	init_mem
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	csrr	a1, vlenb
	srli	a2, a1, 3
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	slli	a1, a1, 1
	li	a2, 0
	sd	a2, 168(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_10
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	slli	a1, a0, 4
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	call	__umoddi3
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	mv	a3, a0
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sub	a2, a2, a3
	sd	a2, 128(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 4
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 3
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
                                        # implicit-def: $v16m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vid.v	v16
                                        # implicit-def: $v8m8
	vadd.vx	v8, v16, a1
                                        # implicit-def: $v24m8
	vsetvli	zero, zero, e64, m8, tu, ma
	vmv.v.x	v24, a0
	csrr	a0, vlenb
	slli	a1, a0, 6
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vs8r.v	v24, (a0)                       # vscale x 64-byte Folded Spill
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 3
	add	a1, a1, a0
	slli	a0, a0, 3
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vs8r.v	v24, (a0)                       # vscale x 64-byte Folded Spill
	li	a0, 0
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 4
	add	a1, a1, a0
	slli	a0, a0, 2
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vs8r.v	v16, (a0)                       # vscale x 64-byte Folded Spill
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 3
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 2
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vs8r.v	v8, (a0)                        # vscale x 64-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 6
	add	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vl8r.v	v24, (a3)                       # vscale x 64-byte Folded Reload
	csrr	a3, vlenb
	mv	a4, a3
	slli	a3, a3, 3
	add	a4, a4, a3
	slli	a3, a3, 3
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vl8r.v	v16, (a3)                       # vscale x 64-byte Folded Reload
	csrr	a3, vlenb
	mv	a4, a3
	slli	a3, a3, 4
	add	a4, a4, a3
	slli	a3, a3, 2
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vl8r.v	v0, (a3)                        # vscale x 64-byte Folded Reload
	csrr	a3, vlenb
	mv	a4, a3
	slli	a3, a3, 3
	add	a4, a4, a3
	slli	a3, a3, 1
	add	a4, a4, a3
	slli	a3, a3, 2
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vl8r.v	v8, (a3)                        # vscale x 64-byte Folded Reload
	csrr	a3, vlenb
	mv	a4, a3
	slli	a3, a3, 3
	add	a4, a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vs8r.v	v8, (a3)                        # vscale x 64-byte Folded Spill
	csrr	a3, vlenb
	slli	a3, a3, 4
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vs8r.v	v0, (a3)                        # vscale x 64-byte Folded Spill
	addi	a3, sp, 1200
	add	a3, a3, a0
                                        # implicit-def: $v10m2
	vsetvli	a4, zero, e8, m2, ta, ma
	vle8.v	v10, (a3)
	addi	a3, sp, 176
	add	a3, a3, a0
                                        # implicit-def: $v12m2
	vle8.v	v12, (a3)
	vmsne.vv	v8, v10, v12
	csrr	a3, vlenb
	slli	a3, a3, 3
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 2047
	addi	a3, a3, 193
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	add	a1, a0, a1
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	vcpop.m	a0, v8
	xor	a1, a1, a2
	seqz	a1, a1
	sd	a1, 104(sp)                     # 8-byte Folded Spill
                                        # implicit-def: $v8m8
	vsetvli	a1, zero, e64, m8, ta, ma
	vadd.vv	v8, v0, v16
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 3
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vl8r.v	v16, (a1)                       # vscale x 64-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 5
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
                                        # implicit-def: $v8m8
	vadd.vv	v8, v16, v24
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 3
	add	a2, a2, a1
	slli	a1, a1, 2
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	bnez	a0, .LBB0_5
	j	.LBB0_3
.LBB0_3:                                # %vector.body.interim
                                        #   in Loop: Header=BB0_2 Depth=1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	csrr	a2, vlenb
	mv	a3, a2
	slli	a2, a2, 3
	add	a3, a3, a2
	slli	a2, a2, 2
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 2047
	addi	a2, a2, 193
	vl8r.v	v8, (a2)                        # vscale x 64-byte Folded Reload
	csrr	a2, vlenb
	slli	a3, a2, 5
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 2047
	addi	a2, a2, 193
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	andi	a0, a0, 1
	sd	a1, 136(sp)                     # 8-byte Folded Spill
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 4
	add	a2, a2, a1
	slli	a1, a1, 2
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 3
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 2
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 168(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB0_14
	j	.LBB0_10
.LBB0_5:                                # %vector.early.exit
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 3
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vl8r.v	v0, (a0)                        # vscale x 64-byte Folded Reload
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 3
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vl8r.v	v8, (a0)                        # vscale x 64-byte Folded Reload
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 4
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vl8r.v	v24, (a0)                       # vscale x 64-byte Folded Reload
                                        # implicit-def: $v16m8
	vadd.vv	v16, v8, v24
	csrr	a0, vlenb
	slli	a0, a0, 4
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vl8r.v	v24, (a0)                       # vscale x 64-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 3
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	addi	a0, sp, 2047
	addi	a0, a0, 193
	vs8r.v	v16, (a0)                       # vscale x 64-byte Folded Spill
                                        # implicit-def: $v16m8
	vadd.vv	v16, v24, v0
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	a0, sp, a0
	addi	a0, a0, 2047
	addi	a0, a0, 193
	vs8r.v	v16, (a0)                       # vscale x 64-byte Folded Spill
	csrr	a0, vlenb
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	slli	a1, a0, 1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	vsetvli	a0, zero, e8, m2, ta, ma
	vfirst.m	a0, v8
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	bltz	a0, .LBB0_7
# %bb.6:                                # %vector.early.exit
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB0_7:                                # %vector.early.exit
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	addi	a1, a1, -1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_9
# %bb.8:                                # %vector.early.exit
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB0_9:                                # %vector.early.exit
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 2047
	addi	a1, a1, 193
	vl8r.v	v8, (a1)                        # vscale x 64-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 3
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	vl8r.v	v16, (a1)                       # vscale x 64-byte Folded Reload
	slli	a0, a0, 3
	csrr	a1, vlenb
	mv	a3, a1
	slli	a1, a1, 5
	add	a3, a3, a1
	slli	a1, a1, 1
	add	a1, a1, a3
	add	a1, sp, a1
	addi	a1, a1, 2047
	addi	a1, a1, 193
	add	a0, a1, a0
	vsetvli	a3, zero, e64, m8, ta, ma
	vse64.v	v16, (a1)
	slli	a2, a2, 3
	add	a1, a1, a2
	vse64.v	v8, (a1)
	ld	a0, 0(a0)
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_13
.LBB0_10:                               # %scalar.ph
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_11
.LBB0_11:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 144(sp)                     # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	addi	a0, sp, 1200
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, sp, 176
	add	a1, a1, a2
	lbu	a1, 0(a1)
	add	a2, a2, a3
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_13
	j	.LBB0_12
.LBB0_12:                               # %loop.inc
                                        #   in Loop: Header=BB0_11 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_11
	j	.LBB0_14
.LBB0_13:                               # %loop.early.exit
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addi	sp, s0, -2032
	.cfi_def_cfa sp, 2032
	ld	ra, 2024(sp)                    # 8-byte Folded Reload
	ld	s0, 2016(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 2032
	.cfi_def_cfa_offset 0
	ret
.LBB0_14:                               # %loop.end
	.cfi_restore_state
	li	a0, 0
	addi	sp, s0, -2032
	.cfi_def_cfa sp, 2032
	ld	ra, 2024(sp)                    # 8-byte Folded Reload
	ld	s0, 2016(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 2032
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
