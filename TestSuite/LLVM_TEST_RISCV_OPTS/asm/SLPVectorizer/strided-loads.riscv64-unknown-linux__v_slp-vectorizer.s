# Source: SLPVectorizer/strided-loads.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: sum_of_abs
# src = pre-opt (sum_of_abs), tgt = post-opt (sum_of_abs)
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
	lbu	a2, 64(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 128(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 192(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 256(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 320(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a2, 384(a1)
	slli	a3, a2, 56
	srai	a3, a3, 63
	xor	a2, a2, a3
	subw	a2, a2, a3
	slli	a2, a2, 56
	srai	a2, a2, 56
	addw	a0, a0, a2
	lbu	a1, 448(a1)
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
	li	a1, 64
                                        # implicit-def: $v9
	vsetivli	zero, 8, e8, mf2, tu, ma
	vlse8.v	v9, (a0), a1
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, ta, ma
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
