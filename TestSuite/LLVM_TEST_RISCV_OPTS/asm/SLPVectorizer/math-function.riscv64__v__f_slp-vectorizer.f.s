# Source: SLPVectorizer/math-function.riscv64__v__f_slp-vectorizer.ll
# Function: f
# src = pre-opt (f), tgt = post-opt (f)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB32_2
	j	.LBB32_1
.LBB32_1:                               # %foo
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa0, 0(a0)
	call	fabsf
	j	.LBB32_3
.LBB32_2:                               # %bar
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa0, 0(a0)
	call	fabsf
	j	.LBB32_3
.LBB32_3:                               # %baz
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end32:
	.size	src, .Lfunc_end32-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	andi	a0, a2, 1
	ld	a2, 0(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	ld	a1, 8(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB32_2
	j	.LBB32_1
.LBB32_1:                               # %foo
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa0, 0(a0)
	call	fabsf
	j	.LBB32_3
.LBB32_2:                               # %bar
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa0, 0(a0)
	call	fabsf
	j	.LBB32_3
.LBB32_3:                               # %baz
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(a1)
	sd	a0, 8(a1)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end32:
	.size	tgt, .Lfunc_end32-tgt
	.cfi_endproc
                                        # -- End function
