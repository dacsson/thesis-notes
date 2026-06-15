# Source: LoopVectorize/low-trip-count.riscv64__v_loop-vectorize.ll
# Function: const_tc_with_predicated_store
# src = pre-opt (const_tc_with_predicated_store), tgt = post-opt (const_tc_with_predicated_store)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	mv	a3, a2
	mv	a2, a1
	mv	a1, a0
	li	a0, 0
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %header
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lui	a1, 260096
	fmv.w.x	fa5, a1
	andi	a0, a0, 1
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	bnez	a0, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                # %if.then
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	fmv.w.x	fa5, zero
	andi	a0, a0, 1
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	bnez	a0, .LBB7_4
	j	.LBB7_3
.LBB7_3:                                # %if.else1
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	fsw	fa5, 4(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB7_5
	j	.LBB7_4
.LBB7_4:                                # %if.else2
                                        #   in Loop: Header=BB7_1 Depth=1
	lui	a0, 262144
	fmv.w.x	fa5, a0
	fsw	fa5, 4(sp)                      # 4-byte Folded Spill
	j	.LBB7_5
.LBB7_5:                                # %latch
                                        #   in Loop: Header=BB7_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	flw	fa5, 4(sp)                      # 4-byte Folded Reload
	slli	a2, a0, 2
	add	a1, a1, a2
	fsw	fa5, 0(a1)
	addi	a2, a0, 1
	li	a1, 56
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB7_1
	j	.LBB7_6
.LBB7_6:                                # %exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a4, vlenb
	slli	a4, a4, 2
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 4 * vlenb
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB7_1
.LBB7_1:                                # %vector.ph
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	andi	a1, a2, 1
	not	a3, a3
	or	a2, a2, a3
	andi	a2, a2, 1
                                        # implicit-def: $v8
	vsetvli	a3, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a2
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	addi	a2, sp, 48
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a1
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v10, 0
	lui	a1, 260096
                                        # implicit-def: $v8m2
	vmerge.vxm	v8, v10, a1, v0
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 48
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	andi	a0, a0, 1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a0
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	j	.LBB7_2
.LBB7_2:                                # %vector.body
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 48
	vl2r.v	v12, (a1)                       # vscale x 16-byte Folded Reload
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 48
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	addi	a1, sp, 48
	vl1r.v	v10, (a1)                       # vscale x 8-byte Folded Reload
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v16
	li	a1, 57
	vmsltu.vx	v8, v16, a1
	vmand.mm	v8, v8, v10
	vmand.mm	v0, v8, v9
	lui	a2, 262144
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.x	v10, a2
                                        # implicit-def: $v8m2
	vmerge.vvm	v8, v10, v12, v0
	vsetvli	zero, a1, e32, m2, ta, ma
	vse32.v	v8, (a0)
	j	.LBB7_3
.LBB7_3:                                # %middle.block
	j	.LBB7_4
.LBB7_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
