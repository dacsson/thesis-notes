# Source: SLPVectorizer/strided-loads-vectorized.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test_bf16
# src = pre-opt (test_bf16), tgt = post-opt (test_bf16)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lhu	a1, 0(a0)
	lhu	a0, 60(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 0(a2)
	lhu	a1, 8(a0)
	lhu	a0, 52(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 2(a2)
	lhu	a1, 16(a0)
	lhu	a0, 44(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 4(a2)
	lhu	a1, 24(a0)
	lhu	a0, 36(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 6(a2)
	lhu	a1, 32(a0)
	lhu	a0, 28(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 8(a2)
	lhu	a1, 40(a0)
	lhu	a0, 20(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 10(a2)
	lhu	a1, 48(a0)
	lhu	a0, 12(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 12(a2)
	lhu	a1, 56(a0)
	lhu	a0, 4(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 14(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
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
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lhu	a1, 0(a0)
	lhu	a0, 60(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 0(a2)
	lhu	a1, 8(a0)
	lhu	a0, 52(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 2(a2)
	lhu	a1, 16(a0)
	lhu	a0, 44(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 4(a2)
	lhu	a1, 24(a0)
	lhu	a0, 36(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 6(a2)
	lhu	a1, 32(a0)
	lhu	a0, 28(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 8(a2)
	lhu	a1, 40(a0)
	lhu	a0, 20(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 10(a2)
	lhu	a1, 48(a0)
	lhu	a0, 12(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a1, fa0
	sh	a1, 12(a2)
	lhu	a1, 56(a0)
	lhu	a0, 4(a0)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fsub.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 14(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
