# Source: SLPVectorizer/funnel-shift-cost.riscv64__v_slp-vectorizer.ll
# Function: foo
# src = pre-opt (foo), tgt = post-opt (foo)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 2
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 4
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 6
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	ld	t0, 80(sp)                      # 8-byte Folded Reload
	ld	t1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a5, 104(sp)                     # 8-byte Folded Reload
	ld	a7, 112(sp)                     # 8-byte Folded Reload
	ld	a3, 120(sp)                     # 8-byte Folded Reload
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	slli	a3, a7, 1
	slli	t1, t1, 48
	srli	t1, t1, 63
	or	a3, a3, t1
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sh	a3, 0(t0)
	slli	a3, a5, 1
	slli	a7, a7, 48
	srli	a7, a7, 63
	or	a3, a3, a7
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sh	a3, 0(a6)
	slli	a3, a2, 1
	slli	a5, a5, 48
	srli	a5, a5, 63
	or	a3, a3, a5
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sh	a3, 0(a4)
	slli	a0, a0, 1
	slli	a2, a2, 48
	srli	a2, a2, 63
	or	a0, a0, a2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sh	a0, 0(a1)
	j	.LBB0_2
.LBB0_2:                                # %use.results
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a6, 48(sp)                      # 8-byte Folded Reload
	addw	a1, a5, a4
	subw	a7, a3, a2
	addw	a1, a1, a7
	sh	a1, 0(a6)
	addi	a1, a0, -1
	slli	a0, a1, 48
	sd	a5, 88(sp)                      # 8-byte Folded Spill
	sd	a4, 96(sp)                      # 8-byte Folded Spill
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	bgez	a0, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %exit
	addi	sp, sp, 128
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 2
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 4
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 6
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %while.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 72(sp)                      # 8-byte Folded Reload
	ld	t0, 80(sp)                      # 8-byte Folded Reload
	ld	t1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 96(sp)                      # 8-byte Folded Reload
	ld	a5, 104(sp)                     # 8-byte Folded Reload
	ld	a7, 112(sp)                     # 8-byte Folded Reload
	ld	a3, 120(sp)                     # 8-byte Folded Reload
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	slli	a3, a7, 1
	slli	t1, t1, 48
	srli	t1, t1, 63
	or	a3, a3, t1
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sh	a3, 0(t0)
	slli	a3, a5, 1
	slli	a7, a7, 48
	srli	a7, a7, 63
	or	a3, a3, a7
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sh	a3, 0(a6)
	slli	a3, a2, 1
	slli	a5, a5, 48
	srli	a5, a5, 63
	or	a3, a3, a5
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sh	a3, 0(a4)
	slli	a0, a0, 1
	slli	a2, a2, 48
	srli	a2, a2, 63
	or	a0, a0, a2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sh	a0, 0(a1)
	j	.LBB0_2
.LBB0_2:                                # %use.results
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a5, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a6, 48(sp)                      # 8-byte Folded Reload
	addw	a1, a5, a4
	subw	a7, a3, a2
	addw	a1, a1, a7
	sh	a1, 0(a6)
	addi	a1, a0, -1
	slli	a0, a1, 48
	sd	a5, 88(sp)                      # 8-byte Folded Spill
	sd	a4, 96(sp)                      # 8-byte Folded Spill
	sd	a3, 104(sp)                     # 8-byte Folded Spill
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	bgez	a0, .LBB0_1
	j	.LBB0_3
.LBB0_3:                                # %exit
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
