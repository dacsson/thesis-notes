# Source: SLPVectorizer/x264-satd-8x4.riscv64__m__v__unaligned-vector-mem_slp-vectorizer.ll
# Function: x264_pixel_satd_8x4
# src = pre-opt (x264_pixel_satd_8x4), tgt = post-opt (x264_pixel_satd_8x4)
# Triple: riscv64, Attrs: +m,+v,+unaligned-vector-mem
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	s0, 40(sp)                      # 8-byte Folded Spill
	sd	s1, 32(sp)                      # 8-byte Folded Spill
	sd	s2, 24(sp)                      # 8-byte Folded Spill
	sd	s3, 16(sp)                      # 8-byte Folded Spill
	sd	s4, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset s0, -8
	.cfi_offset s1, -16
	.cfi_offset s2, -24
	.cfi_offset s3, -32
	.cfi_offset s4, -40
	sext.w	s0, a1
	sext.w	a5, a3
	lbu	a1, 0(a0)
	lbu	a3, 0(a2)
	subw	a3, a1, a3
	lbu	a1, 4(a0)
	lbu	a4, 4(a2)
	subw	a1, a1, a4
	slliw	a1, a1, 16
	addw	a1, a1, a3
	lbu	a3, 1(a0)
	lbu	a4, 1(a2)
	subw	a4, a3, a4
	lbu	a3, 5(a0)
	lbu	a6, 5(a2)
	subw	a3, a3, a6
	slliw	a3, a3, 16
	addw	a7, a3, a4
	lbu	a3, 2(a0)
	lbu	a4, 2(a2)
	subw	a4, a3, a4
	lbu	a3, 6(a0)
	lbu	a6, 6(a2)
	subw	a3, a3, a6
	slliw	a3, a3, 16
	addw	a3, a3, a4
	lbu	a4, 3(a0)
	lbu	a6, 3(a2)
	subw	a6, a4, a6
	lbu	a4, 7(a0)
	lbu	t0, 7(a2)
	subw	a4, a4, t0
	slliw	a4, a4, 16
	addw	a6, a4, a6
	addw	a4, a7, a1
	subw	a1, a1, a7
	addw	a7, a6, a3
	subw	a3, a3, a6
	addw	a6, a7, a4
	subw	a4, a4, a7
	addw	t2, a3, a1
	subw	a1, a1, a3
	add	a3, a0, s0
	add	a0, a2, a5
	lbu	a2, 0(a3)
	lbu	a7, 0(a0)
	subw	a7, a2, a7
	lbu	a2, 4(a3)
	lbu	t0, 4(a0)
	subw	a2, a2, t0
	slliw	a2, a2, 16
	addw	a2, a2, a7
	lbu	a7, 1(a3)
	lbu	t0, 1(a0)
	subw	t0, a7, t0
	lbu	a7, 5(a3)
	lbu	t1, 5(a0)
	subw	a7, a7, t1
	slliw	a7, a7, 16
	addw	t1, a7, t0
	lbu	a7, 2(a3)
	lbu	t0, 2(a0)
	subw	t0, a7, t0
	lbu	a7, 6(a3)
	lbu	t3, 6(a0)
	subw	a7, a7, t3
	slliw	a7, a7, 16
	addw	a7, a7, t0
	lbu	t0, 3(a3)
	lbu	t3, 3(a0)
	subw	t3, t0, t3
	lbu	t0, 7(a3)
	lbu	t4, 7(a0)
	subw	t0, t0, t4
	slliw	t0, t0, 16
	addw	t3, t0, t3
	addw	t0, t1, a2
	subw	a2, a2, t1
	addw	t1, t3, a7
	subw	a7, a7, t3
	addw	t6, t1, t0
	subw	t0, t0, t1
	addw	t4, a7, a2
	subw	a2, a2, a7
	add	t3, a3, s0
	add	a0, a0, a5
	lbu	a3, 0(t3)
	lbu	a7, 0(a0)
	subw	a7, a3, a7
	lbu	a3, 4(t3)
	lbu	t1, 4(a0)
	subw	a3, a3, t1
	slliw	a3, a3, 16
	addw	a3, a3, a7
	lbu	a7, 1(t3)
	lbu	t1, 1(a0)
	subw	t1, a7, t1
	lbu	a7, 5(t3)
	lbu	t5, 5(a0)
	subw	a7, a7, t5
	slliw	a7, a7, 16
	addw	t5, a7, t1
	lbu	a7, 2(t3)
	lbu	t1, 2(a0)
	subw	t1, a7, t1
	lbu	a7, 6(t3)
	lbu	s1, 6(a0)
	subw	a7, a7, s1
	slliw	a7, a7, 16
	addw	a7, a7, t1
	lbu	t1, 3(t3)
	lbu	s1, 3(a0)
	subw	s1, t1, s1
	lbu	t1, 7(t3)
	lbu	s2, 7(a0)
	subw	t1, t1, s2
	slliw	t1, t1, 16
	addw	s1, t1, s1
	addw	t1, t5, a3
	subw	a3, a3, t5
	addw	t5, s1, a7
	subw	s1, a7, s1
	addw	a7, t5, t1
	subw	t1, t1, t5
	addw	t5, s1, a3
	subw	a3, a3, s1
	add	t3, t3, s0
	add	s2, a0, a5
	lbu	a0, 0(t3)
	lbu	a5, 0(s2)
	subw	a5, a0, a5
	lbu	a0, 4(t3)
	lbu	s0, 4(s2)
	subw	a0, a0, s0
	slliw	a0, a0, 16
	addw	a0, a0, a5
	lbu	a5, 1(t3)
	lbu	s0, 1(s2)
	subw	s0, a5, s0
	lbu	a5, 5(t3)
	lbu	s1, 5(s2)
	subw	a5, a5, s1
	slliw	a5, a5, 16
	addw	s0, a5, s0
	lbu	a5, 2(t3)
	lbu	s1, 2(s2)
	subw	s1, a5, s1
	lbu	a5, 6(t3)
	lbu	s3, 6(s2)
	subw	a5, a5, s3
	slliw	a5, a5, 16
	addw	a5, a5, s1
	lbu	s1, 3(t3)
	lbu	s3, 3(s2)
	subw	s1, s1, s3
	lbu	t3, 7(t3)
	lbu	s2, 7(s2)
	subw	t3, t3, s2
	slliw	t3, t3, 16
	addw	s1, t3, s1
	addw	t3, s0, a0
	subw	a0, a0, s0
	addw	s0, s1, a5
	subw	a5, a5, s1
	addw	s1, s0, t3
	subw	t3, t3, s0
	addw	s0, a5, a0
	subw	a5, a0, a5
	addw	a0, t6, a6
	subw	a6, a6, t6
	addw	t6, s1, a7
	subw	a7, a7, s1
	add	s2, t6, a0
	sub	s1, a0, t6
	add	a0, a7, a6
	sub	t6, a6, a7
	srli	s3, s2, 15
	lui	a7, 16
	addi	a6, a7, 1
	and	s4, s3, a6
	slliw	s3, s4, 16
	subw	s3, s3, s4
	addw	s2, s3, s2
	xor	s2, s2, s3
	srli	s3, a0, 15
	and	s4, s3, a6
	slliw	s3, s4, 16
	subw	s3, s3, s4
	addw	a0, s3, a0
	xor	a0, a0, s3
	srli	s3, s1, 15
	and	s4, s3, a6
	slliw	s3, s4, 16
	subw	s3, s3, s4
	addw	s1, s3, s1
	xor	s1, s1, s3
	srli	s3, t6, 15
	and	s4, s3, a6
	slliw	s3, t6, 1
	and	s3, s3, a7
	subw	s3, s3, s4
	addw	t6, s3, t6
	xor	t6, t6, s3
	addw	a0, a0, s2
	addw	a0, a0, s1
	addw	t6, a0, t6
	addw	a0, t4, t2
	subw	t2, t2, t4
	addw	t4, s0, t5
	subw	s0, t5, s0
	add	t5, t4, a0
	sub	t4, a0, t4
	add	a0, s0, t2
	sub	t2, t2, s0
	srli	s0, t5, 15
	and	s1, s0, a6
	slliw	s0, t5, 1
	and	s0, s0, a7
	subw	s0, s0, s1
	addw	t5, s0, t5
	xor	t5, t5, s0
	srli	s0, a0, 15
	and	s1, s0, a6
	slliw	s0, a0, 1
	and	s0, s0, a7
	subw	s0, s0, s1
	addw	a0, s0, a0
	xor	a0, a0, s0
	srli	s0, t4, 15
	and	s1, s0, a6
	slliw	s0, s1, 16
	subw	s0, s0, s1
	addw	t4, s0, t4
	xor	t4, t4, s0
	srli	s0, t2, 15
	and	s1, s0, a6
	slliw	s0, s1, 16
	subw	s0, s0, s1
	addw	t2, s0, t2
	xor	t2, t2, s0
	addw	a0, a0, t6
	addw	a0, a0, t5
	addw	a0, a0, t4
	addw	t2, a0, t2
	addw	a0, t0, a4
	subw	a4, a4, t0
	addw	t0, t3, t1
	subw	t3, t1, t3
	add	t1, t0, a0
	sub	t0, a0, t0
	add	a0, t3, a4
	sub	a4, a4, t3
	srli	t3, t1, 15
	and	t4, t3, a6
	slliw	t3, t1, 1
	and	t3, t3, a7
	subw	t3, t3, t4
	addw	t1, t3, t1
	xor	t1, t1, t3
	srli	t3, a0, 15
	and	t4, t3, a6
	slliw	t3, a0, 1
	and	t3, t3, a7
	subw	t3, t3, t4
	addw	a0, t3, a0
	xor	a0, a0, t3
	srli	t3, t0, 15
	and	t4, t3, a6
	slliw	t3, t0, 1
	and	t3, t3, a7
	subw	t3, t3, t4
	addw	t0, t3, t0
	xor	t0, t0, t3
	srli	t3, a4, 15
	and	t4, t3, a6
	slliw	t3, t4, 16
	subw	t3, t3, t4
	addw	a4, t3, a4
	xor	a4, a4, t3
	addw	a0, a0, t2
	addw	a0, a0, t1
	addw	a0, a0, t0
	addw	a4, a0, a4
	addw	a0, a2, a1
	subw	a1, a1, a2
	addw	a2, a5, a3
	subw	a5, a3, a5
	add	a3, a2, a0
	sub	a2, a0, a2
	add	a0, a5, a1
	sub	a1, a1, a5
	srli	a5, a3, 15
	and	t0, a5, a6
	slliw	a5, a3, 1
	and	a5, a5, a7
	subw	a5, a5, t0
	addw	a3, a5, a3
	xor	a3, a3, a5
	srli	a5, a0, 15
	and	t0, a5, a6
	slliw	a5, t0, 16
	subw	a5, a5, t0
	addw	a0, a5, a0
	xor	a0, a0, a5
	srli	a5, a2, 15
	and	t0, a5, a6
	slliw	a5, a2, 1
	and	a5, a5, a7
	subw	a5, a5, t0
	addw	a2, a5, a2
	xor	a2, a2, a5
	srli	a5, a1, 15
	and	a6, a5, a6
	slliw	a5, a1, 1
	and	a5, a5, a7
	subw	a5, a5, a6
	addw	a1, a5, a1
	xor	a1, a1, a5
	addw	a0, a0, a4
	addw	a0, a0, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	srliw	a1, a0, 16
	slli	a0, a0, 48
	srli	a0, a0, 48
	add	a0, a0, a1
	srli	a0, a0, 1
	ld	s0, 40(sp)                      # 8-byte Folded Reload
	ld	s1, 32(sp)                      # 8-byte Folded Reload
	ld	s2, 24(sp)                      # 8-byte Folded Reload
	ld	s3, 16(sp)                      # 8-byte Folded Reload
	ld	s4, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	addi	sp, sp, 48
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	mv	a4, a2
	mv	a5, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sext.w	a3, a1
	sext.w	a1, a0
	addi	a2, a5, 4
	addi	a0, a4, 4
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vlse32.v	v8, (a5), a3
                                        # implicit-def: $v9
	vlse32.v	v9, (a4), a1
                                        # implicit-def: $v12m2
	vsetivli	zero, 16, e8, m1, ta, ma
	vwsubu.vv	v12, v8, v9
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, tu, ma
	vlse32.v	v10, (a2), a3
                                        # implicit-def: $v11
	vlse32.v	v11, (a0), a1
                                        # implicit-def: $v8m2
	vsetivli	zero, 16, e8, m1, ta, ma
	vwsubu.vv	v8, v10, v11
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vzext.vf2	v16, v8
                                        # implicit-def: $v8m4
	vsll.vi	v8, v16, 16
	vsetvli	zero, zero, e16, m2, ta, ma
	vwadd.wv	v8, v8, v12
	vmv4r.v	v12, v8
	li	a0, 32
                                        # implicit-def: $v20m4
	vsetivli	zero, 8, e64, m4, ta, ma
	vsrl.vx	v20, v12, a0
                                        # implicit-def: $v16m4
	vsll.vx	v16, v12, a0
                                        # implicit-def: $v12m4
	vor.vv	v12, v16, v20
                                        # implicit-def: $v20m4
	vsetivli	zero, 16, e32, m4, ta, ma
	vrsub.vi	v20, v8, 0
	lui	a1, 11
	addi	a1, a1, -1366
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v16, v8, v20, v0
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vadd.vv	v8, v12, v16
                                        # implicit-def: $v12m4
	vslidedown.vi	v12, v8, 2
	lui	a1, 13
	addi	a1, a1, -820
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
	vsetvli	zero, zero, e32, m4, ta, mu
	vslideup.vi	v12, v8, 2, v0.t
                                        # implicit-def: $v20m4
	vrsub.vi	v20, v12, 0
	lui	a1, 3
	addi	a1, a1, 819
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v16, v12, v20, v0
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vadd.vv	v12, v8, v16
                                        # implicit-def: $v8m4
	vslidedown.vi	v8, v12, 4
	lui	a1, 15
	addi	a1, a1, 240
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
	vsetvli	zero, zero, e32, m4, ta, mu
	vslideup.vi	v8, v12, 4, v0.t
                                        # implicit-def: $v20m4
	vrsub.vi	v20, v8, 0
	lui	a1, 1
	addi	a1, a1, -241
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v16, v8, v20, v0
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vadd.vv	v8, v12, v16
                                        # implicit-def: $v12m4
	vslidedown.vi	v12, v8, 8
	vslideup.vi	v12, v8, 8
                                        # implicit-def: $v20m4
	vrsub.vi	v20, v12, 0
	li	a1, 255
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a1
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v16, v12, v20, v0
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vadd.vv	v12, v8, v16
	vmv.v.v	v8, v12
                                        # implicit-def: $v16m4
	vsetvli	zero, a0, e16, m4, ta, ma
	vsra.vi	v16, v8, 15
                                        # implicit-def: $v8m4
	vsetivli	zero, 16, e32, m4, ta, ma
	vadd.vv	v8, v16, v12
                                        # implicit-def: $v12m4
	vxor.vv	v12, v8, v16
	li	a0, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m4, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m4, ta, ma
	vredsum.vs	v8, v12, v9
	vmv.x.s	a0, v8
	srliw	a1, a0, 16
	slli	a0, a0, 48
	srli	a0, a0, 48
	add	a0, a0, a1
	srli	a0, a0, 1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
