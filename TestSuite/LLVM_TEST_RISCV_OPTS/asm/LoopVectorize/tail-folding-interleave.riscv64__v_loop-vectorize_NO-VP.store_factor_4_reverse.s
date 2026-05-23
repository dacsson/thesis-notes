# Source: LoopVectorize/tail-folding-interleave.riscv64__v_loop-vectorize_NO-VP.ll
# Function: store_factor_4_reverse
# src = pre-opt (store_factor_4_reverse), tgt = post-opt (store_factor_4_reverse)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	sext.w	a2, a0
	slli	a2, a2, 4
	add	a1, a1, a2
	sw	a0, 0(a1)
	sw	a0, 4(a1)
	sw	a0, 8(a1)
	sw	a0, 12(a1)
	addiw	a1, a0, -1
	li	a0, 0
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB6_1
	j	.LBB6_2
.LBB6_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	sext.w	a2, a0
	slli	a2, a2, 4
	add	a1, a1, a2
	sw	a0, 0(a1)
	sw	a0, 4(a1)
	sw	a0, 8(a1)
	sw	a0, 12(a1)
	addiw	a1, a0, -1
	li	a0, 0
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB6_1
	j	.LBB6_2
.LBB6_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
