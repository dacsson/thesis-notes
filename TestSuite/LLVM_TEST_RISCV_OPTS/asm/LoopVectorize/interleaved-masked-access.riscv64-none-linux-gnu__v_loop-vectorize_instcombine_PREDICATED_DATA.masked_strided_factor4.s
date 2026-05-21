# Source: LoopVectorize/interleaved-masked-access.riscv64-none-linux-gnu__v_loop-vectorize_instcombine_PREDICATED_DATA.ll
# Function: masked_strided_factor4
# src = pre-opt (masked_strided_factor4), tgt = post-opt (masked_strided_factor4)
# Triple: riscv64-none-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	li	a0, 0
	sd	a2, 128(sp)                     # 8-byte Folded Spill
	sd	a0, 136(sp)                     # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sext.w	a1, a1
	sext.w	a0, a0
	bgeu	a0, a1, .LBB1_7
	j	.LBB1_2
.LBB1_2:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a2, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	slliw	a0, a0, 2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	addiw	a1, a0, 1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	addiw	a4, a0, 2
	sd	a4, 56(sp)                      # 8-byte Folded Spill
	addiw	a3, a0, 3
	sd	a3, 64(sp)                      # 8-byte Folded Spill
	add	a0, a2, a0
	lb	a0, 0(a0)
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	add	a1, a2, a1
	lb	a1, 0(a1)
	add	a4, a2, a4
	lb	a4, 0(a4)
	sd	a4, 80(sp)                      # 8-byte Folded Spill
	add	a2, a2, a3
	lb	a2, 0(a2)
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB1_4
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
.LBB1_4:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 96(sp)                      # 8-byte Folded Reload
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	li	a2, 0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	subw	a2, a2, a3
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB1_6
# %bb.5:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB1_6:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	ld	a2, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 56(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	ld	a6, 48(sp)                      # 8-byte Folded Reload
	ld	a7, 8(sp)                       # 8-byte Folded Reload
	ld	t0, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	subw	a0, a0, a3
	add	t0, a1, t0
	sb	a7, 0(t0)
	add	a6, a1, a6
	sb	a5, 0(a6)
	add	a4, a1, a4
	sb	a3, 0(a4)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB1_7
.LBB1_7:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	addiw	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bne	a0, a1, .LBB1_1
	j	.LBB1_8
.LBB1_8:                                # %for.end
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

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
	mv	a4, a3
	slli	a3, a3, 4
	add	a4, a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x31, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 49 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	j	.LBB1_1
