# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer_1.ll
# Function: vec3_fpext_cost
# src = pre-opt (vec3_fpext_cost), tgt = post-opt (vec3_fpext_cost)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	fcvt.d.s	fa5, fa0
	fmv.d.x	fa4, zero
	fmadd.d	fa5, fa5, fa4, fa4
	fcvt.s.d	fa5, fa5
	fsw	fa5, 0(a0)
	fsw	fa5, 4(a0)
	fsw	fa5, 8(a0)
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, tu, ma
	vfmv.v.f	v8, fa0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, ta, ma
	vfwcvt.f.f.v	v9, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, tu, ma
	vmv.v.i	v8, 0
	fmv.d.x	fa4, zero
	vsetvli	zero, zero, e64, m1, ta, ma
	vfmadd.vf	v9, fa4, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vfncvt.f.f.w	v8, v9
	vse32.v	v8, (a0)
	fcvt.d.s	fa5, fa0
	fmadd.d	fa5, fa5, fa4, fa4
	fcvt.s.d	fa5, fa5
	fsw	fa5, 8(a0)
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
