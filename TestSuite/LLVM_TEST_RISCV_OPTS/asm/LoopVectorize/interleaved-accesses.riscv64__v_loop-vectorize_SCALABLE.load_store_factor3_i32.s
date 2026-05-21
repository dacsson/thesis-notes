# Source: LoopVectorize/interleaved-accesses.riscv64__v_loop-vectorize_SCALABLE.ll
# Function: load_store_factor3_i32
# src = pre-opt (load_store_factor3_i32), tgt = post-opt (load_store_factor3_i32)
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
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a3, a0, 2
	slli	a2, a0, 3
	add	a2, a2, a3
	add	a2, a1, a2
	lw	a1, 0(a2)
	addiw	a1, a1, 1
	sw	a1, 0(a2)
	lw	a1, 4(a2)
	addiw	a1, a1, 2
	sw	a1, 4(a2)
	lw	a1, 8(a2)
	addiw	a1, a1, 3
	sw	a1, 8(a2)
	addi	a0, a0, 1
	li	a1, 1024
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
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a2, a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x0e, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 14 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	li	a0, 1024
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
	slli	a5, a1, 2
	slli	a4, a1, 3
	add	a4, a4, a5
	add	a3, a3, a4
	slli	a4, a2, 1
	add	a4, a4, a2
                                        # implicit-def: $v24m8
	vsetvli	zero, a4, e32, m8, tu, ma
	vle32.v	v24, (a3)
	vsetvli	a5, zero, e32, m8, ta, ma
	vmv2r.v	v20, v28
	vmv2r.v	v8, v26
	vmv4r.v	v16, v24
	vmv2r.v	v18, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v16
                                        # implicit-def: $v16m4
	vmv2r.v	v16, v20
	vmv4r.v	v12, v16
	addi	a5, sp, 32
	vse32.v	v8, (a5)
                                        # implicit-def: $v8m2_v10m2_v12m2
	vsetvli	a6, zero, e32, m2, ta, ma
	vlseg3e32.v	v8, (a5)
	vmv2r.v	v16, v12
	vmv2r.v	v18, v10
                                        # kill: def $v8m2 killed $v8m2 killed $v8m2_v10m2_v12m2 killed $vtype
                                        # implicit-def: $v14m2
	vadd.vi	v14, v8, 1
                                        # implicit-def: $v8m2_v10m2_v12m2
	vmv.v.v	v8, v14
                                        # implicit-def: $v14m2
	vadd.vi	v14, v18, 2
	vmv.v.v	v10, v14
                                        # implicit-def: $v14m2
	vadd.vi	v14, v16, 3
	vmv.v.v	v12, v14
	csrr	a5, vlenb
	slli	a5, a5, 3
	add	a5, sp, a5
	addi	a5, a5, 32
	vsseg3e32.v	v8, (a5)
                                        # implicit-def: $v8m2
	vle32.v	v8, (a5)
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v8
	csrr	a6, vlenb
	slli	a6, a6, 1
	add	a5, a5, a6
                                        # implicit-def: $v8m2
	vle32.v	v8, (a5)
	vmv.v.v	v18, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v16
	add	a5, a5, a6
                                        # implicit-def: $v20m2
	vle32.v	v20, (a5)
                                        # implicit-def: $v16m4
	vmv.v.v	v16, v20
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
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
