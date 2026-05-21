# Source: SLPVectorizer/reordered-interleaved-loads.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
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
	addi	sp, sp, -272
	.cfi_def_cfa_offset 272
	sd	a7, 168(sp)                     # 8-byte Folded Spill
	sd	a6, 176(sp)                     # 8-byte Folded Spill
	sd	a5, 184(sp)                     # 8-byte Folded Spill
	sd	a4, 192(sp)                     # 8-byte Folded Spill
	sd	a3, 200(sp)                     # 8-byte Folded Spill
	sd	a1, 208(sp)                     # 8-byte Folded Spill
	sd	a0, 216(sp)                     # 8-byte Folded Spill
	ld	t0, 280(sp)
	sd	t0, 224(sp)                     # 8-byte Folded Spill
	ld	t0, 272(sp)
	sd	t0, 232(sp)                     # 8-byte Folded Spill
	lh	a0, 0(a2)
	li	a1, 0
	sd	a1, 240(sp)                     # 8-byte Folded Spill
	slt	a2, a1, a0
	sub	a1, a1, a2
	and	a1, a1, a0
	sd	a1, 248(sp)                     # 8-byte Folded Spill
	li	a1, 8
	sd	a1, 256(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 264(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 264(sp)                     # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	ld	a0, 208(sp)                     # 8-byte Folded Reload
	ld	a3, 248(sp)                     # 8-byte Folded Reload
	ld	a4, 216(sp)                     # 8-byte Folded Reload
	ld	a1, 264(sp)                     # 8-byte Folded Reload
	xor	a1, a1, a4
	sext.w	a1, a1
	slt	a1, a1, a3
	lui	a3, %hi(a)
	sd	a3, 136(sp)                     # 8-byte Folded Spill
	sh	a1, %lo(a)(a3)
	slli	a0, a0, 48
	srai	a1, a0, 48
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	slt	a3, a2, a1
	sub	a2, a2, a3
	and	a2, a2, a1
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB0_4
# %bb.3:                                # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 160(sp)                     # 8-byte Folded Spill
.LBB0_4:                                # %entry
	ld	a1, 240(sp)                     # 8-byte Folded Reload
	ld	a2, 136(sp)                     # 8-byte Folded Reload
	ld	a3, 152(sp)                     # 8-byte Folded Reload
	ld	a4, 144(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	xor	a0, a0, a4
	slt	a0, a0, a3
	sh	a0, %lo(a)(a2)
	lui	a0, %hi(h)
	addi	a0, a0, %lo(h)
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	lh	a0, 0(a0)
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	slt	a2, a1, a0
	sub	a1, a1, a2
	and	a1, a1, a0
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB0_6
# %bb.5:                                # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB0_6:                                # %entry
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	ld	a0, 200(sp)                     # 8-byte Folded Reload
	ld	a3, 136(sp)                     # 8-byte Folded Reload
	ld	a4, 120(sp)                     # 8-byte Folded Reload
	ld	a5, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	xor	a1, a1, a5
	slt	a1, a1, a4
	sh	a1, %lo(a)(a3)
	slli	a0, a0, 48
	srai	a1, a0, 48
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	slt	a3, a2, a1
	sub	a2, a2, a3
	and	a2, a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_8
# %bb.7:                                # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB0_8:                                # %entry
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	ld	a1, 192(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 136(sp)                     # 8-byte Folded Reload
	ld	a5, 88(sp)                      # 8-byte Folded Reload
	ld	a6, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	xor	a3, a3, a6
	slt	a3, a3, a5
	sh	a3, %lo(a)(a4)
	lhu	a0, 6(a0)
	slli	a1, a1, 48
	srai	a1, a1, 48
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	slt	a3, a2, a1
	sub	a2, a2, a3
	and	a2, a2, a1
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_10
# %bb.9:                                # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB0_10:                               # %entry
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	ld	a1, 184(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 136(sp)                     # 8-byte Folded Reload
	ld	a5, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	xor	a3, a3, a6
	slt	a3, a3, a5
	sh	a3, %lo(a)(a4)
	lhu	a0, 12(a0)
	slli	a1, a1, 48
	srai	a1, a1, 48
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slt	a3, a2, a1
	sub	a2, a2, a3
	and	a2, a2, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_12
# %bb.11:                               # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
.LBB0_12:                               # %entry
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 136(sp)                     # 8-byte Folded Reload
	ld	a5, 40(sp)                      # 8-byte Folded Reload
	ld	a6, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	xor	a3, a3, a6
	slt	a3, a3, a5
	sh	a3, %lo(a)(a4)
	lhu	a0, 18(a0)
	slli	a1, a1, 48
	srai	a1, a1, 48
	slt	a3, a2, a1
	sub	a2, a2, a3
	and	a2, a2, a1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_14
# %bb.13:                               # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_14:                               # %entry
	ld	a2, 240(sp)                     # 8-byte Folded Reload
	ld	a1, 232(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 136(sp)                     # 8-byte Folded Reload
	ld	a5, 16(sp)                      # 8-byte Folded Reload
	ld	a6, 168(sp)                     # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	xor	a3, a3, a6
	sext.w	a3, a3
	slt	a3, a3, a5
	sh	a3, %lo(a)(a4)
	lhu	a0, 24(a0)
	slli	a1, a1, 48
	srai	a1, a1, 48
	slt	a3, a2, a1
	sub	a2, a2, a3
	and	a2, a2, a1
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_16
# %bb.15:                               # %entry
	ld	a0, 256(sp)                     # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB0_16:                               # %entry
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 224(sp)                     # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	xor	a0, a0, a2
	sext.w	a0, a0
	slt	a0, a0, a1
	addi	sp, sp, 272
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
	mv	t0, a4
	mv	t3, a3
	mv	t1, a1
	mv	a1, a0
	ld	a0, 8(sp)
	ld	a4, 0(sp)
	lh	a2, 0(a2)
	lui	a3, %hi(h)
	addi	a3, a3, %lo(h)
	lh	t2, 0(a3)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv.v.x	v9, t3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, t2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, t1
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vsext.vf2	v11, v8
	li	a2, 0
                                        # implicit-def: $v9
	vmax.vx	v9, v11, a2
	vsetvli	zero, zero, e16, mf2, ta, ma
	vmseq.vi	v0, v8, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vim	v10, v11, 8, v0
                                        # implicit-def: $v8
	vmv.s.x	v8, a1
	vsetvli	zero, zero, e32, m1, ta, ma
	vslideup.vi	v11, v8, 3
                                        # implicit-def: $v8
	vxor.vv	v8, v10, v11
	vmslt.vv	v9, v8, v9
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.i	v8, 0
	vmv1r.v	v0, v9
                                        # implicit-def: $v11
	vmerge.vim	v11, v8, 1, v0
                                        # implicit-def: $v10
	vsetivli	zero, 1, e8, mf4, ta, ma
	vslidedown.vi	v10, v11, 3
	vmv.x.s	a1, v10
	andi	t1, a1, 1
	lui	a1, %hi(a)
	sh	t1, %lo(a)(a1)
                                        # implicit-def: $v10
	vslidedown.vi	v10, v11, 2
	vmv.x.s	t1, v10
	andi	t1, t1, 1
	sh	t1, %lo(a)(a1)
                                        # implicit-def: $v10
	vslidedown.vi	v10, v11, 1
	vmv.x.s	t1, v10
	andi	t1, t1, 1
	sh	t1, %lo(a)(a1)
	vsetivli	zero, 4, e8, mf4, ta, ma
	vfirst.m	t1, v9
	seqz	t1, t1
	sh	t1, %lo(a)(a1)
                                        # implicit-def: $v10
	vsetvli	zero, zero, e16, mf2, tu, ma
	vmv.v.x	v10, t0
                                        # implicit-def: $v9
	vslide1down.vx	v9, v10, a5
                                        # implicit-def: $v10
	vslide1down.vx	v10, v9, a6
                                        # implicit-def: $v9
	vslide1down.vx	v9, v10, a4
                                        # implicit-def: $v12
	vsetvli	zero, zero, e32, m1, ta, ma
	vsext.vf2	v12, v9
	addi	a3, a3, 6
                                        # implicit-def: $v16m2
	vsetivli	zero, 16, e8, m1, tu, ma
	vle16.v	v16, (a3)
	vmv1r.v	v9, v16
	li	a3, 73
                                        # implicit-def: $v11
	vmv.s.x	v11, a3
                                        # implicit-def: $v10
	vsetivli	zero, 8, e16, m1, tu, ma
	vcompress.vm	v10, v9, v11
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 8
                                        # implicit-def: $v14m2
	vsetivli	zero, 8, e16, m2, ta, ma
	vslidedown.vi	v14, v16, 8
	vmv1r.v	v9, v14
                                        # implicit-def: $v11
	vsetivli	zero, 8, e16, m1, ta, ma
	vrgather.vi	v11, v9, 1
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, m1, tu, ma
	vmerge.vvm	v9, v10, v11, v0
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, ta, ma
	vmax.vx	v10, v12, a2
	vsetvli	zero, zero, e16, mf2, ta, ma
	vmseq.vi	v0, v9, 0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vim	v11, v12, 8, v0
                                        # implicit-def: $v9
	vmv.s.x	v9, a7
	vsetivli	zero, 3, e32, m1, tu, ma
	vslideup.vi	v12, v9, 2
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
	vsetivli	zero, 4, e32, m1, ta, ma
	vslideup.vi	v12, v9, 3
                                        # implicit-def: $v9
	vxor.vv	v9, v11, v12
	vmslt.vv	v0, v9, v10
	vfirst.m	a0, v0
	seqz	a0, a0
	sh	a0, %lo(a)(a1)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v9, v8, 1, v0
                                        # implicit-def: $v8
	vsetivli	zero, 1, e8, mf4, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a0, v8
	andi	a0, a0, 1
	sh	a0, %lo(a)(a1)
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 2
	vmv.x.s	a0, v8
	andi	a0, a0, 1
	sh	a0, %lo(a)(a1)
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 3
	vmv.x.s	a0, v8
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
