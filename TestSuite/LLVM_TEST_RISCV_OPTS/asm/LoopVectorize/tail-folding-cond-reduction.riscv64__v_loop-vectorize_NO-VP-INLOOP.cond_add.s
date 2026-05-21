# Source: LoopVectorize/tail-folding-cond-reduction.riscv64__v_loop-vectorize_NO-VP-INLOOP.ll
# Function: cond_add
# src = pre-opt (cond_add), tgt = post-opt (cond_add)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a4, 0(a2)
	slti	a2, a4, 4
	addiw	a2, a2, -1
	and	a2, a2, a4
	addw	a2, a2, a3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.end
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a3, a0, 3
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	srli	a0, a0, 1
	li	a3, 0
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bltu	a1, a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sub	a1, a1, a2
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 2
	add	a4, a4, a5
                                        # implicit-def: $v12m2
	vsetvli	a5, zero, e32, m2, ta, ma
	vle32.v	v12, (a4)
	vmsgt.vi	v0, v12, 3
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v10m2
	vmerge.vvm	v10, v8, v12, v0
                                        # implicit-def: $v9
	vmv.s.x	v9, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m2, ta, ma
	vredsum.vs	v8, v10, v9
	vmv.x.s	a2, v8
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	add	a0, a0, a3
	mv	a3, a0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	mv	a3, a1
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB0_6
	j	.LBB0_4
.LBB0_4:                                # %scalar.ph
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_5
.LBB0_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a4, 0(a2)
	slti	a2, a4, 4
	addiw	a2, a2, -1
	and	a2, a2, a4
	addw	a2, a2, a3
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	mv	a3, a2
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_5
	j	.LBB0_6
.LBB0_6:                                # %for.end
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
