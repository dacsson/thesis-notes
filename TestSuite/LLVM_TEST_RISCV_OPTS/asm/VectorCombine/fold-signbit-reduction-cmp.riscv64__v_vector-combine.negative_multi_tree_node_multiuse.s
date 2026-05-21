# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_multi_tree_node_multiuse
# src = pre-opt (negative_multi_tree_node_multiuse), tgt = post-opt (negative_multi_tree_node_multiuse)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	addi	a1, sp, 16
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v9
	vmv1r.v	v11, v8
	addi	a1, sp, 16
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
                                        # kill: def $v13 killed $v8 killed $vtype
                                        # kill: def $v12 killed $v10 killed $vtype
                                        # kill: def $v9 killed $v11 killed $vtype
                                        # implicit-def: $v9
	vsrl.vi	v9, v11, 31
                                        # implicit-def: $v11
	vsrl.vi	v11, v10, 31
                                        # implicit-def: $v10
	vsrl.vi	v10, v8, 31
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v11
	vse32.v	v8, (a0)
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e32, m1, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a0, v8
	seqz	a0, a0
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end71:
	.size	src, .Lfunc_end71-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	addi	a1, sp, 16
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v10, v9
	vmv1r.v	v11, v8
	addi	a1, sp, 16
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
                                        # kill: def $v13 killed $v8 killed $vtype
                                        # kill: def $v12 killed $v10 killed $vtype
                                        # kill: def $v9 killed $v11 killed $vtype
                                        # implicit-def: $v9
	vsrl.vi	v9, v11, 31
                                        # implicit-def: $v11
	vsrl.vi	v11, v10, 31
                                        # implicit-def: $v10
	vsrl.vi	v10, v8, 31
                                        # implicit-def: $v8
	vadd.vv	v8, v9, v11
	vse32.v	v8, (a0)
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v9
	vmv.x.s	a0, v8
	seqz	a0, a0
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end71:
	.size	tgt, .Lfunc_end71-tgt
	.cfi_endproc
                                        # -- End function
