# Source: SLPVectorizer/fminimumnum.riscv64___v__zvfhmin__slp-vectorizer_ZVFHMIN.ll
# Function: fmin64
# src = pre-opt (fmin64), tgt = post-opt (fmin64)
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
	lui	a0, %hi(input1_f64)
	addi	a0, a0, %lo(input1_f64)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	ld	a0, 0(a0)
	lui	a1, %hi(input2_f64)
	addi	a1, a1, %lo(input2_f64)
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lui	a3, %hi(output_f64)
	addi	a3, a3, %lo(output_f64)
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 0(a3)
	ld	a0, 8(a0)
	ld	a1, 8(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 8(a3)
	ld	a0, 16(a0)
	ld	a1, 16(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 16(a3)
	ld	a0, 24(a0)
	ld	a1, 24(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 24(a3)
	ld	a0, 32(a0)
	ld	a1, 32(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 32(a3)
	ld	a0, 40(a0)
	ld	a1, 40(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 40(a3)
	ld	a0, 48(a0)
	ld	a1, 48(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 48(a3)
	ld	a0, 56(a0)
	ld	a1, 56(a1)
	call	fminimum_num
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 56(a3)
	ld	a0, 64(a0)
	ld	a1, 64(a1)
	call	fminimum_num
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 64(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a2, %hi(input1_f64)
	addi	a2, a2, %lo(input1_f64)
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v10, (a2)
	lui	a1, %hi(input2_f64)
	addi	a1, a1, %lo(input2_f64)
                                        # implicit-def: $v12m2
	vle64.v	v12, (a1)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vfmin.vv	v8, v10, v12
	lui	a0, %hi(output_f64)
	addi	a0, a0, %lo(output_f64)
	vse64.v	v8, (a0)
	addi	a3, a2, 32
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vle64.v	v10, (a3)
	addi	a3, a1, 32
                                        # implicit-def: $v12m2
	vle64.v	v12, (a3)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vfmin.vv	v8, v10, v12
	addi	a3, a0, 32
	vse64.v	v8, (a3)
	fld	fa5, 64(a2)
	fld	fa4, 64(a1)
	fmin.d	fa5, fa5, fa4
	fsd	fa5, 64(a0)
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
