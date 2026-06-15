# Source: VectorCombine/icmp-vector-reduce.riscv64__v_vector-combine.ll
# Function: or_zext_two_blocks
# src = pre-opt (or_zext_two_blocks), tgt = post-opt (or_zext_two_blocks)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a0, vlenb
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 1 * vlenb
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vzext.vf2	v8, v9
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	slli	a0, a0, 48
	bnez	a0, .LBB41_2
	j	.LBB41_1
.LBB41_1:                               # %then
	addi	a0, sp, 32
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	call	foo
	j	.LBB41_2
.LBB41_2:                               # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end41:
	.size	src, .Lfunc_end41-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a0, vlenb
	sub	sp, sp, a0
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 1 * vlenb
	vsetivli	zero, 4, e32, m1, ta, ma
	vmv1r.v	v9, v8
                                        # kill: def $v8 killed $v9 killed $vtype
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vzext.vf2	v8, v9
	addi	a0, sp, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	slli	a0, a0, 48
	bnez	a0, .LBB41_2
	j	.LBB41_1
.LBB41_1:                               # %then
	addi	a0, sp, 32
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	call	foo
	j	.LBB41_2
.LBB41_2:                               # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end41:
	.size	tgt, .Lfunc_end41-tgt
	.cfi_endproc
                                        # -- End function
