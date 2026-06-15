# Source: LoopVectorize/transform-narrow-interleave-to-widen-memory.riscv64__v.ll
# Function: load_store_interleave_group_i32
# src = pre-opt (load_store_interleave_group_i32), tgt = post-opt (load_store_interleave_group_i32)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	a0, a0, 1
	li	a1, 100
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
	addi	sp, sp, 16
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
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	slli	a1, a1, 4
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 16 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	li	a0, 100
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 4
	add	a3, a3, a4
	slli	a4, a2, 2
                                        # implicit-def: $v8m8
	vsetvli	zero, a4, e32, m8, tu, ma
	vle32.v	v8, (a3)
	addi	a5, sp, 32
	vsetvli	a6, zero, e32, m8, ta, ma
	vse32.v	v8, (a5)
                                        # implicit-def: $v16m2_v18m2_v20m2_v22m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vlseg4e32.v	v16, (a5)
	vmv2r.v	v24, v16
                                        # implicit-def: $v8m2_v10m2_v12m2_v14m2
	vmv2r.v	v8, v24
	vmv2r.v	v24, v18
	vmv2r.v	v10, v24
	vmv2r.v	v24, v20
	vmv2r.v	v12, v24
	vmv2r.v	v16, v22
	vmv2r.v	v14, v16
	csrr	a6, vlenb
	slli	a6, a6, 3
	add	a6, sp, a6
	addi	a6, a6, 32
	vsseg4e32.v	v8, (a6)
	csrr	a5, vlenb
	slli	t0, a5, 1
	add	a5, a6, t0
	add	a7, a5, t0
                                        # implicit-def: $v8m2
	vle32.v	v8, (a7)
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v8
	add	a7, a7, t0
                                        # implicit-def: $v8m2
	vle32.v	v8, (a7)
	vmv.v.v	v18, v8
                                        # implicit-def: $v8m2
	vle32.v	v8, (a6)
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v8
                                        # implicit-def: $v8m2
	vle32.v	v8, (a5)
	vmv.v.v	v22, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v20
	vmv4r.v	v12, v16
	vsetvli	zero, a4, e32, m8, ta, ma
	vse32.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_3
.LBB2_3:                                # %middle.block
	j	.LBB2_4
.LBB2_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 4
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
