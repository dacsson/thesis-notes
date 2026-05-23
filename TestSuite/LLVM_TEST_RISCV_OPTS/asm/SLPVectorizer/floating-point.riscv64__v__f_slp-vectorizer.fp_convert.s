# Source: SLPVectorizer/floating-point.riscv64__v__f_slp-vectorizer.ll
# Function: fp_convert
# src = pre-opt (fp_convert), tgt = post-opt (fp_convert)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	flw	fa2, 0(a0)
	flw	fa3, 4(a0)
	flw	fa4, 8(a0)
	flw	fa5, 12(a0)
	fcvt.w.s	a2, fa2, rtz
	feq.s	a0, fa2, fa2
	seqz	a0, a0
	addiw	a0, a0, -1
	and	a4, a0, a2
	fcvt.w.s	a2, fa3, rtz
	feq.s	a0, fa3, fa3
	seqz	a0, a0
	addiw	a0, a0, -1
	and	a3, a0, a2
	fcvt.w.s	a2, fa4, rtz
	feq.s	a0, fa4, fa4
	seqz	a0, a0
	addiw	a0, a0, -1
	and	a2, a0, a2
	fcvt.w.s	a5, fa5, rtz
	feq.s	a0, fa5, fa5
	seqz	a0, a0
	addiw	a0, a0, -1
	and	a0, a0, a5
	sw	a4, 0(a1)
	sw	a3, 4(a1)
	sw	a2, 8(a1)
	sw	a0, 12(a1)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end6:
	.size	src, .Lfunc_end6-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a1)
	vsetvli	zero, zero, e32, m1, ta, ma
	vmfne.vv	v0, v8, v8
                                        # implicit-def: $v9
	vfcvt.rtz.x.f.v	v9, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, tu, ma
	vmerge.vim	v8, v9, 0, v0
	vse32.v	v8, (a0)
	ret
.Lfunc_end6:
	.size	tgt, .Lfunc_end6-tgt
	.cfi_endproc
                                        # -- End function
