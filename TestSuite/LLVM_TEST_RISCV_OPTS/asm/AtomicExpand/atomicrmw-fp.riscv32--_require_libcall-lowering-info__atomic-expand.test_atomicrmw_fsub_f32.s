# Source: AtomicExpand/atomicrmw-fp.riscv32--_require_libcall-lowering-info__atomic-expand.ll
# Function: test_atomicrmw_fsub_f32
# src = pre-opt (test_atomicrmw_fsub_f32), tgt = post-opt (test_atomicrmw_fsub_f32)
# Triple: riscv32--, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	li	a1, 0
	call	__atomic_load_4
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %atomicrmw.start
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	call	__subsf3
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a1, 24(sp)
	addi	a1, sp, 24
	li	a4, 5
	mv	a3, a4
	call	__atomic_compare_exchange_4
	lw	a1, 24(sp)
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %atomicrmw.end
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
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
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	li	a1, 0
	call	__atomic_load_4
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %atomicrmw.start
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	call	__subsf3
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a1, 24(sp)
	addi	a1, sp, 24
	li	a4, 5
	mv	a3, a4
	call	__atomic_compare_exchange_4
	lw	a1, 24(sp)
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %atomicrmw.end
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
