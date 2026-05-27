# Source: VectorCombine/binop-scalarize.riscv64__v.ll
# Function: add_constant_load
# src = pre-opt (add_constant_load), tgt = post-opt (add_constant_load)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	lw	a0, 0(a0)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.s.x	v9, a0
	li	a0, 42
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vx	v8, v9, a0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	lw	a0, 0(a0)
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.s.x	v9, a0
	li	a0, 42
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vx	v8, v9, a0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
