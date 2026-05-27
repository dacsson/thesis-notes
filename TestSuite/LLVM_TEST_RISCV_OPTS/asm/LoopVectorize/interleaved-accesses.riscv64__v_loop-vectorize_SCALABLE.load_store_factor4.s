# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_SCALABLE.ll
# Function: load_store_factor4
# src = pre-opt (load_store_factor4), tgt = post-opt (load_store_factor4)
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
	j	.LBB4_1
.LBB4_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a2, a0, 5
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
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB4_1
	j	.LBB4_2
.LBB4_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	src, .Lfunc_end4-src
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
	j	.LBB4_1
.LBB4_1:                                # %vector.ph
	li	a0, 1024
	li	a1, 0
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB4_2
.LBB4_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	slli	a4, a1, 5
	add	a3, a3, a4
	slli	a4, a2, 2
                                        # implicit-def: $v8m8
	vsetvli	zero, a4, e64, m8, tu, ma
	vle64.v	v8, (a3)
	addi	a5, sp, 32
	vsetvli	a6, zero, e64, m8, ta, ma
	vse64.v	v8, (a5)
                                        # implicit-def: $v8m2_v10m2_v12m2_v14m2
	vsetvli	a6, zero, e64, m2, ta, ma
	vlseg4e64.v	v8, (a5)
	vmv2r.v	v18, v14
	vmv2r.v	v20, v12
	vmv2r.v	v22, v10
                                        # kill: def $v8m2 killed $v8m2 killed $v8m2_v10m2_v12m2_v14m2 killed $vtype
                                        # implicit-def: $v16m2
	vadd.vi	v16, v8, 1
                                        # implicit-def: $v8m2_v10m2_v12m2_v14m2
	vmv.v.v	v8, v16
                                        # implicit-def: $v16m2
	vadd.vi	v16, v22, 2
	vmv.v.v	v10, v16
                                        # implicit-def: $v16m2
	vadd.vi	v16, v20, 3
	vmv.v.v	v12, v16
                                        # implicit-def: $v16m2
	vadd.vi	v16, v18, 4
	vmv.v.v	v14, v16
	csrr	a6, vlenb
	slli	a6, a6, 3
	add	a6, sp, a6
	addi	a6, a6, 32
	vsseg4e64.v	v8, (a6)
	csrr	a5, vlenb
	slli	t0, a5, 1
	add	a5, a6, t0
	add	a7, a5, t0
                                        # implicit-def: $v8m2
	vle64.v	v8, (a7)
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v8
	add	a7, a7, t0
                                        # implicit-def: $v8m2
	vle64.v	v8, (a7)
	vmv.v.v	v18, v8
                                        # implicit-def: $v8m2
	vle64.v	v8, (a6)
                                        # implicit-def: $v20m4
	vmv.v.v	v20, v8
                                        # implicit-def: $v8m2
	vle64.v	v8, (a5)
	vmv.v.v	v22, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v20
	vmv4r.v	v12, v16
	vsetvli	zero, a4, e64, m8, ta, ma
	vse64.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB4_2
	j	.LBB4_3
.LBB4_3:                                # %middle.block
	j	.LBB4_4
.LBB4_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 4
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end4:
	.size	tgt, .Lfunc_end4-tgt
	.cfi_endproc
                                        # -- End function
