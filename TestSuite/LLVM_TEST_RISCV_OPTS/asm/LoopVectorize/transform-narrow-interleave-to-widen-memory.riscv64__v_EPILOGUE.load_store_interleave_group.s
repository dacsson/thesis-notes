# Source: LoopVectorize/transform-narrow-interleave-to-widen-memory.riscv64__v_EPILOGUE.ll
# Function: load_store_interleave_group
# src = pre-opt (load_store_interleave_group), tgt = post-opt (load_store_interleave_group)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 4
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	li	a2, 0
	li	a0, 100
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 100
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 100
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_8
	j	.LBB0_6
.LBB0_6:                                # %scalar.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
