# Source: SLPVectorizer/loads-ordering.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: rephase
# src = pre-opt (rephase), tgt = post-opt (rephase)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	add	a1, a2, a1
	fld	fa5, 0(a2)
	fmv.d.x	fa4, zero
	fmul.d	fa4, fa5, fa4
	fsd	fa4, 408(a1)
	fsd	fa4, 416(a1)
	fld	fa4, 424(a1)
	fmul.d	fa4, fa5, fa4
	fsd	fa4, 424(a1)
	fld	fa4, 432(a1)
	fmul.d	fa4, fa5, fa4
	fsd	fa4, 432(a1)
	fsd	fa5, 0(a0)
	addi	sp, sp, 16
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
# %bb.0:                                # %entry
	add	a2, a1, a2
	fld	fa5, 0(a1)
	addi	a1, a2, 408
	addi	a2, a2, 424
                                        # implicit-def: $v10
	vsetivli	zero, 2, e64, m1, tu, ma
	vle64.v	v10, (a2)
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v10
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.i	v10, 0
	vmv1r.v	v9, v12
	vsetvli	zero, zero, e64, m2, ta, ma
	vslideup.vi	v10, v8, 2
                                        # implicit-def: $v8m2
	vfmul.vf	v8, v10, fa5
	vse64.v	v8, (a1)
	fsd	fa5, 0(a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
