# Source: LoopVectorize/scalable-vf-hint.riscv64__m__v_loop-vectorize.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: +m,+v
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
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a3, 0(a2)
	add	a1, a1, a4
	lw	a1, 0(a1)
	addw	a1, a1, a3
	sw	a1, 256(a2)
	addi	a0, a0, 1
	li	a1, 1024
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
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	srli	a1, a0, 2
	li	a2, 0
	li	a0, 1024
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
	j	.LBB0_1
.LBB0_1:                                # %vector.memcheck
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	li	a2, 17
	slli	a2, a2, 8
	add	a2, a0, a2
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	lui	a2, 1
	add	a1, a1, a2
	li	a2, 0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bgeu	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %vector.memcheck
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
                                        # implicit-def: $v10
	vsetvli	a5, zero, e32, m1, ta, ma
	vle32.v	v10, (a2)
	add	a3, a3, a4
                                        # implicit-def: $v9
	vle32.v	v9, (a3)
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v10
	addi	a2, a2, 256
	vse32.v	v8, (a2)
	add	a0, a0, a1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	li	a1, 1024
	li	a0, 1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_8
	j	.LBB0_6
.LBB0_6:                                # %scalar.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_7
.LBB0_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 2
	add	a2, a2, a4
	lw	a3, 0(a2)
	add	a1, a1, a4
	lw	a1, 0(a1)
	addw	a1, a1, a3
	sw	a1, 256(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB0_7
	j	.LBB0_8
.LBB0_8:                                # %exit
	addi	sp, sp, 80
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
