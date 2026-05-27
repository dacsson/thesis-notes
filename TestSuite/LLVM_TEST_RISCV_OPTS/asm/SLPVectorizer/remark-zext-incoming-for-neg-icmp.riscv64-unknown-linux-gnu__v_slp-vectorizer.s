# Source: SLPVectorizer/remark-zext-incoming-for-neg-icmp.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a4, a0
	addiw	a3, a2, -3
	addiw	a0, a2, -1
	zext.b	a0, a0
	slli	a1, a1, 56
	srai	a1, a1, 56
	slt	a0, a1, a0
	xori	a0, a0, 1
	addw	a0, a0, a4
	addiw	a4, a2, -2
	zext.b	a4, a4
	slt	a4, a1, a4
	xori	a4, a4, 1
	addw	a0, a0, a4
	zext.b	a3, a3
	slt	a3, a1, a3
	xori	a3, a3, 1
	addw	a0, a0, a3
	addiw	a2, a2, -4
	zext.b	a2, a2
	slt	a1, a1, a2
	xori	a1, a1, 1
	addw	a0, a0, a1
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, ta, ma
	vid.v	v9
                                        # implicit-def: $v8
	vrsub.vi	v8, v9, -1
                                        # implicit-def: $v9
	vadd.vx	v9, v8, a2
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.v.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vzext.vf2	v8, v9
                                        # implicit-def: $v9
	vsext.vf2	v9, v10
	vmsle.vv	v8, v8, v9
	vcpop.m	a0, v8
	addw	a0, a0, a1
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
