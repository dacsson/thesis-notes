# Source: SLPVectorizer/reordered-buildvector-scalars.riscv64-unknown-linux-gnu_slp-vectorizer_THRESH.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	t3, 8(sp)                       # 8-byte Folded Spill
	sd	a6, 0(sp)                       # 8-byte Folded Spill
	mv	t3, a1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	t0, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sraiw	a6, t0, 1
	addiw	t2, t0, 1
	slliw	a0, t0, 1
	addiw	a1, a1, 1
	srli	a7, a1, 1
	or	a1, a6, t0
	srliw	a5, a1, 1
	addiw	a1, a2, 1
	srliw	a4, a1, 1
	addiw	a0, a0, 2
	srliw	a3, a0, 2
	ori	a0, t2, 1
	addw	a2, a0, t0
	ori	t4, t0, 1
	addw	a0, t4, t0
	addiw	a1, a6, 1
	srliw	t1, a1, 1
	lui	t5, 2
	lui	a1, %hi(images)
	addi	a1, a1, %lo(images)
	add	a1, a1, t5
	sh	t1, -12(a1)
	addiw	t4, t4, 1
	srliw	t4, t4, 1
	sh	t4, 4(a1)
	sh	t4, -16(a1)
	or	t4, t3, t0
	srliw	t4, t4, 1
	sh	t4, 20(a1)
	sh	t4, 0(a1)
	sh	t4, -20(a1)
	addiw	t3, t3, 1
	srliw	t3, t3, 1
	sh	t3, 36(a1)
	sh	t3, 16(a1)
	sh	t3, -4(a1)
	srliw	t3, t2, 1
	sh	t3, 32(a1)
	sh	t3, 12(a1)
	sh	t3, -8(a1)
	or	t2, t2, t0
	srliw	t2, t2, 1
	sh	t2, 28(a1)
	sh	t2, 8(a1)
	sh	t1, 24(a1)
	ori	a6, a6, 1
	addw	a6, a6, t0
	sh	a6, 40(a1)
	sh	a7, -10(a1)
	sh	a6, 6(a1)
	sh	a6, -14(a1)
	sh	a5, 22(a1)
	sh	a5, 2(a1)
	sh	a5, -18(a1)
	sh	a4, 38(a1)
	sh	a4, 18(a1)
	sh	a4, -2(a1)
	sh	a4, -22(a1)
	sh	a3, 34(a1)
	sh	a3, 14(a1)
	sh	a3, -6(a1)
	sh	a2, 30(a1)
	sh	a2, 10(a1)
	sh	a0, 26(a1)
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv1r.v	v12, v8
	mv	a6, a1
	mv	a4, a0
                                        # kill: def $v10 killed $v9 killed $vtype
                                        # kill: def $v8 killed $v12 killed $vtype
	sraiw	a5, a4, 1
	slli	a1, a5, 32
	add.uw	a0, a4, a1
	add.uw	t0, a6, a1
	addiw	a2, a4, 1
	slli	a1, a2, 32
	add.uw	a1, a5, a1
	zext.w	a7, a2
	slliw	a2, a4, 1
	ori	a3, a4, 1
                                        # implicit-def: $v8
	vmv.v.x	v8, t0
                                        # implicit-def: $v10
	vslide1down.vx	v10, v8, a7
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, mf2, ta, ma
	vor.vx	v8, v10, a4
	vsetvli	zero, zero, e32, mf2, tu, ma
	vslideup.vi	v12, v9, 3
                                        # implicit-def: $v10
	vsetivli	zero, 8, e32, mf2, tu, ma
	vmv.v.x	v10, a6
                                        # implicit-def: $v9
	vmv.s.x	v9, a5
	vsetivli	zero, 3, e32, mf2, tu, ma
	vslideup.vi	v10, v9, 2
	li	a5, 187
                                        # implicit-def: $v0
	vsetvli	zero, zero, e8, mf8, tu, ma
	vmv.s.x	v0, a5
                                        # implicit-def: $v11
	vsetivli	zero, 8, e32, mf2, tu, ma
	vmerge.vvm	v11, v10, v12, v0
                                        # implicit-def: $v10
	vmv.s.x	v10, a4
	vsetivli	zero, 5, e32, mf2, tu, ma
	vslideup.vi	v11, v10, 4
                                        # implicit-def: $v12
	vmv.s.x	v12, a3
	vmv1r.v	v10, v11
	vsetivli	zero, 2, e32, mf2, tu, ma
	vslideup.vi	v10, v12, 1
                                        # implicit-def: $v12
	vmv.s.x	v12, a2
	vsetivli	zero, 6, e32, mf2, tu, ma
	vslideup.vi	v10, v12, 5
	vsetivli	zero, 8, e32, mf2, ta, ma
	vslideup.vi	v10, v9, 7
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.v.i	v9, 2
                                        # implicit-def: $v12
	vmv.v.i	v12, 1
	vsetivli	zero, 6, e32, mf2, tu, ma
	vslideup.vi	v12, v9, 5
                                        # implicit-def: $v9
	vsetivli	zero, 8, e32, mf2, ta, ma
	vadd.vv	v9, v10, v12
	vsetivli	zero, 12, e32, m1, tu, ma
	vslideup.vi	v9, v8, 8
                                        # implicit-def: $v8
	vsetivli	zero, 16, e32, m1, tu, ma
	vmv.v.i	v8, 2
                                        # implicit-def: $v10
	vmv.v.i	v10, 1
	vsetivli	zero, 6, e32, m1, tu, ma
	vslideup.vi	v10, v8, 5
                                        # implicit-def: $v8
	vsetivli	zero, 16, e32, m1, ta, ma
	vsrl.vv	v8, v9, v10
                                        # implicit-def: $v10
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v10, a1
                                        # implicit-def: $v9
	vslide1down.vx	v9, v10, a0
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, mf2, ta, ma
	vor.vi	v10, v9, 1
                                        # implicit-def: $v9
	vslidedown.vi	v9, v11, 4
                                        # implicit-def: $v11
	vrgather.vi	v11, v9, 0
                                        # implicit-def: $v9
	vadd.vv	v9, v10, v11
	vsetivli	zero, 15, e32, m1, tu, ma
	vslideup.vi	v8, v9, 11
                                        # implicit-def: $v9
	vsetivli	zero, 16, e16, mf2, ta, ma
	vnsrl.wi	v9, v8, 0
	li	a1, 32
	lui	a0, %hi(.LCPI0_0)
	addi	a0, a0, %lo(.LCPI0_0)
                                        # implicit-def: $v10
	vsetvli	zero, a1, e16, m1, tu, ma
	vle16.v	v10, (a0)
                                        # implicit-def: $v8
	vsetvli	zero, a1, e16, m1, ta, ma
	vrgather.vv	v8, v9, v10
	lui	a0, %hi(images)
	addi	a0, a0, %lo(images)
	lui	a2, 2
	addi	a2, a2, -22
	add	a0, a0, a2
	vsetvli	zero, a1, e16, m1, ta, ma
	vse16.v	v8, (a0)
	li	a0, 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
