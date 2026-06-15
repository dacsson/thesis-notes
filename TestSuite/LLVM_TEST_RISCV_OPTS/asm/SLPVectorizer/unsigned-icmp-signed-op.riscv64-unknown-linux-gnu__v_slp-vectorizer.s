# Source: SLPVectorizer/unsigned-icmp-signed-op.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	lhu	a1, 0(a1)
	slli	a0, a0, 48
	srai	a0, a0, 48
	sltu	a0, a0, a1
	xori	a0, a0, 1
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
	lh	a0, 0(a0)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e16, mf2, tu, ma
	vmv.v.i	v9, 0
	vmv1r.v	v10, v9
	vmv.s.x	v10, a1
	vmv.s.x	v9, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vzext.vf2	v8, v9
                                        # implicit-def: $v9
	vsext.vf2	v9, v10
	vmsleu.vv	v8, v8, v9
	vmnot.m	v8, v8
	vcpop.m	a0, v8
	seqz	a0, a0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
