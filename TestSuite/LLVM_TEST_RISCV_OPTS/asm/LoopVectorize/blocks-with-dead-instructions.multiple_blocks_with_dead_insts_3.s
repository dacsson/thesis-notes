# Source: LoopVectorize/blocks-with-dead-instructions.ll
# Function: multiple_blocks_with_dead_insts_3
# src = pre-opt (multiple_blocks_with_dead_insts_3), tgt = post-opt (multiple_blocks_with_dead_insts_3)
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
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	lhu	a0, 0(a0)
	bnez	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %then
                                        #   in Loop: Header=BB2_1 Depth=1
	j	.LBB2_4
.LBB2_3:                                # %else
                                        #   in Loop: Header=BB2_1 Depth=1
	j	.LBB2_4
.LBB2_4:                                # %loop.latch
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sh	a1, 0(a2)
	addi	a0, a0, 3
	li	a1, 1000
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_5
.LBB2_5:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
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
	csrr	a1, vlenb
	slli	a1, a1, 3
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 8 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
                                        # implicit-def: $v16m8
	vsetvli	a0, zero, e64, m8, ta, ma
	vid.v	v16
	li	a0, 3
                                        # implicit-def: $v8m8
	vmul.vx	v8, v16, a0
	li	a0, 333
	addi	a1, sp, 32
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl8r.v	v16, (a1)                       # vscale x 64-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a1, a2, 1
	add	a1, a1, a2
                                        # implicit-def: $v24m8
	vsetvli	a4, zero, e64, m8, ta, ma
	vadd.vv	v24, v16, v16
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a2, e16, m2, ta, ma
	vsoxei64.v	v8, (a3), v24
	sub	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e64, m8, ta, ma
	vadd.vx	v8, v16, a1
	addi	a1, sp, 32
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
