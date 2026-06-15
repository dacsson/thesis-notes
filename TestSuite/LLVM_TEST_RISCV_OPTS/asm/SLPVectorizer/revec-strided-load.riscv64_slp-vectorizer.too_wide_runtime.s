# Source: SLPVectorizer/revec-strided-load.riscv64_slp-vectorizer.ll
# Function: too_wide_runtime
# src = pre-opt (too_wide_runtime), tgt = post-opt (too_wide_runtime)
# Triple: riscv64, Attrs: none
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
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	sd	s1, 0(sp)                       # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	slli	a2, a2, 4
	add	t0, a0, a2
	lh	t1, 0(a0)
	lh	t2, 2(a0)
	lh	t3, 4(a0)
	lh	t4, 6(a0)
	lh	t5, 8(a0)
	lh	t6, 10(a0)
	lh	s0, 12(a0)
	lh	s1, 14(a0)
	lh	a0, 0(t0)
	lh	a2, 2(t0)
	lh	a3, 4(t0)
	lh	a4, 6(t0)
	lh	a5, 8(t0)
	lh	a6, 10(t0)
	lh	a7, 12(t0)
	lh	t0, 14(t0)
	sh	s1, 14(a1)
	sh	s0, 12(a1)
	sh	t6, 10(a1)
	sh	t5, 8(a1)
	sh	t4, 6(a1)
	sh	t3, 4(a1)
	sh	t2, 2(a1)
	sh	t1, 0(a1)
	sh	t0, 30(a1)
	sh	a7, 28(a1)
	sh	a6, 26(a1)
	sh	a5, 24(a1)
	sh	a4, 22(a1)
	sh	a3, 20(a1)
	sh	a2, 18(a1)
	sh	a0, 16(a1)
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	ld	s1, 0(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a0, a0, 4
	add	a0, a0, a2
                                        # implicit-def: $v10
	vsetivli	zero, 8, e16, m1, tu, ma
	vle16.v	v10, (a2)
                                        # implicit-def: $v8m2
	vmv1r.v	v8, v10
                                        # implicit-def: $v12
	vle16.v	v12, (a0)
                                        # implicit-def: $v10m2
	vmv1r.v	v10, v12
	vmv1r.v	v11, v12
	vsetivli	zero, 16, e16, m2, ta, ma
	vslideup.vi	v8, v10, 8
	vse16.v	v8, (a1)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
