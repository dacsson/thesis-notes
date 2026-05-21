# Source: LoopVectorize/interleaved-store-with-gap.riscv64__v_loop-vectorize.ll
# Function: store_factor_2_with_tail_gap
# src = pre-opt (store_factor_2_with_tail_gap), tgt = post-opt (store_factor_2_with_tail_gap)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
	sd	a0, 0(a2)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x09, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 9 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a2, 0
	li	a1, 16
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m8
	vsetivli	zero, 16, e64, m8, ta, ma
	vid.v	v8
	andi	a0, a0, -16
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vs8r.v	v8, (a0)                        # vscale x 64-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 64
	vl8r.v	v16, (a3)                       # vscale x 64-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v24m2
	vsrl.vi	v24, v8, 1
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
                                        # implicit-def: $v6m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vadd.vi	v6, v24, 8
                                        # implicit-def: $v24m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v24, v16, v6
	addi	a3, a2, 128
	lui	a4, 5
	addi	a4, a4, 1365
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a4
	addi	a4, sp, 64
	vs1r.v	v0, (a4)                        # vscale x 8-byte Folded Spill
	vse64.v	v24, (a3), v0.t
	addi	a3, sp, 64
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
	vse64.v	v8, (a2), v0.t
	addi	a0, a0, 16
	li	a2, 16
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vadd.vx	v8, v16, a2
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vs8r.v	v8, (a2)                        # vscale x 64-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_6
	j	.LBB0_4
.LBB0_4:                                # %scalar.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 4
	add	a2, a2, a3
	sd	a0, 0(a2)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_5
	j	.LBB0_6
.LBB0_6:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 3
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
