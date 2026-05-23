# Source: VectorCombine/vector-interleave2-splat-e64.riscv64__v_vector-combine.ll
# Function: interleave2_const_splat_nxv8i64
# src = pre-opt (interleave2_const_splat_nxv8i64), tgt = post-opt (interleave2_const_splat_nxv8i64)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	csrr	a1, vlenb
	srli	a1, a1, 1
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e16, m2, ta, mu
	vid.v	v10
                                        # implicit-def: $v24m2
	vsrl.vi	v24, v10, 1
                                        # implicit-def: $v8m2
	vand.vi	v8, v10, 1
	vmsne.vi	v0, v8, 0
	vadd.vx	v24, v24, a1, v0.t
	li	a1, 777
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
	li	a1, 666
                                        # implicit-def: $v16m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v16, a1
	vmv4r.v	v20, v8
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
	li	a1, 88
	vsetvli	zero, a1, e64, m8, ta, ma
	vse64.v	v8, (a0)
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
	csrr	a1, vlenb
	srli	a1, a1, 1
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e16, m2, ta, mu
	vid.v	v10
                                        # implicit-def: $v24m2
	vsrl.vi	v24, v10, 1
                                        # implicit-def: $v8m2
	vand.vi	v8, v10, 1
	vmsne.vi	v0, v8, 0
	vadd.vx	v24, v24, a1, v0.t
	li	a1, 777
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, tu, ma
	vmv.v.x	v8, a1
	li	a1, 666
                                        # implicit-def: $v16m8
	vsetvli	a2, zero, e64, m8, tu, ma
	vmv.v.x	v16, a1
	vmv4r.v	v20, v8
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e64, m8, ta, ma
	vrgatherei16.vv	v8, v16, v24
	li	a1, 88
	vsetvli	zero, a1, e64, m8, ta, ma
	vse64.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
