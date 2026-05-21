# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: const_stride_2_no_reordering
# src = pre-opt (const_stride_2_no_reordering), tgt = post-opt (const_stride_2_no_reordering)
# Triple: riscv64, Attrs: +m,+v,+unaligned-vector-mem
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	sd	s1, 0(sp)                       # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	lbu	s1, 0(a0)
	lbu	s0, 2(a0)
	lbu	t6, 4(a0)
	lbu	t5, 6(a0)
	lbu	t4, 8(a0)
	lbu	t3, 10(a0)
	lbu	t2, 12(a0)
	lbu	t1, 14(a0)
	lbu	t0, 16(a0)
	lbu	a7, 18(a0)
	lbu	a6, 20(a0)
	lbu	a5, 22(a0)
	lbu	a4, 24(a0)
	lbu	a3, 26(a0)
	lbu	a2, 28(a0)
	lbu	a0, 30(a0)
	sb	s1, 0(a1)
	sb	s0, 1(a1)
	sb	t6, 2(a1)
	sb	t5, 3(a1)
	sb	t4, 4(a1)
	sb	t3, 5(a1)
	sb	t2, 6(a1)
	sb	t1, 7(a1)
	sb	t0, 8(a1)
	sb	a7, 9(a1)
	sb	a6, 10(a1)
	sb	a5, 11(a1)
	sb	a4, 12(a1)
	sb	a3, 13(a1)
	sb	a2, 14(a1)
	sb	a0, 15(a1)
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	ld	s1, 0(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a2, 349525
	addi	a2, a2, 1365
                                        # implicit-def: $v0
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v10m2
	vsetivli	zero, 31, e8, m2, ta, mu
	vle8.v	v10, (a0), v0.t
                                        # implicit-def: $v8
	vsetivli	zero, 16, e8, m1, ta, ma
	vnsrl.wi	v8, v10, 0
	vse8.v	v8, (a1)
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
