# Source: LoopVectorize/select-cmp-reduction.riscv64__v.ll
# Function: select_const_i32_from_fcmp
# src = pre-opt (select_const_i32_from_fcmp), tgt = post-opt (select_const_i32_from_fcmp)
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
	li	a0, 2
	li	a1, 0
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	add	a0, a0, a2
	flw	fa5, 0(a0)
	lui	a0, 263168
	fmv.w.x	fa4, a0
	feq.s	a0, fa5, fa4
	li	a2, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB4_3:                                # %for.body
                                        #   in Loop: Header=BB4_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a0, a0, 1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_4
.LBB4_4:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
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
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 2 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	vsetvli	a1, zero, e8, mf2, ta, ma
	vmclr.m	v8
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vl1r.v	v8, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v10, (a3)
	lui	a3, 263168
	fmv.w.x	fa5, a3
	vsetvli	a3, zero, e32, m2, ta, ma
	vmfne.vf	v9, v10, fa5
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v12
	vmsltu.vx	v10, v12, a2
	vmand.mm	v9, v9, v10
	vmor.mm	v8, v8, v9
	addi	a3, sp, 64
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	addi	a0, sp, 64
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	vcpop.m	a0, v8
	seqz	a0, a0
	addi	a0, a0, 1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB4_4
.LBB4_4:                                # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
