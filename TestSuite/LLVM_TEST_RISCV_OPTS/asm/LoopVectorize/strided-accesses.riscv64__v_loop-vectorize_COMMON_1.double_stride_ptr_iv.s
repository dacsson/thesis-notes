# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: double_stride_ptr_iv
# src = pre-opt (double_stride_ptr_iv), tgt = post-opt (double_stride_ptr_iv)
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
	li	a2, 0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	lw	a4, 0(a3)
	addiw	a4, a4, 1
	sw	a4, 0(a1)
	add	a3, a3, a2
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a4, a0
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
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
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	lw	a4, 0(a3)
	addiw	a4, a4, 1
	sw	a4, 0(a1)
	add	a3, a3, a2
	add	a2, a1, a2
	addi	a0, a0, 1
	li	a1, 1024
	mv	a4, a0
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
