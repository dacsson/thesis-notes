# Source: LoopVectorize/tail-folding-call-intrinsics.riscv64__v_loop-vectorize_NO-VP.ll
# Function: vp_ctlz
# src = pre-opt (vp_ctlz), tgt = post-opt (vp_ctlz)
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
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	srliw	a5, a2, 1
	or	a2, a2, a5
	srliw	a5, a2, 2
	or	a2, a2, a5
	srliw	a5, a2, 4
	or	a2, a2, a5
	srliw	a5, a2, 8
	or	a2, a2, a5
	srliw	a5, a2, 16
	or	a2, a2, a5
	not	a2, a2
	srli	a5, a2, 1
	lui	a6, 349525
	addi	a6, a6, 1365
	and	a5, a5, a6
	sub	a5, a2, a5
	lui	a2, 209715
	addi	a6, a2, 819
	and	a2, a5, a6
	srli	a5, a5, 2
	and	a5, a5, a6
	add	a2, a2, a5
	srli	a5, a2, 4
	addw	a5, a2, a5
	lui	a6, 61681
	addi	a2, a6, -241
	and	a2, a5, a2
	slliw	a5, a5, 8
	addi	a6, a6, -256
	and	a5, a5, a6
	addw	a2, a2, a5
	slliw	a5, a2, 16
	addw	a2, a2, a5
	srliw	a2, a2, 24
	add	a3, a3, a4
	sw	a2, 0(a3)
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
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 1
	li	a0, 8
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_2
# %bb.1:                                # %entry
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB4_2:                                # %entry
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_7
	j	.LBB4_3
.LBB4_3:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	li	a2, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB4_7
	j	.LBB4_4
.LBB4_4:                                # %vector.ph
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a2, a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sub	a2, a0, a2
	and	a1, a1, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_5
.LBB4_5:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vle32.v	v8, (a5)
                                        # implicit-def: $v12m4
	vfwcvt.f.xu.v	v12, v8
	li	a5, 52
                                        # implicit-def: $v10m2
	vnsrl.wx	v10, v12, a5
	li	a5, 1054
                                        # implicit-def: $v8m2
	vrsub.vx	v8, v10, a5
	add	a3, a3, a4
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_5
	j	.LBB4_6
.LBB4_6:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mv	a2, a1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB4_9
	j	.LBB4_7
.LBB4_7:                                # %scalar.ph
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB4_8
.LBB4_8:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	srliw	a5, a2, 1
	or	a2, a2, a5
	srliw	a5, a2, 2
	or	a2, a2, a5
	srliw	a5, a2, 4
	or	a2, a2, a5
	srliw	a5, a2, 8
	or	a2, a2, a5
	srliw	a5, a2, 16
	or	a2, a2, a5
	not	a2, a2
	srli	a5, a2, 1
	lui	a6, 349525
	addi	a6, a6, 1365
	and	a5, a5, a6
	sub	a5, a2, a5
	lui	a2, 209715
	addi	a6, a2, 819
	and	a2, a5, a6
	srli	a5, a5, 2
	and	a5, a5, a6
	add	a2, a2, a5
	srli	a5, a2, 4
	addw	a5, a2, a5
	lui	a6, 61681
	addi	a2, a6, -241
	and	a2, a5, a2
	slliw	a5, a5, 8
	addi	a6, a6, -256
	and	a5, a5, a6
	addw	a2, a2, a5
	slliw	a5, a2, 16
	addw	a2, a2, a5
	srliw	a2, a2, 24
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB4_8
	j	.LBB4_9
.LBB4_9:                                # %exit
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
