# Source: LoopVectorize/iv-select-cmp.riscv64__v.ll
# Function: select_decreasing_induction_icmp_non_const_start
# src = pre-opt (select_decreasing_induction_icmp_non_const_start), tgt = post-opt (select_decreasing_induction_icmp_non_const_start)
# Triple: riscv64, Attrs: +v
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
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a3, 72(sp)                      # 8-byte Folded Reload
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	addi	a2, a2, -1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	slli	a3, a2, 3
	add	a1, a1, a3
	ld	a1, 0(a1)
	add	a0, a0, a3
	ld	a0, 0(a0)
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB1_3
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB1_3:                                # %loop
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	li	a0, 1
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB1_1
	j	.LBB1_4
.LBB1_4:                                # %exit
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
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
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	csrr	a4, vlenb
	slli	a4, a4, 1
	mv	a5, a4
	slli	a4, a4, 1
	add	a5, a5, a4
	slli	a4, a4, 1
	add	a4, a4, a5
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x0e, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 14 * vlenb
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	snez	a0, a3
	sub	a0, a3, a0
	addi	a0, a0, 1
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v16
	li	a1, -1
	vmadd.vx	v16, a1, v8
	srli	a1, a1, 1
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.x	v12, a1
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmclr.m	v8
	li	a1, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs4r.v	v16, (a1)                       # vscale x 32-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs4r.v	v12, (a1)                       # vscale x 32-byte Folded Spill
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 2
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 96
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	ld	a6, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	mv	a3, a2
	slli	a2, a2, 2
	add	a3, a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 96
	vl1r.v	v8, (a2)                        # vscale x 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a3, a2, 3
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vl4r.v	v12, (a2)                       # vscale x 32-byte Folded Reload
	csrr	a2, vlenb
	slli	a3, a2, 2
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vl4r.v	v20, (a2)                       # vscale x 32-byte Folded Reload
	vsetvli	a3, a0, e8, mf2, ta, ma
	li	a2, 0
	sub	a2, a2, a3
	sub	a6, a6, a1
	slli	a6, a6, 3
	addi	a6, a6, -8
	add	a7, a5, a6
	li	a5, -8
                                        # implicit-def: $v24m4
	vsetvli	zero, a3, e64, m4, tu, ma
	vlse64.v	v24, (a7), a5
	add	a4, a4, a6
                                        # implicit-def: $v16m4
	vsetvli	zero, a3, e64, m4, tu, ma
	vlse64.v	v16, (a4), a5
	vsetvli	a4, zero, e64, m4, ta, ma
	vmslt.vv	v9, v16, v24
	vmv1r.v	v0, v9
	vsetvli	zero, a3, e64, m4, tu, ma
	vmerge.vvm	v12, v12, v20, v0
	addi	a4, sp, 96
	vs4r.v	v12, (a4)                       # vscale x 32-byte Folded Spill
                                        # implicit-def: $v16m4
	vsetvli	a4, zero, e64, m4, ta, ma
	vid.v	v16
	vmsltu.vx	v10, v16, a3
	vmand.mm	v9, v9, v10
	vmor.mm	v8, v8, v9
	csrr	a4, vlenb
	slli	a4, a4, 2
	add	a4, sp, a4
	addi	a4, a4, 96
	vs1r.v	v8, (a4)                        # vscale x 8-byte Folded Spill
	add	a1, a3, a1
	sub	a0, a0, a3
                                        # implicit-def: $v16m4
	vadd.vx	v16, v20, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs4r.v	v16, (a1)                       # vscale x 32-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs4r.v	v12, (a1)                       # vscale x 32-byte Folded Spill
	csrr	a1, vlenb
	mv	a2, a1
	slli	a1, a1, 2
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 96
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 96
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	addi	a0, sp, 96
	vl4r.v	v12, (a0)                       # vscale x 32-byte Folded Reload
	vmv1r.v	v10, v12
                                        # implicit-def: $v9
	vredmin.vs	v9, v12, v10
	vmv.x.s	a0, v9
	addi	a1, a0, -1
	vcpop.m	a0, v8
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_5
# %bb.4:                                # %middle.block
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB1_5:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_6
.LBB1_6:                                # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	sp, sp, a1
	.cfi_def_cfa sp, 96
	addi	sp, sp, 96
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
