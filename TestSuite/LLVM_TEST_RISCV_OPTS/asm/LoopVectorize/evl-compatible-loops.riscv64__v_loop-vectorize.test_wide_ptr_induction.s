# Source: LoopVectorize/evl-compatible-loops.riscv64__v_loop-vectorize.ll
# Function: test_wide_ptr_induction
# src = pre-opt (test_wide_ptr_induction), tgt = post-opt (test_wide_ptr_induction)
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
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	addi	a2, a3, 8
	slli	a5, a0, 3
	add	a4, a4, a5
	sd	a3, 0(a4)
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.cond.cleanup
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	li	a2, 0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vid.v	v8
                                        # implicit-def: $v10m2
	vsll.vi	v10, v8, 3
                                        # implicit-def: $v8m2
	vadd.vx	v8, v10, a1
	vsetvli	a3, a0, e8, mf4, ta, ma
	slli	a5, a2, 3
	add	a4, a4, a5
	vsetvli	zero, a3, e64, m2, ta, ma
	vse64.v	v8, (a4)
	add	a2, a3, a2
	sub	a0, a0, a3
	slli	a3, a3, 3
	add	a1, a1, a3
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %for.cond.cleanup
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
