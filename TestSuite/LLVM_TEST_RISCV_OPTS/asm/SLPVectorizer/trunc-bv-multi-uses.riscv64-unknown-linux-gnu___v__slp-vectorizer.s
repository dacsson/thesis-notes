# Source: SLPVectorizer/trunc-bv-multi-uses.riscv64-unknown-linux-gnu___v__slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: "+v"
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	srli	a3, a0, 32
	srli	a2, a1, 32
	addw	a0, a0, a3
	addw	a1, a1, a2
	call	__muldi3
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
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
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
                                        # implicit-def: $v8
	vsetivli	zero, 2, e64, m1, tu, ma
	vmv.v.x	v8, a0
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vnsrl.wi	v8, v9, 0
	li	a0, 32
                                        # implicit-def: $v10
	vnsrl.wx	v10, v9, a0
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	vmv.x.s	a0, v9
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, mf2, ta, ma
	vslidedown.vi	v8, v9, 1
	vmv.x.s	a1, v8
	call	__muldi3
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
