# Source: SLPVectorizer/complex-loads.riscv64-unknown-linux-gnu__v_slp-vectorizer_THR15.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a6, vlenb
	slli	a6, a6, 1
	mv	a7, a6
	slli	a6, a6, 1
	add	a7, a7, a6
	slli	a6, a6, 1
	add	a6, a6, a7
	sub	sp, sp, a6
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x0e, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 14 * vlenb
	sd	a5, 24(sp)                      # 8-byte Folded Spill
	mv	t3, a1
	mv	t4, a0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	t2, t4, 4
	addi	a1, t3, 4
	add	t1, t4, a2
	add	t0, t3, a3
	addi	a7, t1, 4
	addi	a6, t0, 4
	add	a5, a4, a2
	add	a4, a0, a3
	addi	a3, a5, 4
	addi	a2, a4, 4
                                        # implicit-def: $v9
	vsetivli	zero, 2, e8, mf8, tu, ma
	vmv.v.i	v9, 0
	li	a0, 0
                                        # implicit-def: $v8
	vluxei8.v	v8, (a0), v9
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v9, (t4)
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v10, v9
	vmv.v.v	v9, v10
                                        # implicit-def: $v12m4
	vmv.v.v	v12, v9
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v11, (t3)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v9, v11
	vwsubu.wv	v10, v10, v9
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v11, (t2)
                                        # implicit-def: $v16
	vle8.v	v16, (a1)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v9, v11, v16
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v11, v9
                                        # implicit-def: $v9
	vsll.vi	v9, v11, 16
                                        # implicit-def: $v11
	vadd.vv	v11, v9, v10
	vmv.v.v	v9, v11
	li	a1, 32
                                        # implicit-def: $v16
	vsetivli	zero, 2, e64, m1, ta, ma
	vsrl.vx	v16, v9, a1
                                        # implicit-def: $v10
	vsll.vx	v10, v9, a1
                                        # implicit-def: $v9
	vor.vv	v9, v10, v16
                                        # implicit-def: $v16
	vsetivli	zero, 4, e32, m1, ta, ma
	vrsub.vi	v16, v11, 0
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 10
	csrr	t2, vlenb
	add	t2, sp, t2
	addi	t2, t2, 32
	vs1r.v	v0, (t2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v10, v11, v16, v0
                                        # implicit-def: $v17
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v17, v9, v10
                                        # implicit-def: $v10
	vslidedown.vi	v10, v17, 2
	vslideup.vi	v10, v17, 2
                                        # implicit-def: $v11
	vrsub.vi	v11, v10, 0
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 3
	addi	t2, sp, 32
	vs1r.v	v0, (t2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v9, v10, v11, v0
	csrr	t2, vlenb
	add	t2, sp, t2
	addi	t2, t2, 32
	vl1r.v	v0, (t2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v10, v17, v9
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v9, (t1)
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v16, v9
	vmv.v.v	v9, v16
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v9
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v11, (t0)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v9, v11
	vwsubu.wv	v16, v16, v9
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v9, (a7)
                                        # implicit-def: $v18
	vle8.v	v18, (a6)
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v11, v9, v18
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v9, v11
                                        # implicit-def: $v11
	vsll.vi	v11, v9, 16
                                        # implicit-def: $v9
	vadd.vv	v9, v11, v16
	vmv.v.v	v11, v9
                                        # implicit-def: $v18
	vsetivli	zero, 2, e64, m1, ta, ma
	vsrl.vx	v18, v11, a1
                                        # implicit-def: $v16
	vsll.vx	v16, v11, a1
                                        # implicit-def: $v11
	vor.vv	v11, v16, v18
                                        # implicit-def: $v18
	vsetivli	zero, 4, e32, m1, ta, ma
	vrsub.vi	v18, v9, 0
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vvm	v16, v9, v18, v0
	addi	a6, sp, 32
	vl1r.v	v0, (a6)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v9, v11, v16
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v9
	csrr	a6, vlenb
	slli	a6, a6, 1
	mv	a7, a6
	slli	a6, a6, 2
	add	a6, a6, a7
	add	a6, sp, a6
	addi	a6, a6, 32
	vs4r.v	v20, (a6)                       # vscale x 32-byte Folded Spill
                                        # implicit-def: $v16
	vslidedown.vi	v16, v9, 2
	vslideup.vi	v16, v9, 2
                                        # implicit-def: $v18
	vrsub.vi	v18, v16, 0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vvm	v11, v16, v18, v0
                                        # implicit-def: $v19
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v19, v9, v11
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v9, (a5)
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v11, v9
                                        # implicit-def: $v4m4
	vmv.v.v	v4, v11
                                        # implicit-def: $v16
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v16, (a4)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v9, v16
	vwsubu.wv	v11, v11, v9
                                        # implicit-def: $v16
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v16, (a3)
                                        # implicit-def: $v18
	vle8.v	v18, (a2)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, ta, ma
	vwsubu.vv	v9, v16, v18
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v16, v9
                                        # implicit-def: $v9
	vsll.vi	v9, v16, 16
                                        # implicit-def: $v18
	vadd.vv	v18, v9, v11
	vmv.v.v	v11, v18
                                        # implicit-def: $v16
	vsetivli	zero, 2, e64, m1, ta, ma
	vsrl.vx	v16, v11, a1
                                        # implicit-def: $v9
	vsll.vx	v9, v11, a1
                                        # implicit-def: $v11
	vor.vv	v11, v9, v16
                                        # implicit-def: $v16
	vsetivli	zero, 4, e32, m1, ta, ma
	vadd.vv	v16, v11, v18
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v16
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 32
	vs4r.v	v20, (a2)                       # vscale x 32-byte Folded Spill
                                        # implicit-def: $v9
	vsub.vv	v9, v11, v18
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 5
                                        # implicit-def: $v11
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v11, v9, v16, v0
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 32
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v18
	vsetvli	zero, zero, e32, m1, ta, ma
	vslidedown.vi	v18, v11, 2
	vslideup.vi	v18, v11, 2
                                        # implicit-def: $v16
	vadd.vv	v16, v11, v18
                                        # implicit-def: $v9
	vsub.vv	v9, v11, v18
                                        # implicit-def: $v11
	vslidedown.vi	v11, v16, 2
	vslideup.vi	v11, v9, 2
	li	a2, 4
                                        # implicit-def: $v9
	vsetivli	zero, 2, e8, mf8, tu, ma
	vlse8.v	v9, (a0), a2
                                        # implicit-def: $v18
	vsetivli	zero, 4, e8, mf4, tu, ma
	vle8.v	v18, (a0)
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v16, v18
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v16
	csrr	a3, vlenb
	slli	a3, a3, 1
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 32
	vs4r.v	v20, (a3)                       # vscale x 32-byte Folded Spill
	vsetvli	zero, zero, e8, mf4, ta, ma
	vslideup.vi	v8, v9, 2
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v9, v8
                                        # implicit-def: $v16
	vsetvli	zero, zero, e8, mf4, tu, ma
	vle8.v	v16, (a2)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf4	v8, v16
                                        # implicit-def: $v16
	vid.v	v16
                                        # implicit-def: $v18
	vrsub.vi	v18, v16, 3
                                        # implicit-def: $v16
	vrgather.vv	v16, v8, v18
                                        # implicit-def: $v8
	vsub.vv	v8, v9, v16
                                        # implicit-def: $v9
	vsll.vi	v9, v8, 16
	vmv.v.v	v8, v9
                                        # implicit-def: $v18
	vsetivli	zero, 2, e64, m1, ta, ma
	vsrl.vx	v18, v8, a1
                                        # implicit-def: $v16
	vsll.vx	v16, v8, a1
                                        # implicit-def: $v8
	vor.vv	v8, v16, v18
                                        # implicit-def: $v18
	vsetivli	zero, 4, e32, m1, ta, ma
	vrsub.vi	v18, v8, 0
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vvm	v16, v8, v18, v0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v8, v9, v16
                                        # implicit-def: $v16
	vslidedown.vi	v16, v8, 2
	vslideup.vi	v16, v8, 2
                                        # implicit-def: $v18
	vrsub.vi	v18, v16, 0
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 12
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v9, v16, v18, v0
                                        # implicit-def: $v16
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v16, v8, v9
                                        # implicit-def: $v8
	vadd.vv	v8, v19, v10
                                        # implicit-def: $v18
	vslidedown.vi	v18, v8, 2
	vslideup.vi	v18, v8, 2
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v18
                                        # implicit-def: $v18
	vsub.vv	v18, v10, v19
                                        # implicit-def: $v10
	vslidedown.vi	v10, v18, 2
	vslideup.vi	v10, v18, 2
                                        # implicit-def: $v20m2
	vmv.v.v	v20, v10
	vmv1r.v	v9, v10
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v20, v8, 4
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, ta, ma
	vadd.vv	v10, v16, v11
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
                                        # implicit-def: $v10
	vsub.vv	v10, v11, v16
                                        # implicit-def: $v22m2
	vmv.v.v	v22, v10
	vmv1r.v	v9, v10
	vsetivli	zero, 8, e32, m2, ta, ma
	vslideup.vi	v22, v8, 4
                                        # implicit-def: $v18m2
	vadd.vv	v18, v22, v20
	vmv1r.v	v11, v18
                                        # implicit-def: $v8m2
	vsub.vv	v8, v20, v22
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v8
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e32, m2, ta, ma
	vslidedown.vi	v8, v18, 4
	vmv1r.v	v10, v8
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e32, m1, ta, ma
	vwaddu.vv	v8, v11, v10
	li	a2, -1
	vwmaccu.vx	v8, a2, v10
                                        # implicit-def: $v28m4
	vmv2r.v	v28, v8
	lui	a2, %hi(.LCPI0_0)
	addi	a2, a2, %lo(.LCPI0_0)
                                        # implicit-def: $v18m2
	vsetivli	zero, 16, e16, m2, tu, ma
	vle16.v	v18, (a2)
                                        # implicit-def: $v8m4
	vmv2r.v	v22, v2
	vsetvli	zero, zero, e32, m4, ta, ma
	vrgatherei16.vv	v8, v20, v18
	li	a2, -256
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v20, v28, v8, v0
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 32
	vl4r.v	v8, (a2)                        # vscale x 32-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 32
	vl4r.v	v0, (a2)                        # vscale x 32-byte Folded Reload
                                        # implicit-def: $v28m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vslidedown.vi	v28, v8, 2
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 2
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 32
	vl4r.v	v8, (a2)                        # vscale x 32-byte Folded Reload
	vmv2r.v	v2, v18
	vmv1r.v	v1, v16
	vslideup.vi	v28, v0, 1
	vmv2r.v	v6, v18
	vmv1r.v	v5, v16
	vsetivli	zero, 4, e32, m4, tu, ma
	vslideup.vi	v28, v4, 2
                                        # implicit-def: $v4m4
	vmv4r.v	v0, v24
	vmv2r.v	v2, v18
	vmv1r.v	v1, v16
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v4, v0, 2
	vmv2r.v	v26, v18
	vmv1r.v	v25, v16
	vslideup.vi	v4, v24, 5
	li	a2, 68
                                        # implicit-def: $v0
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v24m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v24, v28, v4, v0
                                        # implicit-def: $v28m4
	vmv4r.v	v4, v12
	vmv2r.v	v6, v18
	vmv1r.v	v5, v16
	vsetvli	zero, zero, e64, m4, ta, ma
	vslideup.vi	v28, v4, 3
	vmv2r.v	v14, v18
	vmv1r.v	v13, v16
	vslideup.vi	v28, v12, 6
	li	a2, 136
                                        # implicit-def: $v0
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vvm	v12, v24, v28, v0
                                        # implicit-def: $v24m4
	vmv4r.v	v28, v8
	vmv2r.v	v30, v18
	vmv1r.v	v29, v16
	vsetivli	zero, 16, e32, m4, ta, ma
	vslideup.vi	v24, v28, 6
	li	a2, 1024
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a2
	vmv2r.v	v10, v18
	vmv1r.v	v9, v16
	vsetvli	zero, zero, e32, m4, ta, mu
	vslideup.vi	v24, v8, 7, v0.t
	li	a2, 1280
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmerge.vvm	v8, v12, v24, v0
	csrr	a2, vlenb
	srli	a2, a2, 2
	lui	a3, %hi(.LCPI0_1)
	addi	a3, a3, %lo(.LCPI0_1)
                                        # implicit-def: $v12m2
	vle16.v	v12, (a3)
                                        # implicit-def: $v18m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vslidedown.vx	v18, v12, a2
	vmv1r.v	v14, v18
                                        # implicit-def: $v16
	vsetvli	a3, zero, e32, m1, ta, ma
	vrgatherei16.vv	v16, v17, v14
                                        # kill: def $v12 killed $v12 killed $v12m2 killed $vtype
                                        # implicit-def: $v24
	vrgatherei16.vv	v24, v17, v12
                                        # implicit-def: $v12m4
	vmv.v.v	v12, v24
	vmv.v.v	v13, v16
                                        # implicit-def: $v24m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v24, v18, a2
	vmv1r.v	v18, v24
                                        # implicit-def: $v16
	vsetvli	a3, zero, e32, m1, ta, ma
	vrgatherei16.vv	v16, v17, v18
	vmv.v.v	v14, v16
                                        # implicit-def: $v18m2
	vsetivli	zero, 16, e16, m2, ta, ma
	vslidedown.vx	v18, v24, a2
                                        # kill: def $v18 killed $v18 killed $v18m2 killed $vtype
                                        # implicit-def: $v16
	vsetvli	a2, zero, e32, m1, ta, ma
	vrgatherei16.vv	v16, v17, v18
	vmv.v.v	v15, v16
	li	a2, 21
	slli	a2, a2, 9
                                        # implicit-def: $v0
	vsetvli	zero, zero, e16, mf2, tu, ma
	vmv.s.x	v0, a2
                                        # implicit-def: $v16m4
	vsetivli	zero, 16, e32, m4, tu, ma
	vmerge.vvm	v16, v8, v12, v0
	vmv4r.v	v8, v16
                                        # implicit-def: $v12m4
	vsetvli	zero, a1, e16, m4, ta, ma
	vsra.vi	v12, v8, 15
                                        # implicit-def: $v8m4
	vsetivli	zero, 16, e32, m4, ta, ma
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
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	sp, sp, a1
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
