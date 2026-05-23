# Source: VectorCombine/fold-reduce-add-cmp-zero.riscv64__v_vector-combine.ll
# Function: nn_sge_0_tautological
# src = pre-opt (nn_sge_0_tautological), tgt = post-opt (nn_sge_0_tautological)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a0, vlenb
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv1r.v	v9, v8
	addi	a0, sp, 16
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
                                        # kill: def $v8 killed $v0 killed $vtype
                                        # implicit-def: $v9
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vim	v8, v9, 1, v0
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vmerge.vim	v10, v9, 1, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	srli	a0, a0, 63
	xori	a0, a0, 1
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a0, vlenb
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv1r.v	v9, v8
	addi	a0, sp, 16
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
                                        # kill: def $v8 killed $v0 killed $vtype
                                        # implicit-def: $v9
	vmv.v.i	v9, 0
                                        # implicit-def: $v8
	vmerge.vim	v8, v9, 1, v0
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v10
	vmerge.vim	v10, v9, 1, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vadd.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	srli	a0, a0, 63
	xori	a0, a0, 1
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
