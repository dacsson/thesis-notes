# Source: SLPVectorizer/strided-loads-vectorized.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test_f16
# src = pre-opt (test_f16), tgt = post-opt (test_f16)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	lhu	a0, 0(a1)
	lhu	a1, 60(a1)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 0(a2)
	lhu	a0, 8(a1)
	lhu	a1, 52(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 2(a2)
	lhu	a0, 16(a1)
	lhu	a1, 44(a1)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fsw	fa0, 52(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 52(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 4(a2)
	lhu	a0, 24(a1)
	lhu	a1, 36(a1)
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	fsw	fa0, 68(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 68(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 6(a2)
	lhu	a0, 32(a1)
	lhu	a1, 28(a1)
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	fsw	fa0, 84(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 84(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 8(a2)
	lhu	a0, 40(a1)
	lhu	a1, 20(a1)
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	fsw	fa0, 100(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 100(sp)                    # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 10(a2)
	lhu	a0, 48(a1)
	lhu	a1, 12(a1)
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	fsw	fa0, 116(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 116(sp)                    # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 12(a2)
	lhu	a0, 56(a1)
	lhu	a1, 4(a1)
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	fsw	fa0, 140(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 140(sp)                    # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 14(a1)
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
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
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	lhu	a0, 0(a1)
	lhu	a1, 60(a1)
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	fsw	fa0, 20(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 0(a2)
	lhu	a0, 8(a1)
	lhu	a1, 52(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	fsw	fa0, 36(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 36(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 2(a2)
	lhu	a0, 16(a1)
	lhu	a1, 44(a1)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fsw	fa0, 52(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 52(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 4(a2)
	lhu	a0, 24(a1)
	lhu	a1, 36(a1)
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	fsw	fa0, 68(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 68(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 6(a2)
	lhu	a0, 32(a1)
	lhu	a1, 28(a1)
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	fsw	fa0, 84(sp)                     # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 84(sp)                     # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 8(a2)
	lhu	a0, 40(a1)
	lhu	a1, 20(a1)
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	fsw	fa0, 100(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 100(sp)                    # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 10(a2)
	lhu	a0, 48(a1)
	lhu	a1, 12(a1)
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	fsw	fa0, 116(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 116(sp)                    # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 12(a2)
	lhu	a0, 56(a1)
	lhu	a1, 4(a1)
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	fsw	fa0, 140(sp)                    # 4-byte Folded Spill
	fmv.w.x	fa0, a0
	call	__extendhfsf2
	flw	fa5, 140(sp)                    # 4-byte Folded Reload
	fsub.s	fa0, fa0, fa5
	call	__truncsfhf2
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	fmv.x.w	a0, fa0
	sh	a0, 14(a1)
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
