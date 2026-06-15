# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: target_vl_one
# src = pre-opt (target_vl_one), tgt = post-opt (target_vl_one)
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
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 349525
	addi	a0, a0, 1365
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, tu, ma
	vmv.s.x	v8, a0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
