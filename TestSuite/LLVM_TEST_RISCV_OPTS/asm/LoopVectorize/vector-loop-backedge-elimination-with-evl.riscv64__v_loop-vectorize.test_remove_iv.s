# Source: LoopVectorize/vector-loop-backedge-elimination-with-evl.riscv64__v_loop-vectorize.ll
# Function: test_remove_iv
# src = pre-opt (test_remove_iv), tgt = post-opt (test_remove_iv)
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
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	xori	a2, a1, 3
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addiw	a3, a0, 1
	sext.w	a0, a0
	li	a1, 5
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -64
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 4 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.i	v8, 0
	vmv1r.v	v10, v8
	vmv.s.x	v10, a0
	vmv1r.v	v8, v10
	addi	a0, sp, 64
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
	addi	a0, sp, 64
	vl2r.v	v8, (a0)                        # vscale x 16-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vxor.vi	v10, v8, 3
	vsetivli	zero, 6, e32, m2, tu, ma
	vmv.v.v	v8, v10
	addi	a0, sp, 32
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	addi	a0, sp, 32
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetivli	zero, 8, e32, m2, ta, ma
	vredxor.vs	v8, v10, v9
	vmv.x.s	a0, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
