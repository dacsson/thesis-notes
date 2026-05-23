# Source: LoopVectorize/tail-folding-cast-intrinsics.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: vp_sext
# src = pre-opt (vp_sext), tgt = post-opt (vp_sext)
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
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	slli	a4, a0, 3
	add	a3, a3, a4
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	slli	a3, a2, 3
	add	a3, a0, a3
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a1, a1, a2
	bgeu	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %vector.memcheck
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a5, a1, 2
	add	a4, a4, a5
                                        # implicit-def: $v10
	vsetvli	zero, a2, e32, m1, tu, ma
	vle32.v	v10, (a4)
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vsext.vf2	v8, v10
	slli	a4, a1, 3
	add	a3, a3, a4
	vsetvli	zero, a2, e64, m2, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	j	.LBB0_8
.LBB0_6:                                # %scalar.ph
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	slli	a4, a0, 3
	add	a3, a3, a4
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
