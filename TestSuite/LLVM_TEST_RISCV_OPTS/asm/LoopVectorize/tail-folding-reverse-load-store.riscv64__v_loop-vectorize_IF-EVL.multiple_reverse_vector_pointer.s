# Source: LoopVectorize/tail-folding-reverse-load-store.riscv64__v_loop-vectorize_IF-EVL.ll
# Function: multiple_reverse_vector_pointer
# src = pre-opt (multiple_reverse_vector_pointer), tgt = post-opt (multiple_reverse_vector_pointer)
# Triple: riscv64, Attrs: +v
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
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	li	a0, 1024
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	add	a4, a4, a0
	lb	a4, 0(a4)
	add	a1, a1, a4
	lbu	a1, 0(a1)
	add	a3, a3, a0
	sb	a1, 0(a3)
	add	a2, a2, a0
	sb	a1, 0(a2)
	addi	a1, a0, -1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_1
	j	.LBB2_2
.LBB2_2:                                # %exit
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
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	csrr	a4, vlenb
	slli	a5, a4, 1
	add	a4, a5, a4
	sub	sp, sp, a4
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x03, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 3 * vlenb
	sd	a3, 96(sp)                      # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	j	.LBB2_1
.LBB2_1:                                # %vector.ph
	li	a0, 1025
	li	a1, 0
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	j	.LBB2_2
.LBB2_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	ld	a1, 120(sp)                     # 8-byte Folded Reload
	ld	a4, 80(sp)                      # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	sd	a4, 32(sp)                      # 8-byte Folded Spill
	vsetvli	a0, a0, e8, m2, ta, ma
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a3, 1024
	sub	a3, a3, a4
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	add	a1, a1, a3
	addi	a3, a0, -1
	sd	a3, 56(sp)                      # 8-byte Folded Spill
	vsetvli	a3, zero, e8, m2, ta, ma
	vmset.m	v8
	addi	a3, sp, 128
	vs1r.v	v8, (a3)                        # vscale x 8-byte Folded Spill
	li	a3, -1
                                        # implicit-def: $v8m2
	vsetvli	zero, a0, e8, m2, tu, ma
	vlse8.v	v8, (a1), a3
	vsetvli	a1, zero, e64, m8, ta, ma
	vmv1r.v	v10, v8
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 128
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	vmv1r.v	v8, v9
	csrr	a1, vlenb
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	sub	a4, a0, a1
	sltu	a3, a0, a4
	addi	a3, a3, -1
	and	a3, a3, a4
                                        # implicit-def: $v16m8
	vsext.vf8	v16, v8
                                        # implicit-def: $v8
	vsetvli	zero, a3, e8, m1, tu, ma
	vluxei64.v	v8, (a2), v16
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 128
	vs1r.v	v8, (a2)                        # vscale x 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB2_4
# %bb.3:                                # %vector.body
                                        #   in Loop: Header=BB2_2 Depth=1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB2_4:                                # %vector.body
                                        #   in Loop: Header=BB2_2 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	ld	a6, 104(sp)                     # 8-byte Folded Reload
	ld	t0, 112(sp)                     # 8-byte Folded Reload
	ld	a7, 72(sp)                      # 8-byte Folded Reload
	csrr	t1, vlenb
	slli	t1, t1, 1
	add	t1, sp, t1
	addi	t1, t1, 128
	vl1r.v	v8, (t1)                        # vscale x 8-byte Folded Reload
	addi	t1, sp, 128
	vl1r.v	v0, (t1)                        # vscale x 8-byte Folded Reload
	csrr	t1, vlenb
	add	t1, sp, t1
	addi	t1, t1, 128
	vl1r.v	v9, (t1)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v16m8
	vsetvli	t1, zero, e64, m8, ta, ma
	vsext.vf8	v16, v9
                                        # implicit-def: $v9
	vsetvli	zero, a7, e8, m1, ta, mu
	vluxei64.v	v9, (t0), v16, v0.t
                                        # implicit-def: $v10m2
	vsetvli	zero, a7, e8, m1, ta, mu
	vmv1r.v	v10, v9
	vsetvli	zero, a7, e8, m1, ta, mu
	vmv1r.v	v11, v8
	add	a6, a6, a5
	sub	a6, a6, a4
                                        # implicit-def: $v16m4
	vsetvli	zero, a2, e16, m4, ta, ma
	vid.v	v16
                                        # implicit-def: $v12m4
	vsetvli	zero, a2, e16, m4, ta, ma
	vrsub.vx	v12, v16, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, a2, e8, m2, ta, ma
	vrgatherei16.vv	v8, v10, v12
	vsetvli	zero, a2, e8, m2, ta, ma
	vse8.v	v8, (a6)
	add	a3, a3, a5
	sub	a3, a3, a4
	vsetvli	zero, a2, e8, m2, ta, ma
	vse8.v	v8, (a3)
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 88(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB2_2
	j	.LBB2_5
.LBB2_5:                                # %middle.block
	j	.LBB2_6
.LBB2_6:                                # %exit
	csrr	a0, vlenb
	slli	a1, a0, 1
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end2:
	.size	tgt, .Lfunc_end2-tgt
	.cfi_endproc
                                        # -- End function
