# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: scalar_non_constant
# src = pre-opt (scalar_non_constant), tgt = post-opt (scalar_non_constant)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
