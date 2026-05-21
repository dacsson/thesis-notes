# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: multi_and_lshr_eq_1
# src = pre-opt (multi_and_lshr_eq_1), tgt = post-opt (multi_and_lshr_eq_1)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v9
	vmv1r.v	v9, v8
                                        # kill: def $v11 killed $v10 killed $vtype
                                        # kill: def $v8 killed $v9 killed $vtype
                                        # implicit-def: $v8
	vand.vv	v8, v9, v10
                                        # implicit-def: $v9
	vsrl.vi	v9, v8, 31
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v9
	vmv.x.s	a0, v8
	addi	a0, a0, -1
	seqz	a0, a0
	ret
.Lfunc_end59:
	.size	src, .Lfunc_end59-src
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
	addi	a0, sp, 16
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v8
	addi	a0, sp, 16
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
                                        # kill: def $v11 killed $v8 killed $vtype
                                        # kill: def $v9 killed $v10 killed $vtype
                                        # implicit-def: $v9
	vand.vv	v9, v8, v10
                                        # implicit-def: $v8
	vredand.vs	v8, v9, v9
	vmv.x.s	a0, v8
	srli	a0, a0, 63
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end59:
	.size	tgt, .Lfunc_end59-tgt
	.cfi_endproc
                                        # -- End function
