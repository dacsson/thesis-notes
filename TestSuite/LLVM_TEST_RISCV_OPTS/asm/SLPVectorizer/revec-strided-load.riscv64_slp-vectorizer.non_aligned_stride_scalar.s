# Source: SLPVectorizer/revec-strided-load.riscv64_slp-vectorizer.ll
# Function: non_aligned_stride_scalar
# src = pre-opt (non_aligned_stride_scalar), tgt = post-opt (non_aligned_stride_scalar)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lbu	a4, 0(a0)
	lbu	a3, 1(a0)
	lbu	a2, 3(a0)
	lbu	a0, 4(a0)
	sb	a4, 0(a1)
	sb	a3, 1(a1)
	sb	a2, 2(a1)
	sb	a0, 3(a1)
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	li	a2, 27
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, m1, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v10
	vsetivli	zero, 5, e8, mf2, ta, mu
	vle8.v	v10, (a0), v0.t
	vmv1r.v	v9, v10
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 4
	vsetivli	zero, 4, e8, mf4, ta, mu
	vslidedown.vi	v9, v9, 1, v0.t
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf2, ta, ma
	vslidedown.vi	v8, v10, 4
                                        # implicit-def: $v10
	vsetivli	zero, 4, e8, mf4, ta, ma
	vrgather.vi	v10, v8, 0
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	vse8.v	v8, (a1)
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
