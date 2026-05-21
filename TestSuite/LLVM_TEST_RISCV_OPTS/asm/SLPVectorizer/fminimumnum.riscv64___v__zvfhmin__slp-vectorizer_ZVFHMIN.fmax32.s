# Source: SLPVectorizer/fminimumnum.riscv64___v__zvfhmin__slp-vectorizer_ZVFHMIN.ll
# Function: fmax32
# src = pre-opt (fmax32), tgt = post-opt (fmax32)
# Triple: riscv64, Attrs: "+v,+zvfhmin"
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
	lui	a0, %hi(input1_f32)
	addi	a0, a0, %lo(input1_f32)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	lw	a0, 0(a0)
	lui	a1, %hi(input2_f32)
	addi	a1, a1, %lo(input2_f32)
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	lw	a1, 0(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lui	a3, %hi(output_f32)
	addi	a3, a3, %lo(output_f32)
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sw	a2, 0(a3)
	lw	a0, 4(a0)
	lw	a1, 4(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 4(a3)
	lw	a0, 8(a0)
	lw	a1, 8(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 8(a3)
	lw	a0, 12(a0)
	lw	a1, 12(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 12(a3)
	lw	a0, 16(a0)
	lw	a1, 16(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 16(a3)
	lw	a0, 20(a0)
	lw	a1, 20(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 20(a3)
	lw	a0, 24(a0)
	lw	a1, 24(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 24(a3)
	lw	a0, 28(a0)
	lw	a1, 28(a1)
	call	fmaximum_numf
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 28(a3)
	lw	a0, 32(a0)
	lw	a1, 32(a1)
	call	fmaximum_numf
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sw	a0, 32(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a2, %hi(input1_f32)
	addi	a2, a2, %lo(input1_f32)
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v10, (a2)
	lui	a1, %hi(input2_f32)
	addi	a1, a1, %lo(input2_f32)
                                        # implicit-def: $v12m2
	vle32.v	v12, (a1)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfmax.vv	v8, v10, v12
	lui	a0, %hi(output_f32)
	addi	a0, a0, %lo(output_f32)
	vse32.v	v8, (a0)
	flw	fa5, 32(a2)
	flw	fa4, 32(a1)
	fmax.s	fa5, fa5, fa4
	fsw	fa5, 32(a0)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
