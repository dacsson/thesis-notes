# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: eq_num_elts
# src = pre-opt (eq_num_elts), tgt = post-opt (eq_num_elts)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	lui	a0, 654150
	addi	a0, a0, -730
                                        # implicit-def: $v8m2
	vsetivli	zero, 2, e32, m2, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end14:
	.size	src, .Lfunc_end14-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 654150
	addi	a0, a0, -730
                                        # implicit-def: $v8m2
	vsetivli	zero, 2, e32, m2, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end14:
	.size	tgt, .Lfunc_end14-tgt
	.cfi_endproc
                                        # -- End function
