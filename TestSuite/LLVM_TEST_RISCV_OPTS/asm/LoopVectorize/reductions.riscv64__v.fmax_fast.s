# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fmax_fast
# src = pre-opt (fmax_fast), tgt = post-opt (fmax_fast)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	fmv.w.x	fa5, zero
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	j	.LBB15_1
.LBB15_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	flw	fa4, 44(sp)                     # 4-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a2, a2, a3
	flw	fa5, 0(a2)
	fmax.s	fa5, fa5, fa4
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB15_1
	j	.LBB15_2
.LBB15_2:                               # %for.end
	flw	fa0, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	src, .Lfunc_end15-src
	.cfi_endproc
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
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB15_1
.LBB15_1:                               # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB15_2
.LBB15_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v12, (a3)
                                        # implicit-def: $v10m2
	vsetvli	a3, zero, e32, m2, ta, ma
	vfmax.vv	v10, v12, v8
	vsetvli	zero, a2, e32, m2, tu, ma
	vmv.v.v	v8, v10
	addi	a3, sp, 64
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB15_2
	j	.LBB15_3
.LBB15_3:                               # %middle.block
	addi	a0, sp, 64
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	vsetvli	a0, zero, e32, m2, ta, ma
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vfredmax.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	j	.LBB15_4
.LBB15_4:                               # %for.end
	flw	fa0, 28(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end15:
	.size	tgt, .Lfunc_end15-tgt
	.cfi_endproc
                                        # -- End function
