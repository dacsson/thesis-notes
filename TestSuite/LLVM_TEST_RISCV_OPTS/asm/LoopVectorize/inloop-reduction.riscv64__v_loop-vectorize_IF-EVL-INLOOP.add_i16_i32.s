# Source: LoopVectorize/inloop-reduction.riscv64__v_loop-vectorize_IF-EVL-INLOOP.ll
# Function: add_i16_i32
# src = pre-opt (add_i16_i32), tgt = post-opt (add_i16_i32)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	mv	a3, a2
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	sext.w	a4, a0
	slli	a4, a4, 1
	add	a3, a3, a4
	lh	a3, 0(a3)
	addw	a2, a2, a3
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.cond.cleanup
	ld	a0, 40(sp)                      # 8-byte Folded Reload
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sext.w	a1, a0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_6
	j	.LBB0_1
.LBB0_1:                                # %for.body.preheader
	j	.LBB0_2
.LBB0_2:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	li	a1, 0
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 32
	srli	a3, a3, 32
	vsetvli	a3, a3, e8, m1, ta, ma
	sext.w	a5, a2
	slli	a5, a5, 1
	add	a1, a1, a5
                                        # implicit-def: $v10m2
	vsetvli	zero, a3, e16, m2, tu, ma
	vle16.v	v10, (a1)
	li	a1, 0
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m4, tu, ma
	vmv.s.x	v8, a1
	vsetvli	zero, a3, e16, m2, ta, ma
	vwredsum.vs	v8, v10, v8
	vsetvli	zero, a3, e32, m4, ta, ma
	vmv.x.s	a1, v8
	addw	a1, a1, a4
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	addw	a2, a3, a2
	subw	a0, a0, a3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	j	.LBB0_5
.LBB0_5:                                # %for.cond.cleanup.loopexit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %for.cond.cleanup
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
