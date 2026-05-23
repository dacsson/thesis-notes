# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: bitcast_target_elt_type_too_large
# src = pre-opt (bitcast_target_elt_type_too_large), tgt = post-opt (bitcast_target_elt_type_too_large)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v8
	vsetivli	zero, 4, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
