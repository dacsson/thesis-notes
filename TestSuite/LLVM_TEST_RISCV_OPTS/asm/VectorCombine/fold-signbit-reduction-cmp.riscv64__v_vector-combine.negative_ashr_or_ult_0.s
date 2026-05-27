# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_ashr_or_ult_0
# src = pre-opt (negative_ashr_or_ult_0), tgt = post-opt (negative_ashr_or_ult_0)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end53:
	.size	src, .Lfunc_end53-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end53:
	.size	tgt, .Lfunc_end53-tgt
	.cfi_endproc
                                        # -- End function
