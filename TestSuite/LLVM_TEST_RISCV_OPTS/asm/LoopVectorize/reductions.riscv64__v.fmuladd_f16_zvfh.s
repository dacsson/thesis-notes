# Source: LoopVectorize/reductions.riscv64__v.ll
# Function: fmuladd_f16_zvfh
# src = pre-opt (fmuladd_f16_zvfh), tgt = post-opt (fmuladd_f16_zvfh)
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
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	fmv.h.x	fa5, zero
	li	a0, 0
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	fsh	fa5, 46(sp)                     # 2-byte Folded Spill
	j	.LBB21_1
.LBB21_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	flh	fa4, 46(sp)                     # 2-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 24(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 1
	add	a4, a4, a3
	flh	fa5, 0(a4)
	add	a2, a2, a3
	flh	fa3, 0(a2)
	fcvt.s.h	fa3, fa3
	fcvt.s.h	fa5, fa5
	fmul.s	fa5, fa5, fa3
	fcvt.h.s	fa5, fa5
	fcvt.s.h	fa5, fa5
	fcvt.s.h	fa4, fa4
	fadd.s	fa5, fa5, fa4
	fcvt.h.s	fa5, fa5
	fsh	fa5, 6(sp)                      # 2-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	fsh	fa5, 46(sp)                     # 2-byte Folded Spill
	bne	a0, a1, .LBB21_1
	j	.LBB21_2
.LBB21_2:                               # %for.end
	flh	fa0, 6(sp)                      # 2-byte Folded Reload
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end21:
	.size	src, .Lfunc_end21-src
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
	csrr	a3, vlenb
	slli	a3, a3, 2
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 4 * vlenb
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB21_1
.LBB21_1:                               # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	lui	a1, 1048568
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e16, m2, tu, ma
	vmv.v.x	v8, a1
	vmv1r.v	v10, v8
	vmv.s.x	v10, zero
	vmv1r.v	v8, v10
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB21_2
.LBB21_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	ld	a5, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, m1, ta, ma
	slli	a4, a1, 1
	add	a5, a5, a4
                                        # implicit-def: $v12m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v12, (a5)
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e16, m2, tu, ma
	vle16.v	v10, (a3)
	vsetvli	a3, zero, e16, m2, ta, ma
	vfmadd.vv	v10, v12, v8
	vsetvli	zero, a2, e16, m2, tu, ma
	vmv.v.v	v8, v10
	addi	a3, sp, 64
	vs2r.v	v8, (a3)                        # vscale x 16-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB21_2
	j	.LBB21_3
.LBB21_3:                               # %middle.block
	addi	a0, sp, 64
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	lui	a0, 1048568
                                        # implicit-def: $v9
	vsetvli	a1, zero, e16, m2, tu, ma
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, m2, ta, ma
	vfredusum.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	fsh	fa5, 22(sp)                     # 2-byte Folded Spill
	j	.LBB21_4
.LBB21_4:                               # %for.end
	flh	fa0, 22(sp)                     # 2-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end21:
	.size	tgt, .Lfunc_end21-tgt
	.cfi_endproc
                                        # -- End function
