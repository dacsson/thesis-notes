# Source: VectorCombine/load-widening.riscv32__v_vector-combine.ll
# Function: fixed_load_scalable_src
# src = pre-opt (fixed_load_scalable_src), tgt = post-opt (fixed_load_scalable_src)
# Triple: riscv32, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetvli	a1, zero, e16, m1, tu, ma
	vmv.v.i	v8, 0
	vse16.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v8
	vsetvli	a1, zero, e16, m1, tu, ma
	vmv.v.i	v8, 0
	vse16.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
