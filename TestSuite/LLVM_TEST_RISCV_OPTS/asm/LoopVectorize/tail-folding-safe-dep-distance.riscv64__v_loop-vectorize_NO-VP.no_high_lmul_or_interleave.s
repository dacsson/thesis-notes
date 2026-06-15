# Source: LoopVectorize/tail-folding-safe-dep-distance.riscv64__v_loop-vectorize_NO-VP.ll
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 3
	add	a2, a1, a2
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v8, (a2)
	addi	a2, a0, 1024
	slli	a2, a2, 3
	add	a1, a1, a2
	vse64.v	v8, (a1)
	addi	a0, a0, 4
	lui	a1, 1
	addi	a1, a1, -1096
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB5_2
	j	.LBB5_3
.LBB5_3:                                # %middle.block
	j	.LBB5_4
.LBB5_4:                                # %scalar.ph
	lui	a0, 1
	addi	a0, a0, -1096
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_5
.LBB5_5:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
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
	bne	a0, a1, .LBB5_5
	j	.LBB5_6
.LBB5_6:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
