# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: dot_product_fp64
# src = pre-opt (dot_product_fp64), tgt = post-opt (dot_product_fp64)
# Triple: riscv64, Attrs: +m,+v
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lwu	a3, 0(a1)
	lwu	a2, 4(a1)
	slli	a2, a2, 32
	or	a2, a2, a3
	fmv.d.x	fa3, a2
	lwu	a3, 8(a1)
	lwu	a2, 12(a1)
	slli	a2, a2, 32
	or	a2, a2, a3
	fmv.d.x	fa1, a2
	lwu	a2, 16(a1)
	lwu	a1, 20(a1)
	slli	a1, a1, 32
	or	a1, a1, a2
	fmv.d.x	fa5, a1
	lwu	a2, 0(a0)
	lwu	a1, 4(a0)
	slli	a1, a1, 32
	or	a1, a1, a2
	fmv.d.x	fa2, a1
	lwu	a2, 8(a0)
	lwu	a1, 12(a0)
	slli	a1, a1, 32
	or	a1, a1, a2
	fmv.d.x	fa0, a1
	lwu	a1, 16(a0)
	lwu	a0, 20(a0)
	slli	a0, a0, 32
	or	a0, a0, a1
	fmv.d.x	fa4, a0
	fmul.d	fa1, fa1, fa0
	fmadd.d	fa3, fa3, fa2, fa1
	fmadd.d	fa0, fa5, fa4, fa3
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end16:
	.size	src, .Lfunc_end16-src
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lwu	a3, 0(a1)
	lwu	a2, 4(a1)
	slli	a2, a2, 32
	or	a2, a2, a3
	fmv.d.x	fa3, a2
	lwu	a3, 8(a1)
	lwu	a2, 12(a1)
	slli	a2, a2, 32
	or	a2, a2, a3
	fmv.d.x	fa1, a2
	lwu	a2, 16(a1)
	lwu	a1, 20(a1)
	slli	a1, a1, 32
	or	a1, a1, a2
	fmv.d.x	fa5, a1
	lwu	a2, 0(a0)
	lwu	a1, 4(a0)
	slli	a1, a1, 32
	or	a1, a1, a2
	fmv.d.x	fa2, a1
	lwu	a2, 8(a0)
	lwu	a1, 12(a0)
	slli	a1, a1, 32
	or	a1, a1, a2
	fmv.d.x	fa0, a1
	lwu	a1, 16(a0)
	lwu	a0, 20(a0)
	slli	a0, a0, 32
	or	a0, a0, a1
	fmv.d.x	fa4, a0
	fmul.d	fa1, fa1, fa0
	fmadd.d	fa3, fa3, fa2, fa1
	fmadd.d	fa0, fa5, fa4, fa3
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end16:
	.size	tgt, .Lfunc_end16-tgt
	.cfi_endproc
                                        # -- End function
