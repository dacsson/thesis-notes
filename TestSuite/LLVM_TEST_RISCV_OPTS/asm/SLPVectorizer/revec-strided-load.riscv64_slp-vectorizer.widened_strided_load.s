# Source: SLPVectorizer/revec-strided-load.riscv64_slp-vectorizer.ll
# Function: widened_strided_load
# src = pre-opt (widened_strided_load), tgt = post-opt (widened_strided_load)
# Triple: riscv64, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	sd	s1, 0(sp)                       # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	mv	t0, a0
	lbu	t1, 0(t0)
	lbu	t2, 1(t0)
	lbu	t3, 2(t0)
	lbu	t4, 3(t0)
	lbu	t5, 4(t0)
	lbu	t6, 5(t0)
	lbu	s0, 6(t0)
	lbu	s1, 7(t0)
	lbu	a0, 16(t0)
	lbu	a2, 17(t0)
	lbu	a3, 18(t0)
	lbu	a4, 19(t0)
	lbu	a5, 20(t0)
	lbu	a6, 21(t0)
	lbu	a7, 22(t0)
	lbu	t0, 23(t0)
	sb	s1, 7(a1)
	sb	s0, 6(a1)
	sb	t6, 5(a1)
	sb	t5, 4(a1)
	sb	t4, 3(a1)
	sb	t3, 2(a1)
	sb	t2, 1(a1)
	sb	t1, 0(a1)
	sb	t0, 15(a1)
	sb	a7, 14(a1)
	sb	a6, 13(a1)
	sb	a5, 12(a1)
	sb	a4, 11(a1)
	sb	a3, 10(a1)
	sb	a2, 9(a1)
	sb	a0, 8(a1)
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	ld	s1, 0(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	li	a2, 16
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vlse64.v	v8, (a0), a2
	vse64.v	v8, (a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
