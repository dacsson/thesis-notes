# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fmin_fast_bfloat_zvfbfmin
# src = pre-opt (fmin_fast_bfloat_zvfbfmin), tgt = post-opt (fmin_fast_bfloat_zvfbfmin)
# Triple: riscv64, Attrs: +v
#

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
	fmv.h.x	fa5, zero
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	fsh	fa5, 62(sp)                     # 2-byte Folded Spill
	j	.LBB14_1
.LBB14_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	flh	fa3, 62(sp)                     # 2-byte Folded Reload
	fsh	fa3, 14(sp)                     # 2-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 1
	add	a0, a0, a1
	flh	fa5, 0(a0)
	fcvt.s.bf16	fa4, fa5
	fcvt.s.bf16	fa3, fa3
	flt.s	a0, fa4, fa3
	fsh	fa5, 30(sp)                     # 2-byte Folded Spill
	bnez	a0, .LBB14_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB14_1 Depth=1
	flh	fa5, 14(sp)                     # 2-byte Folded Reload
	fsh	fa5, 30(sp)                     # 2-byte Folded Spill
.LBB14_3:                               # %for.body
                                        #   in Loop: Header=BB14_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	flh	fa5, 30(sp)                     # 2-byte Folded Reload
	fsh	fa5, 12(sp)                     # 2-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	fsh	fa5, 62(sp)                     # 2-byte Folded Spill
	bne	a0, a1, .LBB14_1
	j	.LBB14_4
.LBB14_4:                               # %for.end
	flh	fa0, 12(sp)                     # 2-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	src, .Lfunc_end14-src
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
	j	.LBB14_1
.LBB14_1:                               # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e16, m2, tu, ma
	vmv.v.i	v8, 0
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB14_2
.LBB14_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a4, a1, 1
	add	a3, a3, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v12, (a3)
                                        # implicit-def: $v16m4
	vsetvli	a3, zero, e16, m2, ta, ma
	vfwcvtbf16.f.f.v	v16, v12
                                        # implicit-def: $v20m4
	vfwcvtbf16.f.f.v	v20, v8
	vsetvli	zero, zero, e32, m4, ta, ma
	vmflt.vv	v0, v16, v20
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e16, m2, tu, ma
	vmerge.vvm	v10, v8, v12, v0
	vsetvli	zero, a2, e16, m2, tu, ma
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
	bnez	a0, .LBB14_2
	j	.LBB14_3
.LBB14_3:                               # %middle.block
	addi	a0, sp, 64
	vl2r.v	v8, (a0)                        # vscale x 16-byte Folded Reload
                                        # implicit-def: $v12m4
	vsetvli	a0, zero, e16, m2, ta, ma
	vfwcvtbf16.f.f.v	v12, v8
	vmv1r.v	v9, v12
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m4, ta, ma
	vfredmin.vs	v8, v12, v9
	vfmv.f.s	fa5, v8
	fcvt.bf16.s	fa5, fa5
	fsh	fa5, 30(sp)                     # 2-byte Folded Spill
	j	.LBB14_4
.LBB14_4:                               # %for.end
	flh	fa0, 30(sp)                     # 2-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
	.cfi_endproc
                                        # -- End function
