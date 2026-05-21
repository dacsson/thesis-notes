# Source: LoopVectorize/bf16.riscv64__v__zvfbfmin_loop-vectorize_ZVFBFMIN.ll
# Function: fadd
# src = pre-opt (fadd), tgt = post-opt (fadd)
# Triple: riscv64, Attrs: +v,+zvfbfmin
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a2, 1
	add	a0, a0, a2
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	add	a1, a1, a2
	lhu	a0, 0(a0)
	lhu	a1, 0(a1)
	slliw	a1, a1, 16
	fmv.w.x	fa4, a1
	slliw	a0, a0, 16
	fmv.w.x	fa5, a0
	fadd.s	fa0, fa5, fa4
	call	__truncsfbf2
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	fmv.x.w	a2, fa0
	sh	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
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
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a5, a1, 1
	add	a3, a3, a5
	add	a4, a4, a5
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v12, (a3)
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v8, (a4)
                                        # implicit-def: $v16m4
	vsetvli	a4, zero, e16, m2, ta, ma
	vfwcvtbf16.f.f.v	v16, v8
                                        # implicit-def: $v8m4
	vfwcvtbf16.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e32, m4, ta, ma
	vfadd.vv	v12, v8, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, ta, ma
	vfncvtbf16.f.f.w	v8, v12
	vsetvli	zero, a2, e16, m2, ta, ma
	vse16.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
