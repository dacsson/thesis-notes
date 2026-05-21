# Source: LoopVectorize/veclib-function-calls._v_inject-tli-mappings_loop-vectorize.ll
# Function: ilogb_f64
# src = pre-opt (ilogb_f64), tgt = post-opt (ilogb_f64)
# Triple: riscv64, Attrs: v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB48_1
.LBB48_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 3
	add	a0, a0, a1
	fld	fa0, 0(a0)
	call	ilogb
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB48_1
	j	.LBB48_2
.LBB48_2:                               # %for.end
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end48:
	.size	src, .Lfunc_end48-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	srli	a1, a0, 2
	li	a2, 0
	li	a0, 1000
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB48_4
	j	.LBB48_1
.LBB48_1:                               # %vector.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	li	a0, 1000
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB48_2
.LBB48_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 3
	add	a0, a0, a1
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, ta, ma
	vle64.v	v8, (a0)
	call	Sleef_ilogbdx_rvvm2
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a3, a3, a4
	vsetvli	a4, zero, e32, m1, ta, ma
	vse32.v	v8, (a3)
	add	a0, a0, a2
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB48_2
	j	.LBB48_3
.LBB48_3:                               # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	li	a1, 1000
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB48_6
	j	.LBB48_4
.LBB48_4:                               # %scalar.ph
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB48_5
.LBB48_5:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	slli	a1, a1, 3
	add	a0, a0, a1
	fld	fa0, 0(a0)
	call	ilogb
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1000
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB48_5
	j	.LBB48_6
.LBB48_6:                               # %for.end
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end48:
	.size	tgt, .Lfunc_end48-tgt
	.cfi_endproc
                                        # -- End function
