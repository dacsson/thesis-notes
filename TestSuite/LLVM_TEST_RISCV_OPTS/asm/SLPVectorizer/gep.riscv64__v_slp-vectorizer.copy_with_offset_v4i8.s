# Source: SLPVectorizer/gep.riscv64__v_slp-vectorizer.ll
# Function: copy_with_offset_v4i8
# src = pre-opt (copy_with_offset_v4i8), tgt = post-opt (copy_with_offset_v4i8)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	lbu	a2, 8(a0)
	sb	a2, 16(a1)
	lbu	a2, 9(a0)
	sb	a2, 17(a1)
	lbu	a2, 10(a0)
	sb	a2, 18(a1)
	lbu	a0, 11(a0)
	sb	a0, 19(a1)
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a1, a1, 8
	addi	a0, a0, 16
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v8, (a1)
	vse8.v	v8, (a0)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
