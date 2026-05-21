# Source: InterleavedAccess/zve32x.riscv64__zve32x__zvl128b_interleaved-access_ZVE32X.ll
# Function: load_large_vector
# src = pre-opt (load_large_vector), tgt = post-opt (load_large_vector)
# Triple: riscv64, Attrs: +zve32x,+zvl128b
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	mv	a6, a0
	ld	a1, 80(a6)
	ld	a0, 72(a6)
	ld	a3, 56(a6)
	ld	a2, 48(a6)
	ld	a5, 8(a6)
	ld	a4, 0(a6)
	ld	a7, 32(a6)
	ld	a6, 24(a6)
	xor	a6, a6, a7
	snez	a6, a6
                                        # implicit-def: $v9
	vsetivli	zero, 1, e8, m1, tu, ma
	vmv.s.x	v9, a6
                                        # implicit-def: $v8
	vsetivli	zero, 1, e8, mf4, ta, ma
	vand.vi	v8, v9, 1
	vmsne.vi	v0, v8, 0
	li	a6, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.s.x	v10, a6
                                        # implicit-def: $v11
	vmerge.vim	v11, v10, 1, v0
	xor	a4, a4, a5
	snez	a4, a4
                                        # implicit-def: $v9
	vmv.s.x	v9, a4
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vand.vi	v8, v9, 1
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vim	v8, v9, 1, v0
	vsetivli	zero, 2, e8, mf4, tu, ma
	vslideup.vi	v8, v11, 1
	vsetivli	zero, 4, e8, mf4, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v8, v9, 1, v0
	xor	a2, a2, a3
	snez	a2, a2
                                        # implicit-def: $v12
	vmv.s.x	v12, a2
                                        # implicit-def: $v11
	vsetivli	zero, 1, e8, mf4, ta, ma
	vand.vi	v11, v12, 1
	vmsne.vi	v0, v11, 0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v11, v10, 1, v0
	vsetivli	zero, 3, e8, mf4, tu, ma
	vslideup.vi	v8, v11, 2
	vsetivli	zero, 4, e8, mf4, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v8, v9, 1, v0
	xor	a0, a0, a1
	snez	a0, a0
                                        # implicit-def: $v11
	vmv.s.x	v11, a0
                                        # implicit-def: $v9
	vsetivli	zero, 1, e8, mf4, ta, ma
	vand.vi	v9, v11, 1
	vmsne.vi	v0, v9, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v9, v10, 1, v0
	vsetivli	zero, 4, e8, mf4, ta, ma
	vslideup.vi	v8, v9, 3
	vmsne.vi	v0, v8, 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	mv	a6, a0
	ld	a1, 80(a6)
	ld	a0, 72(a6)
	ld	a3, 56(a6)
	ld	a2, 48(a6)
	ld	a5, 8(a6)
	ld	a4, 0(a6)
	ld	a7, 32(a6)
	ld	a6, 24(a6)
	xor	a6, a6, a7
	snez	a6, a6
                                        # implicit-def: $v9
	vsetivli	zero, 1, e8, m1, tu, ma
	vmv.s.x	v9, a6
                                        # implicit-def: $v8
	vsetivli	zero, 1, e8, mf4, ta, ma
	vand.vi	v8, v9, 1
	vmsne.vi	v0, v8, 0
	li	a6, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmv.s.x	v10, a6
                                        # implicit-def: $v11
	vmerge.vim	v11, v10, 1, v0
	xor	a4, a4, a5
	snez	a4, a4
                                        # implicit-def: $v9
	vmv.s.x	v9, a4
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, ta, ma
	vand.vi	v8, v9, 1
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v9
	vsetivli	zero, 4, e8, mf4, tu, ma
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vim	v8, v9, 1, v0
	vsetivli	zero, 2, e8, mf4, tu, ma
	vslideup.vi	v8, v11, 1
	vsetivli	zero, 4, e8, mf4, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v8, v9, 1, v0
	xor	a2, a2, a3
	snez	a2, a2
                                        # implicit-def: $v12
	vmv.s.x	v12, a2
                                        # implicit-def: $v11
	vsetivli	zero, 1, e8, mf4, ta, ma
	vand.vi	v11, v12, 1
	vmsne.vi	v0, v11, 0
                                        # implicit-def: $v11
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v11, v10, 1, v0
	vsetivli	zero, 3, e8, mf4, tu, ma
	vslideup.vi	v8, v11, 2
	vsetivli	zero, 4, e8, mf4, ta, ma
	vmsne.vi	v0, v8, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v8, v9, 1, v0
	xor	a0, a0, a1
	snez	a0, a0
                                        # implicit-def: $v11
	vmv.s.x	v11, a0
                                        # implicit-def: $v9
	vsetivli	zero, 1, e8, mf4, ta, ma
	vand.vi	v9, v11, 1
	vmsne.vi	v0, v9, 0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf4, tu, ma
	vmerge.vim	v9, v10, 1, v0
	vsetivli	zero, 4, e8, mf4, ta, ma
	vslideup.vi	v8, v9, 3
	vmsne.vi	v0, v8, 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