.LBB1_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	zext.b	a2, a0
	csrr	a0, vlenb
	slli	a1, a0, 1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	addi	a3, a1, 1023
	li	a0, 0
	sub	a4, a0, a1
	and	a3, a3, a4
	sd	a3, 24(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m8
	vsetvli	a3, zero, e32, m8, tu, ma
	vmv.v.x	v8, a2
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vs8r.v	v8, (a2)                        # vscale x 64-byte Folded Spill
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e32, m8, ta, ma
	vid.v	v8
                                        # implicit-def: $v16m8
	vsetvli	zero, zero, e32, m8, tu, ma
	vmv.v.x	v16, a1
	csrr	a1, vlenb
	slli	a2, a1, 3
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs8r.v	v16, (a1)                       # vscale x 64-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 4
	add	a0, a1, a0
	add	a0, sp, a0
	addi	a0, a0, 64
	vs8r.v	v8, (a0)                        # vscale x 64-byte Folded Spill
	j	.LBB1_2
.LBB1_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	ld	a5, 48(sp)                      # 8-byte Folded Reload
	csrr	a4, vlenb
	slli	a6, a4, 4
	add	a4, a6, a4
	add	a4, sp, a4
	addi	a4, a4, 64
	vl8r.v	v16, (a4)                       # vscale x 64-byte Folded Reload
	csrr	a4, vlenb
	add	a4, sp, a4
	addi	a4, a4, 64
	vl8r.v	v24, (a4)                       # vscale x 64-byte Folded Reload
                                        # implicit-def: $v8m8
	vsetvli	zero, zero, e32, m8, ta, ma
	vid.v	v8
                                        # implicit-def: $v0m8
	vsaddu.vx	v0, v8, a0
	li	a4, 1024
	vmsltu.vx	v8, v0, a4
	vmsltu.vv	v9, v24, v16
	vmand.mm	v0, v8, v9
	slliw	a4, a0, 2
	add	a5, a5, a4
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e8, m2, tu, ma
	vmv.v.i	v8, 0
                                        # implicit-def: $v24m2
	vmerge.vim	v24, v8, 1, v0
                                        # implicit-def: $v8m2_v10m2_v12m2_v14m2
	vmv2r.v	v8, v24
	vmv2r.v	v10, v24
	vmv2r.v	v12, v24
	vmv2r.v	v14, v24
	csrr	t2, vlenb
	mv	a6, t2
	slli	t2, t2, 3
	add	a6, a6, t2
	slli	t2, t2, 1
	add	t2, t2, a6
	add	t2, sp, t2
	addi	t2, t2, 64
	vsseg4e8.v	v8, (t2)
	csrr	t0, vlenb
	slli	a7, t0, 1
	add	t3, t2, a7
	add	a6, t3, a7
	add	t1, a6, a7
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e8, m2, ta, ma
	vle8.v	v10, (t1)
	vmsne.vi	v9, v10, 0
                                        # implicit-def: $v10m2
	vle8.v	v10, (a6)
	vmsne.vi	v8, v10, 0
	srli	a6, t0, 1
	srli	t1, t0, 2
	vsetvli	zero, a6, e8, mf2, ta, ma
	vslideup.vx	v8, v9, t1
                                        # implicit-def: $v10m2
	vsetvli	t4, zero, e8, m2, ta, ma
	vle8.v	v10, (t3)
	vmsne.vi	v9, v10, 0
                                        # implicit-def: $v10m2
	vle8.v	v10, (t2)
	vmsne.vi	v0, v10, 0
	vsetvli	zero, a6, e8, mf2, ta, ma
	vslideup.vx	v0, v9, t1
	vsetvli	zero, t0, e8, m1, ta, ma
	vslideup.vx	v0, v8, a6
	addi	a6, sp, 64
	vs1r.v	v0, (a6)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8m8
	vsetvli	a6, zero, e8, m8, ta, mu
	vle8.v	v8, (a5), v0.t
	addi	a5, sp, 64
	vl1r.v	v0, (a5)                        # vscale x 8-byte Folded Reload
	csrr	a5, vlenb
	slli	a6, a5, 5
	add	a5, a6, a5
	add	a5, sp, a5
	addi	a5, a5, 64
	vse8.v	v8, (a5)
                                        # implicit-def: $v2m2_v4m2_v6m2_v8m2
	vsetvli	a6, zero, e8, m2, ta, ma
	vlseg4e8.v	v2, (a5)
	vmv2r.v	v28, v8
	vmv2r.v	v24, v6
	vmv2r.v	v10, v4
	vmv2r.v	v8, v2
                                        # implicit-def: $v30m2
	vmax.vv	v30, v8, v10
                                        # implicit-def: $v8m2_v10m2_v12m2_v14m2
	vmv.v.v	v8, v30
                                        # implicit-def: $v26m2
	vrsub.vi	v26, v30, 0
	vmv.v.v	v10, v26
                                        # implicit-def: $v26m2
	vmax.vv	v26, v24, v28
	vmv.v.v	v12, v26
                                        # implicit-def: $v24m2
	vrsub.vi	v24, v26, 0
	vmv.v.v	v14, v24
	add	a3, a3, a4
	csrr	a5, vlenb
	mv	a4, a5
	slli	a5, a5, 3
	add	a4, a4, a5
	slli	a5, a5, 2
	add	a5, a5, a4
	add	a5, sp, a5
	addi	a5, a5, 64
	vsseg4e8.v	v8, (a5)
	add	a4, a5, a7
	add	a6, a4, a7
                                        # implicit-def: $v8m2
	vle8.v	v8, (a6)
                                        # implicit-def: $v4m4
	vmv.v.v	v4, v8
	add	a6, a6, a7
                                        # implicit-def: $v8m2
	vle8.v	v8, (a6)
	vmv.v.v	v6, v8
                                        # implicit-def: $v8m2
	vle8.v	v8, (a5)
                                        # implicit-def: $v24m4
	vmv.v.v	v24, v8
                                        # implicit-def: $v8m2
	vle8.v	v8, (a4)
	vmv.v.v	v26, v8
                                        # implicit-def: $v8m8
	vmv4r.v	v8, v24
	csrr	a4, vlenb
	slli	a5, a4, 3
	add	a4, a5, a4
	add	a4, sp, a4
	addi	a4, a4, 64
	vl8r.v	v24, (a4)                       # vscale x 64-byte Folded Reload
	vmv4r.v	v12, v4
	vsetvli	a4, zero, e8, m8, ta, ma
	vse8.v	v8, (a3), v0.t
	addw	a0, a0, a2
                                        # implicit-def: $v8m8
	vsetvli	a2, zero, e32, m8, ta, ma
	vadd.vv	v8, v16, v24
	sext.w	a1, a1
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a3, a2, 4
	add	a2, a3, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vs8r.v	v8, (a2)                        # vscale x 64-byte Folded Spill
	bne	a0, a1, .LBB1_2
	j	.LBB1_3
.LBB1_3:                                # %middle.block
	j	.LBB1_4
.LBB1_4:                                # %for.end
	csrr	a0, vlenb
	mv	a1, a0
	slli	a0, a0, 4
	add	a1, a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
