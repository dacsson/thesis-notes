# Source: LoopVectorize/conditional-scalar-assignment-fold-tail.riscv64__v_loop-vectorize.ll
# Function: non_speculatable_find_last_reduction
# src = pre-opt (non_speculatable_find_last_reduction), tgt = post-opt (non_speculatable_find_last_reduction)
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
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	sext.w	a0, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bge	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB1_3
.LBB1_3:                                # %latch
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
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
	csrr	a5, vlenb
	slli	a5, a5, 1
	mv	a6, a5
	slli	a5, a5, 2
	add	a5, a5, a6
	sub	sp, sp, a5
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xe0, 0x00, 0x22, 0x11, 0x0a, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 96 + 10 * vlenb
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	sd	a4, 80(sp)                      # 8-byte Folded Spill
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a2, 80(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e32, m2, tu, ma
	vmv.v.x	v8, a2
	csrr	a2, vlenb
	slli	a3, a2, 1
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v10m2
	vmv.v.x	v10, a1
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmclr.m	v8
	li	a1, 0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a5, 72(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 3
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 3
	sub	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 1
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 96
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a5, a5, a4
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v14, (a5)
	vsetvli	a5, zero, e32, m2, ta, ma
	vmslt.vv	v0, v10, v14
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v16
	vmsltu.vx	v8, v16, a2
	vmand.mm	v8, v8, v0
	add	a3, a3, a4
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, ta, mu
	vle32.v	v14, (a3), v0.t
	vsetvli	a3, zero, e8, mf2, ta, ma
	vcpop.m	a3, v8
	snez	a3, a3
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v10, a3
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v0, v10, 0
	vmand.mm	v8, v8, v0
	vmandn.mm	v9, v9, v0
	vmor.mm	v8, v8, v9
	addi	a3, sp, 96
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v10, v12, v14, v0
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 96
	vs2r.v	v10, (a3)                       # vscale x 16-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	sub	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 96
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	addi	a0, sp, 96
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 96
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
	csrr	a0, vlenb
	slli	a1, a0, 2
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 96
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	vmv1r.v	v9, v10
	vmv.x.s	a0, v9
	sd	a0, 24(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v24m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v24
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.i	v20, 0
	vmv1r.v	v0, v8
                                        # implicit-def: $v16m4
	vmerge.vvm	v16, v20, v24, v0
	vmv1r.v	v10, v16
                                        # implicit-def: $v9
	vsetvli	zero, zero, e64, m4, ta, ma
	vredmaxu.vs	v9, v16, v10
	vmv.x.s	a0, v9
                                        # implicit-def: $v10m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v10, v12, a0
	vmv1r.v	v9, v10
	vmv.x.s	a1, v9
	vsetvli	a0, zero, e8, mf2, ta, ma
	vcpop.m	a0, v8
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB1_5
# %bb.4:                                # %middle.block
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB1_5:                                # %middle.block
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB1_6
.LBB1_6:                                # %exit
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 2
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
