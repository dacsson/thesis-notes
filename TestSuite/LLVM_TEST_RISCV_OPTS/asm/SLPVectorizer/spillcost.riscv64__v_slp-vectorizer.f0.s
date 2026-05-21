# Source: SLPVectorizer/spillcost.riscv64__v_slp-vectorizer.ll
# Function: f0
# src = pre-opt (f0), tgt = post-opt (f0)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %foo
	call	g
	call	g
	call	g
	j	.LBB0_3
.LBB0_2:                                # %bar
	call	g
	call	g
	call	g
	j	.LBB0_3
.LBB0_3:                                # %baz
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
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
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %foo
	call	g
	call	g
	call	g
	j	.LBB0_3
.LBB0_2:                                # %bar
	call	g
	call	g
	call	g
	j	.LBB0_3
.LBB0_3:                                # %baz
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
