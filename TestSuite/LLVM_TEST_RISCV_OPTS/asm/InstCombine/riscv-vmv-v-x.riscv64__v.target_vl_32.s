# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: target_vl_32
# src = pre-opt (target_vl_32), tgt = post-opt (target_vl_32)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a1, 128
	li	a0, 85
                                        # implicit-def: $v8
	vsetvli	zero, a1, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 349525
	addi	a0, a0, 1365
	li	a1, 32
                                        # implicit-def: $v8
	vsetvli	zero, a1, e32, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
