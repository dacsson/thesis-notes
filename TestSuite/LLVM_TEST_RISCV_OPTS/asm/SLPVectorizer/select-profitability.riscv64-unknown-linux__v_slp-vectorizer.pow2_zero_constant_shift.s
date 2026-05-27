# Source: SLPVectorizer/select-profitability.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: pow2_zero_constant_shift
# src = pre-opt (pow2_zero_constant_shift), tgt = post-opt (pow2_zero_constant_shift)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a3, 0(sp)                       # 8-byte Folded Spill
	mv	a3, a2
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	mv	a3, a1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, -1
	seqz	a0, a0
	addi	a3, a3, -1
	seqz	a3, a3
	addi	a1, a1, -1
	seqz	a1, a1
	addi	a2, a2, -1
	seqz	a2, a2
	or	a0, a0, a3
	or	a1, a1, a2
	or	a0, a0, a1
	slli	a0, a0, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
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
# %bb.0:
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv.v.x	v9, a0
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a1
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a2
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a3
	vsetvli	zero, zero, e16, mf2, ta, ma
	vmseq.vi	v0, v8, 1
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vim	v8, v9, 1, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vsll.vi	v9, v8, 16
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
