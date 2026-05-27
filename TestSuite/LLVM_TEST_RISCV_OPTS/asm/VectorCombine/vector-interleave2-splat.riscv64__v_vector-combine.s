# Source: VectorCombine/vector-interleave2-splat.riscv64__v_vector-combine.ll
# Function: interleave2_const_splat_nxv16i32
# src = pre-opt (interleave2_const_splat_nxv16i32), tgt = post-opt (interleave2_const_splat_nxv16i32)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a1, 666
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e32, m4, tu, ma
	vmv.v.x	v8, a1
	li	a1, 777
                                        # implicit-def: $v16m8
	vsetvli	zero, zero, e32, m4, ta, ma
	vwaddu.vx	v16, v8, a1
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e32, m4, tu, ma
	vmv.v.i	v8, -1
	vsetvli	zero, zero, e32, m4, ta, ma
	vwmaccu.vx	v16, a1, v8
	vmv4r.v	v24, v16
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v24
	vmv4r.v	v16, v20
	vmv4r.v	v12, v16
	li	a1, 88
	vsetvli	zero, a1, e32, m8, ta, ma
	vse32.v	v8, (a0)
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
# %bb.0:
	li	a1, 777
	slli	a1, a1, 32
	addi	a1, a1, 666
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v8, a1
	li	a1, 88
	vsetvli	zero, a1, e32, m8, ta, ma
	vse32.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
