# Source: LoopVectorize/partial-reduce-dot-product._v__experimental-zvdot4a8i_loop-vectorize_FIXED.ll
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 4 * vlenb
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
                                        # implicit-def: $v8
	vsetivli	zero, 2, e32, mf2, tu, ma
	vmv.v.i	v8, 0
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	vmv1r.v	v9, v8
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 48
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a4, a3, 1
	add	a3, a4, a3
	add	a3, sp, a3
	addi	a3, a3, 48
	vl1r.v	v8, (a3)                        # vscale x 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, sp, a3
	addi	a3, a3, 48
	vl1r.v	v9, (a3)                        # vscale x 8-byte Folded Reload
	add	a3, a2, a0
	addi	a2, a3, 8
                                        # implicit-def: $v13
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v13, (a3)
                                        # implicit-def: $v11
	vle8.v	v11, (a2)
	add	a2, a1, a0
	addi	a1, a2, 8
                                        # implicit-def: $v12
	vle8.v	v12, (a2)
                                        # implicit-def: $v10
	vle8.v	v10, (a1)
	vsetivli	zero, 2, e32, mf2, ta, ma
	vdot4au.vv	v9, v12, v13
	addi	a1, sp, 48
	vs1r.v	v9, (a1)                        # vscale x 8-byte Folded Spill
	vdot4au.vv	v8, v10, v11
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	addi	a0, a0, 16
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 48
	vs1r.v	v9, (a2)                        # vscale x 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 48
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	bne	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 48
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	addi	a0, sp, 48
	vl1r.v	v10, (a0)                       # vscale x 8-byte Folded Reload
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %for.exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	sp, sp, a1
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
