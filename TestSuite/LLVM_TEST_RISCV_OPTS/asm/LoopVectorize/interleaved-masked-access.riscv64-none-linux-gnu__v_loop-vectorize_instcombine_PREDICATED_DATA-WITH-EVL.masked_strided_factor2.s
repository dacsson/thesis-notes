# Source: LoopVectorize/interleaved-masked-access.riscv64-none-linux-gnu__v_loop-vectorize_instcombine_PREDICATED_DATA-WITH-EVL.ll
# Function: masked_strided_factor2
# src = pre-opt (masked_strided_factor2), tgt = post-opt (masked_strided_factor2)
# Triple: riscv64-none-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a2, 64(sp)                      # 8-byte Folded Spill
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sext.w	a1, a1
	sext.w	a0, a0
	bgeu	a0, a1, .LBB0_5
	j	.LBB0_2
.LBB0_2:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	slliw	a2, a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a0, a1, a2
	lb	a0, 0(a0)
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	addiw	a2, a2, 1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	add	a1, a1, a2
	lb	a1, 0(a1)
	mv	a2, a1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_4
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB0_4:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	add	a0, a1, a0
	sb	a3, 0(a0)
	li	a0, 0
	subw	a0, a0, a3
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB0_5
.LBB0_5:                                # %for.inc
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_6
.LBB0_6:                                # %for.end
	addi	sp, sp, 80
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
	csrr	a3, vlenb
	slli	a4, a3, 4
	add	a3, a4, a3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x11, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 17 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	zext.b	a0, a0
                                        # implicit-def: $v8m8
	vsetvli	a1, zero, e32, m8, tu, ma
	vmv.v.x	v8, a0
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vs8r.v	v8, (a0)                        # vscale x 64-byte Folded Spill
	li	a0, 1024
	li	a1, 0
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e32, m8, ta, ma
	vid.v	v8
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a5, a2, 3
	add	a2, a5, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v16, (a2)                       # vscale x 64-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vl8r.v	v8, (a2)                        # vscale x 64-byte Folded Reload
	slli	a2, a0, 32
	srli	a2, a2, 32
	vsetvli	a2, a2, e8, m2, ta, ma
	vsetvli	a5, zero, e32, m8, ta, ma
	vmsltu.vv	v0, v8, v16
	slliw	a6, a1, 1
	add	a7, a4, a6
	slli	a4, a2, 1
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e8, m2, tu, ma
	vmv.v.i	v10, 0
                                        # implicit-def: $v8m2
	vmerge.vim	v8, v10, 1, v0
                                        # implicit-def: $v12m4
	vsetvli	zero, zero, e8, m2, ta, ma
	vwaddu.vv	v12, v8, v8
	li	a5, -1
	vwmaccu.vx	v12, a5, v8
	vmv2r.v	v10, v14
	vmsne.vi	v8, v10, 0
	vmv2r.v	v10, v12
	vmsne.vi	v0, v10, 0
	csrr	t0, vlenb
	srli	t1, t0, 1
	srli	t0, t0, 2
	vsetvli	zero, t1, e8, mf2, ta, ma
	vslideup.vx	v0, v8, t0
	addi	t0, sp, 64
	vs1r.v	v0, (t0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v24m4
	vsetvli	zero, a4, e8, m4, ta, mu
	vle8.v	v24, (a7), v0.t
	addi	a7, sp, 64
	vl1r.v	v0, (a7)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v12m2
	vsetvli	a7, zero, e8, m2, ta, ma
	vnsrl.wi	v12, v24, 8
                                        # implicit-def: $v8m2
	vnsrl.wi	v8, v24, 0
                                        # implicit-def: $v10m2
	vmax.vv	v10, v8, v12
	add	a3, a3, a6
                                        # implicit-def: $v8m2
	vrsub.vi	v8, v10, 0
                                        # implicit-def: $v12m4
	vwaddu.vv	v12, v10, v8
	vwmaccu.vx	v12, a5, v8
	vmv2r.v	v24, v12
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v24
	vmv2r.v	v12, v14
	vmv2r.v	v10, v12
	vsetvli	zero, a4, e8, m4, ta, ma
	vse8.v	v8, (a3), v0.t
	addw	a1, a2, a1
	subw	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a3, zero, e32, m8, ta, ma
	vadd.vx	v8, v16, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v8, (a1)                        # vscale x 64-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %for.end
	csrr	a0, vlenb
	slli	a1, a0, 4
	add	a0, a1, a0
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
