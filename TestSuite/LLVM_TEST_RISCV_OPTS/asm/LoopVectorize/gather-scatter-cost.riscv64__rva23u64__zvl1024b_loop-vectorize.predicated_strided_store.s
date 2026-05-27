# Source: LoopVectorize/gather-scatter-cost.riscv64__rva23u64__zvl1024b_loop-vectorize.ll
# Function: predicated_strided_store
# src = pre-opt (predicated_strided_store), tgt = post-opt (predicated_strided_store)
# Triple: riscv64, Attrs: +rva23u64,+zvl1024b
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 3
	sub	a2, a2, a0
	add	a2, a2, a1
	li	a1, 0
	sb	a1, 0(a2)
	addi	a2, a0, 1
	li	a1, 585
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
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
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	li	a0, 586
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, ta, ma
	vid.v	v8
	addi	a1, sp, 32
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a1, a0, e8, mf4, ta, ma
	li	a3, 7
                                        # implicit-def: $v12m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vmul.vx	v12, v10, a3
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.i	v8, 0
	vsetvli	zero, a1, e8, mf4, ta, ma
	vsoxei64.v	v8, (a2), v12
	sub	a0, a0, a1
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a1
	addi	a1, sp, 32
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %exit
	csrr	a0, vlenb
	sh1add	sp, a0, sp
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
