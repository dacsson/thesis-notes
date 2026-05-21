# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: loop_contains_store_uncounted_exit_is_a_switch
# src = pre-opt (loop_contains_store_uncounted_exit_is_a_switch), tgt = post-opt (loop_contains_store_uncounted_exit_is_a_switch)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB13_1
.LBB13_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a3, a2, a1
	lh	a2, 0(a3)
	addiw	a2, a2, 1
	sh	a2, 0(a3)
	add	a0, a0, a1
	lhu	a0, 0(a0)
	li	a1, 500
	beq	a0, a1, .LBB13_3
	j	.LBB13_2
.LBB13_2:                               # %for.inc
                                        #   in Loop: Header=BB13_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB13_1
	j	.LBB13_3
.LBB13_3:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end13:
	.size	src, .Lfunc_end13-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB13_1
.LBB13_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a3, a2, a1
	lh	a2, 0(a3)
	addiw	a2, a2, 1
	sh	a2, 0(a3)
	add	a0, a0, a1
	lhu	a0, 0(a0)
	li	a1, 500
	beq	a0, a1, .LBB13_3
	j	.LBB13_2
.LBB13_2:                               # %for.inc
                                        #   in Loop: Header=BB13_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 20
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB13_1
	j	.LBB13_3
.LBB13_3:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end13:
	.size	tgt, .Lfunc_end13-tgt
	.cfi_endproc
                                        # -- End function
