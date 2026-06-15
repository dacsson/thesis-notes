# Source: LoopVectorize/dead-ops-cost.riscv64-linux-gnu__v__f.ll
# Function: dead_live_out_due_to_scalar_epilogue_required
# src = pre-opt (dead_live_out_due_to_scalar_epilogue_required), tgt = post-opt (dead_live_out_due_to_scalar_epilogue_required)
# Triple: riscv64-linux-gnu, Attrs: +v,+f
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	sext.w	a0, a1
	add	a2, a2, a0
	lbu	a2, 0(a2)
	add	a4, a3, a0
	li	a3, 0
	sb	a3, 0(a4)
	addiw	a3, a1, 4
	li	a1, 1001
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_1
	j	.LBB1_2
.LBB1_2:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
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
	addi	sp, sp, -112
	.cfi_def_cfa_offset 112
	csrr	a2, vlenb
	mv	a3, a2
	slli	a2, a2, 1
	add	a3, a3, a2
	slli	a2, a2, 4
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xf0, 0x00, 0x22, 0x11, 0x23, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 112 + 35 * vlenb
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.memcheck
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	addi	a2, a0, 1005
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	addi	a1, a1, 1005
	bgeu	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %vector.memcheck
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	bltu	a0, a1, .LBB1_8
	j	.LBB1_3
.LBB1_3:                                # %vector.ph
                                        # implicit-def: $v16m8
	vsetvli	a0, zero, e32, m8, ta, ma
	vid.v	v16
                                        # implicit-def: $v8m8
	vsll.vi	v8, v16, 2
	li	a0, 252
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 2
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 112
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	j	.LBB1_4
.LBB1_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	mv	a3, a1
	slli	a1, a1, 1
	add	a3, a3, a1
	slli	a1, a1, 2
	add	a3, a3, a1
	slli	a1, a1, 1
	add	a1, a1, a3
	add	a1, sp, a1
	addi	a1, a1, 112
	vl8r.v	v8, (a1)                        # vscale x 64-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 112
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	slli	a0, a0, 32
	srli	a0, a0, 32
	vsetvli	a0, a0, e8, m2, ta, ma
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	slliw	a1, a0, 2
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	vsetvli	a1, zero, e64, m8, ta, ma
	vmv4r.v	v24, v8
                                        # implicit-def: $v16m8
	vsext.vf2	v16, v24
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a3, a1
	slli	a1, a1, 2
	add	a1, a1, a3
	add	a1, sp, a1
	addi	a1, a1, 112
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	vmv4r.v	v8, v12
                                        # implicit-def: $v16m8
	vsext.vf2	v16, v8
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a3, a1
	slli	a1, a1, 3
	add	a1, a1, a3
	add	a1, sp, a1
	addi	a1, a1, 112
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sub	a4, a0, a1
	sltu	a3, a0, a4
	addi	a3, a3, -1
	and	a3, a3, a4
	sd	a3, 64(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, a3, e8, m1, tu, ma
	vluxei64.v	v8, (a2), v16
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 2
	add	a3, a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 112
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_6
# %bb.5:                                # %vector.body
                                        #   in Loop: Header=BB1_4 Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB1_6:                                # %vector.body
                                        #   in Loop: Header=BB1_4 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a4, 64(sp)                      # 8-byte Folded Reload
	ld	a6, 104(sp)                     # 8-byte Folded Reload
	ld	a5, 72(sp)                      # 8-byte Folded Reload
	csrr	a7, vlenb
	slli	a7, a7, 1
	add	a7, sp, a7
	addi	a7, a7, 112
	vl8r.v	v16, (a7)                       # vscale x 64-byte Folded Reload
	csrr	a7, vlenb
	slli	a7, a7, 1
	mv	t0, a7
	slli	a7, a7, 3
	add	a7, a7, t0
	add	a7, sp, a7
	addi	a7, a7, 112
	vl8r.v	v24, (a7)                       # vscale x 64-byte Folded Reload
	csrr	a7, vlenb
	slli	a7, a7, 1
	mv	t0, a7
	slli	a7, a7, 2
	add	a7, a7, t0
	add	a7, sp, a7
	addi	a7, a7, 112
	vl8r.v	v0, (a7)                        # vscale x 64-byte Folded Reload
	csrr	a7, vlenb
	slli	a7, a7, 1
	mv	t0, a7
	slli	a7, a7, 2
	add	t0, t0, a7
	slli	a7, a7, 1
	add	a7, a7, t0
	add	a7, sp, a7
	addi	a7, a7, 112
	vl1r.v	v10, (a7)                       # vscale x 8-byte Folded Reload
                                        # implicit-def: $v11
	vsetvli	zero, a5, e8, m1, tu, ma
	vluxei64.v	v11, (a6), v0
                                        # implicit-def: $v8m2
	vsetvli	a6, zero, e8, m1, tu, ma
	vmv1r.v	v8, v11
	vmv1r.v	v9, v10
	addi	a6, sp, 112
	vs2r.v	v8, (a6)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8
	vmv.v.i	v8, 0
	vsetvli	zero, a5, e8, m1, ta, ma
	vsoxei64.v	v8, (a3), v0
	vsetvli	zero, a4, e8, m1, ta, ma
	vsoxei64.v	v8, (a3), v24
	subw	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e32, m8, ta, ma
	vadd.vx	v8, v16, a1
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 2
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 112
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_4
	j	.LBB1_7
.LBB1_7:                                # %middle.block
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 112
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	slli	a0, a0, 32
	srli	a0, a0, 32
	addi	a0, a0, -1
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e8, m2, ta, ma
	vslidedown.vx	v8, v10, a0
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vmv.x.s	a0, v8
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_10
.LBB1_8:                                # %scalar.ph
	li	a0, 0
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_9
.LBB1_9:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	sext.w	a0, a1
	add	a2, a2, a0
	lbu	a2, 0(a2)
	add	a4, a3, a0
	li	a3, 0
	sb	a3, 0(a4)
	addiw	a3, a1, 4
	li	a1, 1001
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_9
	j	.LBB1_10
.LBB1_10:                               # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 4
	add	a1, a1, a2
	add	sp, sp, a1
	.cfi_def_cfa sp, 112
	addi	sp, sp, 112
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
