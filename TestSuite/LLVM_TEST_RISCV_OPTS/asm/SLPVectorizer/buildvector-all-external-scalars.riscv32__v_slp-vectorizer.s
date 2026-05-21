# Source: SLPVectorizer/buildvector-all-external-scalars.riscv32__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %newFuncRoot
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %while.body.i.i
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a1, 8(sp)                       # 4-byte Folded Reload
	sw	a0, 0(sp)                       # 4-byte Folded Spill
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	flw	fa5, 0(a0)
	flw	fa4, 0(a1)
	fsw	fa4, 0(a0)
	fsw	fa5, 0(a1)
	flw	fa5, 4(a0)
	flw	fa4, -4(a1)
	fsw	fa4, 4(a0)
	fsw	fa5, -4(a1)
	flw	fa5, 8(a0)
	flw	fa4, -8(a1)
	fsw	fa4, 8(a0)
	fsw	fa5, -8(a1)
	flw	fa5, 12(a0)
	flw	fa4, -12(a1)
	fsw	fa4, 12(a0)
	fsw	fa5, -12(a1)
	flw	fa5, 16(a0)
	flw	fa4, -16(a1)
	fsw	fa4, 16(a0)
	fsw	fa5, -16(a1)
	flw	fa5, 20(a0)
	flw	fa4, -20(a1)
	fsw	fa4, 20(a0)
	fsw	fa5, -20(a1)
	flw	fa5, 24(a0)
	flw	fa4, -24(a1)
	fsw	fa4, 24(a0)
	fsw	fa5, -24(a1)
	flw	fa5, 28(a0)
	flw	fa4, -28(a1)
	fsw	fa4, 28(a0)
	fsw	fa5, -28(a1)
	flw	fa5, 32(a0)
	flw	fa4, -32(a1)
	fsw	fa4, 32(a0)
	fsw	fa5, -32(a1)
	flw	fa5, 36(a0)
	flw	fa4, -36(a1)
	fsw	fa4, 36(a0)
	fsw	fa5, -36(a1)
	flw	fa5, 40(a0)
	flw	fa4, -40(a1)
	fsw	fa4, 40(a0)
	fsw	fa5, -40(a1)
	flw	fa5, 44(a0)
	flw	fa4, -44(a1)
	fsw	fa4, 44(a0)
	fsw	fa5, -44(a1)
	flw	fa5, 48(a0)
	flw	fa4, -48(a1)
	fsw	fa4, 48(a0)
	fsw	fa5, -48(a1)
	flw	fa5, 52(a0)
	flw	fa4, -52(a1)
	fsw	fa4, 52(a0)
	fsw	fa5, -52(a1)
	flw	fa5, 56(a0)
	flw	fa4, -56(a1)
	fsw	fa4, 56(a0)
	fsw	fa5, -56(a1)
	flw	fa5, 60(a0)
	flw	fa4, -60(a1)
	fsw	fa4, 60(a0)
	fsw	fa5, -60(a1)
	flw	fa5, 64(a0)
	flw	fa4, -64(a1)
	fsw	fa4, 64(a0)
	fsw	fa5, -64(a1)
	flw	fa5, 68(a0)
	flw	fa4, -68(a1)
	fsw	fa4, 68(a0)
	fsw	fa5, -68(a1)
	flw	fa5, 72(a0)
	flw	fa4, -72(a1)
	fsw	fa4, 72(a0)
	fsw	fa5, -72(a1)
	flw	fa5, 76(a0)
	flw	fa4, -76(a1)
	fsw	fa4, 76(a0)
	fsw	fa5, -76(a1)
	flw	fa5, 80(a0)
	flw	fa4, -80(a1)
	fsw	fa4, 80(a0)
	fsw	fa5, -80(a1)
	flw	fa5, 84(a0)
	flw	fa4, -84(a1)
	fsw	fa4, 84(a0)
	fsw	fa5, -84(a1)
	flw	fa5, 88(a0)
	flw	fa4, -88(a1)
	fsw	fa4, 88(a0)
	fsw	fa5, -88(a1)
	flw	fa5, 92(a0)
	flw	fa4, -92(a1)
	fsw	fa4, 92(a0)
	fsw	fa5, -92(a1)
	flw	fa5, 96(a0)
	flw	fa4, -96(a1)
	fsw	fa4, 96(a0)
	fsw	fa5, -96(a1)
	flw	fa5, 100(a0)
	flw	fa4, -100(a1)
	fsw	fa4, 100(a0)
	fsw	fa5, -100(a1)
	flw	fa5, 104(a0)
	flw	fa4, -104(a1)
	fsw	fa4, 104(a0)
	fsw	fa5, -104(a1)
	flw	fa5, 108(a0)
	flw	fa4, -108(a1)
	fsw	fa4, 108(a0)
	fsw	fa5, -108(a1)
	flw	fa5, 112(a0)
	flw	fa4, -112(a1)
	fsw	fa4, 112(a0)
	fsw	fa5, -112(a1)
	flw	fa5, 116(a0)
	flw	fa4, -116(a1)
	fsw	fa4, 116(a0)
	fsw	fa5, -116(a1)
	flw	fa5, 120(a0)
	flw	fa4, -120(a1)
	fsw	fa4, 120(a0)
	fsw	fa5, -120(a1)
	flw	fa5, 124(a0)
	flw	fa4, -124(a1)
	fsw	fa4, 124(a0)
	fsw	fa5, -124(a1)
	addi	a0, a0, 128
	addi	a1, a1, -128
	mv	a2, a1
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	mv	a2, a0
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	bltu	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %invoke.cont21.exitStub
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
# %bb.0:                                # %newFuncRoot
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a2, vlenb
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, tu, ma
	vmv.v.x	v9, a0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a1
	addi	a0, sp, 16
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %while.body.i.i
                                        # =>This Inner Loop Header: Depth=1
	addi	a0, sp, 16
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 1, e32, mf2, ta, ma
	vslidedown.vi	v9, v8, 1
	vmv.x.s	a0, v9
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	flw	fa5, 0(a0)
	vmv.x.s	a1, v8
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	flw	fa4, 0(a1)
	fsw	fa4, 0(a0)
	fsw	fa5, 0(a1)
	flw	fa5, 4(a0)
	flw	fa4, -4(a1)
	fsw	fa4, 4(a0)
	fsw	fa5, -4(a1)
	flw	fa5, 8(a0)
	flw	fa4, -8(a1)
	fsw	fa4, 8(a0)
	fsw	fa5, -8(a1)
	flw	fa5, 12(a0)
	flw	fa4, -12(a1)
	fsw	fa4, 12(a0)
	fsw	fa5, -12(a1)
	flw	fa5, 16(a0)
	flw	fa4, -16(a1)
	fsw	fa4, 16(a0)
	fsw	fa5, -16(a1)
	flw	fa5, 20(a0)
	flw	fa4, -20(a1)
	fsw	fa4, 20(a0)
	fsw	fa5, -20(a1)
	flw	fa5, 24(a0)
	flw	fa4, -24(a1)
	fsw	fa4, 24(a0)
	fsw	fa5, -24(a1)
	flw	fa5, 28(a0)
	flw	fa4, -28(a1)
	fsw	fa4, 28(a0)
	fsw	fa5, -28(a1)
	flw	fa5, 32(a0)
	flw	fa4, -32(a1)
	fsw	fa4, 32(a0)
	fsw	fa5, -32(a1)
	flw	fa5, 36(a0)
	flw	fa4, -36(a1)
	fsw	fa4, 36(a0)
	fsw	fa5, -36(a1)
	flw	fa5, 40(a0)
	flw	fa4, -40(a1)
	fsw	fa4, 40(a0)
	fsw	fa5, -40(a1)
	flw	fa5, 44(a0)
	flw	fa4, -44(a1)
	fsw	fa4, 44(a0)
	fsw	fa5, -44(a1)
	flw	fa5, 48(a0)
	flw	fa4, -48(a1)
	fsw	fa4, 48(a0)
	fsw	fa5, -48(a1)
	flw	fa5, 52(a0)
	flw	fa4, -52(a1)
	fsw	fa4, 52(a0)
	fsw	fa5, -52(a1)
	flw	fa5, 56(a0)
	flw	fa4, -56(a1)
	fsw	fa4, 56(a0)
	fsw	fa5, -56(a1)
	flw	fa5, 60(a0)
	flw	fa4, -60(a1)
	fsw	fa4, 60(a0)
	fsw	fa5, -60(a1)
	flw	fa5, 64(a0)
	flw	fa4, -64(a1)
	fsw	fa4, 64(a0)
	fsw	fa5, -64(a1)
	flw	fa5, 68(a0)
	flw	fa4, -68(a1)
	fsw	fa4, 68(a0)
	fsw	fa5, -68(a1)
	flw	fa5, 72(a0)
	flw	fa4, -72(a1)
	fsw	fa4, 72(a0)
	fsw	fa5, -72(a1)
	flw	fa5, 76(a0)
	flw	fa4, -76(a1)
	fsw	fa4, 76(a0)
	fsw	fa5, -76(a1)
	flw	fa5, 80(a0)
	flw	fa4, -80(a1)
	fsw	fa4, 80(a0)
	fsw	fa5, -80(a1)
	flw	fa5, 84(a0)
	flw	fa4, -84(a1)
	fsw	fa4, 84(a0)
	fsw	fa5, -84(a1)
	flw	fa5, 88(a0)
	flw	fa4, -88(a1)
	fsw	fa4, 88(a0)
	fsw	fa5, -88(a1)
	flw	fa5, 92(a0)
	flw	fa4, -92(a1)
	fsw	fa4, 92(a0)
	fsw	fa5, -92(a1)
	flw	fa5, 96(a0)
	flw	fa4, -96(a1)
	fsw	fa4, 96(a0)
	fsw	fa5, -96(a1)
	flw	fa5, 100(a0)
	flw	fa4, -100(a1)
	fsw	fa4, 100(a0)
	fsw	fa5, -100(a1)
	flw	fa5, 104(a0)
	flw	fa4, -104(a1)
	fsw	fa4, 104(a0)
	fsw	fa5, -104(a1)
	flw	fa5, 108(a0)
	flw	fa4, -108(a1)
	fsw	fa4, 108(a0)
	fsw	fa5, -108(a1)
	flw	fa5, 112(a0)
	flw	fa4, -112(a1)
	fsw	fa4, 112(a0)
	fsw	fa5, -112(a1)
	flw	fa5, 116(a0)
	flw	fa4, -116(a1)
	fsw	fa4, 116(a0)
	fsw	fa5, -116(a1)
	flw	fa5, 120(a0)
	flw	fa4, -120(a1)
	fsw	fa4, 120(a0)
	fsw	fa5, -120(a1)
	addi	a2, a1, -124
	addi	a3, a0, 124
	flw	fa5, 124(a0)
	flw	fa4, -124(a1)
	fsw	fa4, 124(a0)
	fsw	fa5, -124(a1)
	addi	a1, a1, -128
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, tu, ma
	vmv.v.x	v9, a3
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a2
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, mf2, ta, ma
	vid.v	v10
                                        # implicit-def: $v9
	vsll.vi	v9, v10, 3
                                        # implicit-def: $v10
	vrsub.vi	v10, v9, 4
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	addi	a0, a0, 128
                                        # implicit-def: $v8
	vslidedown.vi	v8, v9, 1
	vslideup.vi	v8, v9, 1
	addi	a2, sp, 16
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	bltu	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %invoke.cont21.exitStub
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
