# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize.ll
# Function: load_store_factor8
# src = pre-opt (load_store_factor8), tgt = post-opt (load_store_factor8)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 6
	add	a2, a1, a2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	ld	a1, 0(a2)
	addi	a1, a1, 1
	sd	a1, 0(a2)
	ld	a1, 8(a2)
	addi	a1, a1, 2
	sd	a1, 8(a2)
	ld	a1, 16(a2)
	addi	a1, a1, 3
	sd	a1, 16(a2)
	ld	a1, 24(a2)
	addi	a1, a1, 4
	sd	a1, 24(a2)
	ld	a1, 32(a2)
	addi	a1, a1, 5
	sd	a1, 32(a2)
	ld	a1, 40(a2)
	addi	a1, a1, 6
	sd	a1, 40(a2)
	ld	a1, 48(a2)
	addi	a1, a1, 7
	sd	a1, 48(a2)
	ld	a1, 56(a2)
	addi	a1, a1, 8
	sd	a1, 56(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB8_1
	j	.LBB8_2
.LBB8_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
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
	csrr	a1, vlenb
	slli	a1, a1, 3
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x18, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 24 * vlenb
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB8_1
.LBB8_1:                                # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB8_2
.LBB8_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf8, ta, ma
	slli	a4, a1, 6
	add	a3, a3, a4
	slli	a4, a2, 3
                                        # implicit-def: $v8m8
	vsetvli	zero, a4, e64, m8, tu, ma
	vle64.v	v8, (a3)
	csrr	a5, vlenb
	slli	a5, a5, 3
	add	a5, sp, a5
	addi	a5, a5, 48
	vsetvli	a6, zero, e64, m8, ta, ma
	vse64.v	v8, (a5)
                                        # implicit-def: $v8_v9_v10_v11_v12_v13_v14_v15
	vsetvli	a6, zero, e64, m1, ta, ma
	vlseg8e64.v	v8, (a5)
	addi	a5, sp, 48
	vs8r.v	v8, (a5)                        # vscale x 64-byte Folded Spill
	vmv1r.v	v17, v15
	vmv1r.v	v18, v14
	vmv1r.v	v19, v13
	vmv1r.v	v20, v12
	vmv1r.v	v21, v11
	vmv1r.v	v22, v10
	vmv1r.v	v23, v9
                                        # implicit-def: $v16
	vadd.vi	v16, v8, 1
                                        # implicit-def: $v8_v9_v10_v11_v12_v13_v14_v15
	vmv.v.v	v8, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v23, 2
	vmv.v.v	v9, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v22, 3
	vmv.v.v	v10, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v21, 4
	vmv.v.v	v11, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v20, 5
	vmv.v.v	v12, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v19, 6
	vmv.v.v	v13, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v18, 7
	vmv.v.v	v14, v16
                                        # implicit-def: $v16
	vadd.vi	v16, v17, 8
	vmv.v.v	v15, v16
	csrr	a6, vlenb
	slli	a6, a6, 4
	add	a6, sp, a6
	addi	a6, a6, 48
	vsseg8e64.v	v8, (a6)
	csrr	t4, vlenb
	add	a5, a6, t4
	add	t0, a5, t4
	add	a7, t0, t4
	add	t2, a7, t4
	add	t1, t2, t4
	add	t3, t1, t4
                                        # implicit-def: $v10
	vle64.v	v10, (t3)
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
	add	t3, t3, t4
                                        # implicit-def: $v10
	vle64.v	v10, (t3)
	vmv.v.v	v9, v10
                                        # implicit-def: $v12
	vle64.v	v12, (t2)
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
                                        # implicit-def: $v12
	vle64.v	v12, (t1)
	vmv.v.v	v11, v12
                                        # implicit-def: $v16m4
	vmv2r.v	v16, v10
	vmv2r.v	v18, v8
                                        # implicit-def: $v10
	vle64.v	v10, (t0)
                                        # implicit-def: $v8m2
	vmv.v.v	v8, v10
                                        # implicit-def: $v10
	vle64.v	v10, (a7)
	vmv.v.v	v9, v10
                                        # implicit-def: $v12
	vle64.v	v12, (a6)
                                        # implicit-def: $v10m2
	vmv.v.v	v10, v12
                                        # implicit-def: $v12
	vle64.v	v12, (a5)
	vmv.v.v	v11, v12
                                        # implicit-def: $v20m4
	vmv2r.v	v20, v10
	vmv2r.v	v22, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v20
	vmv4r.v	v12, v16
	vsetvli	zero, a4, e64, m8, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB8_2
	j	.LBB8_3
.LBB8_3:                                # %middle.block
	j	.LBB8_4
.LBB8_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
