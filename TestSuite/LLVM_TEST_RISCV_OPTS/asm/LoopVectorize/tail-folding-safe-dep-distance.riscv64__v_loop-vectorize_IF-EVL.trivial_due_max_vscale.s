# Source: LoopVectorize/tail-folding-safe-dep-distance.riscv64__v_loop-vectorize_IF-EVL.ll
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	li	a0, 200
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 3
	add	a3, a3, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vle64.v	v8, (a3)
	lui	a4, 16
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
