# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_1.ll
# Function: constant_stride_reinterpret
# src = pre-opt (constant_stride_reinterpret), tgt = post-opt (constant_stride_reinterpret)
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
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB9_1
.LBB9_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a1, a1, a3
	ld	a1, 0(a1)
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB9_1
	j	.LBB9_2
.LBB9_2:                                # %exit
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	.cfi_offset ra, -8
	csrr	a2, vlenb
	slli	a2, a2, 2
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 4 * vlenb
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	srli	a1, a0, 3
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	srli	a1, a0, 1
	li	a2, 0
	li	a0, 1024
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB9_4
	j	.LBB9_1
.LBB9_1:                                # %vector.ph
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 1
	sd	a1, 32(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v8, a1
	addi	a1, sp, 112
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	slli	a1, a0, 2
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	call	__umoddi3
	mv	a1, a0
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sub	a0, a0, a1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
                                        # implicit-def: $v8m2
	vsetvli	a1, zero, e64, m2, ta, ma
	vid.v	v8
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 112
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB9_2
.LBB9_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	csrr	a6, vlenb
	slli	a6, a6, 1
	add	a6, sp, a6
	addi	a6, a6, 112
	vl2r.v	v14, (a6)                       # vscale x 16-byte Folded Reload
	addi	a6, sp, 112
	vl2r.v	v12, (a6)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v10m2
	vadd.vv	v10, v14, v12
                                        # implicit-def: $v8m2
	vsll.vi	v8, v14, 2
                                        # implicit-def: $v16m2
	vsll.vi	v16, v10, 2
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e64, m2, tu, ma
	vluxei64.v	v14, (a5), v8
                                        # implicit-def: $v8m2
	vluxei64.v	v8, (a5), v16
	slli	a5, a0, 3
	add	a4, a4, a5
	slli	a3, a3, 3
	add	a3, a4, a3
	vse64.v	v14, (a4)
	vse64.v	v8, (a3)
	add	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vadd.vv	v8, v10, v12
	mv	a2, a0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 112
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB9_2
	j	.LBB9_3
.LBB9_3:                                # %middle.block
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	li	a1, 1024
	mv	a2, a0
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	beq	a0, a1, .LBB9_6
	j	.LBB9_4
.LBB9_4:                                # %scalar.ph
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB9_5
.LBB9_5:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	slli	a3, a0, 2
	add	a1, a1, a3
	ld	a1, 0(a1)
	slli	a3, a0, 3
	add	a2, a2, a3
	sd	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB9_5
	j	.LBB9_6
.LBB9_6:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
