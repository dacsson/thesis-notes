# Source: LoopVectorize/runtime-check-dependent-on-stride.riscv64__v_loop-vectorize_UNIT-STRIDE-MV.ll
# Function: foo
# src = pre-opt (foo), tgt = post-opt (foo)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	addi	a1, a3, 2
	mv	a0, a1
	call	__muldi3
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 3
	add	a0, a0, a1
	addi	a0, a0, 128
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a5, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a5, a5, 3
	add	a1, a1, a5
	add	a2, a2, a5
	slli	a4, a4, 3
	add	a3, a3, a4
	ld	a1, 0(a1)
	ld	a3, 0(a3)
	add	a1, a1, a3
	sd	a1, 0(a2)
	li	a1, 64
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
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
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	addi	a1, a3, 2
	mv	a0, a1
	call	__muldi3
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 3
	add	a0, a0, a1
	addi	a0, a0, 128
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	addi	a2, a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	call	__muldi3
	ld	a5, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a5, a5, 3
	add	a1, a1, a5
	add	a2, a2, a5
	slli	a4, a4, 3
	add	a3, a3, a4
	ld	a1, 0(a1)
	ld	a3, 0(a3)
	add	a1, a1, a3
	sd	a1, 0(a2)
	li	a1, 64
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
