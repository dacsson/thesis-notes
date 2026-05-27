# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: constant_stride_masked_no_reordering
# src = pre-opt (constant_stride_masked_no_reordering), tgt = post-opt (constant_stride_masked_no_reordering)
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
	lbu	s0, 1(a0)
	lbu	t6, 2(a0)
	lbu	t5, 3(a0)
	lbu	t4, 8(a0)
	lbu	t3, 9(a0)
	lbu	t2, 10(a0)
	lbu	t1, 11(a0)
	lbu	t0, 16(a0)
	lbu	a7, 17(a0)
	lbu	a6, 18(a0)
	lbu	a5, 19(a0)
	lbu	a4, 24(a0)
	lbu	a3, 25(a0)
	lbu	a1, 26(a0)
	lbu	a0, 27(a0)
	sb	s1, 0(a2)
	sb	s0, 1(a2)
	sb	t6, 2(a2)
	sb	t5, 3(a2)
	sb	t4, 4(a2)
	sb	t3, 5(a2)
	sb	t2, 6(a2)
	sb	t1, 7(a2)
	sb	t0, 8(a2)
	sb	a7, 9(a2)
	sb	a6, 10(a2)
	sb	a5, 11(a2)
	sb	a4, 12(a2)
	sb	a3, 13(a2)
	sb	a1, 14(a2)
	sb	a0, 15(a2)
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	ld	s1, 0(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a1, 61681
	addi	a1, a1, -241
                                        # implicit-def: $v0
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v12m2
	vsetivli	zero, 28, e8, m2, ta, mu
	vle8.v	v12, (a0), v0.t
	vmv1r.v	v9, v12
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, ta, ma
	vnsrl.wi	v8, v9, 0
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e8, m2, ta, ma
	vslidedown.vi	v10, v12, 16
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, ta, ma
	vnsrl.wi	v9, v10, 0
	vsetivli	zero, 4, e32, m1, ta, ma
	vslideup.vi	v8, v9, 2
	vsetivli	zero, 16, e8, m1, ta, ma
	vse8.v	v8, (a2)
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
