# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: vl_non_constant
# src = pre-opt (vl_non_constant), tgt = post-opt (vl_non_constant)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	li	a0, 85
                                        # implicit-def: $v8
	vsetvli	zero, a1, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end11:
	.size	src, .Lfunc_end11-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a1, a0
	li	a0, 85
                                        # implicit-def: $v8
	vsetvli	zero, a1, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end11:
	.size	tgt, .Lfunc_end11-tgt
	.cfi_endproc
                                        # -- End function
