# Source: LoopVectorize/partial-reduce-dot-product._v__experimental-zvdot4a8i_loop-vectorize.ll
# Function: vdot4au
# src = pre-opt (vdot4au), tgt = post-opt (vdot4au)
# Triple: riscv64, Attrs: v
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
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a1, a1, a2
	lbu	a1, 0(a1)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	call	__muldi3
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addw	a2, a1, a2
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 1
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 2 * vlenb
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_2
# %bb.1:                                # %entry
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB1_2:                                # %entry
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	li	a3, 0
	mv	a2, a3
	li	a0, 1024
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_6
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 72(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	a1, zero, e32, mf2, tu, ma
	vmv.v.i	v8, 0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 144
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 112(sp)                     # 8-byte Folded Reload
	csrr	a5, vlenb
	add	a5, sp, a5
	addi	a5, a5, 144
	vl1r.v	v8, (a5)                        # vscale x 8-byte Folded Reload
	add	a4, a4, a0
                                        # implicit-def: $v10
	vsetvli	a5, zero, e8, mf2, ta, ma
	vle8.v	v10, (a4)
	add	a3, a3, a0
                                        # implicit-def: $v9
	vle8.v	v9, (a3)
	vsetvli	a3, zero, e32, mf2, ta, ma
	vdot4au.vv	v8, v9, v10
	addi	a3, sp, 144
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 144
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	bne	a0, a1, .LBB1_4
	j	.LBB1_5
.LBB1_5:                                # %middle.block
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 144
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	li	a1, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.s.x	v10, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a2, v8
	li	a1, 1024
	mv	a3, a0
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB1_8
	j	.LBB1_6
.LBB1_6:                                # %scalar.ph
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_7
.LBB1_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	add	a1, a1, a2
	lbu	a1, 0(a1)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	call	__muldi3
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	addw	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a3, a0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_7
	j	.LBB1_8
.LBB1_8:                                # %for.exit
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
