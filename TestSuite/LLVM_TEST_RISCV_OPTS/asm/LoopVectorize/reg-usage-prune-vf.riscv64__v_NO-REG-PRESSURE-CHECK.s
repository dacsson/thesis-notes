# Source: LoopVectorize/reg-usage-prune-vf.riscv64__v_NO-REG-PRESSURE-CHECK.ll
# Function: f
# src = pre-opt (f), tgt = post-opt (f)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	a0, 0
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 0(sp)                       # 8-byte Folded Reload
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	add	a6, a3, a4
	lbu	a7, -1(a6)
	add	a6, a2, a4
	lbu	a6, -1(a6)
	add	a4, a1, a4
	lbu	a4, -1(a4)
	slli	t0, a0, 1
	add	t0, t0, a0
	add	a5, a5, t0
	sb	a7, 0(a5)
	sb	a6, 1(a5)
	sb	a4, 2(a5)
	addi	a5, a0, 1
	addi	a4, a3, 2
	addi	a3, a2, 3
	addi	a2, a1, 4
	li	a1, 1024
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	sd	a4, 24(sp)                      # 8-byte Folded Spill
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	mv	a3, a2
	slli	a2, a2, 1
	add	a3, a3, a2
	slli	a2, a2, 2
	add	a3, a3, a2
	slli	a2, a2, 2
	add	a2, a2, a3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x2b, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 43 * vlenb
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
                                        # implicit-def: $v0m8
	vsetvli	a0, zero, e64, m8, ta, ma
	vid.v	v0
                                        # implicit-def: $v24m8
	vadd.vv	v24, v0, v0
	li	a0, 3
                                        # implicit-def: $v16m8
	vmul.vx	v16, v0, a0
                                        # implicit-def: $v8m8
	vsll.vi	v8, v0, 2
	li	a0, 1025
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 4
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v24, (a1)                       # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 3
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 5
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a6, 48(sp)                      # 8-byte Folded Reload
	ld	a7, 56(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 5
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v0, (a2)                        # vscale x 64-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 3
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v8, (a2)                        # vscale x 64-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 4
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, sp, a2
	addi	a2, a2, 64
	vs8r.v	v8, (a2)                        # vscale x 64-byte Folded Spill
	addi	a2, sp, 64
	vs8r.v	v16, (a2)                       # vscale x 64-byte Folded Spill
	vsetvli	a5, a0, e8, m1, ta, ma
	sd	a5, 24(sp)                      # 8-byte Folded Spill
	slli	a2, a5, 2
	slli	a4, a5, 1
	add	a3, a4, a5
                                        # implicit-def: $v24m8
	vsetvli	t0, zero, e64, m8, ta, ma
	vadd.vi	v24, v16, -1
                                        # implicit-def: $v16
	vsetvli	zero, a5, e8, m1, tu, ma
	vluxei64.v	v16, (a7), v24
                                        # implicit-def: $v24_v25_v26
	vsetvli	t0, zero, e64, m8, ta, ma
	vmv1r.v	v24, v16
                                        # implicit-def: $v16m8
	vadd.vi	v16, v8, -1
                                        # implicit-def: $v8
	vsetvli	zero, a5, e8, m1, tu, ma
	vluxei64.v	v8, (a7), v16
	addi	t0, sp, 64
	vl8r.v	v16, (t0)                       # vscale x 64-byte Folded Reload
	vsetvli	t0, zero, e64, m8, ta, ma
	vmv1r.v	v25, v8
                                        # implicit-def: $v8m8
	vadd.vi	v8, v0, -1
                                        # implicit-def: $v27
	vsetvli	zero, a5, e8, m1, tu, ma
	vluxei64.v	v27, (a7), v8
	csrr	a7, vlenb
	slli	a7, a7, 3
	add	a7, sp, a7
	addi	a7, a7, 64
	vl8r.v	v8, (a7)                        # vscale x 64-byte Folded Reload
	vsetvli	a7, zero, e8, m1, ta, ma
	vmv1r.v	v26, v27
	slli	a7, a1, 1
	add	a7, a7, a1
	add	a6, a6, a7
	csrr	a7, vlenb
	slli	a7, a7, 3
	mv	t0, a7
	slli	a7, a7, 2
	add	a7, a7, t0
	add	a7, sp, a7
	addi	a7, a7, 64
	vsseg3e8.v	v24, (a7)
                                        # implicit-def: $v24
	vle8.v	v24, (a7)
                                        # implicit-def: $v28m2
	vmv.v.v	v28, v24
	csrr	t0, vlenb
	add	a7, a7, t0
                                        # implicit-def: $v24
	vle8.v	v24, (a7)
	vmv.v.v	v29, v24
                                        # implicit-def: $v24m4
	vmv2r.v	v24, v28
	add	a7, a7, t0
                                        # implicit-def: $v30
	vle8.v	v30, (a7)
                                        # implicit-def: $v28m2
	vmv.v.v	v28, v30
	vmv2r.v	v26, v28
	vsetvli	zero, a3, e8, m4, ta, ma
	vse8.v	v24, (a6)
	add	a1, a5, a1
	sub	a0, a0, a5
                                        # implicit-def: $v24m8
	vsetvli	a5, zero, e64, m8, ta, ma
	vadd.vx	v24, v16, a4
                                        # implicit-def: $v16m8
	vadd.vx	v16, v8, a3
                                        # implicit-def: $v8m8
	vadd.vx	v8, v0, a2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 4
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v24, (a1)                       # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 3
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 5
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 1
	add	a1, a1, a0
	slli	a0, a0, 2
	add	a1, a1, a0
	slli	a0, a0, 2
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
