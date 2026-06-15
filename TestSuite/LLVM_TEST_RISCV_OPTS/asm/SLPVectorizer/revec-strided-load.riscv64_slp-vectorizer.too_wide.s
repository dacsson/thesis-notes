# Source: SLPVectorizer/revec-strided-load.riscv64_slp-vectorizer.ll
# Function: too_wide
# src = pre-opt (too_wide), tgt = post-opt (too_wide)
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
	mv	t0, a0
	lh	t1, 0(t0)
	lh	t2, 2(t0)
	lh	t3, 4(t0)
	lh	t4, 6(t0)
	lh	t5, 8(t0)
	lh	t6, 10(t0)
	lh	s0, 12(t0)
	lh	s1, 14(t0)
	lh	a0, 32(t0)
	lh	a2, 34(t0)
	lh	a3, 36(t0)
	lh	a4, 38(t0)
	lh	a5, 40(t0)
	lh	a6, 42(t0)
	lh	a7, 44(t0)
	lh	t0, 46(t0)
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
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	a2, a0, 32
                                        # implicit-def: $v8m8
	vsetivli	zero, 16, e64, m8, tu, ma
	vmv.v.x	v8, a2
	vmv1r.v	v9, v8
	vmv.s.x	v9, a0
	csrr	a0, vlenb
	srli	a0, a0, 3
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vid.v	v10
                                        # implicit-def: $v14m2
	vsrl.vi	v14, v10, 3
                                        # implicit-def: $v10m2
	vslidedown.vx	v10, v14, a0
                                        # implicit-def: $v12m2
	vslidedown.vx	v12, v10, a0
	vmv1r.v	v16, v12
                                        # implicit-def: $v8
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v9, v16
	vmv1r.v	v11, v10
                                        # implicit-def: $v10
	vrgatherei16.vv	v10, v9, v11
                                        # kill: def $v14 killed $v14 killed $v14m2 killed $vtype
                                        # implicit-def: $v11
	vrgatherei16.vv	v11, v9, v14
                                        # implicit-def: $v16m8
	vmv.v.v	v16, v11
	vmv.v.v	v17, v10
	vmv.v.v	v18, v8
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v10, v12, a0
	vmv1r.v	v12, v10
                                        # implicit-def: $v8
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v9, v12
	vmv.v.v	v19, v8
                                        # implicit-def: $v12m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v12, v10, a0
	vmv1r.v	v10, v12
                                        # implicit-def: $v8
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v9, v10
	vmv.v.v	v20, v8
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v10, v12, a0
	vmv1r.v	v12, v10
                                        # implicit-def: $v8
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v9, v12
	vmv.v.v	v21, v8
                                        # implicit-def: $v12m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v12, v10, a0
	vmv1r.v	v10, v12
                                        # implicit-def: $v8
	vsetvli	a2, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v9, v10
	vmv.v.v	v22, v8
                                        # implicit-def: $v10m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v10, v12, a0
                                        # kill: def $v10 killed $v10 killed $v10m2 killed $vtype
                                        # implicit-def: $v8
	vsetvli	a0, zero, e64, m1, ta, ma
	vrgatherei16.vv	v8, v9, v10
	vmv.v.v	v23, v8
	lui	a0, %hi(.LCPI5_0)
	ld	a0, %lo(.LCPI5_0)(a0)
                                        # implicit-def: $v12
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v12, a0
                                        # implicit-def: $v8m4
	vsetivli	zero, 16, e32, m4, ta, ma
	vsext.vf4	v8, v12
	vwadd.wv	v16, v16, v8
	li	a0, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vluxei64.v	v8, (a0), v16
	vse16.v	v8, (a1)
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
