# Source: SLPVectorizer/basic-strided-loads.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: const_stride_2_with_reordering
# src = pre-opt (const_stride_2_with_reordering), tgt = post-opt (const_stride_2_with_reordering)
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
	lbu	s0, 0(a0)
	lbu	s1, 2(a0)
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
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
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
                                        # implicit-def: $v12m2
	vsetivli	zero, 31, e8, m2, ta, mu
	vle8.v	v12, (a0), v0.t
	vmv1r.v	v8, v12
	lui	a0, %hi(.LCPI3_0)
	ld	a0, %lo(.LCPI3_0)(a0)
                                        # implicit-def: $v10
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v10, a0
                                        # implicit-def: $v9
	vsetivli	zero, 16, e8, m1, ta, ma
	vrgather.vv	v9, v8, v10
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e8, m2, ta, ma
	vslidedown.vi	v10, v12, 16
	vmv1r.v	v8, v10
                                        # implicit-def: $v11
	vsetivli	zero, 16, e8, m1, ta, ma
	vid.v	v11
                                        # implicit-def: $v10
	vadd.vv	v10, v11, v11
                                        # implicit-def: $v11
	vadd.vi	v11, v10, -16
                                        # implicit-def: $v10
	vrgather.vv	v10, v8, v11
	li	a0, -256
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	vse8.v	v8, (a1)
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
