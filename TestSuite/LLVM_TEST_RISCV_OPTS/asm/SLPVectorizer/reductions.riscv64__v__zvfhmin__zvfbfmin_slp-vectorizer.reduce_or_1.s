# Source: SLPVectorizer/reductions.riscv64__v__zvfhmin__zvfbfmin_slp-vectorizer.ll
# Function: reduce_or_1
# src = pre-opt (reduce_or_1), tgt = post-opt (reduce_or_1)
# Triple: riscv64, Attrs: +v,+zvfhmin,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lbu	a3, 0(a2)
	lbu	a1, 0(a0)
	xor	a3, a1, a3
	lbu	a4, 1(a2)
	lbu	a1, 1(a0)
	xor	a1, a1, a4
	or	a3, a1, a3
	lbu	a4, 2(a2)
	lbu	a1, 2(a0)
	xor	a1, a1, a4
	or	a3, a1, a3
	lbu	a4, 3(a2)
	lbu	a1, 3(a0)
	xor	a1, a1, a4
	or	a3, a1, a3
	lbu	a4, 4(a2)
	lbu	a1, 4(a0)
	xor	a1, a1, a4
	or	a3, a1, a3
	lbu	a4, 5(a2)
	lbu	a1, 5(a0)
	xor	a1, a1, a4
	or	a3, a1, a3
	lbu	a4, 6(a2)
	lbu	a1, 6(a0)
	xor	a1, a1, a4
	or	a1, a1, a3
	lbu	a2, 7(a2)
	lbu	a0, 7(a0)
	xor	a0, a0, a2
	or	a0, a0, a1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vxor.vv	v9, v8, v10
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
