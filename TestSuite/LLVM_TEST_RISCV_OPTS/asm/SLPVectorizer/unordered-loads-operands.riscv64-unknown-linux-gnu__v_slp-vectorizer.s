# Source: SLPVectorizer/unordered-loads-operands.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(a0)
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	flw	fa5, 48(a0)
	fmv.w.x	fa3, zero
	fadd.s	fa2, fa5, fa3
	flw	fa4, 32(a0)
	fsub.s	fa5, fa5, fa4
	flw	fa0, 24(a0)
	fadd.s	fa1, fa0, fa3
	flw	fa4, 40(a0)
	fsub.s	fa4, fa4, fa0
	fsub.s	fa2, fa2, fa1
	fsw	fa2, 40(a0)
	flw	fa2, 28(a0)
	fsub.s	fa2, fa3, fa2
	flw	fa1, 36(a0)
	fsub.s	fa3, fa3, fa1
	li	a1, 0
	sw	a1, 24(a0)
	fsub.s	fa5, fa5, fa2
	fsw	fa5, 32(a0)
	fadd.s	fa4, fa4, fa3
	fsw	fa4, 36(a0)
	fsw	fa5, 44(a0)
	j	.LBB0_1
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 0(a0)
	addi	a0, a2, 32
	addi	a1, a2, 40
	addi	a3, a2, 24
	lui	a4, 115074
	addi	a4, a4, 1052
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.s.x	v10, a4
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 5
	addi	a4, sp, 32
	vs1r.v	v0, (a4)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 3, e32, m1, ta, mu
	vle32.v	v8, (a3), v0.t
	addi	a3, sp, 32
	vl1r.v	v0, (a3)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v9
	vle32.v	v9, (a1), v0.t
                                        # implicit-def: $v12
	vsetivli	zero, 4, e32, m1, tu, ma
	vluxei8.v	v12, (a2), v10
	lui	a1, 8224
	addi	a1, a1, 2
                                        # implicit-def: $v10
	vmv.s.x	v10, a1
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vsext.vf4	v11, v10
                                        # implicit-def: $v10
	vrgather.vv	v10, v9, v11
                                        # implicit-def: $v11
	vslidedown.vi	v11, v8, 2
	vslideup.vi	v11, v8, 1
                                        # implicit-def: $v8
	vfsub.vv	v8, v10, v11
	fmv.w.x	fa5, zero
                                        # implicit-def: $v10
	vfadd.vf	v10, v9, fa5
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 11
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 32
	vs1r.v	v0, (a1)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v9, v10, v8, v0
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 32
	vl1r.v	v0, (a1)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v11
	vsetvli	zero, zero, e32, m1, ta, ma
	vfrsub.vf	v11, v12, fa5
                                        # implicit-def: $v10
	vfadd.vf	v10, v12, fa5
                                        # implicit-def: $v12
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vvm	v12, v10, v11, v0
	li	a1, 0
	sw	a1, 24(a2)
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, ta, ma
	vfsub.vv	v10, v9, v12
                                        # implicit-def: $v9
	vfadd.vv	v9, v8, v11
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 13
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	vse32.v	v8, (a0)
	j	.LBB0_1
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
