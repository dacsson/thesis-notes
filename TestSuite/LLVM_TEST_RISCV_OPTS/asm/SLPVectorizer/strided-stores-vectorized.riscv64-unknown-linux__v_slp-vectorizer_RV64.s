# Source: SLPVectorizer/strided-stores-vectorized.riscv64-unknown-linux__v_slp-vectorizer_RV64.ll
# Function: store_reverse
# src = pre-opt (store_reverse), tgt = post-opt (store_reverse)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	ld	a0, 0(a1)
	ld	a2, 64(a1)
	sll	a0, a0, a2
	sd	a0, 56(a1)
	ld	a0, 8(a1)
	ld	a2, 72(a1)
	sll	a0, a0, a2
	sd	a0, 48(a1)
	ld	a0, 16(a1)
	ld	a2, 80(a1)
	sll	a0, a0, a2
	sd	a0, 40(a1)
	ld	a0, 24(a1)
	ld	a2, 88(a1)
	sll	a0, a0, a2
	sd	a0, 32(a1)
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
	mv	a2, a0
	addi	a1, a2, 64
	addi	a0, a2, 56
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v10, (a2)
                                        # implicit-def: $v12m2
	vle64.v	v12, (a1)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vsll.vv	v8, v10, v12
	li	a1, -8
	vsse64.v	v8, (a0), a1
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
