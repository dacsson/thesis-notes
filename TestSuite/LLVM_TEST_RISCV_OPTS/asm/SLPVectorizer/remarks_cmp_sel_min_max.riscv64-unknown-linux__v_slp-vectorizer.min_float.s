# Source: SLPVectorizer/remarks_cmp_sel_min_max.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: min_float
# src = pre-opt (min_float), tgt = post-opt (min_float)
# Triple: riscv64-unknown-linux, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	flw	fa5, 40(a1)
	fmv.w.x	fa4, zero
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
	flt.s	a0, fa4, fa5
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB1_2
# %bb.1:                                # %entry
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
.LBB1_2:                                # %entry
	flw	fa4, 24(sp)                     # 4-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	fsw	fa5, 0(a1)
	flw	fa5, 44(a0)
	flt.s	a0, fa4, fa5
	fsw	fa5, 4(sp)                      # 4-byte Folded Spill
	beqz	a0, .LBB1_4
# %bb.3:                                # %entry
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
	fsw	fa5, 4(sp)                      # 4-byte Folded Spill
.LBB1_4:                                # %entry
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	flw	fa5, 4(sp)                      # 4-byte Folded Reload
	fsw	fa5, 4(a0)
                                        # implicit-def: $x10
	addi	sp, sp, 32
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
	addi	a1, a1, 40
                                        # implicit-def: $v10
	vsetivli	zero, 2, e32, mf2, tu, ma
	vle32.v	v10, (a1)
	fmv.w.x	fa5, zero
	vsetvli	zero, zero, e32, mf2, ta, ma
	vmfgt.vf	v8, v10, fa5
	vmnot.m	v0, v8
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vvm	v8, v9, v10, v0
	vse32.v	v8, (a0)
                                        # implicit-def: $x10
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
