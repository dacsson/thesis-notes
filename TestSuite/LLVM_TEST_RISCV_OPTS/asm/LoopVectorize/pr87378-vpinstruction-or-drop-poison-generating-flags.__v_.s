# Source: LoopVectorize/pr87378-vpinstruction-or-drop-poison-generating-flags.__v_.ll
# Function: pr87378_vpinstruction_or_drop_poison_generating_flags
# src = pre-opt (pr87378_vpinstruction_or_drop_poison_generating_flags), tgt = post-opt (pr87378_vpinstruction_or_drop_poison_generating_flags)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %then.1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_5
	j	.LBB0_3
.LBB0_3:                                # %else.1
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB0_6
	j	.LBB0_4
.LBB0_4:                                # %then.2
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %merge
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	slli	a1, a1, 1
	add	a1, a0, a1
	li	a0, 0
	sh	a0, 0(a1)
	j	.LBB0_6
.LBB0_6:                                # %loop.latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a2, a0, 1
	li	a1, 1000
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_7
.LBB0_7:                                # %exit
	addi	sp, sp, 64
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a4, vlenb
	slli	a4, a4, 5
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x20, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 32 * vlenb
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m8
	vsetvli	a3, zero, e64, m8, tu, ma
	vmv.v.x	v8, a2
	addi	a2, sp, 64
	vs8r.v	v8, (a2)                        # vscale x 64-byte Folded Spill
                                        # implicit-def: $v8m8
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	slli	a1, a1, 3
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
                                        # implicit-def: $v8m8
	vmv.v.x	v8, a0
	csrr	a0, vlenb
	slli	a0, a0, 4
	add	a0, sp, a0
	addi	a0, a0, 64
	vs8r.v	v8, (a0)                        # vscale x 64-byte Folded Spill
	li	a0, 1001
	li	a1, 0
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vid.v	v8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 3
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 3
	mv	a4, a2
	slli	a2, a2, 1
	add	a2, a2, a4
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v0, (a2)                        # vscale x 64-byte Folded Reload
	addi	a2, sp, 64
	vl8r.v	v24, (a2)                       # vscale x 64-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	vsetvli	a4, zero, e64, m8, ta, ma
	vmsleu.vv	v10, v16, v24
	vmsltu.vv	v9, v24, v16
	csrr	a4, vlenb
	slli	a4, a4, 4
	add	a4, sp, a4
	addi	a4, a4, 64
	vl8r.v	v24, (a4)                       # vscale x 64-byte Folded Reload
	vmsltu.vv	v11, v0, v16
	vmsleu.vv	v8, v16, v0
	vmor.mm	v8, v9, v8
	vmand.mm	v8, v8, v10
	vmor.mm	v8, v8, v9
	vmsleu.vv	v12, v16, v24
	vmand.mm	v8, v8, v12
	vmand.mm	v9, v8, v9
	vmor.mm	v8, v8, v11
	vmand.mm	v8, v8, v10
	vmor.mm	v0, v8, v9
	slli	a4, a1, 1
	add	a3, a3, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e16, m2, ta, ma
	vse16.v	v8, (a3), v0.t
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a3, zero, e64, m8, ta, ma
	vadd.vx	v8, v16, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 3
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 5
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
