# Source: SLPVectorizer/same-node-reused.riscv64__m__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: +m,+v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lh	a2, 0(a0)
	lh	a0, 4(a0)
	addw	a2, a2, a2
	addw	a0, a0, a0
	sh	a2, 0(a1)
	sh	a0, 2(a1)
	sh	a0, 4(a1)
	sh	a0, 6(a1)
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
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 5
                                        # implicit-def: $v8
	vsetivli	zero, 3, e16, mf2, ta, mu
	vle16.v	v8, (a1), v0.t
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, ta, ma
	vadd.vv	v9, v8, v8
                                        # implicit-def: $v10
	vrgather.vi	v10, v9, 2
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 14
                                        # implicit-def: $v8
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	vse16.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
