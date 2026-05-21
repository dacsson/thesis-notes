# Source: LoopVectorize/partial-reduce-dot-product._v_loop-vectorize.ll
# Function: vdot4a
# src = pre-opt (vdot4a), tgt = post-opt (vdot4a)
# Triple: riscv64, Attrs: v
#

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
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a1, a1, a2
	lb	a1, 0(a1)
	add	a0, a0, a2
	lb	a0, 0(a0)
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
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
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
	addi	sp, sp, -160
	.cfi_def_cfa_offset 160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xa0, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 160 + 4 * vlenb
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a1, 128(sp)                     # 8-byte Folded Reload
	li	a3, 0
	mv	a2, a3
	li	a0, 1024
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	csrr	a0, vlenb
	srli	a1, a0, 1
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	li	a0, 0
	subw	a1, a0, a1
	andi	a1, a1, 1024
	sd	a1, 72(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 144
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	ld	a4, 112(sp)                     # 8-byte Folded Reload
	csrr	a5, vlenb
	slli	a5, a5, 1
	add	a5, sp, a5
	addi	a5, a5, 144
	vl2r.v	v8, (a5)                        # vscale x 16-byte Folded Reload
	add	a4, a4, a0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e16, m1, ta, ma
	vle8.v	v10, (a4)
                                        # implicit-def: $v11
	vsext.vf2	v11, v10
	add	a3, a3, a0
                                        # implicit-def: $v12
	vle8.v	v12, (a3)
                                        # implicit-def: $v10
	vsext.vf2	v10, v12
	vwmacc.vv	v8, v10, v11
	addi	a3, sp, 144
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 144
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 144
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	li	a1, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.s.x	v9, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a2, v8
	li	a1, 1024
	mv	a3, a0
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_8
	j	.LBB0_6
.LBB0_6:                                # %scalar.ph
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	add	a1, a1, a2
	lb	a1, 0(a1)
	add	a0, a0, a2
	lb	a0, 0(a0)
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
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %for.exit
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 160
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 160
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
