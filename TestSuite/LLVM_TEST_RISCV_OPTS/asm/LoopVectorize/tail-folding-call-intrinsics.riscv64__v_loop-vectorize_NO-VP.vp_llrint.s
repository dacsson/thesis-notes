# Source: LoopVectorize/tail-folding-call-intrinsics.riscv64__v_loop-vectorize_NO-VP.ll
# Function: vp_llrint
# src = pre-opt (vp_llrint), tgt = post-opt (vp_llrint)
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
	j	.LBB7_1
.LBB7_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	flw	fa5, 0(a2)
	fcvt.d.s	fa5, fa5
	fcvt.l.d	a2, fa5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_2
.LBB7_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
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
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 16
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB7_2
# %bb.1:                                # %entry
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB7_2:                                # %entry
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB7_7
	j	.LBB7_3
.LBB7_3:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	li	a2, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB7_7
	j	.LBB7_4
.LBB7_4:                                # %vector.ph
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a2, a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sub	a2, a0, a2
	and	a1, a1, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB7_5
.LBB7_5:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v12m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vle32.v	v12, (a5)
                                        # implicit-def: $v8m4
	vfwcvt.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vfcvt.x.f.v	v12, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vnsrl.wi	v8, v12, 0
	add	a3, a3, a4
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_5
	j	.LBB7_6
.LBB7_6:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB7_9
	j	.LBB7_7
.LBB7_7:                                # %scalar.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB7_8
.LBB7_8:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	flw	fa5, 0(a2)
	fcvt.d.s	fa5, fa5
	fcvt.l.d	a2, fa5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB7_8
	j	.LBB7_9
.LBB7_9:                                # %exit
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
