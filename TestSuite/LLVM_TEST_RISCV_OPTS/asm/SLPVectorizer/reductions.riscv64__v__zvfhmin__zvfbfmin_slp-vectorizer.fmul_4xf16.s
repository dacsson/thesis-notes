# Source: SLPVectorizer/reductions.riscv64__v__zvfhmin__zvfbfmin_slp-vectorizer.ll
# Function: fmul_4xf16
# src = pre-opt (fmul_4xf16), tgt = post-opt (fmul_4xf16)
# Triple: riscv64, Attrs: +v,+zvfhmin,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	mv	a1, a0
	lhu	a0, 0(a1)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lhu	a0, 2(a1)
	lhu	a2, 4(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	lhu	a1, 6(a1)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	fmul.s	fa5, fa0, fa5
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fmul.s	fa5, fa5, fa0
	fsw	fa5, 52(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 52(sp)                     # 4-byte Folded Reload
	fmul.s	fa0, fa5, fa0
	call	__truncsfhf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end24:
	.size	src, .Lfunc_end24-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	mv	a1, a0
	lhu	a0, 0(a1)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lhu	a0, 2(a1)
	lhu	a2, 4(a1)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	lhu	a1, 6(a1)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	fmul.s	fa5, fa0, fa5
	fsw	fa5, 36(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fmul.s	fa5, fa5, fa0
	fsw	fa5, 52(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 52(sp)                     # 4-byte Folded Reload
	fmul.s	fa0, fa5, fa0
	call	__truncsfhf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end24:
	.size	tgt, .Lfunc_end24-tgt
	.cfi_endproc
                                        # -- End function
