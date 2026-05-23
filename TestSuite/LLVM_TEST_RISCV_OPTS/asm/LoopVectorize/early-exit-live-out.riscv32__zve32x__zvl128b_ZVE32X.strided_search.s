# Source: LoopVectorize/early-exit-live-out.riscv32__zve32x__zvl128b_ZVE32X.ll
# Function: strided_search
# src = pre-opt (strided_search), tgt = post-opt (strided_search)
# Triple: riscv32, Attrs: +zve32x,+zvl128b
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
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	add	a0, a0, a2
	addi	a0, a0, 88
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v8, (a0)
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, m1, tu, ma
	vmv.v.i	v9, 0
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmsne.vv	v8, v8, v9
	vmset.m	v0
	vcpop.m	a0, v8, v0.t
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %latch
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a1, 8(sp)                       # 4-byte Folded Reload
	addi	a4, a1, 112
	sltu	a1, a4, a1
	add	a3, a0, a1
	lui	a0, 4
	addi	a0, a0, -1600
	xor	a0, a4, a0
	or	a0, a0, a3
	li	a2, -1
	mv	a1, a2
	sw	a4, 24(sp)                      # 4-byte Folded Spill
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_1
	j	.LBB1_3
.LBB1_3:                                # %exit
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a0, a1
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	sw	a2, 8(sp)                       # 4-byte Folded Spill
	add	a0, a0, a2
	addi	a0, a0, 88
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v8, (a0)
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, m1, tu, ma
	vmv.v.i	v9, 0
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmsne.vv	v8, v8, v9
	vmset.m	v0
	vcpop.m	a0, v8, v0.t
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %latch
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a1, 8(sp)                       # 4-byte Folded Reload
	addi	a4, a1, 112
	sltu	a1, a4, a1
	add	a3, a0, a1
	lui	a0, 4
	addi	a0, a0, -1600
	xor	a0, a4, a0
	or	a0, a0, a3
	li	a2, -1
	mv	a1, a2
	sw	a4, 24(sp)                      # 4-byte Folded Spill
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_1
	j	.LBB1_3
.LBB1_3:                                # %exit
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
