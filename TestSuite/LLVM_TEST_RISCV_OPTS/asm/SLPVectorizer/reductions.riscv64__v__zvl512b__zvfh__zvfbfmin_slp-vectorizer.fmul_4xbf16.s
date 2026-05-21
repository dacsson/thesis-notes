# Source: SLPVectorizer/reductions.riscv64__v__zvl512b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: fmul_4xbf16
# src = pre-opt (fmul_4xbf16), tgt = post-opt (fmul_4xbf16)
# Triple: riscv64, Attrs: +v,+zvl512b,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	lhu	a2, 0(a0)
	lhu	a3, 2(a0)
	lhu	a1, 4(a0)
	lhu	a0, 6(a0)
	slliw	a3, a3, 16
	fmv.w.x	fa4, a3
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	fmul.s	fa5, fa5, fa4
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	fmul.s	fa5, fa5, fa4
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fmul.s	fa0, fa5, fa4
	call	__truncsfbf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end22:
	.size	src, .Lfunc_end22-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	lhu	a2, 0(a0)
	lhu	a3, 2(a0)
	lhu	a1, 4(a0)
	lhu	a0, 6(a0)
	slliw	a3, a3, 16
	fmv.w.x	fa4, a3
	slliw	a2, a2, 16
	fmv.w.x	fa5, a2
	fmul.s	fa5, fa5, fa4
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	fmul.s	fa5, fa5, fa4
	slliw	a0, a0, 16
	fmv.w.x	fa4, a0
	fmul.s	fa0, fa5, fa4
	call	__truncsfbf2
	fmv.x.w	a0, fa0
	lui	a1, 1048560
	or	a0, a0, a1
	fmv.w.x	fa0, a0
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end22:
	.size	tgt, .Lfunc_end22-tgt
	.cfi_endproc
                                        # -- End function
