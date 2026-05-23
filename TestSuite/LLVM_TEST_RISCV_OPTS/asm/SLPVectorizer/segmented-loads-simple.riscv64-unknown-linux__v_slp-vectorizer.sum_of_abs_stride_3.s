# Source: SLPVectorizer/segmented-loads-simple.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: sum_of_abs_stride_3
# src = pre-opt (sum_of_abs_stride_3), tgt = post-opt (sum_of_abs_stride_3)
# Triple: riscv64-unknown-linux, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	lbu	a0, 0(a1)
	slli	a2, a0, 56
	srai	a2, a2, 63
	xor	a0, a0, a2
	subw	a0, a0, a2
	slli	a0, a0, 56
	srai	a0, a0, 56
	lbu	a2, 3(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 6(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 9(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 12(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 15(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 18(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a1, 21(a1)
	slli	a2, a1, 56
	srai	a2, a2, 63
	xor	a1, a1, a2
	subw	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	addw	a0, a0, a1
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a1, 585
	addi	a1, a1, 585
                                        # implicit-def: $v0
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v12m2
	vsetivli	zero, 22, e8, m2, ta, mu
	vle8.v	v12, (a0), v0.t
	vmv1r.v	v10, v12
                                        # implicit-def: $v8m2
	vsetivli	zero, 16, e8, m2, ta, ma
	vslidedown.vi	v8, v12, 16
	vmv1r.v	v9, v8
	lui	a0, 9
	addi	a0, a0, 585
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m4, tu, ma
	vmv.s.x	v0, a0
                                        # implicit-def: $v8
	vsetivli	zero, 16, e8, m1, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	lui	a0, %hi(.LCPI1_0)
	ld	a0, %lo(.LCPI1_0)(a0)
                                        # implicit-def: $v10
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v10, a0
                                        # implicit-def: $v9
	vsetivli	zero, 16, e8, m1, ta, ma
	vrgather.vv	v9, v8, v10
                                        # implicit-def: $v10
	vsetivli	zero, 8, e8, mf2, ta, ma
	vrsub.vi	v10, v9, 0
                                        # implicit-def: $v8
	vmax.vv	v8, v9, v10
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vsext.vf4	v10, v8
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
