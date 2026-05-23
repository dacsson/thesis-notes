# Source: LoopVectorize/dead-ops-cost.riscv64-linux-gnu__v__f.ll
# Function: dead_load
# src = pre-opt (dead_load), tgt = post-opt (dead_load)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	slli	a0, a1, 48
	srai	a0, a0, 48
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 1
	add	a2, a1, a2
	li	a1, 0
	sh	a1, 0(a2)
	addi	a2, a0, 3
	li	a1, 111
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 8 * vlenb
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	slli	a0, a1, 48
	srai	a1, a0, 48
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	li	a0, 111
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a1
	li	a1, 1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_4
# %bb.3:                                # %entry
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
.LBB0_4:                                # %entry
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sub	a0, a0, a2
	sub	a0, a0, a1
	li	a1, 3
	call	__udivdi3
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	add	a0, a0, a1
	addi	a0, a0, 1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v16m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v16, a1
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vid.v	v8
	li	a1, 3
	vmadd.vx	v8, a1, v16
	addi	a1, sp, 112
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 112
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
	addi	a1, sp, 112
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_6
	j	.LBB0_7
.LBB0_7:                                # %middle.block
	j	.LBB0_8
.LBB0_8:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
