# Source: SLPVectorizer/check-node-without-vector-user.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a5, a0
	lui	a2, %hi(r)
	addi	a2, a2, %lo(r)
	lbu	a3, 0(a2)
	slli	a0, a3, 63
	srai	a0, a0, 63
	and	a0, a0, a5
	add	a0, a2, a0
	lbu	a0, 0(a0)
	sltu	a3, a0, a3
	lui	a0, 1048574
	add	a0, a2, a0
	lbu	a4, 143(a0)
	slli	a0, a4, 63
	srai	a0, a0, 63
	and	a0, a0, a5
	add	a0, a2, a0
	lbu	a0, 0(a0)
	sltu	a0, a0, a4
	addw	a0, a0, a3
	lui	a3, 1048572
	add	a3, a2, a3
	lbu	a4, 286(a3)
	slli	a3, a4, 63
	srai	a3, a3, 63
	and	a3, a3, a5
	add	a3, a2, a3
	lbu	a3, 0(a3)
	sltu	a3, a3, a4
	xori	a3, a3, 1
	subw	a0, a0, a3
	lui	a3, 1048570
	add	a3, a2, a3
	lbu	a3, 429(a3)
	slli	a4, a3, 63
	srai	a4, a4, 63
	and	a4, a4, a5
	add	a2, a2, a4
	lbu	a2, 0(a2)
	sltu	a2, a2, a3
	xori	a2, a2, 1
	subw	a0, a0, a2
	addiw	a0, a0, -2
	sw	a0, 0(a1)
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
	mv	a5, a0
	lui	a2, %hi(r)
	addi	a2, a2, %lo(r)
	lbu	a3, 0(a2)
	slli	a0, a3, 63
	srai	a0, a0, 63
	and	a0, a0, a5
	add	a0, a2, a0
	lbu	a0, 0(a0)
	sltu	a3, a0, a3
	lui	a0, 1048574
	add	a0, a2, a0
	lbu	a4, 143(a0)
	slli	a0, a4, 63
	srai	a0, a0, 63
	and	a0, a0, a5
	add	a0, a2, a0
	lbu	a0, 0(a0)
	sltu	a0, a0, a4
	addw	a0, a0, a3
	lui	a3, 1048572
	add	a3, a2, a3
	lbu	a4, 286(a3)
	slli	a3, a4, 63
	srai	a3, a3, 63
	and	a3, a3, a5
	add	a3, a2, a3
	lbu	a3, 0(a3)
	sltu	a3, a3, a4
	xori	a3, a3, 1
	subw	a0, a0, a3
	lui	a3, 1048570
	add	a3, a2, a3
	lbu	a3, 429(a3)
	slli	a4, a3, 63
	srai	a4, a4, 63
	and	a4, a4, a5
	add	a2, a2, a4
	lbu	a2, 0(a2)
	sltu	a2, a2, a3
	xori	a2, a2, 1
	subw	a0, a0, a2
	addiw	a0, a0, -2
	sw	a0, 0(a1)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
