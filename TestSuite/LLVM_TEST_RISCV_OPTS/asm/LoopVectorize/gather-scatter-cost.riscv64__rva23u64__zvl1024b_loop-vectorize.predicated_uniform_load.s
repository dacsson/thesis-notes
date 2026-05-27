# Source: LoopVectorize/gather-scatter-cost.riscv64__rva23u64__zvl1024b_loop-vectorize.ll
# Function: predicated_uniform_load
# src = pre-opt (predicated_uniform_load), tgt = post-opt (predicated_uniform_load)
# Triple: riscv64, Attrs: +rva23u64,+zvl1024b
#

	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %loop.then
                                        #   in Loop: Header=BB0_1 Depth=1
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_3:                                # %loop.else
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	lw	a0, 0(a0)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %loop.latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	sw	a2, 0(a3)
	addiw	a2, a1, 1
	sext.w	a1, a1
	sext.w	a0, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_1
	j	.LBB0_5
.LBB0_5:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	csrr	a4, vlenb
	sh3add	a4, a4, a4
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xf0, 0x00, 0x22, 0x11, 0x09, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 112 + 9 * vlenb
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	mv	a0, a1
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	sext.w	a0, a1
	addi	a0, a0, 1
	li	a1, 0
	max	a0, a0, a1
	addiw	a0, a0, 1
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.scevcheck
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sext.w	a0, a0
	addi	a0, a0, 1
	li	a1, 0
	max	a0, a0, a1
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sext.w	a0, a0
	bltz	a0, .LBB0_8
	j	.LBB0_2
.LBB0_2:                                # %vector.scevcheck
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	srli	a0, a0, 32
	bnez	a0, .LBB0_8
	j	.LBB0_3
.LBB0_3:                                # %vector.memcheck
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	addi	a2, a0, 4
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	addi	a1, a1, 4
	bgeu	a0, a1, .LBB0_5
	j	.LBB0_4
.LBB0_4:                                # %vector.memcheck
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB0_8
	j	.LBB0_5
.LBB0_5:                                # %vector.ph
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
	ld	a4, 88(sp)                      # 8-byte Folded Reload
	li	a3, 1
	andn	a3, a3, a4
                                        # implicit-def: $v8
	vsetvli	a4, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a3
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	addi	a3, sp, 112
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.x	v8, a2
	csrr	a2, vlenb
	add	a2, a2, sp
	addi	a2, a2, 112
	vs4r.v	v8, (a2)                        # vscale x 32-byte Folded Spill
                                        # implicit-def: $v8m4
	vmv.v.x	v8, a1
	csrr	a1, vlenb
	sh2add	a1, a1, a1
	add	a1, a1, sp
	addi	a1, a1, 112
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB0_6
.LBB0_6:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 88(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	sh2add	a1, a1, a1
	add	a1, a1, sp
	addi	a1, a1, 112
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	csrr	a1, vlenb
	add	a1, a1, sp
	addi	a1, a1, 112
	vl4r.v	v16, (a1)                       # vscale x 32-byte Folded Reload
	addi	a1, sp, 112
	vl1r.v	v0, (a1)                        # vscale x 8-byte Folded Reload
	zext.w	a1, a0
	vsetvli	a1, a1, e8, mf2, ta, ma
	li	a2, 0
                                        # implicit-def: $v10m2
	vsetvli	zero, a1, e32, m2, ta, mu
	vluxei64.v	v10, (a2), v16, v0.t
	andi	a3, a3, 1
                                        # implicit-def: $v8
	vsetvli	a4, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a3
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vim	v8, v10, 0, v0
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v8, (a2), v12
	subw	a0, a0, a1
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_6
	j	.LBB0_7
.LBB0_7:                                # %middle.block
	j	.LBB0_13
.LBB0_8:                                # %scalar.ph
	li	a0, 0
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB0_11
	j	.LBB0_10
.LBB0_10:                               # %loop.then
                                        #   in Loop: Header=BB0_9 Depth=1
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_12
.LBB0_11:                               # %loop.else
                                        #   in Loop: Header=BB0_9 Depth=1
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	lw	a0, 0(a0)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_12
.LBB0_12:                               # %loop.latch
                                        #   in Loop: Header=BB0_9 Depth=1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sw	a2, 0(a3)
	addiw	a2, a1, 1
	sext.w	a1, a1
	sext.w	a0, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB0_9
	j	.LBB0_13
.LBB0_13:                               # %exit
	csrr	a0, vlenb
	sh3add	a0, a0, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 112
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
