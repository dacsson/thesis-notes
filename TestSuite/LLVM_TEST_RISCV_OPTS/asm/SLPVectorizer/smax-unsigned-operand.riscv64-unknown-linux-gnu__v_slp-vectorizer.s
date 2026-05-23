# Source: SLPVectorizer/smax-unsigned-operand.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: main
# src = pre-opt (main), tgt = post-opt (main)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %bb
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	mv	a1, a0
	lui	a2, %hi(e)
	addi	a2, a2, %lo(e)
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sb	a0, 4(a2)
	lwu	a1, 0(a1)
	li	a2, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_2
# %bb.1:                                # %bb
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %bb
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sb	a0, 5(a1)
	addi	sp, sp, 32
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
# %bb.0:                                # %bb
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	mv	a1, a0
	lui	a2, %hi(e)
	addi	a2, a2, %lo(e)
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sb	a0, 4(a2)
	lwu	a1, 0(a1)
	li	a2, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_2
# %bb.1:                                # %bb
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %bb
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sb	a0, 5(a1)
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
