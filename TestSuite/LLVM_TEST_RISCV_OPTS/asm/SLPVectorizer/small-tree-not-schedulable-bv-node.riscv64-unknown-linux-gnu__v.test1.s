# Source: SLPVectorizer/small-tree-not-schedulable-bv-node.riscv64-unknown-linux-gnu__v.ll
# Function: test1
# src = pre-opt (test1), tgt = post-opt (test1)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
.Lfunc_begin0:
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
.Ltmp0:                                 # EH_LABEL
	li	a2, 0
	mv	a0, a2
	mv	a1, a2
	jalr	a2
.Ltmp1:                                 # EH_LABEL
	j	.LBB0_1
.LBB0_1:                                # %invoke.cont32
.Ltmp3:                                 # EH_LABEL
	li	a2, 0
	mv	a0, a2
	mv	a1, a2
	jalr	a2
.Ltmp4:                                 # EH_LABEL
	j	.LBB0_2
.LBB0_2:                                # %invoke.cont37
.LBB0_3:                                # %lpad31.loopexit
.Ltmp2:                                 # EH_LABEL
	j	.LBB0_6
.LBB0_4:                                # %lpad34.loopexit
.Ltmp5:                                 # EH_LABEL
	j	.LBB0_5
.LBB0_5:                                # %lpad34.body
	j	.LBB0_6
.LBB0_6:                                # %ehcleanup47
	li	a0, 0
	call	_Unwind_Resume
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
.Lfunc_begin0:
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
.Ltmp0:                                 # EH_LABEL
	li	a2, 0
	mv	a0, a2
	mv	a1, a2
	jalr	a2
.Ltmp1:                                 # EH_LABEL
	j	.LBB0_1
.LBB0_1:                                # %invoke.cont32
.Ltmp3:                                 # EH_LABEL
	li	a2, 0
	mv	a0, a2
	mv	a1, a2
	jalr	a2
.Ltmp4:                                 # EH_LABEL
	j	.LBB0_2
.LBB0_2:                                # %invoke.cont37
.LBB0_3:                                # %lpad31.loopexit
.Ltmp2:                                 # EH_LABEL
	j	.LBB0_6
.LBB0_4:                                # %lpad34.loopexit
.Ltmp5:                                 # EH_LABEL
	j	.LBB0_5
.LBB0_5:                                # %lpad34.body
	j	.LBB0_6
.LBB0_6:                                # %ehcleanup47
	li	a0, 0
	call	_Unwind_Resume
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
