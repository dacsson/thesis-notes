# Source: SLPVectorizer/revec.riscv64_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	lui	a0, 16
	addi	a1, a0, -1500
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	addi	a0, a0, -1472
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %if.end.i87
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	lw	a2, 4(a1)
	lw	a1, 0(a1)
	lw	a1, 4(a0)
	lw	a0, 0(a0)
	li	a0, 1
	bnez	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %if.end.i87
	li	a0, 0
	bnez	a0, .LBB0_4
	j	.LBB0_4
.LBB0_3:                                # %if.then458.i
	j	.LBB0_4
.LBB0_4:                                # %sw.bb509.i
	li	a0, 0
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	j	.LBB0_1
.LBB0_1:                                # %if.end.i87
	lui	a0, %hi(.LCPI0_0)
	addi	a0, a0, %lo(.LCPI0_0)
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, mf2, tu, ma
	vle16.v	v8, (a0)
	li	a0, 0
                                        # implicit-def: $v9
	vluxei16.v	v9, (a0), v8
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vmv.v.i	v8, 0
	vsetivli	zero, 2, e32, mf2, tu, ma
	vmv.v.v	v8, v9
	li	a0, 1
	bnez	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %if.end.i87
	li	a0, 0
	bnez	a0, .LBB0_4
	j	.LBB0_4
.LBB0_3:                                # %if.then458.i
	j	.LBB0_4
.LBB0_4:                                # %sw.bb509.i
	li	a0, 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
