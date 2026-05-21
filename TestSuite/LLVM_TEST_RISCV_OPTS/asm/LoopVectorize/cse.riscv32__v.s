# Source: LoopVectorize/cse.riscv32__v.ll
# Function: widenpointerinduction_evl_cse
# src = pre-opt (widenpointerinduction_evl_cse), tgt = post-opt (widenpointerinduction_evl_cse)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	li	a2, 0
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	sw	a1, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a3, 12(sp)                      # 4-byte Folded Reload
	lw	a4, 16(sp)                      # 4-byte Folded Reload
	sw	a2, 0(a4)
	sw	a1, 0(a3)
	addi	a0, a0, 1
	addi	a3, a2, 2
	addi	a2, a1, 2
	li	a1, 1024
	mv	a4, a0
	sw	a4, 20(sp)                      # 4-byte Folded Spill
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	li	a0, 0
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 4 * vlenb
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a0, zero, e32, m2, tu, ma
	vmv.v.x	v8, a2
	addi	a0, sp, 32
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vmv.v.x	v8, a1
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 32
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	li	a0, 1024
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 32
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	addi	a3, sp, 32
	vl2r.v	v14, (a3)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v16m2
	vadd.vv	v16, v8, v8
                                        # implicit-def: $v8m2
	vadd.vx	v8, v16, a1
                                        # implicit-def: $v12m2
	vadd.vx	v12, v16, a2
	vsetvli	a3, a0, e8, mf2, ta, ma
	li	a4, 0
	vsetvli	zero, a3, e32, m2, ta, ma
	vsoxei32.v	v12, (a4), v14
	vsetvli	zero, a3, e32, m2, ta, ma
	vsoxei32.v	v8, (a4), v10
	sub	a0, a0, a3
	slli	a3, a3, 1
	add	a2, a2, a3
	add	a1, a1, a3
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	mv	a1, a0
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	li	a0, 0
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
