# Source: SLPVectorizer/revec-strided-store.riscv64_slp-vectorizer.ll
# Function: doubly_widened_strided_store
# src = pre-opt (doubly_widened_strided_store), tgt = post-opt (doubly_widened_strided_store)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	li	a0, 0
	sb	a0, 1(a1)
	sb	a0, 0(a1)
	sb	a0, 3(a1)
	sb	a0, 2(a1)
	sb	a0, 13(a1)
	sb	a0, 12(a1)
	sb	a0, 15(a1)
	sb	a0, 14(a1)
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	addi	a0, a1, 12
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.i	v8, 0
	vse8.v	v8, (a1)
	vse8.v	v8, (a0)
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
