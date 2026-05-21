# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer.ll
# Function: v3_load_f32_fadd_fadd_by_constant_store
# src = pre-opt (v3_load_f32_fadd_fadd_by_constant_store), tgt = post-opt (v3_load_f32_fadd_fadd_by_constant_store)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	flw	fa5, 0(a0)
	lui	a2, 266752
	fmv.w.x	fa2, a2
	fadd.s	fa3, fa5, fa2
	flw	fa5, 4(a0)
	fadd.s	fa4, fa5, fa2
	flw	fa5, 8(a0)
	fadd.s	fa5, fa5, fa2
	fsw	fa3, 0(a1)
	fsw	fa4, 4(a1)
	fsw	fa5, 8(a1)
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
                                        # implicit-def: $v9
	vsetivli	zero, 3, e32, m1, tu, ma
	vle32.v	v9, (a0)
	lui	a0, 266752
	fmv.w.x	fa5, a0
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, ta, ma
	vfadd.vf	v8, v9, fa5
	vsetivli	zero, 3, e32, m1, ta, ma
	vse32.v	v8, (a1)
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
