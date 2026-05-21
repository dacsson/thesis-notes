# Source: LoopVectorize/tail-folding-reverse-load-store.riscv64__v_loop-vectorize_NO-VP.ll
# Function: reverse_load_store_masked
# src = pre-opt (reverse_load_store_masked), tgt = post-opt (reverse_load_store_masked)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	addi	a2, a2, -1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a1, 0(a0)
	li	a0, 99
	blt	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	add	a1, a1, a2
	sw	a0, 0(a1)
	j	.LBB1_3
.LBB1_3:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addiw	a0, a0, 1
	li	a1, 1024
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_4
.LBB1_4:                                # %loopend
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	csrr	a4, vlenb
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 1 * vlenb
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
# %bb.1:                                # %entry
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 152(sp)                     # 8-byte Folded Spill
.LBB1_2:                                # %entry
	ld	a3, 136(sp)                     # 8-byte Folded Reload
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	li	a2, 0
	li	a0, 1024
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_6
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
	ld	a2, 136(sp)                     # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sub	a2, a2, a1
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	ld	a4, 120(sp)                     # 8-byte Folded Reload
	ld	a6, 128(sp)                     # 8-byte Folded Reload
	ld	a5, 136(sp)                     # 8-byte Folded Reload
	sub	a5, a5, a0
	slli	a5, a5, 2
	sext.w	a7, a0
	slli	a7, a7, 2
	add	a6, a6, a7
                                        # implicit-def: $v8m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vle32.v	v8, (a6)
	li	a6, 100
	vmslt.vx	v0, v8, a6
	addi	a5, a5, -4
	add	a6, a4, a5
	slli	a4, a2, 2
	addi	a4, a4, -4
	sub	a7, a6, a4
	csrr	a6, vlenb
	srli	t0, a6, 1
	addiw	t0, t0, -1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m1, ta, ma
	vid.v	v8
                                        # implicit-def: $v10
	vrsub.vx	v10, v8, t0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v9
	vmerge.vim	v9, v8, 1, v0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vrgatherei16.vv	v8, v9, v10
	vmsne.vi	v0, v8, 0
	addi	t0, sp, 160
	vs1r.v	v0, (t0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, mu
	vle32.v	v8, (a7), v0.t
	addi	a7, sp, 160
	vl1r.v	v0, (a7)                        # vscale x 8-byte Folded Reload
	vmv1r.v	v10, v9
	vmv1r.v	v11, v8
	srli	a6, a6, 2
	addiw	a6, a6, -1
                                        # implicit-def: $v8
	vsetvli	a7, zero, e32, m1, ta, ma
	vid.v	v8
                                        # implicit-def: $v9
	vrsub.vx	v9, v8, a6
                                        # implicit-def: $v8
	vrgather.vv	v8, v11, v9
                                        # implicit-def: $v11
	vrgather.vv	v11, v10, v9
	add	a3, a3, a5
	sub	a3, a3, a4
                                        # implicit-def: $v10
	vrgather.vv	v10, v11, v9
                                        # implicit-def: $v11
	vrgather.vv	v11, v8, v9
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v11
	vmv.v.v	v9, v10
	vsetvli	a4, zero, e32, m2, ta, ma
	vse32.v	v8, (a3), v0.t
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_4
	j	.LBB1_5
.LBB1_5:                                # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	beq	a0, a1, .LBB1_10
	j	.LBB1_6
.LBB1_6:                                # %scalar.ph
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_7
.LBB1_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	addi	a2, a2, -1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a1, 0(a0)
	li	a0, 99
	blt	a0, a1, .LBB1_9
	j	.LBB1_8
.LBB1_8:                                # %if.then
                                        #   in Loop: Header=BB1_7 Depth=1
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	add	a1, a1, a2
	sw	a0, 0(a1)
	j	.LBB1_9
.LBB1_9:                                # %for.inc
                                        #   in Loop: Header=BB1_7 Depth=1
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	li	a1, 1024
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_7
	j	.LBB1_10
.LBB1_10:                               # %loopend
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 160
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
