# Source: SLPVectorizer/segmented-loads-simple.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: sum_of_abs_stride_2
# src = pre-opt (sum_of_abs_stride_2), tgt = post-opt (sum_of_abs_stride_2)
# Triple: riscv64-unknown-linux, Attrs: +v
#

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
	lbu	a2, 2(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 4(a1)
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
	lbu	a2, 8(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 10(a1)
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
	lbu	a1, 14(a1)
	slli	a2, a1, 56
	srai	a2, a2, 63
	xor	a1, a1, a2
	subw	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	addw	a0, a0, a1
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
	lui	a1, 5
	addi	a1, a1, 1365
                                        # implicit-def: $v0
	vsetivli	zero, 1, e16, m1, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v8
	vsetivli	zero, 15, e8, m1, ta, mu
	vle8.v	v8, (a0), v0.t
                                        # implicit-def: $v9
	vsetivli	zero, 8, e8, mf2, ta, ma
	vnsrl.wi	v9, v8, 0
                                        # implicit-def: $v10
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
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
