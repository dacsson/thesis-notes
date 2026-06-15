# Source: LoopVectorize/early-exit-live-out.riscv32__v_RV32.ll
# Function: strided_search
# src = pre-opt (strided_search), tgt = post-opt (strided_search)
# Triple: riscv32, Attrs: +v
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
	vsetivli	zero, 8, e64, m4, tu, ma
	vle8.v	v8, (a0)
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
	vsetvli	zero, zero, e8, mf2, ta, ma
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
	addi	sp, sp, -176
	.cfi_def_cfa_offset 176
	sw	ra, 172(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xb0, 0x01, 0x22, 0x11, 0x09, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 176 + 9 * vlenb
	sw	a0, 108(sp)                     # 4-byte Folded Spill
	csrr	a0, vlenb
	srli	a0, a0, 3
	sw	a0, 112(sp)                     # 4-byte Folded Spill
	li	a2, 1
	li	a3, 0
	sw	a3, 128(sp)                     # 4-byte Folded Spill
	mv	a1, a3
	call	__muldi3
	lw	a3, 128(sp)                     # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 112(sp)                     # 4-byte Folded Reload
	sw	a2, 116(sp)                     # 4-byte Folded Spill
	mv	a2, a1
	lw	a1, 116(sp)                     # 4-byte Folded Reload
	sw	a2, 120(sp)                     # 4-byte Folded Spill
	sw	a1, 124(sp)                     # 4-byte Folded Spill
	li	a2, 2
	mv	a1, a3
	call	__muldi3
	lw	a2, 128(sp)                     # 4-byte Folded Reload
	sw	a0, 132(sp)                     # 4-byte Folded Spill
	mv	a0, a1
	lw	a1, 132(sp)                     # 4-byte Folded Reload
	sltiu	a1, a1, 133
	seqz	a0, a0
	and	a0, a0, a1
	mv	a1, a2
	sw	a2, 136(sp)                     # 4-byte Folded Spill
	sw	a1, 140(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB1_8
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	lw	a1, 120(sp)                     # 4-byte Folded Reload
	lw	a0, 124(sp)                     # 4-byte Folded Reload
	srli	a2, a0, 31
	slli	a1, a1, 1
	or	a3, a1, a2
	sw	a3, 64(sp)                      # 4-byte Folded Spill
	slli	a2, a0, 1
	sw	a2, 68(sp)                      # 4-byte Folded Spill
	li	a0, 132
	sw	a0, 72(sp)                      # 4-byte Folded Spill
	li	a1, 0
	sw	a1, 96(sp)                      # 4-byte Folded Spill
	call	__umoddi3
	lw	a3, 96(sp)                      # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, 72(sp)                      # 4-byte Folded Reload
	sltiu	a4, a2, 133
	xori	a4, a4, 1
	add	a1, a1, a4
	sub	a1, a3, a1
	sw	a1, 76(sp)                      # 4-byte Folded Spill
	sub	a0, a0, a2
	sw	a0, 80(sp)                      # 4-byte Folded Spill
	li	a2, 112
	sw	a2, 84(sp)                      # 4-byte Folded Spill
	call	__muldi3
	lw	a2, 84(sp)                      # 4-byte Folded Reload
	lw	a3, 96(sp)                      # 4-byte Folded Reload
	mv	a4, a0
	lw	a0, 124(sp)                     # 4-byte Folded Reload
	mv	a5, a1
	lw	a1, 120(sp)                     # 4-byte Folded Reload
	sw	a5, 88(sp)                      # 4-byte Folded Spill
	sw	a4, 92(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetvli	a4, zero, e64, m2, ta, ma
	vid.v	v10
                                        # implicit-def: $v8m2
	vmul.vx	v8, v10, a2
	csrr	a2, vlenb
	slli	a4, a2, 1
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 160
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	li	a2, 224
	call	__muldi3
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 160
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	mv	a2, a1
	lw	a1, 96(sp)                      # 4-byte Folded Reload
	sw	a2, 148(sp)
	sw	a0, 144(sp)
	addi	a0, sp, 144
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vlse64.v	v10, (a0), zero
	csrr	a0, vlenb
	slli	a2, a0, 2
	add	a0, a2, a0
	add	a0, sp, a0
	addi	a0, a0, 160
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	mv	a0, a1
	sw	a1, 100(sp)                     # 4-byte Folded Spill
	sw	a0, 104(sp)                     # 4-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 3
	sub	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 160
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	lw	a3, 80(sp)                      # 4-byte Folded Reload
	lw	a4, 76(sp)                      # 4-byte Folded Reload
	lw	a5, 64(sp)                      # 4-byte Folded Reload
	lw	a1, 68(sp)                      # 4-byte Folded Reload
	lw	a6, 108(sp)                     # 4-byte Folded Reload
	lw	a2, 100(sp)                     # 4-byte Folded Reload
	lw	a0, 104(sp)                     # 4-byte Folded Reload
	csrr	a7, vlenb
	slli	t0, a7, 2
	add	a7, t0, a7
	add	a7, sp, a7
	addi	a7, a7, 160
	vl2r.v	v12, (a7)                       # vscale x 16-byte Folded Reload
	csrr	a7, vlenb
	slli	t0, a7, 3
	sub	a7, t0, a7
	add	a7, sp, a7
	addi	a7, a7, 160
	vl2r.v	v10, (a7)                       # vscale x 16-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
	sw	a2, 48(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vnsrl.wi	v8, v10, 0
	addi	a6, a6, 88
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vluxei32.v	v14, (a6), v8
	vsetvli	zero, zero, e64, m2, ta, ma
	vmseq.vi	v8, v14, 0
	addi	a6, sp, 160
	vs1r.v	v8, (a6)                        # vscale x 8-byte Folded Spill
	add	a1, a2, a1
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	sltu	a2, a1, a2
	add	a0, a0, a5
	add	a2, a0, a2
	sw	a2, 56(sp)                      # 4-byte Folded Spill
	vcpop.m	a0, v8
	xor	a2, a2, a4
	xor	a1, a1, a3
	or	a1, a1, a2
	seqz	a1, a1
	sw	a1, 60(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v12
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 160
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	bnez	a0, .LBB1_5
	j	.LBB1_3
.LBB1_3:                                # %vector.body.interim
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a1, 56(sp)                      # 4-byte Folded Reload
	lw	a2, 52(sp)                      # 4-byte Folded Reload
	lw	a0, 60(sp)                      # 4-byte Folded Reload
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 160
	vl2r.v	v8, (a3)                        # vscale x 16-byte Folded Reload
	andi	a0, a0, 1
	sw	a2, 100(sp)                     # 4-byte Folded Spill
	sw	a1, 104(sp)                     # 4-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 160
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	beqz	a0, .LBB1_2
	j	.LBB1_4
.LBB1_4:                                # %middle.block
	lw	a3, 88(sp)                      # 4-byte Folded Reload
	lw	a4, 92(sp)                      # 4-byte Folded Reload
	lw	a1, 76(sp)                      # 4-byte Folded Reload
	lw	a0, 80(sp)                      # 4-byte Folded Reload
	xori	a0, a0, 132
	or	a0, a0, a1
	li	a2, -1
	mv	a1, a2
	sw	a4, 136(sp)                     # 4-byte Folded Spill
	sw	a3, 140(sp)                     # 4-byte Folded Spill
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_11
	j	.LBB1_8
.LBB1_5:                                # %vector.early.exit
	addi	a0, sp, 160
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	srli	a1, a0, 2
	vfirst.m	a0, v8
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	bltz	a0, .LBB1_7
# %bb.6:                                # %vector.early.exit
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	sw	a0, 32(sp)                      # 4-byte Folded Spill
.LBB1_7:                                # %vector.early.exit
	lw	a1, 44(sp)                      # 4-byte Folded Reload
	lw	a2, 48(sp)                      # 4-byte Folded Reload
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
	li	a2, 112
	li	a3, 0
	call	__muldi3
	sw	a0, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	j	.LBB1_11
.LBB1_8:                                # %scalar.ph
	lw	a1, 136(sp)                     # 4-byte Folded Reload
	lw	a0, 140(sp)                     # 4-byte Folded Reload
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	j	.LBB1_9
.LBB1_9:                                # %loop.header
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 108(sp)                     # 4-byte Folded Reload
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	add	a0, a0, a2
	addi	a0, a0, 88
                                        # implicit-def: $v8
	vsetivli	zero, 8, e64, m4, tu, ma
	vle8.v	v8, (a0)
	li	a0, 0
                                        # implicit-def: $v9
	vmv.s.x	v9, a0
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vv	v8, v8, v9
	vmset.m	v0
	vcpop.m	a0, v8, v0.t
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_11
	j	.LBB1_10
.LBB1_10:                               # %latch
                                        #   in Loop: Header=BB1_9 Depth=1
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	addi	a4, a1, 112
	sltu	a1, a4, a1
	add	a3, a0, a1
	lui	a0, 4
	addi	a0, a0, -1600
	xor	a0, a4, a0
	or	a0, a0, a3
	li	a2, -1
	mv	a1, a2
	sw	a4, 20(sp)                      # 4-byte Folded Spill
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB1_9
	j	.LBB1_11
.LBB1_11:                               # %exit
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	lw	a1, 40(sp)                      # 4-byte Folded Reload
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	add	sp, sp, a2
	.cfi_def_cfa sp, 176
	lw	ra, 172(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 176
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
