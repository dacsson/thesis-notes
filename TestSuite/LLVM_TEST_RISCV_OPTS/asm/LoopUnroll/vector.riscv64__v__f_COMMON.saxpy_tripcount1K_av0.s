# Source: LoopUnroll/vector.riscv64__v__f_COMMON.ll
# Function: saxpy_tripcount1K_av0
# src = pre-opt (saxpy_tripcount1K_av0), tgt = post-opt (saxpy_tripcount1K_av0)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 1 * vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v8, fa0
	li	a0, 0
	addi	a1, sp, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 48
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	slli	a2, a0, 2
	add	a3, a3, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, tu, ma
	vle32.v	v8, (a3)
	add	a1, a1, a2
                                        # implicit-def: $v10
	vle32.v	v10, (a1)
	vsetvli	zero, zero, e32, m1, ta, ma
	vfmadd.vv	v8, v9, v10
	vse32.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	src, .Lfunc_end2-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 1 * vlenb
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vfmv.v.f	v8, fa0
	li	a0, 0
	addi	a1, sp, 48
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 48
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	slli	a2, a0, 2
	add	a3, a3, a2
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, tu, ma
	vle32.v	v8, (a3)
	add	a1, a1, a2
                                        # implicit-def: $v10
	vle32.v	v10, (a1)
	vsetvli	zero, zero, e32, m1, ta, ma
	vfmadd.vv	v8, v9, v10
	vse32.v	v8, (a1)
	addi	a0, a0, 4
	li	a1, 1024
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
