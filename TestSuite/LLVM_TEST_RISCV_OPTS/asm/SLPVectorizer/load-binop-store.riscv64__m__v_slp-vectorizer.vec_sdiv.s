# Source: SLPVectorizer/load-binop-store.riscv64__m__v_slp-vectorizer.ll
# Function: vec_sdiv
# src = pre-opt (vec_sdiv), tgt = post-opt (vec_sdiv)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lh	a2, 0(a0)
	lh	a0, 2(a0)
	lui	a3, 5
	addi	a3, a3, -1755
	mul	a2, a2, a3
	srli	a4, a2, 63
	srli	a2, a2, 17
	addw	a2, a2, a4
	mul	a0, a0, a3
	srli	a3, a0, 63
	srli	a0, a0, 17
	addw	a0, a0, a3
	sh	a2, 0(a1)
	sh	a0, 2(a1)
	addi	sp, sp, 16
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
                                        # implicit-def: $v9
	vsetivli	zero, 2, e16, mf4, tu, ma
	vle16.v	v9, (a1)
	lui	a1, 5
	addi	a1, a1, -1755
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, ta, ma
	vmulh.vx	v8, v9, a1
                                        # implicit-def: $v9
	vsra.vi	v9, v8, 1
                                        # implicit-def: $v10
	vsrl.vi	v10, v9, 15
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v10
	vse16.v	v8, (a0)
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
