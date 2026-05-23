# Source: LoopVectorize/tail-folding-safe-dep-distance.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: no_high_lmul_or_interleave
# src = pre-opt (no_high_lmul_or_interleave), tgt = post-opt (no_high_lmul_or_interleave)
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
	j	.LBB5_1
.LBB5_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	slli	a1, a0, 3
	add	a1, a2, a1
	ld	a1, 0(a1)
	addi	a3, a0, 1024
	slli	a3, a3, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a2, a0, 1
	lui	a1, 1
	addi	a1, a1, -1095
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_2
.LBB5_2:                                # %exit
	addi	sp, sp, 16
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
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	li	a1, 0
	lui	a0, 1
	addi	a0, a0, -1094
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a1, 1024
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB5_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB5_2 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB5_4:                                # %vector.body
                                        #   in Loop: Header=BB5_2 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a2, e8, mf8, ta, ma
	slli	a4, a1, 3
	add	a4, a3, a4
                                        # implicit-def: $v8
	vsetvli	zero, a2, e64, m1, tu, ma
	vle64.v	v8, (a4)
	addi	a4, a1, 1024
	slli	a4, a4, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m1, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_5
.LBB5_5:                                # %middle.block
	j	.LBB5_6
.LBB5_6:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
