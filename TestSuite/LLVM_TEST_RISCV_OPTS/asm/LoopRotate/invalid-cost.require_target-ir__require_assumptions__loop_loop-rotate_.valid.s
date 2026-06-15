# Source: LoopRotate/invalid-cost.require_target-ir__require_assumptions__loop_loop-rotate_.ll
# Function: valid
# src = pre-opt (valid), tgt = post-opt (valid)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	addi	sp, sp, -16
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a0
	li	a0, 99
	blt	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_3:                                # %for.end
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:                                # %entry
	addi	sp, sp, -16
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	sext.w	a0, a1
	addiw	a2, a1, 1
	li	a1, 100
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.end
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
                                        # -- End function
