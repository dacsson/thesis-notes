# Source: SLPVectorizer/load-binop-store.riscv64__m__v_slp-vectorizer_DEFAULT.ll
# Function: vec_and
# src = pre-opt (vec_and), tgt = post-opt (vec_and)
# Triple: riscv64, Attrs: +m,+v
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
	mv	a3, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lh	a2, 0(a0)
	lh	a0, 2(a0)
	lh	a4, 0(a3)
	lh	a3, 2(a3)
	and	a2, a2, a4
	and	a0, a0, a3
	sh	a2, 0(a1)
	sh	a0, 2(a1)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
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
	vsetivli	zero, 2, e16, mf4, tu, ma
	vle16.v	v9, (a1)
                                        # implicit-def: $v10
	vle16.v	v10, (a2)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, ta, ma
	vand.vv	v8, v9, v10
	vse16.v	v8, (a0)
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
