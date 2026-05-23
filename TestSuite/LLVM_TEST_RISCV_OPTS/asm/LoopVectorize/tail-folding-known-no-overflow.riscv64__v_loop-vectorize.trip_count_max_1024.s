# Source: LoopVectorize/tail-folding-known-no-overflow.riscv64__v_loop-vectorize.ll
# Function: trip_count_max_1024
# src = pre-opt (trip_count_max_1024), tgt = post-opt (trip_count_max_1024)
# Triple: riscv64, Attrs: +v
#

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
	li	a2, 0
	li	a0, 1024
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 3
	add	a3, a2, a3
	ld	a2, 0(a3)
	addi	a2, a2, 1
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
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
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	bltu	a0, a1, .LBB0_6
	j	.LBB0_1
.LBB0_1:                                # %loop.preheader
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	seqz	a1, a0
	add	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 3
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e64, m2, tu, ma
	vle64.v	v10, (a3)
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vadd.vi	v8, v10, 1
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_4
.LBB0_4:                                # %middle.block
	j	.LBB0_5
.LBB0_5:                                # %exit.loopexit
	j	.LBB0_6
.LBB0_6:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
