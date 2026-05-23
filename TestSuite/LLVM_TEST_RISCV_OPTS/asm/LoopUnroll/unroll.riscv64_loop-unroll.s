# Source: LoopUnroll/unroll.riscv64_loop-unroll.ll
# Function: saxpy
# src = pre-opt (saxpy), tgt = post-opt (saxpy)
# Triple: riscv64, Attrs: none
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
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a2
	lw	a0, 0(a0)
	call	__mulsf3
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	add	a1, a1, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lw	a1, 0(a1)
	call	__addsf3
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 64
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit_loop
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
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	flw	fa4, 36(sp)                     # 4-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a4, a3, a2
	flw	fa5, 0(a4)
	add	a4, a1, a2
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 4
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 8
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 12
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 16
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 20
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 24
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 28
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 32
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 36
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 40
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 44
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 48
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 52
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a4, a2, 56
	add	a5, a3, a4
	flw	fa5, 0(a5)
	add	a4, a4, a1
	flw	fa3, 0(a4)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a4)
	addi	a2, a2, 60
	add	a3, a3, a2
	flw	fa5, 0(a3)
	add	a1, a1, a2
	flw	fa3, 0(a1)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, 0(a1)
	addi	a0, a0, 16
	li	a1, 64
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit_loop
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
