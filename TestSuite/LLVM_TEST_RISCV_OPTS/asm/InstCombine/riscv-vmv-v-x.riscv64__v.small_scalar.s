# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: small_scalar
# src = pre-opt (small_scalar), tgt = post-opt (small_scalar)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.i	v8, 3
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 12336
	addi	a0, a0, 771
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.s.x	v8, a0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
