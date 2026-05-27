# Source: LoopVectorize/select-cmp-reduction.riscv64__v.ll
# Function: select_const_f32_from_icmp
# src = pre-opt (select_const_f32_from_icmp), tgt = post-opt (select_const_f32_from_icmp)
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
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	lui	a1, 263168
	fmv.w.x	fa5, a1
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	flw	fa5, 60(sp)                     # 4-byte Folded Reload
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	lui	a1, 265728
	fmv.w.x	fa4, a1
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
	li	a1, 3
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB5_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB5_1 Depth=1
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
.LBB5_3:                                # %for.body
                                        #   in Loop: Header=BB5_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB5_1
	j	.LBB5_4
.LBB5_4:                                # %exit
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	src, .Lfunc_end5-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x06, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 6 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	lui	a1, 263168
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e32, m2, tu, ma
	vmv.v.x	v10, a1
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmclr.m	v8
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB5_2
.LBB5_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 2
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 1
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v12, (a2)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v14m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v14, (a3)
	vsetvli	a3, zero, e32, m2, ta, ma
	vmsne.vi	v10, v14, 3
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v16
	vmsltu.vx	v8, v16, a2
	vmand.mm	v8, v8, v10
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
	addi	a3, sp, 64
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	lui	a3, 265728
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vxm	v10, v12, a3, v0
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 64
	vs2r.v	v10, (a3)                       # vscale x 16-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v10, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB5_2
	j	.LBB5_3
.LBB5_3:                                # %middle.block
	addi	a0, sp, 64
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
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
	vfmv.f.s	fa5, v9
	vsetvli	a0, zero, e8, mf2, ta, ma
	vcpop.m	a0, v8
	lui	a1, 263168
	fmv.w.x	fa4, a1
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	bnez	a0, .LBB5_5
# %bb.4:                                # %middle.block
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
.LBB5_5:                                # %middle.block
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	fsw	fa5, 20(sp)                     # 4-byte Folded Spill
	j	.LBB5_6
.LBB5_6:                                # %exit
	flw	fa0, 20(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
