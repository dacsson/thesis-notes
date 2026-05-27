# Source: LoopVectorize/truncate-to-minimal-bitwidth-evl-crash.riscv64__v_loop-vectorize.ll
# Function: truncate_to_minimal_bitwidths_widen_cast_recipe
# src = pre-opt (truncate_to_minimal_bitwidths_widen_cast_recipe), tgt = post-opt (truncate_to_minimal_bitwidths_widen_cast_recipe)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	li	a1, 0
	sb	a1, 0(zero)
	addi	a2, a0, 1
	li	a1, 8
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	li	a0, 9
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	vsetvli	a1, a0, e8, m1, ta, ma
                                        # implicit-def: $v16m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.i	v16, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, m1, tu, ma
	vmv.v.i	v8, 0
	li	a2, 0
	vsetvli	zero, a1, e8, m1, ta, ma
	vsoxei64.v	v8, (a2), v16
	sub	a0, a0, a1
	mv	a1, a0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
