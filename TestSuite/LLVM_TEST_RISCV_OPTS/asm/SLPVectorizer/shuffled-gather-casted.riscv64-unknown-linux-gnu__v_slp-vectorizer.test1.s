# Source: SLPVectorizer/shuffled-gather-casted.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
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
	lhu	a0, 0(a0)
	lui	a1, 16
	addi	a1, a1, -1
	li	a2, 4
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB1_2
# %bb.1:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB1_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	addi	sp, sp, 16
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
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	lhu	a0, 0(a0)
	lui	a1, 16
	addi	a1, a1, -1
	li	a2, 4
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	beq	a0, a1, .LBB1_2
# %bb.1:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB1_2:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
