# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: target_vl_two
# src = pre-opt (target_vl_two), tgt = post-opt (target_vl_two)
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
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 5
	addi	a0, a0, 1365
                                        # implicit-def: $v8
	vsetivli	zero, 2, e16, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
