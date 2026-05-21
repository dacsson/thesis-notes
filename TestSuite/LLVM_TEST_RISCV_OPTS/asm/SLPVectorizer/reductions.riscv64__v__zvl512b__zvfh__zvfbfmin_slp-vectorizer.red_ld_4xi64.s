# Source: SLPVectorizer/reductions.riscv64__v__zvl512b__zvfh__zvfbfmin_slp-vectorizer.ll
# Function: red_ld_4xi64
# src = pre-opt (red_ld_4xi64), tgt = post-opt (red_ld_4xi64)
# Triple: riscv64, Attrs: +v,+zvl512b,+zvfh,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	ld	a0, 0(a1)
	ld	a2, 8(a1)
	add	a0, a0, a2
	ld	a2, 16(a1)
	add	a0, a0, a2
	ld	a1, 24(a1)
	add	a0, a0, a1
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	vsetivli	zero, 4, e64, m1, tu, ma
	vle64.v	v9, (a0)
	li	a0, 0
                                        # implicit-def: $v10
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
