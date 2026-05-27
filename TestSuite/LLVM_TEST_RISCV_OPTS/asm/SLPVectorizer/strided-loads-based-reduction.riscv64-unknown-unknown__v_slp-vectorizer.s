# Source: SLPVectorizer/strided-loads-based-reduction.riscv64-unknown-unknown__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-unknown, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	t1, a2
	sext.w	t0, a3
	lbu	a2, 0(a1)
	lbu	a3, 0(a0)
	subw	a3, a2, a3
	lbu	a2, 1(a1)
	lbu	a4, 1(a0)
	subw	a4, a2, a4
	addw	a2, a4, a3
	subw	a3, a3, a4
	slliw	a3, a3, 16
	addw	a3, a2, a3
	lbu	a2, 2(a1)
	lbu	a4, 2(a0)
	subw	a4, a2, a4
	lbu	a2, 3(a1)
	lbu	a5, 3(a0)
	subw	a5, a2, a5
	addw	a2, a5, a4
	subw	a4, a4, a5
	slliw	a4, a4, 16
	addw	a4, a2, a4
	addw	a2, a4, a3
	subw	a3, a3, a4
	add	a1, a1, t1
	add	a0, a0, t0
	lbu	a4, 0(a1)
	lbu	a5, 0(a0)
	subw	a5, a4, a5
	lbu	a4, 1(a1)
	lbu	a6, 1(a0)
	subw	a6, a4, a6
	addw	a4, a6, a5
	subw	a5, a5, a6
	slliw	a5, a5, 16
	addw	a4, a4, a5
	lbu	a5, 2(a1)
	lbu	a6, 2(a0)
	subw	a6, a5, a6
	lbu	a5, 3(a1)
	lbu	a7, 3(a0)
	subw	a7, a5, a7
	addw	a5, a7, a6
	subw	a6, a6, a7
	slliw	a6, a6, 16
	addw	a5, a5, a6
	addw	a6, a5, a4
	subw	a7, a4, a5
	add	a5, a1, t1
	add	a4, a0, t0
	lbu	a0, 0(a5)
	lbu	a1, 0(a4)
	subw	a1, a0, a1
	lbu	a0, 1(a5)
	lbu	t2, 1(a4)
	subw	t2, a0, t2
	addw	a0, t2, a1
	subw	a1, a1, t2
	slliw	a1, a1, 16
	addw	a0, a0, a1
	lbu	a1, 2(a5)
	lbu	t2, 2(a4)
	subw	t2, a1, t2
	lbu	a1, 3(a5)
	lbu	t3, 3(a4)
	subw	t3, a1, t3
	addw	a1, t3, t2
	subw	t2, t2, t3
	slliw	t2, t2, 16
	addw	t2, a1, t2
	addw	a1, t2, a0
	subw	a0, a0, t2
	add	a5, a5, t1
	add	t1, a4, t0
	lbu	a4, 0(a5)
	lbu	t0, 0(t1)
	subw	t0, a4, t0
	lbu	a4, 1(a5)
	lbu	t2, 1(t1)
	subw	t2, a4, t2
	addw	a4, t2, t0
	subw	t0, t0, t2
	slliw	t0, t0, 16
	addw	a4, a4, t0
	lbu	t0, 2(a5)
	lbu	t2, 2(t1)
	subw	t0, t0, t2
	lbu	a5, 3(a5)
	lbu	t1, 3(t1)
	subw	t1, a5, t1
	addw	a5, t1, t0
	subw	t0, t0, t1
	slliw	t0, t0, 16
	addw	t0, a5, t0
	addw	a5, t0, a4
	subw	t0, a4, t0
	addw	a4, a6, a2
	subw	a2, a2, a6
	addw	a6, a5, a1
	subw	a5, a1, a5
	add	a1, a6, a4
	sub	a4, a4, a6
	add	t1, a5, a2
	sub	a2, a2, a5
	srli	t2, a1, 15
	lui	a6, 16
	addi	a5, a6, 1
	and	t3, t2, a5
	slliw	t2, a1, 1
	and	t2, t2, a6
	subw	t2, t2, t3
	addw	a1, t2, a1
	xor	a1, a1, t2
	srli	t2, t1, 15
	and	t3, t2, a5
	slliw	t2, t1, 1
	and	t2, t2, a6
	subw	t2, t2, t3
	addw	t1, t2, t1
	xor	t1, t1, t2
	addw	a1, a1, t1
	srli	t1, a4, 15
	and	t2, t1, a5
	slliw	t1, a4, 1
	and	t1, t1, a6
	subw	t1, t1, t2
	addw	a4, t1, a4
	xor	a4, a4, t1
	addw	a1, a1, a4
	srli	a4, a2, 15
	and	t1, a4, a5
	slliw	a4, t1, 16
	subw	a4, a4, t1
	addw	a2, a4, a2
	xor	a2, a2, a4
	sext.w	a2, a2
	add	a2, a1, a2
	addi	a1, a6, -1
	and	a4, a2, a1
	srliw	a2, a2, 16
	add	a2, a2, a4
	addw	a4, a7, a3
	subw	a3, a3, a7
	addw	a7, t0, a0
	subw	t0, a0, t0
	add	a0, a7, a4
	sub	a4, a4, a7
	add	a7, t0, a3
	sub	a3, a3, t0
	srli	t0, a0, 15
	and	t1, t0, a5
	slliw	t0, a0, 1
	and	t0, t0, a6
	subw	t0, t0, t1
	addw	a0, t0, a0
	xor	a0, a0, t0
	srli	t0, a7, 15
	and	t1, t0, a5
	slliw	t0, a7, 1
	and	t0, t0, a6
	subw	t0, t0, t1
	addw	a7, t0, a7
	xor	a7, a7, t0
	addw	a0, a0, a7
	srli	a7, a4, 15
	and	t0, a7, a5
	slliw	a7, a4, 1
	and	a7, a7, a6
	subw	a7, a7, t0
	addw	a4, a7, a4
	xor	a4, a4, a7
	addw	a0, a0, a4
	srli	a4, a3, 15
	and	a5, a4, a5
	slliw	a4, a3, 1
	and	a4, a4, a6
	subw	a4, a4, a5
	addw	a3, a4, a3
	xor	a3, a3, a4
	addw	a0, a0, a3
	and	a1, a0, a1
	srliw	a0, a0, 16
	add	a0, a0, a2
	add	a0, a0, a1
	srli	a0, a0, 1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a4, vlenb
	slli	a4, a4, 1
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	mv	t0, a2
	mv	t1, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sext.w	a3, a1
	sext.w	a1, a0
	addi	a7, t1, 1
	addi	a6, t0, 1
	addi	a5, t1, 2
	addi	a4, t0, 2
	addi	a2, t1, 3
	addi	a0, t0, 3
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, mf4, tu, ma
	vlse8.v	v8, (t1), a3
                                        # implicit-def: $v10
	vlse8.v	v10, (t0), a1
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v9, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vlse8.v	v8, (a7), a3
                                        # implicit-def: $v10
	vlse8.v	v10, (a6), a1
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v11, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vwadd.vv	v8, v11, v9
                                        # implicit-def: $v10
	vwsub.vv	v10, v9, v11
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vsll.vi	v9, v10, 16
                                        # implicit-def: $v12
	vadd.vv	v12, v8, v9
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vlse8.v	v8, (a5), a3
                                        # implicit-def: $v10
	vlse8.v	v10, (a4), a1
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v9, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vlse8.v	v8, (a2), a3
                                        # implicit-def: $v10
	vlse8.v	v10, (a0), a1
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v11, v8, v10
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vwadd.vv	v8, v11, v9
                                        # implicit-def: $v10
	vwsub.vv	v10, v9, v11
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vsll.vi	v9, v10, 16
                                        # implicit-def: $v11
	vadd.vv	v11, v8, v9
                                        # implicit-def: $v8
	vsub.vv	v8, v12, v11
	vmv.v.v	v9, v8
	li	a0, 32
                                        # implicit-def: $v13
	vsetivli	zero, 2, e64, m1, ta, ma
	vsrl.vx	v13, v9, a0
                                        # implicit-def: $v10
	vsll.vx	v10, v9, a0
                                        # implicit-def: $v9
	vor.vv	v9, v10, v13
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, ta, ma
	vadd.vv	v10, v11, v12
	vmv.v.v	v11, v10
                                        # implicit-def: $v13
	vsetivli	zero, 2, e64, m1, ta, ma
	vsrl.vx	v13, v11, a0
                                        # implicit-def: $v12
	vsll.vx	v12, v11, a0
                                        # implicit-def: $v11
	vor.vv	v11, v12, v13
                                        # implicit-def: $v13
	vsetivli	zero, 4, e32, m1, ta, ma
	vrsub.vi	v13, v10, 0
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 10
	addi	a0, sp, 32
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v12
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v12, v10, v13, v0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v10, v11, v12
                                        # implicit-def: $v12
	vslidedown.vi	v12, v10, 2
	vslideup.vi	v12, v10, 2
                                        # implicit-def: $v13
	vrsub.vi	v13, v12, 0
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 3
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v11
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v11, v12, v13, v0
	addi	a0, sp, 32
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v12
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v12, v10, v11
	vmv.v.v	v10, v12
                                        # implicit-def: $v11
	vsetivli	zero, 8, e16, m1, ta, ma
	vsra.vi	v11, v10, 15
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, ta, ma
	vadd.vv	v10, v11, v12
                                        # implicit-def: $v12
	vxor.vv	v12, v10, v11
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v11, v12, v10
	vmv.x.s	a0, v11
	lui	a1, 16
	addi	a1, a1, -1
	and	a2, a0, a1
	srliw	a0, a0, 16
	add	a2, a0, a2
                                        # implicit-def: $v12
	vrsub.vi	v12, v8, 0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vvm	v11, v8, v12, v0
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v8, v9, v11
                                        # implicit-def: $v9
	vslidedown.vi	v9, v8, 2
	vslideup.vi	v9, v8, 2
                                        # implicit-def: $v12
	vrsub.vi	v12, v9, 0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vvm	v11, v9, v12, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v9, v8, v11
	vmv.v.v	v8, v9
                                        # implicit-def: $v11
	vsetivli	zero, 8, e16, m1, ta, ma
	vsra.vi	v11, v8, 15
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, ta, ma
	vadd.vv	v8, v11, v9
                                        # implicit-def: $v9
	vxor.vv	v9, v8, v11
                                        # implicit-def: $v8
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	and	a1, a0, a1
	srliw	a0, a0, 16
	add	a0, a0, a2
	add	a0, a0, a1
	srli	a0, a0, 1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
