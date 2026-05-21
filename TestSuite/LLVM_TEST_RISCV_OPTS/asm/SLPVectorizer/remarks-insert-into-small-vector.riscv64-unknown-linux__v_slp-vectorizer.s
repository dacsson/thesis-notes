# Source: SLPVectorizer/remarks-insert-into-small-vector.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	flw	fa5, 0(zero)
	fmv.w.x	fa4, zero
	fmin.s	fa5, fa5, fa4
	li	a0, 0
	sw	a0, 0(zero)
	fsw	fa5, 4(zero)
	sw	a0, 8(zero)
	sw	a0, 12(zero)
	ret
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a0, vlenb
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	flw	fa5, 0(zero)
                                        # implicit-def: $v12
	vsetivli	zero, 2, e8, mf8, tu, ma
	vmv.v.i	v12, 0
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, mf2, tu, ma
	vluxei8.v	v10, (a0), v12
	vmv1r.v	v8, v10
                                        # implicit-def: $v9
	vfmv.v.f	v9, fa5
	fmv.w.x	fa5, zero
                                        # implicit-def: $v11
	vfslide1down.vf	v11, v9, fa5
	vmv1r.v	v9, v11
	vsetvli	zero, zero, e32, mf2, ta, ma
	vmflt.vv	v0, v10, v11
	addi	a1, sp, 16
	vs1r.v	v0, (a1)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v11
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.i	v11, 0
                                        # implicit-def: $v10
	vmerge.vim	v10, v11, 1, v0
	addi	a1, sp, 16
	vl1r.v	v0, (a1)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v11
	vsetivli	zero, 2, e8, mf8, tu, ma
	vmerge.vim	v11, v12, 1, v0
	vsetivli	zero, 4, e8, mf4, ta, ma
	vslideup.vi	v10, v11, 2
	vmsne.vi	v0, v10, 0
	vsetvli	zero, zero, e32, m1, ta, ma
	vslideup.vi	v8, v9, 2
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.v.i	v9, 0
	vmv1r.v	v10, v9
	vsetivli	zero, 3, e32, m1, tu, ma
	vmv.v.v	v10, v8
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	vse32.v	v8, (a0)
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
