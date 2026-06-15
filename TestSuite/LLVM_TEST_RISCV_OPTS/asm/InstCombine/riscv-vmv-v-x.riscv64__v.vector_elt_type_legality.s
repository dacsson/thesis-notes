# Source: InstCombine/riscv-vmv-v-x.riscv64__v.ll
# Function: vector_elt_type_legality
# src = pre-opt (vector_elt_type_legality), tgt = post-opt (vector_elt_type_legality)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 85
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, m1, tu, ma
	vmv.v.x	v8, a0
	ret
.Lfunc_end13:
	.size	src, .Lfunc_end13-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lui	a0, 349525
	addi	a0, a0, 1365
	slli	a1, a0, 32
	add	a0, a0, a1
                                        # implicit-def: $v8
	vsetivli	zero, 1, e64, m1, tu, ma
	vmv.s.x	v8, a0
	ret
.Lfunc_end13:
	.size	tgt, .Lfunc_end13-tgt
	.cfi_endproc
                                        # -- End function
