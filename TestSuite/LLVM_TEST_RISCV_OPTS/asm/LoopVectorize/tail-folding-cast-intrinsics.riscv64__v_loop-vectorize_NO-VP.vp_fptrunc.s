# Source: LoopVectorize/tail-folding-cast-intrinsics.riscv64__v_loop-vectorize_NO-VP.ll
# Function: vp_fptrunc
# src = pre-opt (vp_fptrunc), tgt = post-opt (vp_fptrunc)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a0, 3
	add	a3, a3, a4
	fld	fa5, 0(a3)
	fcvt.s.d	fa5, fa5
	slli	a3, a0, 2
	add	a2, a2, a3
	fsw	fa5, 0(a2)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 2
	li	a0, 16
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %entry
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB4_2:                                # %entry
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_8
	j	.LBB4_3
.LBB4_3:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 2
	add	a3, a0, a3
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 3
	add	a1, a1, a2
	li	a2, 0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bgeu	a0, a1, .LBB4_5
	j	.LBB4_4
.LBB4_4:                                # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_8
	j	.LBB4_5
.LBB4_5:                                # %vector.ph
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a2, a0, 2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sub	a2, a0, a2
	and	a1, a1, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_6
.LBB4_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 3
	add	a4, a4, a5
                                        # implicit-def: $v10m2
	vsetvli	a5, zero, e32, m1, ta, ma
	vle64.v	v10, (a4)
                                        # implicit-def: $v8
	vfncvt.f.f.w	v8, v10
	slli	a4, a0, 2
	add	a3, a3, a4
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_6
	j	.LBB4_7
.LBB4_7:                                # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_10
	j	.LBB4_8
.LBB4_8:                                # %scalar.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_9
.LBB4_9:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 3
	add	a3, a3, a4
	fld	fa5, 0(a3)
	fcvt.s.d	fa5, fa5
	slli	a3, a0, 2
	add	a2, a2, a3
	fsw	fa5, 0(a2)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB4_9
	j	.LBB4_10
.LBB4_10:                               # %exit
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
