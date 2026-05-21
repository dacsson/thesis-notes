# Source: SLPVectorizer/segmented-stores.riscv64-unknown-linux__v_slp-vectorizer.ll
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	mv	a1, a0
	ld	a0, 0(sp)
	srli	a2, a0, 48
	sh	a2, 6(a1)
	srli	a2, a0, 32
	sh	a2, 4(a1)
	sh	a0, 0(a1)
	srli	a0, a0, 16
	sh	a0, 2(a1)
	lwu	a0, 16(sp)
	lwu	a2, 20(sp)
	sh	a2, 12(a1)
	srli	a2, a2, 16
	sh	a2, 14(a1)
	sh	a0, 8(a1)
	srli	a0, a0, 16
	sh	a0, 10(a1)
	lhu	a0, 8(sp)
	lhu	a2, 10(sp)
	lhu	a3, 12(sp)
	lhu	a4, 14(sp)
	sh	a4, 22(a1)
	sh	a3, 20(a1)
	sh	a2, 18(a1)
	sh	a0, 16(a1)
	lhu	a0, 24(sp)
	lhu	a2, 26(sp)
	lhu	a3, 28(sp)
	lhu	a4, 30(sp)
	sh	a4, 30(a1)
	sh	a3, 28(a1)
	sh	a2, 26(a1)
	sh	a0, 24(a1)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	mv	a1, sp
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e32, m1, tu, ma
	vle64.v	v10, (a1)
	lui	a1, 12304
	addi	a1, a1, 512
                                        # implicit-def: $v8
	vmv.s.x	v8, a1
                                        # implicit-def: $v12
	vsetvli	zero, zero, e16, mf2, ta, ma
	vsext.vf2	v12, v8
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vrgatherei16.vv	v8, v10, v12
	vse64.v	v8, (a0)
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
