# Source: LoopRotate/invalid-cost.require_target-ir__require_assumptions__loop_loop-rotate_.ll
# Function: invalid_dup_required
# src = pre-opt (invalid_dup_required), tgt = post-opt (invalid_dup_required)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetvli	a2, zero, e8, mf8, ta, ma
	vle8.v	v9, (a1)
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v9
	vse8.v	v8, (a1)
	sext.w	a1, a0
	li	a0, 99
	blt	a0, a1, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	call	f
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_3:                                # %for.end
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetvli	a2, zero, e8, mf8, ta, ma
	vle8.v	v9, (a1)
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v9
	vse8.v	v8, (a1)
	sext.w	a1, a0
	li	a0, 99
	blt	a0, a1, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	call	f
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addiw	a0, a0, 1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_3:                                # %for.end
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
                                        # -- End function
