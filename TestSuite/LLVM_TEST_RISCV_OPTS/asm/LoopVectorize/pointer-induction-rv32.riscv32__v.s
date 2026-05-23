# Source: LoopVectorize/pointer-induction-rv32.riscv32__v.ll
# Function: widenpointerinduction_evl
# src = pre-opt (widenpointerinduction_evl), tgt = post-opt (widenpointerinduction_evl)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	li	a1, 0
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	lw	a2, 4(sp)                       # 4-byte Folded Reload
	sw	a1, 0(a2)
	addi	a0, a0, 1
	addi	a2, a1, 1
	li	a1, 1024
	mv	a3, a0
	sw	a3, 8(sp)                       # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	li	a0, 0
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	lw	a1, 28(sp)                      # 4-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a0, zero, e32, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a0, sp, 32
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	li	a0, 1024
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	addi	a2, sp, 32
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v12m2
	vsetvli	a2, zero, e32, m2, ta, ma
	vid.v	v12
                                        # implicit-def: $v8m2
	vadd.vx	v8, v12, a1
	vsetvli	a2, a0, e8, mf2, ta, ma
	li	a3, 0
	vsetvli	zero, a2, e32, m2, ta, ma
	vsoxei32.v	v8, (a3), v10
	sub	a0, a0, a2
	add	a1, a1, a2
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	mv	a1, a0
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	li	a0, 0
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
