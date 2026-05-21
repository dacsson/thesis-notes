# Source: LoopVectorize/gather-scatter-cost.riscv64__rva23u64__zvl1024b_loop-vectorize.ll
# Function: mixed_gather_scatters
# src = pre-opt (mixed_gather_scatters), tgt = post-opt (mixed_gather_scatters)
# Triple: riscv64, Attrs: +rva23u64,+zvl1024b
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	li	a1, 0
	mv	a0, a1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_1
.LBB3_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ori	a2, a1, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addiw	a3, a0, 1
	sext.w	a0, a0
	li	a1, 9
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB3_1
	j	.LBB3_2
.LBB3_2:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a0, vlenb
	slli	a0, a0, 1
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	j	.LBB3_1
.LBB3_1:                                # %vector.ph
	li	a0, 10
                                        # implicit-def: $v8
	vsetvli	a1, zero, e8, mf8, tu, ma
	vmv.v.i	v8, 0
	csrr	a1, vlenb
	add	a1, a1, sp
	addi	a1, a1, 32
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB3_2
.LBB3_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, a1, sp
	addi	a1, a1, 32
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	zext.w	a1, a0
	vsetvli	a1, a1, e8, mf8, ta, ma
                                        # implicit-def: $v9
	vsetvli	a2, zero, e8, mf8, ta, ma
	vor.vi	v9, v8, 1
	vsetvli	zero, a1, e8, mf8, tu, ma
	vmv.v.v	v8, v9
	addi	a2, sp, 32
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	subw	a0, a0, a1
	csrr	a1, vlenb
	add	a1, a1, sp
	addi	a1, a1, 32
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB3_2
	j	.LBB3_3
.LBB3_3:                                # %middle.block
	addi	a0, sp, 32
	vl1r.v	v9, (a0)                        # vscale x 8-byte Folded Reload
	vsetvli	a0, zero, e8, mf8, ta, ma
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB3_4
.LBB3_4:                                # %exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	sh1add	sp, a1, sp
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
