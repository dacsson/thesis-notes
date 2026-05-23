# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_ashr_add_ugt_minus1
# src = pre-opt (negative_ashr_add_ugt_minus1), tgt = post-opt (negative_ashr_add_ugt_minus1)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end51:
	.size	src, .Lfunc_end51-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a0, 0
	ret
.Lfunc_end51:
	.size	tgt, .Lfunc_end51-tgt
	.cfi_endproc
                                        # -- End function
