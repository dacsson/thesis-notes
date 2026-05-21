# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: negative_scalar
# src = pre-opt (negative_scalar), tgt = post-opt (negative_scalar)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.i	v8, -4
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 1036240
	addi	a0, a0, -772
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.s.x	v8, a0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
