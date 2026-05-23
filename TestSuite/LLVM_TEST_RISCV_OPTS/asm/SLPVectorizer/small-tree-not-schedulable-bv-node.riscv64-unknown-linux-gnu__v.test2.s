# Source: SLPVectorizer/small-tree-not-schedulable-bv-node.riscv64-unknown-linux-gnu__v.ll
# Function: test2
# src = pre-opt (test2), tgt = post-opt (test2)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	j	.LBB1_1
.LBB1_1:                                # %do_action
                                        # =>This Inner Loop Header: Depth=1
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
# %bb.2:                                # %do_action
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a1, a0, 2
	lui	a0, %hi(.LJTI1_0)
	addi	a0, a0, %lo(.LJTI1_0)
	add	a0, a0, a1
	lw	a0, 0(a0)
	jr	a0
.LBB1_3:                                # %yy_find_action.backedge
                                        #   in Loop: Header=BB1_1 Depth=1
	j	.LBB1_1
.LBB1_4:                                # %sw.bb175
                                        #   in Loop: Header=BB1_1 Depth=1
	j	.LBB1_3
.LBB1_5:                                # %sw.default
.LBB1_6:                                # %cleanup185
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI1_0:

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	j	.LBB1_1
.LBB1_1:                                # %do_action
                                        # =>This Inner Loop Header: Depth=1
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
# %bb.2:                                # %do_action
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	slli	a1, a0, 2
	lui	a0, %hi(.LJTI1_0)
	addi	a0, a0, %lo(.LJTI1_0)
	add	a0, a0, a1
	lw	a0, 0(a0)
	jr	a0
.LBB1_3:                                # %yy_find_action.backedge
                                        #   in Loop: Header=BB1_1 Depth=1
	j	.LBB1_1
.LBB1_4:                                # %sw.bb175
                                        #   in Loop: Header=BB1_1 Depth=1
	j	.LBB1_3
.LBB1_5:                                # %sw.default
.LBB1_6:                                # %cleanup185
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI1_0:
