# Source: LoopVectorize/truncate-to-minimal-bitwidth-cost._v.ll
# Function: truncate_to_i1_used_by_branch
# src = pre-opt (truncate_to_i1_used_by_branch), tgt = post-opt (truncate_to_i1_used_by_branch)
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
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	bnez	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %then
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_3
.LBB2_3:                                # %loop.latch
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a2, a0, 1
	slli	a0, a0, 56
	srai	a0, a0, 56
	li	a1, 8
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB2_1
	j	.LBB2_4
.LBB2_4:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a0, vlenb
	slli	a0, a0, 2
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 4 * vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, tu, ma
	vmv.v.x	v8, a0
	addi	a0, sp, 32
	vs4r.v	v8, (a0)                        # vscale x 32-byte Folded Spill
	li	a0, 9
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	slli	a1, a0, 32
	srli	a1, a1, 32
	vsetvli	a1, a1, e8, mf2, ta, ma
                                        # implicit-def: $v8
	vsetvli	a2, zero, e8, mf2, tu, ma
	vmv.v.i	v8, 0
	li	a2, 0
	vsetvli	zero, a1, e8, mf2, ta, ma
	vsoxei64.v	v8, (a2), v12
	subw	a0, a0, a1
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
