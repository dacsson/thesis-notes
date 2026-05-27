# Source: SLPVectorizer/vec3-base.riscv64__m__v_slp-vectorizer_1.ll
# Function: phi_store3
# src = pre-opt (phi_store3), tgt = post-opt (phi_store3)
# Triple: riscv64, Attrs: +m,+v
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
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %exit
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	li	a0, 1
	sw	a0, 0(a1)
	li	a0, 2
	sw	a0, 4(a1)
	li	a0, 3
	sw	a0, 8(a1)
	addi	sp, sp, 16
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB5_1
.LBB5_1:                                # %exit
	ld	a1, 8(sp)                       # 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 2, e32, mf2, ta, ma
	vid.v	v9
                                        # implicit-def: $v8
	vadd.vi	v8, v9, 1
	vse32.v	v8, (a1)
	li	a0, 3
	sw	a0, 8(a1)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end5:
	.size	tgt, .Lfunc_end5-tgt
	.cfi_endproc
                                        # -- End function
