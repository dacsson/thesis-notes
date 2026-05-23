# Source: LoopVectorize/early_exit_with_stores.riscv64__v.ll
# Function: uncountable_exit_with_constant_nonunit_stride
# src = pre-opt (uncountable_exit_with_constant_nonunit_stride), tgt = post-opt (uncountable_exit_with_constant_nonunit_stride)
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
	j	.LBB20_1
.LBB20_1:                               # %for.body
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
	lh	a1, 0(a0)
	li	a0, 500
	blt	a0, a1, .LBB20_3
	j	.LBB20_2
.LBB20_2:                               # %for.inc
                                        #   in Loop: Header=BB20_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a1, a0, 20
	li	a0, 2000
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB20_1
	j	.LBB20_3
.LBB20_3:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end20:
	.size	src, .Lfunc_end20-src
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
	j	.LBB20_1
.LBB20_1:                               # %for.body
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
	lh	a1, 0(a0)
	li	a0, 500
	blt	a0, a1, .LBB20_3
	j	.LBB20_2
.LBB20_2:                               # %for.inc
                                        #   in Loop: Header=BB20_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	a1, a0, 20
	li	a0, 2000
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB20_1
	j	.LBB20_3
.LBB20_3:                               # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end20:
	.size	tgt, .Lfunc_end20-tgt
	.cfi_endproc
                                        # -- End function
