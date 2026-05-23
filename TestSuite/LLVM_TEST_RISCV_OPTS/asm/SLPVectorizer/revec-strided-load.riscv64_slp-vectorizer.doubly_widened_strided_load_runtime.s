# Source: SLPVectorizer/revec-strided-load.riscv64_slp-vectorizer.ll
# Function: doubly_widened_strided_load_runtime
# src = pre-opt (doubly_widened_strided_load_runtime), tgt = post-opt (doubly_widened_strided_load_runtime)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	slli	a2, a2, 1
	add	a2, a0, a2
	lbu	a7, 0(a0)
	lbu	t0, 1(a0)
	lbu	a5, 2(a0)
	lbu	a6, 3(a0)
	lbu	a3, 0(a2)
	lbu	a4, 1(a2)
	lbu	a0, 2(a2)
	lbu	a2, 3(a2)
	sb	t0, 1(a1)
	sb	a7, 0(a1)
	sb	a6, 3(a1)
	sb	a5, 2(a1)
	sb	a4, 5(a1)
	sb	a3, 4(a1)
	sb	a2, 7(a1)
	sb	a0, 6(a1)
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	slli	a2, a2, 1
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, tu, ma
	vlse32.v	v8, (a0), a2
	vse32.v	v8, (a1)
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
