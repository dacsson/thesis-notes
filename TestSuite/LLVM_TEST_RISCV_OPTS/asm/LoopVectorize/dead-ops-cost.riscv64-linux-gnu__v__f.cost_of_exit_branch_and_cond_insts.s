# Source: LoopVectorize/dead-ops-cost.riscv64-linux-gnu__v__f.ll
# Function: cost_of_exit_branch_and_cond_insts
# src = pre-opt (cost_of_exit_branch_and_cond_insts), tgt = post-opt (cost_of_exit_branch_and_cond_insts)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %then
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	sext.w	a1, a1
	slli	a1, a1, 2
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a2)
	sw	a0, 0(a1)
	j	.LBB2_3
.LBB2_3:                                # %loop.exiting
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	addiw	a2, a1, 1
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	sext.w	a1, a1
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	slli	a0, a0, 48
	srli	a1, a0, 48
	li	a0, 111
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_5
# %bb.4:                                # %loop.exiting
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB2_5:                                # %loop.exiting
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	li	a1, 770
	sub	a1, a1, a2
	bge	a0, a1, .LBB2_7
	j	.LBB2_6
.LBB2_6:                                # %loop.latch
                                        #   in Loop: Header=BB2_1 Depth=1
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_7:                                # %exit
	j	.LBB2_8
.LBB2_8:                                # %return
	li	a0, 0
	addi	sp, sp, 80
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
	addi	sp, sp, -208
	.cfi_def_cfa_offset 208
	csrr	a4, vlenb
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xd0, 0x01, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 208 + 1 * vlenb
	sd	a1, 160(sp)                     # 8-byte Folded Spill
	sd	a0, 168(sp)                     # 8-byte Folded Spill
	mv	a0, a3
	sd	a0, 176(sp)                     # 8-byte Folded Spill
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	slli	a0, a3, 48
	srli	a1, a0, 48
	li	a0, 111
	sd	a0, 192(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 200(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_2
# %bb.1:                                # %entry
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	sd	a0, 200(sp)                     # 8-byte Folded Spill
.LBB2_2:                                # %entry
	ld	a1, 200(sp)                     # 8-byte Folded Reload
	li	a0, 770
	sub	a1, a0, a1
	li	a2, 0
	slt	a0, a2, a1
	sub	a0, a2, a0
	and	a0, a0, a1
	addi	a0, a0, 1
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	li	a1, 20
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_28
	j	.LBB2_3
.LBB2_3:                                # %vector.memcheck
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	addi	a1, a1, 1
	sd	a1, 120(sp)                     # 8-byte Folded Spill
	slli	a0, a0, 48
	srli	a1, a0, 48
	li	a0, 111
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_5
# %bb.4:                                # %vector.memcheck
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 136(sp)                     # 8-byte Folded Spill
.LBB2_5:                                # %vector.memcheck
	ld	a0, 168(sp)                     # 8-byte Folded Reload
	ld	a3, 160(sp)                     # 8-byte Folded Reload
	ld	a2, 136(sp)                     # 8-byte Folded Reload
	li	a1, 770
	sub	a4, a1, a2
	li	a2, 0
	slt	a1, a2, a4
	sub	a1, a2, a1
	and	a1, a1, a4
	slli	a1, a1, 2
	add	a1, a1, a3
	addi	a1, a1, 4
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	bgeu	a0, a1, .LBB2_7
	j	.LBB2_6
.LBB2_6:                                # %vector.memcheck
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	sd	a2, 152(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_28
	j	.LBB2_7
.LBB2_7:                                # %vector.ph
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 7
	li	a1, 8
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	bnez	a0, .LBB2_9
# %bb.8:                                # %vector.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 104(sp)                     # 8-byte Folded Spill
.LBB2_9:                                # %vector.ph
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	subw	a1, a1, a2
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf2, tu, ma
	vmv.v.x	v8, a0
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	li	a0, 0
	addi	a1, sp, 208
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB2_10
.LBB2_10:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sext.w	a2, a2
	slli	a2, a2, 2
	add	a1, a1, a2
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB2_12
	j	.LBB2_11
.LBB2_11:                               # %pred.store.if
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_12
.LBB2_12:                               # %pred.store.continue
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_14
	j	.LBB2_13
.LBB2_13:                               # %pred.store.if5
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_14
.LBB2_14:                               # %pred.store.continue6
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_16
	j	.LBB2_15
.LBB2_15:                               # %pred.store.if7
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_16
.LBB2_16:                               # %pred.store.continue8
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_18
	j	.LBB2_17
.LBB2_17:                               # %pred.store.if9
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_18
.LBB2_18:                               # %pred.store.continue10
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_20
	j	.LBB2_19
.LBB2_19:                               # %pred.store.if11
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_20
.LBB2_20:                               # %pred.store.continue12
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_22
	j	.LBB2_21
.LBB2_21:                               # %pred.store.if13
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_22
.LBB2_22:                               # %pred.store.continue14
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_24
	j	.LBB2_23
.LBB2_23:                               # %pred.store.if15
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_24
.LBB2_24:                               # %pred.store.continue16
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB2_26
	j	.LBB2_25
.LBB2_25:                               # %pred.store.if17
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB2_26
.LBB2_26:                               # %pred.store.continue18
                                        #   in Loop: Header=BB2_10 Depth=1
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	addi	a3, sp, 208
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	vse32.v	v8, (a2), v0.t
	addiw	a0, a0, 8
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_10
	j	.LBB2_27
.LBB2_27:                               # %middle.block
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	j	.LBB2_28
.LBB2_28:                               # %scalar.ph
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_29
.LBB2_29:                               # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB2_31
	j	.LBB2_30
.LBB2_30:                               # %then
                                        #   in Loop: Header=BB2_29 Depth=1
	ld	a2, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	sext.w	a1, a1
	slli	a1, a1, 2
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a2)
	sw	a0, 0(a1)
	j	.LBB2_31
.LBB2_31:                               # %loop.exiting
                                        #   in Loop: Header=BB2_29 Depth=1
	ld	a0, 176(sp)                     # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	addiw	a2, a1, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	slli	a0, a0, 48
	srli	a1, a0, 48
	li	a0, 111
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_33
# %bb.32:                               # %loop.exiting
                                        #   in Loop: Header=BB2_29 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB2_33:                               # %loop.exiting
                                        #   in Loop: Header=BB2_29 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	li	a1, 770
	sub	a1, a1, a2
	bge	a0, a1, .LBB2_35
	j	.LBB2_34
.LBB2_34:                               # %loop.latch
                                        #   in Loop: Header=BB2_29 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB2_29
.LBB2_35:                               # %exit
	j	.LBB2_36
.LBB2_36:                               # %return
	li	a0, 0
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 208
	addi	sp, sp, 208
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
