# Source: LoopVectorize/truncate-to-minimal-bitwidth-cost._v.ll
# Function: test_pr98413_zext_removed
# src = pre-opt (test_pr98413_zext_removed), tgt = post-opt (test_pr98413_zext_removed)
# Triple: riscv64, Attrs: v
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
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	slli	a4, a0, 1
	add	a3, a3, a4
	lh	a3, 0(a3)
	and	a1, a1, a3
	add	a2, a2, a0
	sb	a1, 0(a2)
	addi	a2, a0, 1
	li	a1, 96
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
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	a1, zero, e8, m1, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 64
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	li	a0, 97
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 64
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a5, a1, 1
	add	a4, a4, a5
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v12, (a4)
                                        # implicit-def: $v10
	vsetvli	a4, zero, e8, m1, ta, ma
	vnsrl.wi	v10, v12, 0
                                        # implicit-def: $v8
	vand.vv	v8, v9, v10
	add	a3, a3, a1
	vsetvli	zero, a2, e8, m1, ta, ma
	vse8.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
