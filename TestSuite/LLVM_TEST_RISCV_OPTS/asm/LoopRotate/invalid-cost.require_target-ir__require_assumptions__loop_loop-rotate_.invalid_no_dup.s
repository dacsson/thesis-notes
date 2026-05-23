# Source: LoopRotate/invalid-cost.require_target-ir__require_assumptions__loop_loop-rotate_.ll
# Function: invalid_no_dup
# src = pre-opt (invalid_no_dup), tgt = post-opt (invalid_no_dup)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	sext.w	a1, a0
	li	a0, 99
	blt	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetvli	a2, zero, e8, mf8, ta, ma
	vle8.v	v9, (a1)
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v9
	vse8.v	v8, (a1)
	addiw	a0, a0, 1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_3:                                # %for.end
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetvli	a2, zero, e8, mf8, ta, ma
	vle8.v	v9, (a1)
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v9
	vse8.v	v8, (a1)
	addiw	a0, a0, 1
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %for.end
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
                                        # -- End function
