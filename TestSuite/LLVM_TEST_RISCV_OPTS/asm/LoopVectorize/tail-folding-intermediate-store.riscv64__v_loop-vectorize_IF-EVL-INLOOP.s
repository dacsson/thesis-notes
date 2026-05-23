# Source: LoopVectorize/tail-folding-intermediate-store.riscv64__v_loop-vectorize_IF-EVL-INLOOP.ll
# Function: reduction_intermediate_store
# src = pre-opt (reduction_intermediate_store), tgt = post-opt (reduction_intermediate_store)
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
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 2
	add	a2, a2, a5
	lw	a2, 0(a2)
	addw	a2, a2, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.end
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.memcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	addi	a3, a0, 4
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a1, a1, a2
	bgeu	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %vector.memcheck
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	vsetvli	a3, a0, e8, mf2, ta, ma
	slli	a5, a2, 2
	add	a1, a1, a5
                                        # implicit-def: $v10m2
	vsetvli	zero, a3, e32, m2, tu, ma
	vle32.v	v10, (a1)
	li	a1, 0
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m2, tu, ma
	vmv.s.x	v8, a1
	vsetvli	zero, a3, e32, m2, ta, ma
	vredsum.vs	v8, v10, v8
	vsetvli	zero, a3, e32, m2, ta, ma
	vmv.x.s	a1, v8
	addw	a1, a1, a4
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	add	a2, a3, a2
	sub	a0, a0, a3
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	sw	a0, 0(a1)
	j	.LBB0_8
.LBB0_6:                                # %scalar.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 2
	add	a2, a2, a5
	lw	a2, 0(a2)
	addw	a2, a2, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %for.end
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
