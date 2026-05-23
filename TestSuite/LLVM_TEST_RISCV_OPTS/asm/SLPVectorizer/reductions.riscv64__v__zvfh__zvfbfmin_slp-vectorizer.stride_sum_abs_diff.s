# Source: SLPVectorizer/reductions.riscv64__v__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: stride_sum_abs_diff
# src = pre-opt (stride_sum_abs_diff), tgt = post-opt (stride_sum_abs_diff)
# Triple: riscv64, Attrs: +v,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a3, a2
	mv	a2, a1
	mv	a1, a0
	lw	a0, 0(a1)
	lw	a4, 0(a2)
	sub	a0, a0, a4
	sraiw	a4, a0, 31
	xor	a0, a0, a4
	subw	a0, a0, a4
	lw	a4, 4(a1)
	lw	a5, 4(a2)
	sub	a4, a4, a5
	sraiw	a5, a4, 31
	xor	a4, a4, a5
	subw	a4, a4, a5
	addw	a0, a0, a4
	slli	a3, a3, 2
	add	a1, a1, a3
	add	a2, a2, a3
	lw	a3, 0(a1)
	lw	a4, 0(a2)
	sub	a3, a3, a4
	sraiw	a4, a3, 31
	xor	a3, a3, a4
	subw	a3, a3, a4
	addw	a0, a0, a3
	lw	a1, 4(a1)
	lw	a2, 4(a2)
	sub	a1, a1, a2
	sraiw	a2, a1, 31
	xor	a1, a1, a2
	subw	a1, a1, a2
	addw	a0, a0, a1
	ret
.Lfunc_end18:
	.size	src, .Lfunc_end18-src
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	mv	a3, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 2
	add	a1, a3, a0
	add	a0, a2, a0
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, tu, ma
	vle32.v	v9, (a3)
                                        # implicit-def: $v10
	vle32.v	v10, (a2)
                                        # implicit-def: $v11
	vle32.v	v11, (a1)
                                        # implicit-def: $v8
	vle32.v	v8, (a0)
	vsetivli	zero, 4, e32, m1, ta, ma
	vslideup.vi	v9, v11, 2
	vslideup.vi	v10, v8, 2
                                        # implicit-def: $v8
	vsub.vv	v8, v9, v10
                                        # implicit-def: $v10
	vrsub.vi	v10, v8, 0
                                        # implicit-def: $v9
	vmax.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end18:
	.size	tgt, .Lfunc_end18-tgt
	.cfi_endproc
                                        # -- End function
