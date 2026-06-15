# Source: LoopVectorize/tail-folding-call-intrinsics.riscv64__v_loop-vectorize_NO-VP.ll
# Function: vp_umin
# src = pre-opt (vp_umin), tgt = post-opt (vp_umin)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lw	a0, 0(a0)
	add	a1, a1, a2
	lw	a1, 0(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_3
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB3_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB3_3:                                # %loop
                                        #   in Loop: Header=BB3_1 Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_4
.LBB3_4:                                # %exit
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 16
	sd	a0, 160(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 168(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_2
# %bb.1:                                # %entry
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	sd	a0, 168(sp)                     # 8-byte Folded Spill
.LBB3_2:                                # %entry
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_8
	j	.LBB3_3
.LBB3_3:                                # %vector.memcheck
	ld	a2, 152(sp)                     # 8-byte Folded Reload
	ld	a3, 136(sp)                     # 8-byte Folded Reload
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sub	a0, a2, a0
	sub	a2, a2, a3
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_8
	j	.LBB3_4
.LBB3_4:                                # %vector.memcheck
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_8
	j	.LBB3_5
.LBB3_5:                                # %vector.ph
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a2, a0, 1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sub	a2, a0, a2
	and	a1, a1, a2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB3_6
.LBB3_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	ld	a5, 112(sp)                     # 8-byte Folded Reload
	ld	a6, 120(sp)                     # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a6, a6, a4
                                        # implicit-def: $v10m2
	vsetvli	a7, zero, e32, m2, ta, ma
	vle32.v	v10, (a6)
	add	a5, a5, a4
                                        # implicit-def: $v12m2
	vle32.v	v12, (a5)
                                        # implicit-def: $v8m2
	vminu.vv	v8, v10, v12
	add	a3, a3, a4
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_6
	j	.LBB3_7
.LBB3_7:                                # %middle.block
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB3_12
	j	.LBB3_8
.LBB3_8:                                # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB3_9
.LBB3_9:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lw	a0, 0(a0)
	add	a1, a1, a2
	lw	a1, 0(a1)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB3_11
# %bb.10:                               # %loop
                                        #   in Loop: Header=BB3_9 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB3_11:                               # %loop
                                        #   in Loop: Header=BB3_9 Depth=1
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 128(sp)                     # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_9
	j	.LBB3_12
.LBB3_12:                               # %exit
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
