# Source: SLPVectorizer/fminimumnum.riscv64___v__zvfh__slp-vectorizer.ll
# Function: fmin16
# src = pre-opt (fmin16), tgt = post-opt (fmin16)
# Triple: riscv64, Attrs: "+v,+zvfh"
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sd	ra, 168(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	lui	a0, %hi(input1_f16)
	addi	a0, a0, %lo(input1_f16)
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	lhu	a0, 0(a0)
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	lui	a0, %hi(input2_f16)
	addi	a0, a0, %lo(input2_f16)
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	lhu	a0, 0(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	lui	a3, %hi(output_f16)
	addi	a3, a3, %lo(output_f16)
	sd	a3, 160(sp)                     # 8-byte Folded Spill
	sh	a2, 0(a3)
	lhu	a1, 2(a1)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	lhu	a0, 2(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 2(a3)
	lhu	a1, 4(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	lhu	a0, 4(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 4(a3)
	lhu	a1, 6(a1)
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	lhu	a0, 6(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 6(a3)
	lhu	a1, 8(a1)
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	lhu	a0, 8(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 8(a3)
	lhu	a1, 10(a1)
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	lhu	a0, 10(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 10(a3)
	lhu	a1, 12(a1)
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	lhu	a0, 12(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 12(a3)
	lhu	a1, 14(a1)
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	lhu	a0, 14(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sh	a2, 14(a3)
	lhu	a1, 16(a1)
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	lhu	a0, 16(a0)
	call	__extendhfsf2
	mv	a1, a0
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a1, 152(sp)                     # 8-byte Folded Spill
	call	__extendhfsf2
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	call	fminimum_numf
	call	__truncsfhf2
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	sh	a0, 16(a1)
	ld	ra, 168(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a2, %hi(input1_f16)
	addi	a2, a2, %lo(input1_f16)
                                        # implicit-def: $v9
	vsetivli	zero, 8, e16, m1, tu, ma
	vle16.v	v9, (a2)
	lui	a1, %hi(input2_f16)
	addi	a1, a1, %lo(input2_f16)
                                        # implicit-def: $v10
	vle16.v	v10, (a1)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m1, ta, ma
	vfmin.vv	v8, v9, v10
	lui	a0, %hi(output_f16)
	addi	a0, a0, %lo(output_f16)
	vse16.v	v8, (a0)
	flh	fa5, 16(a2)
	flh	fa4, 16(a1)
	fcvt.s.h	fa4, fa4
	fcvt.s.h	fa5, fa5
	fmin.s	fa5, fa5, fa4
	fcvt.h.s	fa5, fa5
	fsh	fa5, 16(a0)
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
