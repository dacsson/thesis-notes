# Source: SLPVectorizer/select-profitability.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: pow2_zero_variable_shift
# src = pre-opt (pow2_zero_variable_shift), tgt = post-opt (pow2_zero_variable_shift)
# Triple: riscv64-unknown-linux, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	mv	a3, a2
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	mv	a3, a1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, -1
	seqz	a0, a0
	addi	a3, a3, -1
	seqz	a3, a3
	addi	a1, a1, -1
	seqz	a1, a1
	addi	a2, a2, -1
	seqz	a2, a2
	slli	a0, a0, 19
	slli	a3, a3, 18
	slli	a1, a1, 17
	slli	a2, a2, 16
	or	a0, a0, a3
	or	a1, a1, a2
	or	a0, a0, a1
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
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	mv	a3, a2
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	mv	a3, a1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, -1
	seqz	a0, a0
	addi	a3, a3, -1
	seqz	a3, a3
	addi	a1, a1, -1
	seqz	a1, a1
	addi	a2, a2, -1
	seqz	a2, a2
	slli	a0, a0, 19
	slli	a3, a3, 18
	slli	a1, a1, 17
	slli	a2, a2, 16
	or	a0, a0, a3
	or	a1, a1, a2
	or	a0, a0, a1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
