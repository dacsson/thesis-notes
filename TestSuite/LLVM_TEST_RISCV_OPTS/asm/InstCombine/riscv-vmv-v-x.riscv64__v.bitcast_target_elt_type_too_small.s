# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: bitcast_target_elt_type_too_small
# src = pre-opt (bitcast_target_elt_type_too_small), tgt = post-opt (bitcast_target_elt_type_too_small)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v0
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v0, a0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v0
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v0, a0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
