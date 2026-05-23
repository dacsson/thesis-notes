# Source: SLPVectorizer/complex-loads.riscv64-unknown-linux-gnu__v__unaligned-vector-mem_slp-vectorizer_UNALIGNED_VEC_MEM.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v,+unaligned-vector-mem
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -240
	.cfi_def_cfa_offset 240
	sd	ra, 232(sp)                     # 8-byte Folded Spill
	sd	s0, 224(sp)                     # 8-byte Folded Spill
	sd	s1, 216(sp)                     # 8-byte Folded Spill
	sd	s2, 208(sp)                     # 8-byte Folded Spill
	sd	s3, 200(sp)                     # 8-byte Folded Spill
	sd	s4, 192(sp)                     # 8-byte Folded Spill
	sd	s5, 184(sp)                     # 8-byte Folded Spill
	sd	s6, 176(sp)                     # 8-byte Folded Spill
	sd	s7, 168(sp)                     # 8-byte Folded Spill
	sd	s8, 160(sp)                     # 8-byte Folded Spill
	sd	s9, 152(sp)                     # 8-byte Folded Spill
	sd	s10, 144(sp)                    # 8-byte Folded Spill
	sd	s11, 136(sp)                    # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	.cfi_offset s2, -32
	.cfi_offset s3, -40
	.cfi_offset s4, -48
	.cfi_offset s5, -56
	.cfi_offset s6, -64
	.cfi_offset s7, -72
	.cfi_offset s8, -80
	.cfi_offset s9, -88
	.cfi_offset s10, -96
	.cfi_offset s11, -104
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	sd	a4, 0(sp)                       # 8-byte Folded Spill
	mv	a4, a3
	ld	a3, 0(sp)                       # 8-byte Folded Reload
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	mv	t1, a2
	mv	a2, a1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	mv	t2, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	lbu	a7, 0(t2)
	lbu	a4, 0(a2)
	sub	a5, a7, a4
	lbu	a4, 4(t2)
	lbu	a6, 4(a2)
	sub	a4, a4, a6
	slli	a4, a4, 16
	add	a4, a4, a5
	lbu	t0, 1(t2)
	lbu	a5, 1(a2)
	sub	a6, t0, a5
	lbu	a5, 5(t2)
	lbu	t3, 5(a2)
	sub	a5, a5, t3
	slli	a5, a5, 16
	add	t3, a5, a6
	lbu	a6, 2(t2)
	lbu	a5, 2(a2)
	sub	t4, a6, a5
	lbu	a5, 6(t2)
	lbu	t5, 6(a2)
	sub	a5, a5, t5
	slli	a5, a5, 16
	add	t4, a5, t4
	lbu	a5, 3(t2)
	lbu	t5, 3(a2)
	sub	t6, a5, t5
	lbu	t5, 7(t2)
	lbu	s0, 7(a2)
	sub	t5, t5, s0
	slli	t5, t5, 16
	add	t6, t5, t6
	add	t5, t3, a4
	subw	t3, a4, t3
	add	a4, t6, t4
	sd	a4, 112(sp)                     # 8-byte Folded Spill
	sub	s7, t4, t6
	addw	s0, a4, t5
	subw	a4, t5, a4
	addw	s8, s7, t3
	subw	t3, t3, s7
	sd	t3, 128(sp)                     # 8-byte Folded Spill
	add	t3, t2, t1
	add	s4, a2, a1
	lbu	s1, 0(t3)
	lbu	a2, 0(s4)
	subw	t2, s1, a2
	lbu	a2, 4(t3)
	lbu	t4, 4(s4)
	subw	a2, a2, t4
	slliw	a2, a2, 16
	addw	a2, a2, t2
	lbu	s2, 1(t3)
	lbu	t2, 1(s4)
	subw	t4, s2, t2
	lbu	t2, 5(t3)
	lbu	t6, 5(s4)
	subw	t2, t2, t6
	slliw	t2, t2, 16
	addw	s3, t2, t4
	lbu	t2, 2(t3)
	lbu	t4, 2(s4)
	sub	t6, t2, t4
	lbu	t4, 6(t3)
	lbu	s5, 6(s4)
	sub	t4, t4, s5
	slli	t4, t4, 16
	add	t4, t4, t6
	lbu	t6, 3(t3)
	lbu	s5, 3(s4)
	sub	t6, t6, s5
	lbu	t3, 7(t3)
	lbu	s4, 7(s4)
	sub	t3, t3, s4
	slli	t3, t3, 16
	add	t6, t3, t6
	addw	t3, s3, a2
	subw	a2, a2, s3
	add	ra, t6, t4
	sub	s4, t4, t6
	addw	t4, ra, t3
	sd	t4, 24(sp)                      # 8-byte Folded Spill
	subw	t6, t3, ra
	addw	s9, s4, a2
	subw	a2, a2, s4
	add	a3, a3, t1
	add	s3, a0, a1
	lbu	t4, 0(a3)
	lbu	a0, 0(s3)
	subw	a1, t4, a0
	lbu	a0, 4(a3)
	lbu	t1, 4(s3)
	subw	a0, a0, t1
	slliw	a0, a0, 16
	addw	a0, a0, a1
	lbu	s10, 1(a3)
	lbu	a1, 1(s3)
	subw	t1, s10, a1
	lbu	a1, 5(a3)
	lbu	t3, 5(s3)
	subw	a1, a1, t3
	slliw	a1, a1, 16
	addw	t3, a1, t1
	lbu	a1, 2(a3)
	lbu	t1, 2(s3)
	sub	t1, a1, t1
	lbu	a1, 6(a3)
	lbu	s5, 6(s3)
	sub	a1, a1, s5
	slli	a1, a1, 16
	add	a1, a1, t1
	lbu	t1, 3(a3)
	lbu	s5, 3(s3)
	sub	t1, t1, s5
	lbu	a3, 7(a3)
	lbu	s3, 7(s3)
	sub	a3, a3, s3
	slli	a3, a3, 16
	add	t1, a3, t1
	addw	a3, t3, a0
	subw	a0, a0, t3
	add	s6, t1, a1
	subw	a1, a1, t1
	addw	t1, s6, a3
	sd	t1, 32(sp)                      # 8-byte Folded Spill
	subw	t3, a3, s6
	addw	s5, a1, a0
	subw	a3, a0, a1
	lbu	a1, 0(zero)
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	lbu	a0, 5(zero)
	subw	a0, a1, a0
	slliw	t1, a0, 16
	lbu	a0, 6(zero)
	subw	a0, a1, a0
	slliw	a0, a0, 16
	lbu	s3, 7(zero)
	subw	a1, a1, s3
	slliw	a1, a1, 16
	addw	s3, a1, a0
	subw	a0, a0, a1
	addw	a1, s3, t1
	subw	s3, t1, s3
	subw	s11, a0, t1
	addw	t1, t1, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addw	a0, a0, s0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	subw	s0, s0, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	addw	a0, a1, a0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	subw	a0, a0, a1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	addw	a0, a1, a0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	subw	a0, a0, a1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	addw	a0, a0, s0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	subw	s0, s0, a0
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	s0, 104(sp)                     # 8-byte Folded Spill
	xor	a0, a0, a1
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	srli	a0, s6, 15
	lui	a1, 16
	addi	s0, a1, 1
	and	a1, a0, s0
	slliw	a0, a1, 16
	subw	a0, a0, a1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	addw	a0, a0, a1
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	xor	a0, a0, s6
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	srli	a0, ra, 15
	and	a0, a0, s0
	slliw	s6, a0, 16
	subw	s6, s6, a0
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	addw	s6, s6, a0
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	xor	ra, s6, ra
	srli	a0, a0, 15
	and	a0, a0, s0
	slliw	s6, a0, 16
	subw	s6, s6, a0
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	addw	s6, s6, a0
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	xor	s6, s6, a0
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	addw	a0, a0, a1
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	addw	a0, a0, ra
	addw	s6, a0, s6
	addw	a0, s9, s8
	subw	s8, s8, s9
	addw	s9, s11, s5
	subw	s11, s5, s11
	addw	s5, s9, a0
	subw	s9, a0, s9
	addw	a0, s11, s8
	subw	s8, s8, s11
	xor	s5, s5, s10
	xor	a0, a0, t4
	srli	t4, s4, 15
	and	s10, t4, s0
	slliw	t4, s10, 16
	subw	t4, t4, s10
	addw	t4, t4, s9
	xor	s4, t4, s4
	srli	t4, s7, 15
	and	s9, t4, s0
	slliw	t4, s9, 16
	subw	t4, t4, s9
	addw	t4, t4, s8
	xor	t4, t4, s7
	addw	a0, a0, s6
	addw	a0, a0, s5
	addw	a0, a0, s4
	addw	t4, a0, t4
	addw	a0, t6, a4
	subw	t6, a4, t6
	addw	a4, s3, t3
	subw	s3, t3, s3
	addw	t3, a4, a0
	subw	a4, a0, a4
	addw	a0, s3, t6
	subw	t6, t6, s3
	xor	t3, t3, s2
	xor	a0, a0, s1
	xor	t2, a4, t2
	srli	a4, t5, 15
	and	s0, a4, s0
	slliw	a4, s0, 16
	subw	a4, a4, s0
	addw	a4, a4, t6
	xor	a4, a4, t5
	addw	a0, a0, t4
	addw	a0, a0, t3
	addw	a0, a0, t2
	addw	a4, a0, a4
	addw	a0, a2, a1
	subw	a1, a1, a2
	subw	a2, a3, t1
	addw	t1, a3, t1
	addw	a3, a2, a0
	subw	a2, a0, a2
	addw	a0, t1, a1
	subw	a1, a1, t1
	xor	a3, a3, t0
	xor	a0, a0, a7
	xor	a2, a2, a6
	xor	a1, a1, a5
	addw	a0, a0, a4
	addw	a0, a0, a3
	addw	a0, a0, a2
	addw	a0, a0, a1
	ld	ra, 232(sp)                     # 8-byte Folded Reload
	ld	s0, 224(sp)                     # 8-byte Folded Reload
	ld	s1, 216(sp)                     # 8-byte Folded Reload
	ld	s2, 208(sp)                     # 8-byte Folded Reload
	ld	s3, 200(sp)                     # 8-byte Folded Reload
	ld	s4, 192(sp)                     # 8-byte Folded Reload
	ld	s5, 184(sp)                     # 8-byte Folded Reload
	ld	s6, 176(sp)                     # 8-byte Folded Reload
	ld	s7, 168(sp)                     # 8-byte Folded Reload
	ld	s8, 160(sp)                     # 8-byte Folded Reload
	ld	s9, 152(sp)                     # 8-byte Folded Reload
	ld	s10, 144(sp)                    # 8-byte Folded Reload
	ld	s11, 136(sp)                    # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	.cfi_restore s11
	addi	sp, sp, 240
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
	addi	sp, sp, -192
	.cfi_def_cfa_offset 192
	sd	ra, 184(sp)                     # 8-byte Folded Spill
	sd	s0, 176(sp)                     # 8-byte Folded Spill
	sd	s1, 168(sp)                     # 8-byte Folded Spill
	sd	s2, 160(sp)                     # 8-byte Folded Spill
	sd	s3, 152(sp)                     # 8-byte Folded Spill
	sd	s4, 144(sp)                     # 8-byte Folded Spill
	sd	s5, 136(sp)                     # 8-byte Folded Spill
	sd	s6, 128(sp)                     # 8-byte Folded Spill
	sd	s7, 120(sp)                     # 8-byte Folded Spill
	sd	s8, 112(sp)                     # 8-byte Folded Spill
	sd	s9, 104(sp)                     # 8-byte Folded Spill
	sd	s10, 96(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	.cfi_offset s2, -32
	.cfi_offset s3, -40
	.cfi_offset s4, -48
	.cfi_offset s5, -56
	.cfi_offset s6, -64
	.cfi_offset s7, -72
	.cfi_offset s8, -80
	.cfi_offset s9, -88
	.cfi_offset s10, -96
	addi	s0, sp, 192
	.cfi_def_cfa s0, 0
	andi	sp, sp, -64
	mv	t2, a1
	mv	t3, a0
	addi	t4, t3, 4
	addi	t1, t2, 4
	add	t0, t3, a2
	add	a7, t2, a3
	addi	a6, t0, 4
	addi	a0, a7, 4
	add	a4, a4, a2
	add	a3, a5, a3
	addi	a2, a4, 4
	addi	a1, a3, 4
	lbu	a5, 0(zero)
                                        # implicit-def: $v14
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v14, (t4)
                                        # implicit-def: $v8
	vle8.v	v8, (t3)
                                        # implicit-def: $v16
	vle8.v	v16, (t2)
                                        # implicit-def: $v15
	vle8.v	v15, (t1)
                                        # implicit-def: $v13
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v13, v8
                                        # implicit-def: $v8m4
	vmv.v.v	v8, v13
                                        # implicit-def: $v12
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v12, v16
	vwsubu.wv	v13, v13, v12
                                        # implicit-def: $v12
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v12, v14, v15
                                        # implicit-def: $v14
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v14, v12
                                        # implicit-def: $v12
	vsll.vi	v12, v14, 16
                                        # implicit-def: $v28
	vadd.vv	v28, v12, v13
                                        # implicit-def: $v12
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v12, (t0)
                                        # implicit-def: $v20
	vle8.v	v20, (a7)
                                        # implicit-def: $v18
	vle8.v	v18, (a6)
                                        # implicit-def: $v19
	vle8.v	v19, (a0)
                                        # implicit-def: $v17
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v17, v12
                                        # implicit-def: $v12m4
	vmv.v.v	v12, v17
                                        # implicit-def: $v16
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v16, v20
	vwsubu.wv	v17, v17, v16
                                        # implicit-def: $v16
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v16, v18, v19
                                        # implicit-def: $v18
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v18, v16
                                        # implicit-def: $v16
	vsll.vi	v16, v18, 16
                                        # implicit-def: $v19
	vadd.vv	v19, v16, v17
	li	a0, 0
                                        # implicit-def: $v17
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v17, (a0)
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v16, v17
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v16
	lbu	a6, 4(zero)
                                        # implicit-def: $v16
	vsetivli	zero, 2, e8, mf8, tu, ma
	vmv.v.x	v16, a5
	li	a7, 4
                                        # implicit-def: $v18
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v18, (a7)
                                        # implicit-def: $v17
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v17, v18
                                        # implicit-def: $v18
	vsetivli	zero, 2, e32, mf2, ta, ma
	vzext.vf4	v18, v16
                                        # implicit-def: $v16
	vsetivli	zero, 4, e32, m1, tu, ma
	vslide1up.vx	v16, v18, a6
                                        # implicit-def: $v18
	vmv.s.x	v18, a5
	vsetvli	zero, zero, e32, m1, ta, ma
	vslideup.vi	v16, v18, 3
	vsetvli	zero, zero, e16, mf2, ta, ma
	vwsubu.wv	v16, v16, v17
                                        # implicit-def: $v18
	vsetvli	zero, zero, e32, m1, ta, ma
	vsll.vi	v18, v16, 16
                                        # implicit-def: $v16
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v16, (a4)
                                        # implicit-def: $v31
	vle8.v	v31, (a3)
                                        # implicit-def: $v17
	vle8.v	v17, (a2)
                                        # implicit-def: $v30
	vle8.v	v30, (a1)
                                        # implicit-def: $v29
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v29, v16
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v29
                                        # implicit-def: $v16
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v16, v31
	vwsubu.wv	v29, v29, v16
                                        # implicit-def: $v16
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v16, v17, v30
                                        # implicit-def: $v17
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v17, v16
                                        # implicit-def: $v16
	vsll.vi	v16, v17, 16
                                        # implicit-def: $v17
	vadd.vv	v17, v16, v29
	vmv.x.s	t2, v28
                                        # implicit-def: $v16
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v16, v28, 1
	vmv.x.s	t1, v16
	subw	a6, t2, t1
	vmv.x.s	t0, v19
                                        # implicit-def: $v16
	vslidedown.vi	v16, v19, 1
	vmv.x.s	a2, v16
	subw	a5, t0, a2
	vmv.x.s	a7, v18
                                        # implicit-def: $v16
	vslidedown.vi	v16, v18, 1
	vmv.x.s	a4, v16
	subw	s10, a7, a4
	vmv.x.s	a3, v17
                                        # implicit-def: $v16
	vslidedown.vi	v16, v17, 1
	vmv.x.s	a1, v16
	subw	s2, a3, a1
	addw	s3, t1, t2
	addw	a2, a2, t0
	addw	s1, a4, a7
	addw	a1, a1, a3
                                        # implicit-def: $v16
	vslidedown.vi	v16, v28, 2
	vmv.x.s	t5, v16
                                        # implicit-def: $v16
	vslidedown.vi	v16, v28, 3
	vmv.x.s	t4, v16
	subw	s4, t5, t4
                                        # implicit-def: $v16
	vslidedown.vi	v16, v19, 2
	vmv.x.s	t3, v16
                                        # implicit-def: $v16
	vslidedown.vi	v16, v19, 3
	vmv.x.s	t2, v16
	subw	s5, t3, t2
                                        # implicit-def: $v16
	vslidedown.vi	v16, v18, 2
	vmv.x.s	t1, v16
                                        # implicit-def: $v16
	vslidedown.vi	v16, v18, 3
	vmv.x.s	t0, v16
	subw	s9, t1, t0
                                        # implicit-def: $v16
	vslidedown.vi	v16, v17, 2
	vmv.x.s	a7, v16
                                        # implicit-def: $v16
	vslidedown.vi	v16, v17, 3
	vmv.x.s	a4, v16
	subw	a3, a7, a4
	addw	s6, t4, t5
	addw	s7, t2, t3
	addw	t4, t0, t1
	addw	s8, a4, a7
	subw	t6, a6, s4
	subw	t5, a5, s5
	subw	t3, s10, s9
	subw	t0, s2, a3
	subw	t2, s3, s6
	subw	t1, a2, s7
	subw	a7, s1, t4
	subw	a4, a1, s8
	addw	a6, s4, a6
	addw	a5, s5, a5
	addw	s9, s9, s10
	addw	a3, a3, s2
	addw	s2, s6, s3
	addw	a2, s7, a2
	addw	s1, t4, s1
	addw	a1, s8, a1
	subw	t4, t6, t5
	addw	t6, t5, t6
	addw	t5, t3, t0
	subw	t3, t0, t3
	subw	t0, t2, t1
	addw	t2, t1, t2
	addw	t1, a7, a4
	subw	a7, a4, a7
	subw	a4, a6, a5
	addw	a6, a5, a6
	addw	a5, s9, a3
	subw	a3, a3, s9
	subw	s9, s2, a2
	addw	s10, a2, s2
	addw	a2, s1, a1
	subw	a1, a1, s1
	subw	s2, t4, t3
	subw	s1, t6, t5
	addw	t6, t5, t6
	addw	t5, t3, t4
	subw	t4, t0, a7
	subw	t3, t2, t1
	addw	t2, t1, t2
	addw	t1, a7, t0
	subw	t0, a4, a3
	subw	a7, a6, a5
	addw	a6, a5, a6
	addw	a5, a3, a4
	subw	a4, s9, a1
	subw	a3, s10, a2
	addw	a2, a2, s10
	addw	a1, a1, s9
                                        # implicit-def: $v16m4
	vmv2r.v	v26, v28
	vmv1r.v	v25, v28
	vsetivli	zero, 16, e32, m4, tu, ma
	vslide1up.vx	v16, v24, s8
	vmv1r.v	v24, v16
                                        # implicit-def: $v25
	vmv.s.x	v25, s7
	vsetivli	zero, 3, e32, m1, tu, ma
	vslideup.vi	v24, v25, 2
                                        # implicit-def: $v25
	vmv.s.x	v25, s6
	vsetivli	zero, 4, e32, m1, tu, ma
	vslideup.vi	v24, v25, 3
	vmv1r.v	v16, v24
	vmv2r.v	v22, v24
	vmv1r.v	v21, v24
	vsetivli	zero, 8, e32, m4, tu, ma
	vslideup.vi	v16, v20, 4
	vmv2r.v	v20, v16
                                        # implicit-def: $v24
	vmv.s.x	v24, s5
                                        # implicit-def: $v22m2
	vmv1r.v	v22, v24
	vmv1r.v	v23, v24
	vsetivli	zero, 7, e32, m2, tu, ma
	vslideup.vi	v20, v22, 6
                                        # implicit-def: $v24
	vmv.s.x	v24, s4
                                        # implicit-def: $v22m2
	vmv1r.v	v22, v24
	vmv1r.v	v23, v24
	vsetivli	zero, 8, e32, m2, tu, ma
	vslideup.vi	v20, v22, 7
	vmv2r.v	v16, v20
	vmv2r.v	v14, v20
	vmv1r.v	v13, v20
	vsetivli	zero, 12, e32, m4, tu, ma
	vslideup.vi	v16, v12, 8
                                        # implicit-def: $v20
	vmv.s.x	v20, s3
                                        # implicit-def: $v12m4
	vmv1r.v	v12, v20
	vmv2r.v	v14, v20
	vmv1r.v	v13, v20
	vslideup.vi	v16, v12, 11
	vmv2r.v	v10, v12
	vmv1r.v	v9, v12
	vsetivli	zero, 16, e32, m4, ta, ma
	vslideup.vi	v16, v8, 12
	vmv.v.v	v8, v16
	li	s3, 32
                                        # implicit-def: $v12m4
	vsetvli	zero, s3, e16, m4, ta, ma
	vsra.vi	v12, v8, 15
	sw	s2, 60(sp)
	sw	s1, 56(sp)
	sw	t6, 52(sp)
	sw	t5, 48(sp)
	sw	t4, 44(sp)
	sw	t3, 40(sp)
	sw	t2, 36(sp)
	sw	t1, 32(sp)
	sw	t0, 28(sp)
	sw	a7, 24(sp)
	sw	a6, 20(sp)
	sw	a5, 16(sp)
	sw	a4, 12(sp)
	sw	a3, 8(sp)
	sw	a2, 4(sp)
	sw	a1, 0(sp)
	mv	a1, sp
                                        # implicit-def: $v20m4
	vsetivli	zero, 16, e32, m4, tu, ma
	vle32.v	v20, (a1)
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vadd.vv	v8, v12, v20
                                        # implicit-def: $v12m4
	vxor.vv	v12, v8, v16
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m4, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m4, ta, ma
	vredsum.vs	v8, v12, v9
	vmv.x.s	a0, v8
	addi	sp, s0, -192
	.cfi_def_cfa sp, 192
	ld	ra, 184(sp)                     # 8-byte Folded Reload
	ld	s0, 176(sp)                     # 8-byte Folded Reload
	ld	s1, 168(sp)                     # 8-byte Folded Reload
	ld	s2, 160(sp)                     # 8-byte Folded Reload
	ld	s3, 152(sp)                     # 8-byte Folded Reload
	ld	s4, 144(sp)                     # 8-byte Folded Reload
	ld	s5, 136(sp)                     # 8-byte Folded Reload
	ld	s6, 128(sp)                     # 8-byte Folded Reload
	ld	s7, 120(sp)                     # 8-byte Folded Reload
	ld	s8, 112(sp)                     # 8-byte Folded Reload
	ld	s9, 104(sp)                     # 8-byte Folded Reload
	ld	s10, 96(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	.cfi_restore s2
	.cfi_restore s3
	.cfi_restore s4
	.cfi_restore s5
	.cfi_restore s6
	.cfi_restore s7
	.cfi_restore s8
	.cfi_restore s9
	.cfi_restore s10
	addi	sp, sp, 192
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
