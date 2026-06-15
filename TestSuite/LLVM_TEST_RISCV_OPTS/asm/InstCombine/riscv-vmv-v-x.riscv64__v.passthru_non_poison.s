# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: passthru_non_poison
# src = pre-opt (passthru_non_poison), tgt = post-opt (passthru_non_poison)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 85
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a0, 85
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
