# Source: LoopVectorize/tail-folding-call-intrinsics.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: vp_lrint
# src = pre-opt (vp_lrint), tgt = post-opt (vp_lrint)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
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
	j	.LBB6_1
.LBB6_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	flw	fa5, 0(a2)
	fcvt.d.s	fa5, fa5
	fcvt.l.d	a2, fa5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB6_1
	j	.LBB6_2
.LBB6_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB6_1
.LBB6_1:                                # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	a0, a0, a2
	bltu	a0, a1, .LBB6_5
	j	.LBB6_2
.LBB6_2:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB6_3
.LBB6_3:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a5, a5, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v12, (a5)
                                        # implicit-def: $v8m4
	vsetvli	a5, zero, e32, m2, ta, ma
	vfwcvt.f.f.v	v8, v12
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vfcvt.x.f.v	v12, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vnsrl.wi	v8, v12, 0
	add	a3, a3, a4
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB6_3
	j	.LBB6_4
.LBB6_4:                                # %middle.block
	j	.LBB6_7
.LBB6_5:                                # %scalar.ph
	li	a0, 0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	j	.LBB6_6
.LBB6_6:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	flw	fa5, 0(a2)
	fcvt.d.s	fa5, fa5
	fcvt.l.d	a2, fa5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB6_6
	j	.LBB6_7
.LBB6_7:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
