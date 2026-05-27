# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: vl_not_divisible
# src = pre-opt (vl_not_divisible), tgt = post-opt (vl_not_divisible)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v8
	vsetivli	zero, 7, e8, mf2, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end12:
	.size	src, .Lfunc_end12-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v8
	vsetivli	zero, 7, e8, mf2, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end12:
	.size	tgt, .Lfunc_end12-tgt
	.cfi_endproc
                                        # -- End function
