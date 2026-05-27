# Source: LoopVectorize/tail-folding-safe-dep-distance.riscv64__v_loop-vectorize_NO-VP.ll
# Function: trivial_due_max_vscale
# src = pre-opt (trivial_due_max_vscale), tgt = post-opt (trivial_due_max_vscale)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a2, a1, a2
	ld	a1, 0(a2)
	lui	a3, 16
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a2, a0, 1
	li	a1, 199
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB4_2:                                # %entry
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 200
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_6
	j	.LBB4_3
.LBB4_3:                                # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 200
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_4
.LBB4_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 3
	add	a3, a3, a4
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vle64.v	v8, (a3)
	lui	a4, 16
	add	a3, a3, a4
	vse64.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_4
	j	.LBB4_5
.LBB4_5:                                # %middle.block
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	li	a1, 200
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_8
	j	.LBB4_6
.LBB4_6:                                # %scalar.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_7
.LBB4_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a2, a1, a2
	ld	a1, 0(a2)
	lui	a3, 16
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a2, a0, 1
	li	a1, 199
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB4_7
	j	.LBB4_8
.LBB4_8:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
